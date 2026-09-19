stock isOwnerOfVeh(playerid, ownername[])
{
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    if(strlen(ownername) > 0 && strlen(playerName) > 0 && strcmp(playerName,ownername ) == 0)
    {
        return 1;
    }
    return 0;
}
stock isOwnerOfVeh2(playerName[], ownername[])
{
    if(strlen(ownername) > 0 && strlen(playerName) > 0 && strcmp(playerName,ownername ) == 0)
    {
        return 1;
    }
    return 0;
}
stock createVehicleEx(target, modelid, col1, col2){
    new Float:x, Float:y, Float:z;
    new Float:rot;
    
    GetPlayerPos(target, x, y, z);
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(target, playerName, sizeof(playerName));
    for(new i=0; i<MAX_CUSTOM_VEH; i++)
    {
        new vehFile[128];
        format(vehFile, sizeof(vehFile), "Veh/%d.ini", i);
        if(vehicleId[i] == INVALID_VEHICLE_ID && !dini_Exists(vehFile)){
            vehicleId[i] = CreateVehicle(modelid, x, y, z, 0.0, col1, col2, -1, false);
            format(vehicleInfo[vehicleId[i]][ownerName], DINI_MAX_STRING, "%s", playerName);
            vehicleInfo[vehicleId[i]][vModel] = modelid;
            vehicleInfo[vehicleId[i]][vColor1] = col1;
            vehicleInfo[vehicleId[i]][vColor2] = col2;
            vehicleInfo[vehicleId[i]][vX] = x;
            vehicleInfo[vehicleId[i]][vY] = y;
            vehicleInfo[vehicleId[i]][vZ] = z;
            vehicleInfo[vehicleId[i]][vRotation] = 0.0;
            vehicleInfo[vehicleId[i]][vFuel] = 100;
            dini_Create(vehFile);
            dini_Set(vehFile, "Owner", vehicleInfo[vehicleId[i]][ownerName]);
            dini_IntSet(vehFile, "Model", vehicleInfo[vehicleId[i]][vModel]);
            dini_IntSet(vehFile, "Col1", vehicleInfo[vehicleId[i]][vColor1]);
            dini_IntSet(vehFile, "Col2", vehicleInfo[vehicleId[i]][vColor2]);
            dini_FloatSet(vehFile, "X", vehicleInfo[vehicleId[i]][vX]);
            dini_FloatSet(vehFile, "Y", vehicleInfo[vehicleId[i]][vY]);
            dini_FloatSet(vehFile, "Z", vehicleInfo[vehicleId[i]][vZ]);
            dini_FloatSet(vehFile, "Rot", vehicleInfo[vehicleId[i]][vRotation]);
            dini_FloatSet(vehFile, "Fuel", vehicleInfo[vehicleId[i]][vFuel]);
            dini_FloatSet(vehFile, "Health", 1000.0);
            
            return 1;
        }
    }
    return 1;
}
stock createVehicleExx(target, modelid, col1, col2, Float:x, Float:y, Float:z){
    
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(target, playerName, sizeof(playerName));
    for(new i=0; i<MAX_CUSTOM_VEH; i++)
    {
        new vehFile[128];
        format(vehFile, sizeof(vehFile), "Veh/%d.ini", i);
        if(vehicleId[i] == INVALID_VEHICLE_ID && !dini_Exists(vehFile)){
            vehicleId[i] = CreateVehicle(modelid, x, y, z, 0.0, col1, col2, -1, false);
            format(vehicleInfo[vehicleId[i]][ownerName], DINI_MAX_STRING, "%s", playerName);
            vehicleInfo[vehicleId[i]][vModel] = modelid;
            vehicleInfo[vehicleId[i]][vColor1] = col1;
            vehicleInfo[vehicleId[i]][vColor2] = col2;
            vehicleInfo[vehicleId[i]][vX] = x;
            vehicleInfo[vehicleId[i]][vY] = y;
            vehicleInfo[vehicleId[i]][vZ] = z;
            vehicleInfo[vehicleId[i]][vRotation] = 0.0;
            vehicleInfo[vehicleId[i]][vFuel] = 100;
            dini_Create(vehFile);
            dini_Set(vehFile, "Owner", vehicleInfo[vehicleId[i]][ownerName]);
            dini_IntSet(vehFile, "Model", vehicleInfo[vehicleId[i]][vModel]);
            dini_IntSet(vehFile, "Col1", vehicleInfo[vehicleId[i]][vColor1]);
            dini_IntSet(vehFile, "Col2", vehicleInfo[vehicleId[i]][vColor2]);
            dini_FloatSet(vehFile, "X", vehicleInfo[vehicleId[i]][vX]);
            dini_FloatSet(vehFile, "Y", vehicleInfo[vehicleId[i]][vY]);
            dini_FloatSet(vehFile, "Z", vehicleInfo[vehicleId[i]][vZ]);
            dini_FloatSet(vehFile, "Rot", vehicleInfo[vehicleId[i]][vRotation]);
            dini_FloatSet(vehFile, "Fuel", vehicleInfo[vehicleId[i]][vFuel]);
            dini_FloatSet(vehFile, "Health", 1000.0);
            
            return 1;
        }
    }
    return 1;
}
public updateFuel(playerid, vehicle){
    if(GetPlayerVehicleID(playerid) == 0)
    {
        KillTimer(vehicleFuelTimer[vehicle]);
        return 1;
    }
    if(vehicleInfo[vehicle][vFuel] <= 0)
    {
        vehicleInfo[vehicle][vFuel] = 0;
        return 1;
    }
    vehicleInfo[vehicle][vFuel] -= 1;
    return 1;
}
stock resetVehVar(vehicle)
{
    vehicleInfo[vehicle][vModel] = 0;
    vehicleInfo[vehicle][vColor1] = 0;
    vehicleInfo[vehicle][vColor2] = 0;
    vehicleInfo[vehicle][vX] = 0.0;
    vehicleInfo[vehicle][vY] = 0.0;
    vehicleInfo[vehicle][vZ] = 0.0;
    vehicleInfo[vehicle][vRotation] = 0.0;
    vehicleInfo[vehicle][vFuel] = 0;
    vehicleInfo[vehicle][vLock] = 0;
    return 1;
}

