#include <YSI_Coding\y_hooks>

forward updateWeaponBaseLootProgress(playerid, Float:bar, type, amount);
// todo
// masih bug spawn
public updateWeaponBaseLootProgress(playerid, Float:bar, type, amount){
	if(type != 0)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            switch(PlayerPickBaseLoot[playerid])
            {
                case 10:
                {
                    DestroyPickup(Base1Loot[0]);
                    Base1Loot[0] = -1;
                }
                case 12:
                {
                    DestroyPickup(Base1Loot[2]);
                    Base1Loot[2] = -1;
                }
                case 20:
                {
                    DestroyPickup(Base2Loot);
                    Base2Loot = -1;
                }
                case 30:
                {
                    DestroyPickup(Base3Loot);
                    Base3Loot = -1;
                }
                case 40:
                {
                    DestroyPickup(Base4Loot);
                    Base4Loot = -1;
                }
            }
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            
            if(!isWeapHaveSameModel(playerid, type) && isWeapFull(playerid) == 0)
            {
                PlayerPickBaseLoot[playerid] = -1;
                new str[128];
                new weapname[64];
                GetWeaponName(type, weapname, sizeof(weapname));
                format(str, sizeof(str), "Anda mendapatkan senjata %s dan ammo sejumlah %d",weapname, amount);
                sendInfoMessage(playerid, str);  
                ClearAnimations(playerid);
                setWeapon(playerid, type);
                giveAmmo(playerid, type, amount);
                
                
            }
            else
            {
                PlayerPickBaseLoot[playerid] = -1;
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
stock setWeaponBaseLootActivity(playerid, type, amount)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
   
    ActivityProgress[playerid] = 0.0;
    showPlayerActivityTextdraw(playerid);
    TogglePlayerControllable(playerid, false);
    playerActivity[playerid] = 1;
    ApplyAnimation(playerid,"BOMBER", "BOM_Plant",4.1, 0,0,0,0, 10000,1);
    ActivityTimer[playerid] = SetTimerEx("updateWeaponBaseLootProgress", 1000, true, "ifdd", playerid, 10.0, type, amount);
    return 1;
}

hook OnPlayerConnect(playerid)
{
    PlayerPickBaseLoot[playerid] = -1;
    baseLootX[playerid] = 0.0;
    baseLootY[playerid] = 0.0;
    baseLootZ[playerid] = 0.0;
    return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_BASE_LOOT)
    {
        if(response)
        {
            if(PlayerPickBaseLoot[playerid] == 10)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 1.0, 1027.5332,2674.9331,58.0263) && Base1Loot[0] != -1)
                {
                    setWeaponBaseLootActivity(playerid,31, 500);
                    return sendInfoMessage(playerid, "Mencoba mengambil senjata M4!");
                }
                else
                {
                    PlayerPickBaseLoot[playerid] = -1;
                    return sendErrorMessage(playerid, "Anda tidak berada di sekitar item yang ingin di ambil!");
                }
            }
            if(PlayerPickBaseLoot[playerid] == 11)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 1.0, 1025.3779,2617.0757,65.2469) &&  Base1Loot[1] != -1)
                {
                    setLootActivity(playerid, 1, 75000);
                    return sendInfoMessage(playerid, "Mencoba mengambil sebuah tas yang berisi uang!");
                }
                else
                {
                    PlayerPickBaseLoot[playerid] = -1;
                    return sendErrorMessage(playerid, "Anda tidak berada di sekitar item yang ingin di ambil!");
                }
            }
            if(PlayerPickBaseLoot[playerid] == 12)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 1.0, 1038.8926,2615.7952,96.5282) && Base1Loot[2] != -1)
                {
                    setWeaponBaseLootActivity(playerid, 34, 100);
                    return sendInfoMessage(playerid, "Mencoba mengambil senjata sniper rifle!");
                }
                else
                {
                    PlayerPickBaseLoot[playerid] = -1;
                    return sendErrorMessage(playerid, "Anda tidak berada di sekitar item yang ingin di ambil!");
                }
            }
            if(PlayerPickBaseLoot[playerid] == 20)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 1.0, Base2Lok[0], Base2Lok[1], Base2Lok[2]) && Base2Loot != -1)
                {
                    setWeaponBaseLootActivity(playerid, 38, 100);
                    return sendInfoMessage(playerid, "Mencoba mengambil senjata minigun!");
                }
                else
                {
                    PlayerPickBaseLoot[playerid] = -1;
                    return sendErrorMessage(playerid, "Anda tidak berada di sekitar item yang ingin di ambil!");
                }
            }
            if(PlayerPickBaseLoot[playerid] == 30)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 1.0, 214.3931,1822.7318,6.4141) && Base3Loot != -1)
                {
                    setWeaponBaseLootActivity(playerid, 35, 20);
                    return sendInfoMessage(playerid, "Mencoba mengambil senjata RPG");
                }
                else
                {
                    PlayerPickBaseLoot[playerid] = -1;
                    return sendErrorMessage(playerid, "Anda tidak berada di sekitar item yang ingin di ambil!");
                }
            }
            if(PlayerPickBaseLoot[playerid] == 40)
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 1.0, -2128.3125,1753.3145,4.8889) && Base4Loot != -1)
                {
                    setWeaponBaseLootActivity(playerid, 24, 100);
                    return sendInfoMessage(playerid, "Mencoba mengambil senjata desert eagle");
                }
                else
                {
                    PlayerPickBaseLoot[playerid] = -1;
                    return sendErrorMessage(playerid, "Anda tidak berada di sekitar item yang ingin di ambil!");
                }
            }
        }
        
        if(!response)
        {
            PlayerPickBaseLoot[playerid] = -1;
            return 1;
        }
    }
    return 1;
}