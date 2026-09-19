#include <YSI_Coding\y_hooks>

forward hideLootInfo(playerid);

new lootInfoTimer[MAX_PLAYERS];

stock showLootInfo(playerid){
    PlayerTextDrawShow(playerid, lootinfotd[playerid]);
    lootInfoTimer[playerid] = SetTimerEx("hideLootInfo", 3000, false, "i", playerid);
    return 1;
}
public hideLootInfo(playerid){
    PlayerTextDrawHide(playerid,  lootinfotd[playerid]);
}
hook OnPlayerConnect(playerid){
    LootID[playerid] = -1;
    LootPickupState[playerid][piType] = -1;
    LootPickupState[playerid][piAmount] = -1;
    LootPickupState[playerid][piId] = -1;
    return 1;
}
forward updateLootProgress(playerid, Float:bar, type, amount);

public updateLootProgress(playerid, Float:bar, type, amount){
	if(type == 0)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pScrap] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan scrap sejumlah %d", amount);
            sendInfoMessage(playerid, str);  
            ClearAnimations(playerid);
        }
    }
    if(type == 1)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            GiveMoney(playerid, amount);
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan uang sejumlah %d", amount);
            sendInfoMessage(playerid, str); 
            ClearAnimations(playerid);
            if(PlayerPickBaseLoot[playerid] != -1)
            {
                switch(PlayerPickBaseLoot[playerid])
                {
                    case 11:{
                        DestroyPickup(Base1Loot[1]);
                        Base1Loot[1] = -1;
                    }
                }
                PlayerPickBaseLoot[playerid] = -1;
            }
            
        }
    }
    if(type == LOOT_ARMOUR){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            ClearAnimations(playerid);
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pArmour] = 100.0;
            SetPlayerArmour(playerid, Player[playerid][pArmour]);
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan body armour");
            sendSuccessMessage(playerid, str); 
            
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    if(type == LOOT_BANDAGE){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            ClearAnimations(playerid);
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pBandage] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan bandage sejumlah %d", amount);
            sendSuccessMessage(playerid, str); 
      
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    if(type == LOOT_ANTIBIOTIK){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            ClearAnimations(playerid);
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pAntibiotic] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan antibiotic sejumlah %d", amount);
            sendSuccessMessage(playerid, str); 
           
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }
    }
    if(type == LOOT_SCRAP){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            ClearAnimations(playerid);
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pScrap] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan scrap sejumlah %d", amount);
            sendSuccessMessage(playerid, str); 
            
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    if(type == LOOT_APEL){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            ClearAnimations(playerid);
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pApel] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan apel sejumlah %d", amount);
            sendSuccessMessage(playerid, str); 
           
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    if(type == LOOT_MONEY){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            ClearAnimations(playerid);
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            GiveMoney(playerid, amount);
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan uang sejumlah %d", amount);
            sendSuccessMessage(playerid, str); 
            
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    if(type == LOOT_PIZZA){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            ClearAnimations(playerid);
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pPizza] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan pizza sejumlah %d", amount);
            sendSuccessMessage(playerid, str); 
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    if(type == LOOT_MINUMAN){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            KillTimer(ActivityTimer[playerid]);
            ClearAnimations(playerid);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pDrink] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan minuman sejumlah %d", amount);
            sendSuccessMessage(playerid, str); 
           
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    if(type == LOOT_GAS){
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            KillTimer(ActivityTimer[playerid]);
            ClearAnimations(playerid);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            Player[playerid][pGas] += amount;
            new str[128];
            format(str, sizeof(str), "Anda mendapatkan sebuah gas tank");
            sendSuccessMessage(playerid, str); 
           
            DestroyPickup(LootPickup[LootID[playerid]]);
            PlayerPickSmth[playerid] = -1;
            LootPickup[LootID[playerid]] = -1;
            LootID[playerid] = -1;
            TogglePlayerControllable(playerid, 1);
        }

        
    }
    return 1;
}

