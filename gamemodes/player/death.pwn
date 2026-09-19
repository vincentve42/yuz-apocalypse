#include <YSI_Coding\y_hooks>
forward updateWeaponLootProgress(playerid, Float:bar, type, amount);
// todo
// masih bug spawn
public updateWeaponLootProgress(playerid, Float:bar, type, amount){
	if(type != 0)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            DestroyDynamicPickup(deathObject[deathID[playerid]]);
            deathObject[deathID[playerid]] = -1;
            deathID[playerid] = -1;
            deathItemPickup[playerid] = -1;
            if(isWeapFull(playerid) == 0 && !isWeapHaveSameModel(playerid, type))
            {
                
                new str[128];
                new weapname[64];
                GetWeaponName(type, weapname, sizeof(weapname));
                format(str, sizeof(str), "Anda mendapatkan senjata %s dan ammo sejumlah %d",weapname, amount);
                sendInfoMessage(playerid, str);  
                ClearAnimations(playerid);
                setWeapon(playerid, type);
                giveAmmo(playerid, type, amount);
                
                
            }
            else if(isWeapHaveSameModel(playerid, type))
            {
                
                new str[128];
                new weapname[64];
                GetWeaponName(type, weapname, sizeof(weapname));
                format(str, sizeof(str), "Anda mendapatkan ammo senjata %s sejumlah %d",weapname,amount);
                sendInfoMessage(playerid, str);  
                ClearAnimations(playerid);
                giveAmmo(playerid, type, amount);
                refreshGun(playerid);
                
            }
           
        }
    }
}
stock setWeaponLootActivity(playerid, type, amount)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
   
    ActivityProgress[playerid] = 0.0;
    showPlayerActivityTextdraw(playerid);
    TogglePlayerControllable(playerid, false);
    playerActivity[playerid] = 1;
    animLoot(playerid);
    ActivityTimer[playerid] = SetTimerEx("updateWeaponLootProgress", 1000, true, "ifdd", playerid, PROGRESS_LOOTING, type, amount);
    return 1;
}
hook OnPlayerConnect(playerid){
    deathItemPickup[playerid] = -1;
    deathID[playerid] = -1;
    return 1;
}

hook OnGameModeInit()
{
    for(new i =0; i<MAX_DEATH_LOOT; i++)
    {
        deathObject[i] = -1;
    }
    return 1;
}
hook OnPlayerDeath(playerid, killerid, reason){
    for(new i =0; i<MAX_DEATH_LOOT; i++)
    {
        if(deathObject[i] == -1 && UseGun[playerid] != 0)
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
           
            new models;
               
            new ammo;

            new weap;
            if(UseGun[playerid] == 1)
            {
                models = getWeaponPickupModel(Player[playerid][pWeap1]);
                weap = Player[playerid][pWeap1];
                ammo = Player[playerid][pAmmo1];
                Player[playerid][pWeap1] = 0;
                Player[playerid][pAmmo1] = 0; 
            }
            if(UseGun[playerid] == 2)
            {
                models = getWeaponPickupModel(Player[playerid][pWeap2]);
                weap = Player[playerid][pWeap2];
                ammo = Player[playerid][pAmmo2];
                Player[playerid][pWeap2] = 0;
                Player[playerid][pAmmo2] = 0; 
            }
            if(UseGun[playerid] == 3)
            {
                models = getWeaponPickupModel(Player[playerid][pWeap3]);
                weap = Player[playerid][pWeap3];
                ammo = Player[playerid][pAmmo3];
                Player[playerid][pWeap3] = 0;
                Player[playerid][pAmmo3] = 0; 
            }
            
            deathObject[i] = CreateDynamicPickup(models, 1,x,y,z,-1);
            deathItem[deathObject[i]][dX] = x;
            deathItem[deathObject[i]][dY] = y;
            deathItem[deathObject[i]][dZ] = z;
            deathItem[deathObject[i]][dWeapon] = weap;
            deathItem[deathObject[i]][dAmmo] = ammo;
            
            return 1;
        }
    }
    
    
    
    return 1;
}
public OnPlayerPickUpDynamicPickup(playerid, pickupid){

    
    // npcpickup
    for(new i =0; i<1000; i++)
    {
        if(pickupid == NpcPickup[i] && NpcPickup[i] != -1 && playerActivity[playerid] == 0)
        {
            showLootInfo(playerid);
            
            return 1;
        }
    }
    for(new i=0; i<MAX_DEATH_LOOT; i++)
    {
        if(pickupid == deathObject[i] && playerActivity[playerid] == 0)
        {
            showLootInfo(playerid);
            return 1;
        }
        
        return 1;
    }
    
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    if(newkeys & KEY_NO){
        for(new i=0; i<MAX_DEATH_LOOT; i++)
        {
            new pickupid = deathObject[i];
            if(deathObject[i] != -1 && playerActivity[playerid] == 0 && IsPlayerInRangeOfPoint(playerid, 3.0, deathItem[pickupid][dX], deathItem[pickupid][dY], deathItem[pickupid][dZ]))
            {
                if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, deathItem[pickupid][dWeapon]))
                {
                    return sendErrorMessage(playerid, "Slot senjata anda penuh!");
                }
                for(new j=0; j<MAX_PLAYERS; j++)
                {
                    
                    if(deathID[j] == i  && IsPlayerConnected(j)){
                        
                        return sendErrorMessage(playerid, "Loot sudah diambil / sedang diambil player lain");
                    }
                }
                deathItemPickup[playerid] = pickupid;
              
                deathID[playerid] = i;
                new str[256];
                new item[64];
                GetWeaponName(deathItem[pickupid][dWeapon], item, sizeof(item));
                format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} Anda menemukan sebuah {00CCFF}%s{FFFFFF} di area ini.", item);
                ShowPlayerDialog(playerid, DIALOG_LOOT_DEATH, DIALOG_STYLE_MSGBOX, "Senjata ditanah", str, "Ambil", "Tidak");

                return 1;
        
            }
        
        }
        for(new i =0; i<1000; i++) 
        {
            new pickupid = NpcPickup[i];
            if(NpcPickup[i] !=  -1)
            {
                if(IsPlayerInRangeOfPoint(playerid, 1.0, NpcPickupInfo[pickupid][npX], NpcPickupInfo[pickupid][npY], NpcPickupInfo[pickupid][npZ]) && playerActivity[playerid] == 0)
                {
                    new randoms = random(2);
                    if(randoms == 0)
                    {
                        new mny = random(20) + 1;
                        
                        setLootActivity(playerid, 1, mny);
                        DestroyDynamicPickup(NpcPickup[i]);
                        NpcPickup[i] = -1;
                        return 1;

                    }
                    else if(randoms == 1)
                    {
                        new scrap = random(5) + 1; 

                        Player[playerid][pScrap] += scrap;

                            
                        setLootActivity(playerid, 0, scrap); 
                        DestroyDynamicPickup(NpcPickup[i]); 
                        NpcPickup[i] = -1;
                        return 1;
                    }
                }
            }
        }
         
    }
    return 1;
}