// todo
// masih bug spawn
public updateRepairProgress(playerid, Float:bar){
	
    ActivityProgress[playerid] += bar;
    SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
    if(ActivityProgress[playerid] >= 100)
    {
            
            
        KillTimer(ActivityTimer[playerid]);
        TogglePlayerControllable(playerid, 1);
        hideActivityTextDraw(playerid);
        playerActivity[playerid] = 0;
        SetVehicleHealth(vehicleId[tempRepair[playerid]], 1000.0);
        new msg[256];
        format(msg, sizeof(msg), "Anda berhasil memperbaiki kendaraan "EMBED_YELLOW"%s(%d)", GetCarName(vehicleId[tempRepair[playerid]]), vehicleId[tempRepair[playerid]]);
        sendSuccessMessage(playerid, msg);
        tempRepair[playerid] = -1;
           
    }
    return 1;
    
}
public setRepairActivity(playerid)
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
    ActivityTimer[playerid] = SetTimerEx("updateRepairProgress", 1000, true, "if", playerid, 10.0);
  
    return 1;
}

public updateFuelProgress(playerid, Float:bar){
	
    ActivityProgress[playerid] += bar;
    SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
    if(ActivityProgress[playerid] >= 100)
    {
        
        vehicleInfo[vehicleId[tempFuel[playerid]]][vFuel] += 20;
        if(vehicleInfo[vehicleId[tempFuel[playerid]]][vFuel] >= 100)
        {
            vehicleInfo[vehicleId[tempFuel[playerid]]][vFuel] = 100;
        }
        KillTimer(ActivityTimer[playerid]);
        TogglePlayerControllable(playerid, 1);
        hideActivityTextDraw(playerid);
        playerActivity[playerid] = 0;
        new msg[256];
        format(msg, sizeof(msg), "Anda berhasil mengisi bensin kendaraan "EMBED_YELLOW"%s(%d)", GetCarName(vehicleId[tempRepair[playerid]]), vehicleId[tempRepair[playerid]]);
        sendSuccessMessage(playerid, msg);
        tempFuel[playerid] = -1;
           
    }
    
}
stock GetVehModelName(modelid)
{
	new name[128];
 
	if(400 <= modelid <= 611)
	    strcat(name, vehNames[modelid - 400]);
	else
	    name = "Unknown";
 
	return name;
}
public setFuelActivity(playerid)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
   
    ActivityProgress[playerid] = 0.0;
    showPlayerActivityTextdraw(playerid);
    TogglePlayerControllable(playerid, false);
    playerActivity[playerid] = 1;
    ApplyAnimation(playerid,"BOMBER", "BOM_Plant",4.1, 0,0,0,0, 10000,1); // anim perlu diganti
    ActivityTimer[playerid] = SetTimerEx("updateFuelProgress", 1000, true, "if", playerid, 10.0);
    return 1;
}