stock animLoot(playerid){
    ApplyAnimation(playerid,"BOMBER", "BOM_Plant",4.1, 0,0,0,0, 4000,1);
}
stock setLootActivity(playerid, type, amount)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
    if(type == 0){
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        animLoot(playerid);
        ActivityTimer[playerid] = SetTimerEx("updateLootProgress", 1000, true, "ifdd", playerid, PROGRESS_LOOTING, type, amount);
    } //loot
    else if(type == 1){
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        animLoot(playerid);
        ActivityTimer[playerid] = SetTimerEx("updateLootProgress", 1000, true, "ifdd", playerid, PROGRESS_LOOTING, type, amount);
    }
    else //loot
    { // armor
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        animLoot(playerid);
        ActivityTimer[playerid] = SetTimerEx("updateLootProgress", 1000, true, "ifdd", playerid, PROGRESS_LOOTING, type, amount);

       
    }
    return 1;
}
stock createLoot(playerid){
    for(new i =0; i<MAX_LOOT; i++)
    {
        if(LootPickup[i] == -1)
        {
            new rand = random(sizeof(LootModel));
            new Float:x, Float:y, Float:z; 
            GetPlayerPos(playerid, x, y, z);
            new lootFile[1024];
            format(lootFile,sizeof(lootFile), "Loot/%d.ini", i);
            dini_Create(lootFile);
            dini_FloatSet(lootFile, "X", x);
            dini_FloatSet(lootFile, "Y", y);
            dini_FloatSet(lootFile, "Z", z);
            LootPickup[i] = CreatePickup(LootModel[rand], 1, x, y, z, 0);

            new amount;

            if(LootModel[rand] == LOOT_SCRAP)
            {
                amount = random(40) + 20;
            }
            if(LootModel[rand] == LOOT_BANDAGE)
            {
                amount = random(5) + 1;
            }

            if(LootModel[rand] == LOOT_ANTIBIOTIK)
            {
                amount = random(3) + 1;
            }
            if(LootModel[rand] == LOOT_MONEY)
            {
                amount = random(100) + 10;
            }
            if(LootModel[rand] == LOOT_PIZZA)
            {
                amount = random(5) + 1;
            }
            if(LootModel[rand] == LOOT_APEL)
            {
                amount = random(10) + 1;
            }
            if(LootModel[rand] == LOOT_MINUMAN)
            {
                amount = random(10) + 1;
            }
            LootInfo[LootPickup[i]][lX] = x;

            LootInfo[LootPickup[i]][lY] = y;

            LootInfo[LootPickup[i]][lZ] = z;

            LootInfo[LootPickup[i]][lModel] = LootModel[rand];

            LootInfo[LootPickup[i]][lAmount] = amount;

            new success[128];

            format(success, sizeof(success), "Anda berhasil membuat loot dengan id %d", i);

            sendSuccessMessage(playerid, success);

            return 1;

        }
    }
    sendErrorMessage(playerid, "Loot sudah penuh!");
    return 1;
}
stock deleteLoot(playerid, id){
    if(LootPickup[id] == -1)
    {
        new error[128];
        format(error, sizeof(error), "Loot dengan id %d tidak ada atau sudah dihapus", id);
        return sendErrorMessage(playerid, error);
    }
    LootInfo[LootPickup[id]][lX] = 0.0;
    LootInfo[LootPickup[id]][lY] = 0.0;
    LootInfo[LootPickup[id]][lZ] = 0.0;
    LootInfo[LootPickup[id]][lAmount] = -1;
    LootInfo[LootPickup[id]][lModel] = -1;
    DestroyPickup(LootPickup[id]);
    LootPickup[id] = -1;
    new lootFile[128];
    format(lootFile, sizeof(lootFile), "Loot/%d.ini", id);
    dini_Remove(lootFile);
    new error[128];
    format(error, sizeof(error), "Berhasil menghapus loot dengan id %d", id);
    return sendSuccessMessage(playerid, error);
   
}
forward loadLoot();
public loadLoot()
{
    
    for(new i=0; i<MAX_LOOT - 48; i++)
    {
        new Float:x, Float:y, Float:z;

        new rand = random(sizeof(LootModel));

        do{
            x = float(random(5000) - 2500);
            y = float(random(5000) - 2500);
            MapAndreas_FindZ_For2DCoord(x, y, z);
        }
        while(z <= 1 || isPlayerInSafeZone2(x,y));
        z += 0.5;
        LootPickup[i] = CreatePickup(LootModel[rand], 1, x, y, z, 0);

        LootInfo[LootPickup[i]][lX] = x;

        LootInfo[LootPickup[i]][lY] = y;

        LootInfo[LootPickup[i]][lZ] = z;

        LootInfo[LootPickup[i]][lModel] = LootModel[rand];

        new amount;

        if(LootModel[rand] == LOOT_SCRAP)
        {
            amount = random(40) + 20;
        }
        if(LootModel[rand] == LOOT_BANDAGE)
        {
            amount = random(5) + 7;
        }

        if(LootModel[rand] == LOOT_ANTIBIOTIK)
        {
            amount = random(3) + 1;
        }
        if(LootModel[rand] == LOOT_MONEY)
        {
            amount = random(100) + 10;
        }
        if(LootModel[rand] == LOOT_PIZZA)
        {
            amount = random(5) + 1;
        }
        if(LootModel[rand] == LOOT_APEL)
        {
            amount = random(10) + 1;
        }
        if(LootModel[rand] == LOOT_MINUMAN)
        {
            amount = random(10) + 1;
        }
        if(LootModel[rand] == LOOT_GAS)
        {
            amount = 1;
        }
        
        LootInfo[LootPickup[i]][lAmount] = amount;
        if(isPlayerInContZone2(x,y))
            LootInfo[LootPickup[i]][lAmount] = amount * 3/2;
       
        
    }
    
    
    return 1;
}
forward respawnLoot();
public respawnLoot(){
    new str[256];
    format(str, sizeof(str), ""EMBED_YELLOW"[INFO] "EMBED_WHITE"Loot berhasil di spawn");
    SendClientMessageToAll(-1, str);
    deleteAllLoot();
    loadLoot();
    return 1;
}
hook OnGameModeInit()
{
    for(new i=0; i<MAX_LOOT; i++)
    {
        LootPickup[i] = -1;
    }
    loadLoot();
    SetTimer("respawnLoot", 3600000, true);
    return 1;
}


