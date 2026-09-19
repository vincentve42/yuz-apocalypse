#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_VEH_MENU)
    {
        new count = 0;
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playerName,sizeof(playerName));
        if(response){
            for(new i=0; i<MAX_CUSTOM_VEH; i++)
            {
                if(vehicleId[i] != INVALID_VEHICLE_ID)
                {
                    if(isOwnerOfVeh2(playerName, vehicleInfo[vehicleId[i]][ownerName]))
                    {
                        if(listitem == count){
                            ShowPlayerDialog(playerid, DIALOG_VEH_INTERACTION, DIALOG_STYLE_TABLIST_HEADERS,"Manage Kendaraan", "Interaksi\tKeterangan\nLokasi\tMemberitahu player lokasi kendaraan melalui checkpoint\nKunci\tMengunci atau membuka kendaraan\nBagasi Kendaraan\tMemasukan atau mengambil item dari bagasi\nJual kendaraan ke server\tMenjual kendaraan kepada server\nMemberi kendaraan\tMemberi kendaraan kepada player lain", "Pilih", "Batal");
                            tempVehId[playerid] = vehicleId[i];
                            tempVehGlobalID[playerid] = i;
                            return 1;
                        }
                        count++;
                    }
                }
            }    
        }
        
    }
    if(dialogid == DIALOG_VEH_INTERACTION)
    {
        if(response){
            switch(listitem){
                case 0:
                {
                    if(tempVehId[playerid] == INVALID_VEHICLE_ID)
                    {
                        return sendErrorMessage(playerid, "Kendaraan anda tidak valid");
                    }
                    if(!isOwnerOfVeh(playerid, vehicleInfo[tempVehId[playerid]][ownerName]))
                    {
                        return sendErrorMessage(playerid, "Anda bukan pemilik kendaraan tersebut");
                    }
                    new Float:x, Float:y, Float:z;
                    GetVehiclePos(tempVehId[playerid], x, y, z);
                    SetPlayerCheckpoint(playerid,x, y, z,3.0);
                    new success[128];
                    format(success, sizeof(success), "Anda berhasil melakukan tracking terhadap kendaraan id %d", tempVehId[playerid]);
                    tempVehId[playerid] = INVALID_VEHICLE_ID;
                    tempVehGlobalID[playerid] = 0;
                    return sendSuccessMessage(playerid, success);
                }
                case 1:
                {
                    if(tempVehId[playerid] == INVALID_VEHICLE_ID)
                    {
                        return sendErrorMessage(playerid, "Kendaraan anda tidak valid");
                    }
                    if(!isOwnerOfVeh(playerid, vehicleInfo[tempVehId[playerid]][ownerName]))
                    {
                        return sendErrorMessage(playerid, "Anda bukan pemilik kendaraan tersebut");
                    }
                    new Float:x, Float:y, Float:z;
                    GetVehiclePos(tempVehId[playerid], x, y, z);
                    if(!IsPlayerInRangeOfPoint(playerid,3.0, x, y, z))
                    {
                        tempVehGlobalID[playerid] = 0;
                        tempVehId[playerid] = INVALID_VEHICLE_ID;
                        return sendErrorMessage(playerid, "Anda tidak berada di dekat kendaraan yang dituju!");
                    }
                    if(vehicleInfo[tempVehId[playerid]][vLock] == 0)
                    {
                        vehicleInfo[tempVehId[playerid]][vLock] = 1;
                        tempVehGlobalID[playerid] = 0;
                        tempVehId[playerid] = INVALID_VEHICLE_ID;
                        return sendSuccessMessage(playerid, "Anda berhasil mengunci kendaraan anda");
                    }
                    if(vehicleInfo[tempVehId[playerid]][vLock] == 1)
                    {
                        tempVehGlobalID[playerid] = 0;
                        vehicleInfo[tempVehId[playerid]][vLock] = 0;
                        tempVehId[playerid] = INVALID_VEHICLE_ID;
                        return sendSuccessMessage(playerid, "Anda berhasil membuka kendaraan anda");
                    }
                }
                case 2:{
                   new Float:x, Float:y, Float:z;
                   GetVehiclePos(tempVehId[playerid], x, y, z);
                   if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
                   {
                        tempVehGlobalID[playerid] = 0;
                        tempVehId[playerid] = INVALID_VEHICLE_ID;
                        return sendErrorMessage(playerid, "Anda tidak berada di dekat kendaraan yang dituju!");
                   }
                   new sayuz[1024];
                   format(sayuz, sizeof(sayuz), "Nama Item\tJumlah");
                   if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk1]) <= 3)
                   {
                        format(sayuz, sizeof(sayuz), "%s\nKosong\t-1", sayuz);
                   }
                   if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk1]) > 3)
                   {
                        format(sayuz, sizeof(sayuz), "%s\n%s\t"EMBED_YELLOW"%d"EMBED_WHITE"", sayuz, vehicleInfo[tempVehId[playerid]][vTrunk1], vehicleInfo[tempVehId[playerid]][vAmount1]);
                   }
                   if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk2]) <= 3)
                   {
                        format(sayuz, sizeof(sayuz), "%s\nKosong\t-1", sayuz);
                   }
                   if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk2]) > 3)
                   {
                        format(sayuz, sizeof(sayuz), "%s\n%s\t"EMBED_YELLOW"%d"EMBED_WHITE"", sayuz, vehicleInfo[tempVehId[playerid]][vTrunk2], vehicleInfo[tempVehId[playerid]][vAmount2]);
                   }
                   if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk3]) <= 3)
                   {
                        format(sayuz, sizeof(sayuz), "%s\nKosong\t-1", sayuz);
                   }
                   if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk3]) > 3)
                   {    
                        format(sayuz, sizeof(sayuz), "%s\n%s\t"EMBED_YELLOW"%d"EMBED_WHITE"", sayuz, vehicleInfo[tempVehId[playerid]][vTrunk3], vehicleInfo[tempVehId[playerid]][vAmount3]);
                   }
                   ShowPlayerDialog(playerid, DIALOG_TRUNK, DIALOG_STYLE_TABLIST_HEADERS, "Bagasi Kendaraan", sayuz, "Pilih", "Batal");
                }
                case 3:
                {
                    new str[256];
                    format(str, sizeof(str), "Apakah anda ingin menjual kendaraan"EMBED_YELLOW" %s("EMBED_GREEN"%d) "EMBED_WHITE"kepada server?", GetCarName(tempVehId[playerid]), tempVehId[playerid]);
                    ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_SERVER, DIALOG_STYLE_MSGBOX, "Jual Kendaraan", str, "Jual", "Batal");
                }
                case 4:
                {
                    ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"Masukan ID Player", "Selesai", "Batal");
                }
            }
        }
    }
    if(dialogid == DIALOG_JUAL_VEH_SERVER)
    {
        if(response){
            if(tempVehId[playerid] == INVALID_VEHICLE_ID)
            {
                return sendErrorMessage(playerid, "Kendaraan anda tidak valid");
            }
            if(!isOwnerOfVeh(playerid, vehicleInfo[tempVehId[playerid]][ownerName]))
            {
                return sendErrorMessage(playerid, "Anda bukan pemilik kendaraan tersebut");
            }
            new vehFile[128];
            format(vehFile, sizeof(vehFile), "Veh/%d.ini",tempVehGlobalID[playerid]);
            dini_Remove(vehFile);
            GiveMoney(playerid, 50000);
            resetVehVar(tempVehId[playerid]);
            new str[512];
            format(str, sizeof(str), "Berhasil menjual kendaraan "EMBED_YELLOW"%s(%d)"EMBED_WHITE" seharga"EMBED_GREEN" 50.000"EMBED_WHITE" kepada server",GetCarName(tempVehId[playerid]), tempVehId[playerid]);
            sendSuccessMessage(playerid,str);
            vehicleId[tempVehGlobalID[playerid]] = INVALID_VEHICLE_ID;
            tempVehGlobalID[playerid] = 0;
            DestroyVehicle(tempVehId[playerid]);
            tempVehId[playerid] = INVALID_VEHICLE_ID;
            return 1;
        }
        if(!response){
            tempVehId[playerid] = INVALID_VEHICLE_ID;
            tempVehGlobalID[playerid] = 0;
        }
    }
    if(dialogid == DIALOG_JUAL_VEH_PLAYER)
    {
        if(response){
            new target;
            if(sscanf(inputtext,"d", target)){
                return ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"ID Player tidak valid!\nMasukan ID Player", "Selesai", "Batal");
            }
            if(playerid == target){
                return ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"ID Player tidak valid!\nMasukan ID Player", "Selesai", "Batal");
            }
            if(!IsPlayerConnected(playerid) || IsPlayerNPC(playerid))
            {
                return ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"Player tidak terkoneksi!\nMasukan ID Player", "Selesai", "Batal");
            }
            new Float:x, Float:y, Float:z;
            GetVehiclePos(tempVehId[playerid], x, y, z);
            if(!IsPlayerInRangeOfPoint(playerid, 7.0, x, y, z))
            {
                return ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"Anda tidak berada di dekat kendaraan\nMasukan ID Player", "Selesai", "Batal");
            }
            new Float:xx, Float:yy, Float:zz;
            GetPlayerPos(target, xx, yy, zz);
            if(!IsPlayerInRangeOfPoint(playerid, 7.0, xx, yy, zz))
            {
                return ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"Anda tidak berada di dekat player yang dituju\nMasukan ID Player", "Selesai", "Batal");
            }
            if(isPlayerVehSlotFull(target))
            {
                tempVehId[playerid] = INVALID_VEHICLE_ID;
                tempVehGlobalID[playerid] = 0;
                return sendErrorMessage(playerid, "Slot Kendaraan Player yang ingin dituju penuh");
            }
            tempSellVeh[playerid] = target;
            new targetName[MAX_PLAYER_NAME];
            new playerName[MAX_PLAYER_NAME];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new str[512];
            format(str, sizeof(str), "Apakah anda ingin menjual kendaraan "EMBED_YELLOW"%s(%d)"EMBED_WHITE" kepada %s?", GetCarName(tempVehId[playerid]), tempVehId[playerid], targetName);
            ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER_CONFIRM, DIALOG_STYLE_MSGBOX, "Jual Kendaraan", str, "Jual", "Batal");
        }   
        if(!response)
        {
            tempVehId[playerid] = INVALID_VEHICLE_ID;
            tempVehGlobalID[playerid] = 0;
        }
    }
    if(dialogid == DIALOG_JUAL_VEH_PLAYER_CONFIRM)
    {
        if(response){
            new target = tempSellVeh[playerid];
            new Float:x, Float:y, Float:z;
            GetVehiclePos(tempVehId[playerid], x, y, z);
            if(!IsPlayerInRangeOfPoint(playerid, 7.0, x, y, z))
            {
                return ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"Anda tidak berada di dekat kendaraan\nMasukan ID Player", "Selesai", "Batal");
            }
            new Float:xx, Float:yy, Float:zz;
            GetPlayerPos(target, xx, yy, zz);
            if(!IsPlayerInRangeOfPoint(playerid, 7.0, xx, yy, zz))
            {
                return ShowPlayerDialog(playerid, DIALOG_JUAL_VEH_PLAYER, DIALOG_STYLE_INPUT,"Jual Kendaraan" ,"Anda tidak berada di dekat player yang dituju\nMasukan ID Player", "Selesai", "Batal");
            }
            
            new targetName[MAX_PLAYER_NAME];
            new playerName[MAX_PLAYER_NAME];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(target, targetName, sizeof(targetName));
            new success[512];
            new info[512];
            format(success, sizeof(success), "Anda berhasil memberikan kendaraan "EMBED_YELLOW"%s(%d)"EMBED_WHITE" kepada %s", GetCarName(tempVehId[playerid]), tempVehId[playerid], targetName);
            sendSuccessMessage(playerid, success);
            format(info, sizeof(info), "%s memberikan anda kendaraan "EMBED_YELLOW"%s(%d)"EMBED_WHITE"",targetName, GetCarName(tempVehId[playerid]), tempVehId[playerid]);
            sendInfoMessage(target, info);
            format(vehicleInfo[tempVehId[playerid]][ownerName], DINI_MAX_STRING, "%s", targetName);
            tempVehId[playerid] = INVALID_VEHICLE_ID;
            tempVehGlobalID[playerid] = 0;
        }
        if(!response){
            tempVehId[playerid] = INVALID_VEHICLE_ID;
            tempVehGlobalID[playerid] = 0;
            tempSellVeh[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_CONFIRM_REPAIR)
    {
        if(response){
            sendInfoMessage(playerid, "Mencoba memperbaiki kendaraan");
            setRepairActivity(playerid);
            Player[playerid][pScrap] -= 100;
        }
        if(!response){
            tempRepair[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_CONFIRM_REFUEL)
    {
        if(response){
            sendInfoMessage(playerid, "Mencoba mengisi bensin");
            setFuelActivity(playerid);
            Player[playerid][pGas] -= 1;
            
        }
        if(!response){
            tempFuel[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_BUY_VEH){
        if(response){
            if(Player[playerid][pMoney] < getCarPrice(playerSelectedVehModel[playerid]))
            {
                new error[256];
                format(error, sizeof(error), "Anda setidaknya harus memiliki uang sebanyak "EMBED_GREEN"%d"EMBED_WHITE" untuk membeli kendaraan %s", getCarPrice(playerSelectedVehModel[playerid]),GetCarName( playerSelectedVehModel[playerid]));
                playerInDealerShip[playerid] = 0;
                return sendErrorMessage(playerid, error);
            }
            TakeMoney(playerid, getCarPrice(playerSelectedVehModel[playerid]));
            switch(playerInDealerShip[playerid]){
                case 1:
                {
                    createVehicleExx(playerid, playerSelectedVehModel[playerid], 1, 1, -2190.2839,-2440.4727,30.6322);
                }
                case 2:
                {
                    createVehicleExx(playerid, playerSelectedVehModel[playerid], 1, 1, 2300.6377,8.5897,26.4844);
                }
                case 3:{
                    createVehicleExx(playerid, playerSelectedVehModel[playerid], 1, 1, -2224.4536,2344.0862,4.9843 );
                }
            }
            new success[128];
            format(success, sizeof(success), "Anda berhasil membeli mobil "EMBED_YELLOW"%s "EMBED_WHITE"seharga "EMBED_GREEN"%d",GetVehModelName( playerSelectedVehModel[playerid]),getCarPrice(playerSelectedVehModel[playerid]));
            sendSuccessMessage(playerid, success);
        }
        if(!response){
            playerInDealerShip[playerid] = 0;
            playerSelectedVehModel[playerid] = 0;
        }
    }
    if(dialogid == DIALOG_TRUNK){
        if(response){
            tempTrunk[playerid] = listitem + 1;
            switch(tempTrunk[playerid]){
                case 1:{
                    if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk1]) <= 1)
                    {
                        if(UseGun[playerid] != 0)
                        {
                            simpanKeTrunk(playerid, tempVehId[playerid], UseGun[playerid], tempTrunk[playerid]);
                            UseGun[playerid] = 0;
                        }  
            
                    }
                    else
                    {
                            
                        new weapid = getWeaponIdFromName(playerid, vehicleInfo[tempVehId[playerid]][vTrunk1]);
                        if(weapid != 0)
                        {
                            
                            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, weapid))
                            {
                                return sendErrorMessage(playerid, "Slot senjata anda penuh");
                            }
                            if(isWeapFull(playerid) && isWeapHaveSameModel(playerid, weapid))
                            {
                                giveAmmo(playerid, weapid, vehicleInfo[tempVehId[playerid]][vAmount1]);
                                new success[128];
                                format(success, sizeof(success), "Anda berhasil mengambil ammo senjata %s sebanyak %d", vehicleInfo[tempVehId[playerid]][vTrunk1],vehicleInfo[tempVehId[playerid]][vAmount1]);
                                vehicleInfo[tempVehId[playerid]][vAmount1] = 0;
                                return sendSuccessMessage(playerid, success);
                            }
                            if(!isWeapFull(playerid)){
                                setWeapon(playerid, weapid);
                                new success[128];
                                format(success, sizeof(success), "Anda berhasil mengambil senjata %s dengan ammo sebanyak %d", vehicleInfo[tempVehId[playerid]][vTrunk1],vehicleInfo[tempVehId[playerid]][vAmount1]);
                                giveAmmo(playerid, weapid, vehicleInfo[tempVehId[playerid]][vAmount1]);
                                format(vehicleInfo[tempVehId[playerid]][vTrunk1],DINI_MAX_STRING, "");
                                vehicleInfo[tempVehId[playerid]][vAmount1] = 0;
                                
                                return sendSuccessMessage(playerid, success);
                            }
                           
                        }
                    }
                }
                case 2:
                {
                    if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk2]) <= 1)
                    {
                        if(UseGun[playerid] != 0)
                        {
                            simpanKeTrunk(playerid, tempVehId[playerid], UseGun[playerid], tempTrunk[playerid]);
                            UseGun[playerid] = 0;
                        } 
                       
                    }
                    else
                    {
                            
                        new weapid = getWeaponIdFromName(playerid, vehicleInfo[tempVehId[playerid]][vTrunk2]);
                        if(weapid != 0)
                        {
                
                            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, weapid))
                            {
                                return sendErrorMessage(playerid, "Slot senjata anda penuh");
                            }
                            if(isWeapFull(playerid) && isWeapHaveSameModel(playerid, weapid))
                            {
                                giveAmmo(playerid, weapid, vehicleInfo[tempVehId[playerid]][vAmount2]);
                                new success[128];
                                format(success, sizeof(success), "Anda berhasil mengambil ammo senjata %s sebanyak %d", vehicleInfo[tempVehId[playerid]][vTrunk2],vehicleInfo[tempVehId[playerid]][vAmount2]);
                                vehicleInfo[tempVehId[playerid]][vAmount2] = 0;
                                return sendSuccessMessage(playerid, success);
                            }
                            if(!isWeapFull(playerid)){
                                setWeapon(playerid, weapid);
                                new success[128];
                                format(success, sizeof(success), "Anda berhasil mengambil senjata %s dengan ammo sebanyak %d", vehicleInfo[tempVehId[playerid]][vTrunk2],vehicleInfo[tempVehId[playerid]][vAmount2]);
                                giveAmmo(playerid, weapid, vehicleInfo[tempVehId[playerid]][vAmount2]);
                                format(vehicleInfo[tempVehId[playerid]][vTrunk2],DINI_MAX_STRING, "");
                                vehicleInfo[tempVehId[playerid]][vAmount2] = 0;
                                
                                return sendSuccessMessage(playerid, success);
                            }
                        }
                    }
                }
                case 3:
                {
                    if(strlen(vehicleInfo[tempVehId[playerid]][vTrunk3]) <= 1)
                    {
                        if(UseGun[playerid] != 0)
                        {
                            simpanKeTrunk(playerid, tempVehId[playerid], UseGun[playerid], tempTrunk[playerid]);
                            UseGun[playerid] = 0;
                        }
                        
            
                    }
                    else
                    {
                            
                        new weapid = getWeaponIdFromName(playerid, vehicleInfo[tempVehId[playerid]][vTrunk3]);
                        if(weapid != 0)
                        {
                            
                            if(isWeapFull(playerid) && !isWeapHaveSameModel(playerid, weapid))
                            {
                                return sendErrorMessage(playerid, "Slot senjata anda penuh");
                            }
                            if(isWeapFull(playerid) && isWeapHaveSameModel(playerid, weapid))
                            {
                                giveAmmo(playerid, weapid, vehicleInfo[tempVehId[playerid]][vAmount3]);
                                new success[128];
                                format(success, sizeof(success), "Anda berhasil mengambil ammo senjata %s sebanyak %d", vehicleInfo[tempVehId[playerid]][vTrunk3],vehicleInfo[tempVehId[playerid]][vAmount3]);
                                vehicleInfo[tempVehId[playerid]][vAmount3] = 0;
                                return sendSuccessMessage(playerid, success);
                            }
                            if(!isWeapFull(playerid)){
                                setWeapon(playerid, weapid);
                                new success[128];
                                format(success, sizeof(success), "Anda berhasil mengambil senjata %s dengan ammo sebanyak %d", vehicleInfo[tempVehId[playerid]][vTrunk3],vehicleInfo[tempVehId[playerid]][vAmount3]);
                                giveAmmo(playerid, weapid, vehicleInfo[tempVehId[playerid]][vAmount3]);
                                format(vehicleInfo[tempVehId[playerid]][vTrunk3],DINI_MAX_STRING, "");
                                vehicleInfo[tempVehId[playerid]][vAmount3] = 0;
                                
                                return sendSuccessMessage(playerid, success);
                            }
                           
                        }
                    }
                }
            }
            
        }
    }
    return 1;
}