stock getCarPrice(model){
    switch (model){
        case 478:
        {
            return 100000;
        }
        case 482:
        {
            return 105000;
        }
        case 483:
        {
            return 105000;
        }
        case 498:
        {
            return 115000;
        }
        case 549:
        {
            return 200000;
        }
        case 468:
        {
            return 50000;
        }
    }
    return 0;
}
stock simpanKeTrunk(playerid,vid, gunslot, slottrunk)
{
    if(gunslot == 0)
        return 1;
    if(slottrunk == 0)
        return 1;
    switch(slottrunk)
    {
        case 1:
        {
            switch(gunslot){
                case 1:
                {
                    new weapon = Player[playerid][pWeap1];
                    new ammo  = Player[playerid][pAmmo1];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk1], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount1] = ammo;
                    Player[playerid][pWeap1] = 0;
                    Player[playerid][pAmmo1] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);

                }
                case 2:
                {
                    new weapon = Player[playerid][pWeap2];
                    new ammo  = Player[playerid][pAmmo2];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk1], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount1] = ammo;
                    Player[playerid][pWeap2] = 0;
                    Player[playerid][pAmmo2] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);

                }
                case 3:
                {
                    new weapon = Player[playerid][pWeap3];
                    new ammo  = Player[playerid][pAmmo3];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk1], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount1] = ammo;
                    Player[playerid][pWeap3] = 0;
                    Player[playerid][pAmmo3] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);

                }
            }
        }
        case 2:
        {
            switch(gunslot){
                case 1:
                {
                    new weapon = Player[playerid][pWeap1];
                    new ammo  = Player[playerid][pAmmo1];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk2], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount2] = ammo;
                    Player[playerid][pWeap1] = 0;
                    Player[playerid][pAmmo1] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);
                }
                case 2:
                {
                    new weapon = Player[playerid][pWeap2];
                    new ammo  = Player[playerid][pAmmo2];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk2], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount2] = ammo;
                    Player[playerid][pWeap2] = 0;
                    Player[playerid][pAmmo2] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);
                }
                case 3:
                {
                    new weapon = Player[playerid][pWeap3];
                    new ammo  = Player[playerid][pAmmo3];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk2], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount2] = ammo;
                    Player[playerid][pWeap3] = 0;
                    Player[playerid][pAmmo3] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);
                }
            }
        }
        case 3:
        {
            switch(gunslot){
                case 1:
                {
                    new weapon = Player[playerid][pWeap1];
                    new ammo  = Player[playerid][pAmmo1];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk3], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount3] = ammo;
                    Player[playerid][pWeap1] = 0;
                    Player[playerid][pAmmo1] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);
                }
                case 2:
                {
                    new weapon = Player[playerid][pWeap2];
                    new ammo  = Player[playerid][pAmmo2];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk3], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount3] = ammo;
                    Player[playerid][pWeap2] = 0;
                    Player[playerid][pAmmo2] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);
                }
                case 3:
                {
                    new weapon = Player[playerid][pWeap3];
                    new ammo  = Player[playerid][pAmmo3];
                    new weapName[64];
                    GetWeaponName(weapon, weapName, sizeof(weapName));
                    format(vehicleInfo[vid][vTrunk3], DINI_MAX_STRING, "%s", weapName);
                    vehicleInfo[vid][vAmount3] = ammo;
                    Player[playerid][pWeap3] = 0;
                    Player[playerid][pAmmo3] = 0;
                    ResetPlayerWeapons(playerid);
                    new success[128];
                    format(success, sizeof(success), "Anda sukses memasukan senjata %s ke dalam bagasi kendaraan anda", weapName);
                    return sendSuccessMessage(playerid, success);
                }
            }
        }
    }
    return 1;
}
stock getWeaponIdFromName(playerid, weapname[])
{
   
    for(new i=1; i<=38; i++)
    {
        if(i == 19 || i == 20 || i == 21 || i == 22)
        {
            continue;
        }
        new eachweapname[64];
        GetWeaponName(i, eachweapname, sizeof(eachweapname));
        
        if(strcmp(weapname, eachweapname) == 0)
        {
            return i;
        }
    }
    return 0;
}
stock isPlayerVehSlotFull(playerid){
    new count = 0;
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    for(new i=0; i<MAX_CUSTOM_VEH; i++)
    {
        if(vehicleId[i] != INVALID_VEHICLE_ID)
        {
            if(isOwnerOfVeh2(playerName, vehicleInfo[vehicleId[i]][ownerName]))
            {
                count ++;
            }
        }
    }
    if(count < Player[playerid][pVehSlot])
        return false;
    return true;
}
stock getVehSlotCount(playerid){
    new count = 0;
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    for(new i=0; i<MAX_CUSTOM_VEH; i++)
    {
        if(vehicleId[i] != INVALID_VEHICLE_ID)
        {
            if(isOwnerOfVeh2(playerName, vehicleInfo[vehicleId[i]][ownerName]))
            {
                count ++;
            }
        }
    }
    return count;
}