stock deleteAllLoot()
{
    for(new i =0; i<MAX_LOOT; i++)
    {
        DestroyPickup(LootPickup[i]);
    }
}
hook OnPlayerCommandText(playerid, cmdtext[]){
    new command[128], arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);

    if(!strcmp(command, "/createloot", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan admin");
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5");
        
        createLoot(playerid);
        return 1;
    }
    if(!strcmp(command, "/listloot", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan admin");
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5");
        new str[1024];
        format(str, sizeof(str), "ID\tModel ID\tAmount");
        for(new i = 0; i<MAX_LOOT; i++)
        {
            if(LootPickup[i] != -1)
            {
                format(str, sizeof(str), "%s\n%d\t%d\t%d", str, i,LootInfo[LootPickup[i]][lModel],  LootInfo[LootPickup[i]][lAmount]);
            }
        
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_LOOT, DIALOG_STYLE_TABLIST_HEADERS, "List Loot", str, "Teleport", "Close");
        return 1;
    }
    if(!strcmp(command, "/deleteloot", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan admin");
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5");
        new id;
        if(sscanf(arg1, "d", id)){
            return sendErrorMessage(playerid, "Gunakan /deleteloot [id]");
        }
        deleteLoot(playerid,id);
    }
    if(!strcmp(command, "/respawnloot", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan admin");
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5");
        
        new str[256];
        format(str, sizeof(str), ""EMBED_YELLOW"[INFO] "EMBED_WHITE"Loot berhasil di spawn");
        SendClientMessageToAll(-1, str);
        deleteAllLoot();
        loadLoot();
        return 1;
    }
    return 0;
}
hook OnPlayerSpawn(playerid){
    PlayerPickSmth[playerid] = -1;
    return 1;
}

hook OnPlayerPickUpPickup(playerid, pickupid){
    if(pickupid == Base1Loot[0] && PlayerPickBaseLoot[playerid] == -1)
    {
        showLootInfo(playerid);
        return 1;
    }
    if(pickupid == Base1Loot[1] && PlayerPickBaseLoot[playerid] == -1)
    {
        showLootInfo(playerid);
        return 1;
    }
    if(pickupid == Base1Loot[2] && PlayerPickBaseLoot[playerid] == -1)
    { 
        showLootInfo(playerid);
        return 1;
        // PlayerPickBaseLoot[playerid] = 12;
        // new str[128];
        // format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} Senjata langka {00CCFF}Sniper Rifle {FFFFFF}ditemukan di area ini.");
        // ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
    }
    if(pickupid == Base2Loot && PlayerPickBaseLoot[playerid] == -1)
    { 
        showLootInfo(playerid);
        return 1;
        // PlayerPickBaseLoot[playerid] = 12;
        // new str[128];
        // format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} Senjata langka {00CCFF}Sniper Rifle {FFFFFF}ditemukan di area ini.");
        // ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
    }
    if(pickupid == Base3Loot && PlayerPickBaseLoot[playerid] == -1)
    { 
        showLootInfo(playerid);
        return 1;
        // PlayerPickBaseLoot[playerid] = 12;
        // new str[128];
        // format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} Senjata langka {00CCFF}Sniper Rifle {FFFFFF}ditemukan di area ini.");
        // ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
    }
    if(pickupid == Base4Loot && PlayerPickBaseLoot[playerid] == -1)
    {
        showLootInfo(playerid);
        return 1;
    }
    for(new i=0; i<MAX_LOOT; i++)
    {
        if(pickupid == LootPickup[i])
        { 
            if(PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0){

                showLootInfo(playerid);
                return 1;
            } 
        }
    }
    
    return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys & KEY_NO)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 1027.5332,2674.9331,58.0263) && PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0  && Base1Loot[0] != -1)
        {
            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, 31))
            {
                return sendErrorMessage(playerid, "Slot senjata anda penuh!");
            }
            for(new i =0; i<MAX_PLAYERS; i++)
            {
                if(PlayerPickBaseLoot[i] && IsPlayerConnected(i) == 10)
                {
                    return sendErrorMessage(playerid, "Player lain sedang/telah mengambil loot anda");
                }
            }
            PlayerPickBaseLoot[playerid] = 10;
            new str[128];
            format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} Senjata langka {00CCFF}M4 {FFFFFF}ditemukan di area ini.");
            ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 1025.3779,2617.0757,65.2469) && PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0  && Base1Loot[1] != -1)
        {
            for(new i =0; i<MAX_PLAYERS; i++)
            {
                if(PlayerPickBaseLoot[i] == 11 && IsPlayerConnected(i))
                {
                    return sendErrorMessage(playerid, "Player lain sedang/telah mengambil loot anda");
                }
            }
            PlayerPickBaseLoot[playerid] = 11;
            new str[128];
            format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} Tas {00CCFF}Uang {FFFFFF}ditemukan di area ini.");
            ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 1038.8926,2615.7952,96.5282) && PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0 && Base1Loot[2] != -1)
        {
            for(new i =0; i<MAX_PLAYERS; i++)
            {
                if(PlayerPickBaseLoot[i] == 12 && IsPlayerConnected(i))
                {
                    return sendErrorMessage(playerid, "Player lain sedang/telah mengambil loot anda");
                }
            }
            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, 34))
            {
                return sendErrorMessage(playerid, "Slot senjata anda penuh!");
            }
            PlayerPickBaseLoot[playerid] = 12;
            new str[128];
            format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} senjata {00CCFF}Sniper Rifle {FFFFFF}ditemukan di area ini.");
            ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, Base2Lok[0], Base2Lok[1], Base2Lok[2]) && PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0 && Base2Loot != -1)
        {
            for(new i =0; i<MAX_PLAYERS; i++)
            {
                if(PlayerPickBaseLoot[i] == 20 && IsPlayerConnected(i))
                {
                    return sendErrorMessage(playerid, "Player lain sedang/telah mengambil loot anda");
                }
            }
            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, 38))
            {
                return sendErrorMessage(playerid, "Slot senjata anda penuh!");
            }
            PlayerPickBaseLoot[playerid] = 20;
            new str[128];
            format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} senjata {00CCFF}Minigun {FFFFFF}ditemukan di area ini.");
            ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 214.3931,1822.7318,6.4141) && PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0 && Base3Loot != -1)
        {
            for(new i =0; i<MAX_PLAYERS; i++)
            {
                if(PlayerPickBaseLoot[i] == 30 && IsPlayerConnected(i))
                {
                    return sendErrorMessage(playerid, "Player lain sedang/telah mengambil loot anda");
                }
            }
            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, 35))
            {
                return sendErrorMessage(playerid, "Slot senjata anda penuh!");
            }
            PlayerPickBaseLoot[playerid] = 30;
            new str[128];
            format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} senjata {00CCFF}RPG {FFFFFF}ditemukan di area ini.");
            ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 1.0, -2128.3125,1753.3145,4.8889) && PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0 && Base4Loot != -1)
        {
            for(new i =0; i<MAX_PLAYERS; i++)
            {
                if(PlayerPickBaseLoot[i] == 40 && IsPlayerConnected(i))
                {
                    return sendErrorMessage(playerid, "Player lain sedang/telah mengambil loot anda");
                }
            }
            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, 24))
            {
                return sendErrorMessage(playerid, "Slot senjata anda penuh!");
            }
            PlayerPickBaseLoot[playerid] = 40;
            new str[128];
            format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} senjata {00CCFF}Desert Eagle {FFFFFF}ditemukan di area ini.");
            ShowPlayerDialog(playerid, DIALOG_BASE_LOOT, DIALOG_STYLE_MSGBOX, "Rare Item Loot", str, "Ambil", "Batal");
            return 1;
        }
        for(new i=0; i<MAX_LOOT; i++)
        {
            new pickupid = LootPickup[i];
            
            if(LootPickup[i] != -1)
            {
                if(IsPlayerInRangeOfPoint(playerid, 1.0, LootInfo[pickupid][lX], LootInfo[pickupid][lY], LootInfo[pickupid][lZ]) && PlayerPickSmth[playerid] == -1 && playerActivity[playerid] == 0)
                {
                    
                    new str[256];
                    new item[256];
                    if(LootInfo[pickupid][lModel] == LOOT_ARMOUR)
                    {
                        format(item, sizeof(item), "Body Armour");
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_BANDAGE)
                    {
                        format(item, sizeof(item), "%dx Bandage", LootInfo[pickupid][lAmount]);
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_ANTIBIOTIK)
                    {
                        format(item, sizeof(item), "%dx Antibiotik", LootInfo[pickupid][lAmount]);
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_SCRAP)
                    {
                        format(item, sizeof(item), "%dx Scrap", LootInfo[pickupid][lAmount]);
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_PIZZA)
                    {
                        format(item, sizeof(item), "%dx Pizza", LootInfo[pickupid][lAmount]);
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_APEL)
                    {
                        format(item, sizeof(item), "%dx Apel", LootInfo[pickupid][lAmount]);
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_MINUMAN)
                    {
                        format(item, sizeof(item), "%dx Minuman", LootInfo[pickupid][lAmount]);
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_MONEY)
                    {
                        format(item, sizeof(item), "Uang %d$", LootInfo[pickupid][lAmount]);
                    }
                    if(LootInfo[pickupid][lModel] == LOOT_GAS)
                    {
                        format(item, sizeof(item), "Gas Tank");
                    }
                    for(new j=0; j<MAX_PLAYERS; j++)
                    {
                        if(LootID[j] == i && IsPlayerConnected(j))
                        {
                            return sendErrorMessage(playerid, "Loot telah diambil / sedang diambil player lain");
                        }
                    }
                    format(str, sizeof(str), "{00CCFF}[LOOT]{FFFFFF} Anda menemukan item {00CCFF}%s{FFFFFF} di area ini.", item);
                    PlayerPickSmth[playerid] = pickupid;
                    LootID[playerid] = i;
                    TogglePlayerControllable(playerid, 0);
                    ShowPlayerDialog(playerid, DIALOG_ACCEPT_LOOT, DIALOG_STYLE_MSGBOX, "Loot", str, "Ambil", "Batal");
                    return 1;
                }
            }
        }

    }
    return 1;
}