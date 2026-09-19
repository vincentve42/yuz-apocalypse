#include <YSI_Coding\y_hooks>

hook OnPlayerCommandText(playerid, cmdtext[])
{
    new command[128];
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);
    if(!strcmp(command, "/dropweapon", true))
    {
        if(UseGun[playerid] == 0){
            return sendErrorMessage(playerid, "Anda tidak memegang sebuah senjata");
        }
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
                new success[128];
                new weapName[64];
                GetWeaponName(weap, weapName, sizeof(weapName));
                format(success, sizeof(success), "Anda berhasil menaruh senjata %s", weapName);
                ResetPlayerWeapons(playerid);
                
                UseGun[playerid] = 0;
                return sendSuccessMessage(playerid, success);
            }
        }
    }
    if(!strcmp(command, "/giveweapon", true))
    {
        new target;
        new item[64];

        if(sscanf(arg1, "ds[64]", target, item))
        {
            return sendErrorMessage(playerid, "Gunakan /giveweapon [id] [slot1|slot2|slot3]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target) || playerid == target) return sendErrorMessage(playerid, "Player tidak valid");
        new Float:x, Float:y, Float:z;

        GetPlayerPos(target, x, y, z);
        if(!IsPlayerInRangeOfPoint(playerid, 7.0, x, y, z)){
            return sendErrorMessage(playerid ,"Anda tidak berada di dekat player yang dituju");
        }
        if(!strcmp(item, "slot1", true))
        {
            if(Player[playerid][pWeap1] == 0)
            {
                return sendErrorMessage(playerid, "Anda tidak memiliki senjata di slot 1");
            }
            if(setWeapon(target, Player[playerid][pWeap1]) == 1)
            {
                new playerName[MAX_PLAYER_NAME];
                new targetName[MAX_PLAYER_NAME];

                GetPlayerName(playerid, playerName, sizeof(playerName));
                GetPlayerName(target, targetName, sizeof(targetName));
                giveAmmo(target, Player[playerid][pWeap1], Player[playerid][pAmmo1]);
                new weapname[64];
                GetWeaponName(Player[playerid][pWeap1], weapname, sizeof(weapname));
                
                Player[playerid][pWeap1] = 0;
                Player[playerid][pAmmo1] = 0;
                
                new infomsg[128];
                new successmsg[128];
                format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s kepada %s", weapname, targetName);
                format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s", playerName, weapname);
                sendInfoMessage(target, successmsg);
                sendSuccessMessage(playerid, infomsg);
                
                return 1;

            }
            else{
                sendErrorMessage(playerid, "Slot senjata player yang dituju full");
                return 1;
            }
            
        }
        else if(!strcmp(item, "slot2", true))
        {
            if(Player[playerid][pWeap2] == 0)
            {
                return sendErrorMessage(playerid, "Anda tidak memiliki senjata di slot 2");
            }
            if(setWeapon(target, Player[playerid][pWeap2]) == 1)
            {
                new playerName[MAX_PLAYER_NAME];
                new targetName[MAX_PLAYER_NAME];

                GetPlayerName(playerid, playerName, sizeof(playerName));
                GetPlayerName(target, targetName, sizeof(targetName));
                new weapname[64];
                GetWeaponName(Player[target][pWeap2], weapname, sizeof(weapname));
                giveAmmo(target, Player[playerid][pWeap2], Player[playerid][pAmmo2]);
               
                Player[playerid][pWeap2] = 0;
                Player[playerid][pAmmo2] = 0;
                
                new infomsg[128];
                new successmsg[128];
                format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s kepada %s", weapname, targetName);
                format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s", playerName, weapname);
                sendInfoMessage(target, successmsg);
                sendSuccessMessage(playerid, infomsg);
                
                return 1;

            }
            else{
                sendErrorMessage(playerid, "Slot senjata player yang dituju full");
                return 1;
            }
            
        
        }
        else if(!strcmp(item, "slot3", true))
        {
            if(Player[playerid][pWeap3] == 0)
            {
                return sendErrorMessage(playerid, "Anda tidak memiliki senjata di slot 3");
            }
            if(setWeapon(target, Player[playerid][pWeap3]) == 1)
            {
                new playerName[MAX_PLAYER_NAME];
                new targetName[MAX_PLAYER_NAME];

                GetPlayerName(playerid, playerName, sizeof(playerName));
                GetPlayerName(target, targetName, sizeof(targetName));
                new weapname[64];
                GetWeaponName(Player[target][pWeap3], weapname, sizeof(weapname));
                giveAmmo(target, Player[playerid][pWeap3], Player[playerid][pAmmo3]);
               
                Player[playerid][pWeap3] = 0;
                Player[playerid][pAmmo3] = 0;
                
                new infomsg[128];
                new successmsg[128];
                format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s kepada %s", weapname, targetName);
                format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s", playerName, weapname);
                sendInfoMessage(target, successmsg);
                sendSuccessMessage(playerid, infomsg);
                
                return 1;

            }
            else{
                sendErrorMessage(playerid, "Slot senjata player yang dituju full");
                return 1;
            }
            
        }
        else{
            sendErrorMessage(playerid, "Slot tidak valid");
            return 1;
        }
    }
    if(!strcmp(command, "/give", true))
    {
        new target;
        new item[64];
        new amount;

        if(sscanf(arg1, "ds[64]d", target, item, amount)){
            return sendErrorMessage(playerid, "Gunakan /give [id] [namaitem] [jumlah]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target) || playerid == target) return sendErrorMessage(playerid, "Player tidak valid");

        new Float:x, Float:y, Float:z;

        GetPlayerPos(target, x, y, z);
        if(!IsPlayerInRangeOfPoint(playerid, 7.0, x, y, z)){
            return sendErrorMessage(playerid ,"Anda tidak berada di dekat player yang dituju");
        }
        if(!strcmp(item, "bandage", true))
        {
            if(Player[playerid][pBandage] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah bandage tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];
            
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pBandage] -= amount;
            Player[target][pBandage] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        if(!strcmp(item, "money", true))
        {
            if(Player[playerid][pMoney] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah uang tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            GiveMoney(target, amount);
            TakeMoney(playerid, amount);
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else if(!strcmp(item, "antibiotik", true))
        {
            if(Player[playerid][pAntibiotic] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah antibiotik tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pAntibiotic] -= amount;
            Player[target][pAntibiotic] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        
        else if(!strcmp(item, "apel", true))
        {
            if(Player[playerid][pApel] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah apel tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pApel] -= amount;
            Player[target][pApel] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else if(!strcmp(item, "pizza", true))
        {
            if(Player[playerid][pPizza] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah pizza tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pPizza] -= amount;
            Player[target][pPizza] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else if(!strcmp(item, "minuman", true))
        {
            if(Player[playerid][pDrink] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah pizza tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pDrink] -= amount;
            Player[target][pDrink] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else if(!strcmp(item, "gasmask", true))
        {
            if(Player[playerid][pGasmask] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah gasmask tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pGasmask] -= amount;
            Player[target][pGasmask] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else if(!strcmp(item, "scrap", true))
        {
            if(Player[playerid][pScrap] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah scrap tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pScrap] -= amount;
            Player[target][pScrap] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else if(!strcmp(item, "gas", true))
        {
            if(Player[playerid][pScrap] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah gas tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pGas] -= amount;
            Player[target][pGas] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else if(!strcmp(item, "radio", true))
        {
            if(Player[playerid][pScrap] < amount)
            {
                return sendErrorMessage(playerid, "Jumlah radio tidak cukup");
            }
            new playerName[MAX_PLAYER_NAME];
            new targetName[MAX_PLAYER_NAME];

            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new infomsg[128];
            new successmsg[128];
            format(infomsg, sizeof(infomsg), "Anda berhasil memberikan %s sebanyak %d kepada %s", item, amount, targetName);
            format(successmsg, sizeof(successmsg), "Player %s memberikan anda %s sebanyak %d", playerName, item, amount);
            Player[playerid][pRadio] -= amount;
            Player[target][pRadio] += amount;
            sendSuccessMessage(playerid, infomsg);
            sendInfoMessage(target, successmsg);
            return 1;
        }
        else{
            sendErrorMessage(playerid, "Nama item tidak valid");
            return 1;
        }
    }
    if(!strcmp(command, "/minum", true) || !strcmp(command, "/drink", true))
    {
        if(Player[playerid][pDrink] < 1)
        {
            return sendErrorMessage(playerid, "Anda tidak memiliki air sama sekali");
        }
        Player[playerid][pDrink] -= 1;
        sendInfoMessage(playerid, "Anda mencoba minum air");
        setActivity(playerid, 3);
        return 1;
    }
    if(!strcmp(command, "/use", true))
    {
        new item[128];
        if(sscanf(arg1, "s[128]", item))
        {
            return sendErrorMessage(playerid, "Gunakan /use [namaitem]");
        }
        if(!strcmp(item, "bandage", true))
        {
            if(Player[playerid][pBandage] < 1)
                return sendErrorMessage(playerid, "Bandage anda tidak cukup!");
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            sendInfoMessage(playerid, "Mencoba memakai bandage");
            Player[playerid][pBandage] -= 1;
            setActivity(playerid, 1);
            return 1;
        }
        else if(!strcmp(item, "antibiotik", true))
        {
            if(Player[playerid][pInfected] == 0)
                return sendErrorMessage(playerid, "Anda tidak memerlukan antibiotik");
            if(Player[playerid][pAntibiotic] < 1)
                return sendErrorMessage(playerid, "Anda tidak memiliki antibiotik");
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            sendInfoMessage(playerid, "Mencoba meminum antibiotik");
            Player[playerid][pAntibiotic] -= 1;
            setActivity(playerid, 2);
            return 1;
        }
        else if(!strcmp(item, "minuman", true))
        {
            if(Player[playerid][pDrink] < 1)
            {
                return sendErrorMessage(playerid, "Anda tidak memiliki air sama sekali");
            }
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            Player[playerid][pDrink] -= 1;
            sendInfoMessage(playerid, "Anda mencoba meminum air");
            setActivity(playerid, 3);
            return 1;
        }
        else if(!strcmp(item, "apel", true))
        {
            if(Player[playerid][pApel] < 1)
            {
                return sendErrorMessage(playerid, "Anda tidak memiliki apel sama sekali");
            }
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            Player[playerid][pApel] -= 1;
            sendInfoMessage(playerid, "Anda mencoba memakan apel");
            setActivity(playerid, 4);
            return 1;
        }
        else if(!strcmp(item, "pizza", true))
        {
            if(Player[playerid][pPizza] < 1)
            {
                return sendErrorMessage(playerid, "Anda tidak memiliki pizza sama sekali");
            }
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            Player[playerid][pPizza] -= 1;
            sendInfoMessage(playerid, "Anda mencoba memakan pizza");
            setActivity(playerid, 5);
            return 1;
        }
        else if(!strcmp(item, "gasmask", true))
        {
            if(Player[playerid][pGasmask] < 1)
            {
                return sendErrorMessage(playerid, "Anda tidak memiliki masker gas");
            }
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            Player[playerid][pRadiation] = 100.0;
            Player[playerid][pGasmask] -= 1;
            UseGasmask[playerid] = 1;
            
            sendSuccessMessage(playerid, "Sukses memakai masker gas");

            setRadiationVal(playerid);
            return 1;
        }
        else if(!strcmp(item, "slot1", true)){
            if(Player[playerid][pWeap1] == 0)
                return sendErrorMessage(playerid, "Anda tidak memiliki senjata di slot pertama");
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            ResetPlayerWeapons(playerid);
            new checkhealth = checkArmHealth(playerid);
            if(checkhealth > 0)
            {
                if(checkhealth == 1)
                {
                    sendErrorMessage(playerid, "Lengan kiri anda terluka silahkan gunakan bandage");
                }
                if(checkhealth == 2)
                {
                    sendErrorMessage(playerid, "Lengan kanan anda terluka silahkan gunakan bandage");
                }
                if(checkhealth == 3)
                {
                    sendErrorMessage(playerid, "Kedua lengan anda terluka silahkan gunakan bandage");
                }
                UseGun[playerid] = 0;
                ResetPlayerWeapons(playerid);

                return 1;
            }
            sendSuccessMessage(playerid, "Sukses memakai senjata di slot 1 inventory anda");
            GivePlayerWeapon(playerid, Player[playerid][pWeap1],  Player[playerid][pAmmo1]);
            UseGun[playerid] = 1;
            return 1;
        }
        else if(!strcmp(item, "slot2", true)){
            if(Player[playerid][pWeap2] == 0)
                return sendErrorMessage(playerid, "Anda tidak memiliki senjata di slot kedua");
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, Player[playerid][pWeap2], Player[playerid][pAmmo2]);
            new checkhealth = checkArmHealth(playerid);
            if(checkhealth > 0)
            {
                if(checkhealth == 1)
                {
                    sendErrorMessage(playerid, "Lengan kiri anda terluka silahkan gunakan bandage");
                }
                if(checkhealth == 2)
                {
                    sendErrorMessage(playerid, "Lengan kanan anda terluka silahkan gunakan bandage");
                }
                if(checkhealth == 3)
                {
                    sendErrorMessage(playerid, "Kedua lengan anda terluka silahkan gunakan bandage");
                }
                UseGun[playerid] = 0;
                ResetPlayerWeapons(playerid);

                return 1;
            }
            sendSuccessMessage(playerid, "Sukses memakai senjata di slot 2 inventory anda");
            UseGun[playerid] = 2;
            return 1;
        }
        else if(!strcmp(item, "slot3", true)){
            if(Player[playerid][pWeap3] == 0)
                return sendErrorMessage(playerid, "Anda tidak memiliki senjata di slot ketiga");
            if(playerActivity[playerid] == 1)
                return sendErrorMessage(playerid, "Anda sedang beraktivitas");
            ResetPlayerWeapons(playerid);
            new checkhealth = checkArmHealth(playerid);
            if(checkhealth > 0)
            {
                if(checkhealth == 1)
                {
                    sendErrorMessage(playerid, "Lengan kiri anda terluka silahkan gunakan bandage");
                }
                if(checkhealth == 2)
                {
                    sendErrorMessage(playerid, "Lengan kanan anda terluka silahkan gunakan bandage");
                }
                if(checkhealth == 3)
                {
                    sendErrorMessage(playerid, "Kedua lengan anda terluka silahkan gunakan bandage");
                }
                UseGun[playerid] = 0;
                ResetPlayerWeapons(playerid);

                return 1;
            }
            GivePlayerWeapon(playerid, Player[playerid][pWeap3], Player[playerid][pAmmo3]);
            UseGun[playerid] = 3;
            return sendSuccessMessage(playerid, "Sukses memakai senjata di slot 3 inventory anda");
        }
        sendErrorMessage(playerid, "Item tidak valid silahkan lihat item yang ada dengan perintah /inventory");
    }
    if(!strcmp(command, "/inventory", true) || !strcmp(command, "/items", true) || !strcmp(command, "/i", true))
    {
        showInventory(playerid, playerid);
        return 1;
    }
    return 0;
}