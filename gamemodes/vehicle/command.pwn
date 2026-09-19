#include <YSI_Coding\y_hooks>

hook OnPlayerCommandText(playerid, cmdtext[]){
    new command[128]; 
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);
    if(!strcmp(cmdtext, "/v repair", true) || !strcmp(cmdtext, "/repair", true) || !strcmp(cmdtext, "/vrepair", true) )
    {
        for(new i=0; i<MAX_CUSTOM_VEH; i++){
            if(vehicleId[i] != INVALID_VEHICLE_ID)
            {
                new Float:x, Float:y, Float:z;
            
                GetVehiclePos(vehicleId[i], x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 7.0,x, y, z))
                {
                    if(Player[playerid][pScrap] < 100)
                    {
                        return sendErrorMessage(playerid, "Anda harus memiliki 100 scrap untuk memperbaiki kendaraan!");
                    }
                    new Float:health;
                    GetVehicleHealth(vehicleId[i], health);
                    if(health >= 999)
                    {
                        return sendErrorMessage(playerid, "Kendaraan di dekat anda tidak rusak");
                    }
                    tempRepair[playerid] = i;
                    new str[256];
                    format(str, sizeof(str), "Apakah anda ingin memperbaiki kendaraan "EMBED_YELLOW"%s(%d)"EMBED_WHITE"?", GetCarName(vehicleId[i]), vehicleId[i]);
                    ShowPlayerDialog(playerid, DIALOG_CONFIRM_REPAIR, DIALOG_STYLE_MSGBOX, "Perbaiki Kendaraan", str, "Ya", "Batal");
                    return 1;
                }
            }

        }
        return sendErrorMessage(playerid, "Anda tidak berada di dekat kendaraan");
    }
    if(!strcmp(cmdtext, "/v fuel", true) || !strcmp(cmdtext, "/refuel", true) || !strcmp(cmdtext, "/vfuel", true) )
    {
        for(new i=0; i<MAX_CUSTOM_VEH; i++){
            if(vehicleId[i] != INVALID_VEHICLE_ID)
            {
                new Float:x, Float:y, Float:z;
            
                GetVehiclePos(vehicleId[i], x, y, z);
                if(IsPlayerInRangeOfPoint(playerid, 7.0,x, y, z))
                {
                    if(Player[playerid][pGas] < 1)
                    {
                        return sendErrorMessage(playerid, "Anda tidak memiliki gas tank");
                    }
                   
                    if(vehicleInfo[vehicleId[i]][vFuel] >= 80)
                    {
                        return sendErrorMessage(playerid, "Bensin kendaraan anda tidak habis");
                    }
                    tempFuel[playerid] = i;
                    new str[256];
                    format(str, sizeof(str), "Apakah anda ingin mengisi bensin kendaraan "EMBED_YELLOW"%s(%d)"EMBED_WHITE"?", GetCarName(vehicleId[i]), vehicleId[i]);
                    ShowPlayerDialog(playerid, DIALOG_CONFIRM_REFUEL, DIALOG_STYLE_MSGBOX, "Isi Bensin Kendaraan", str, "Ya", "Batal");
                    
                    return 1;
                }
            }

        }
        return sendErrorMessage(playerid, "Anda tidak berada di dekat kendaraan");
    }
    if(!strcmp(command, "/vmenu", true))
    {
        new str[1024];
        format(str, sizeof(str), "ID\tModel\tDikunci");
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        for(new i=0; i<MAX_CUSTOM_VEH; i++)
        {
            if(vehicleId[i] != INVALID_VEHICLE_ID)
            {
                if(isOwnerOfVeh2(playerName, vehicleInfo[vehicleId[i]][ownerName]))
                {
                    new locked[128];
                    if(vehicleInfo[vehicleId[i]][vLock] == 1)
                    {
                        format(locked, sizeof(locked), "%s", ""EMBED_REALRED"Terkunci");
                    }
                    else
                    {
                        format(locked, sizeof(locked), "%s", ""EMBED_GREEN"Terbuka");
                    }

                    format(str, sizeof(str), "%s\n%d\t%s\t%s",str,vehicleId[i],GetCarName(vehicleId[i]),locked);
                   
                }
            }
        }
        new judul[128];
        format(judul, sizeof(judul), "List Kendaraan ["EMBED_YELLOW"%d"EMBED_WHITE"/"EMBED_YELLOW"%d]", getVehSlotCount(playerid), Player[playerid][pVehSlot]);
        ShowPlayerDialog(playerid, DIALOG_VEH_MENU, DIALOG_STYLE_TABLIST_HEADERS, judul, str, "Pilih", "Batal");
        return 1; 
    }
    if(!strcmp(command, "/createvehicle", true)){
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan admin");
        if(Player[playerid][pAdmin] < 4)
            return sendErrorMessage(playerid, "Anda bukan admin level 4");
        new modelid, color1, color2, target;
        if(sscanf(arg1, "dddd", target,modelid, color1, color2)){
            return sendErrorMessage(playerid, "Gunakan /createvehicle [target] [model] [color1] [color2]");
        }
        return createVehicleEx(target, modelid, color1 ,color2 );
        
    }
    if(!strcmp(command, "/setvehhealth", true)){
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan admin");
        if(Player[playerid][pAdmin] < 4)
            return sendErrorMessage(playerid, "Anda bukan admin level 4");
        new modelid;
        new Float:hp;
        if(sscanf(arg1, "df", modelid,hp)){
            return sendErrorMessage(playerid, "Gunakan /createvehicle [target] [health]");
        }
        
        return SetVehicleHealth(modelid, hp);
        
    }
    return 0;
}