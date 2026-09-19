#include <YSI_Coding\y_hooks>
new tempVehId[MAX_PLAYERS];
new tempVehGlobalID[MAX_PLAYERS];
new tempSellVeh[MAX_PLAYERS];
new tempRepair[MAX_PLAYERS];
new tempFuel[MAX_PLAYERS];
new playerInDealerShip[MAX_PLAYERS];
new playerSelectedVehModel[MAX_PLAYERS];
new tempTrunk[MAX_PLAYERS];
enum VEHICLE{
    ownerName[DINI_MAX_STRING],
    vModel,
    Float:vHealth,
    Float:vX,
    Float:vY,
    Float:vZ,
    Float:vRotation,
    vColor1, 
    vColor2,
    vFuel,
    vLock,
    vTrunk1[DINI_MAX_STRING],
    vAmount1,
    vTrunk2[DINI_MAX_STRING],
    vAmount2,
    vTrunk3[DINI_MAX_STRING],
    vAmount3,
};
forward updateRepairProgress(playerid, Float:bar, type, amount);
#define MAX_CUSTOM_VEH 2000
new vehicleInfo[MAX_CUSTOM_VEH][VEHICLE];
new vehicleId[MAX_CUSTOM_VEH];
new vehicleFuelTimer[MAX_CUSTOM_VEH];

hook OnPlayerSpawn(playerid){
    tempVehId[playerid] = -1;
    return 1;
}
hook OnGameModeInit(){
    // print("1");

    CreateVehicle(411, 1958.0, 1343.0, 15.0, 0.0, -1, -1, -1);

    for(new i=0; i<MAX_CUSTOM_VEH; i++)
    {
        vehicleId[i] = INVALID_VEHICLE_ID;
    }   
    return 1;
}
forward updateFuel(playerid, vehicle);

public OnVehicleStreamIn(vehicleid, forplayerid)
{
    return 1;
}
forward isOwnerOfVeh(playerid, ownername[]);
forward setRepairActivity(playerid);
forward updateFuelProgress(playerid, Float:bar);
forward setFuelActivity(playerid);

hook OnPlayerConnect(playerid){
    tempVehId[playerid] = -1;
    for(new i=0; i<MAX_CUSTOM_VEH; i++)
    {
        new vehFile[128];
        format(vehFile, sizeof(vehFile), "Veh/%d.ini", i);
        if(vehicleId[i] == INVALID_VEHICLE_ID)
        {
            if(dini_Exists(vehFile)){
                new Float:x, Float:y, Float:z, Float:rotation;
                new Float:health;
                new col1, col2;
                new vehmodel, fuel, lock;

                new nName[DINI_MAX_STRING];
                nName = dini_Get(vehFile, "Owner");
                x = dini_Float(vehFile, "X");
                y = dini_Float(vehFile, "Y");
                z = dini_Float(vehFile, "Z");
                rotation = dini_Float(vehFile, "Rot");
                health = dini_Float(vehFile, "Health");
                col1 = dini_Int(vehFile, "Col1");
                col2 = dini_Int(vehFile, "Col2");
                vehmodel = dini_Int(vehFile, "Model");
                fuel = dini_Int(vehFile, "Fuel");
                lock = dini_Int(vehFile, "Lock");
                if(isOwnerOfVeh(playerid, nName))
                {
                    if(health <= 250)
                    {
                        health = 390.0;
                    }
                    vehicleId[i] = CreateVehicle(vehmodel, x, y, z, rotation, col1, col2, -1);
                    SetVehicleHealth(vehicleId[i], health);
                   
                    
                    format(vehicleInfo[vehicleId[i]][ownerName], DINI_MAX_STRING, "%s", nName);
                    vehicleInfo[vehicleId[i]][vModel] = vehmodel;
                    vehicleInfo[vehicleId[i]][vX] = x;
                    vehicleInfo[vehicleId[i]][vY] = y;
                    vehicleInfo[vehicleId[i]][vZ] = z;
                    vehicleInfo[vehicleId[i]][vRotation] = rotation;
                    vehicleInfo[vehicleId[i]][vColor1] = col1;
                    vehicleInfo[vehicleId[i]][vColor2] = col2;
                    vehicleInfo[vehicleId[i]][vHealth] = health;
                    vehicleInfo[vehicleId[i]][vFuel] = fuel;
                    vehicleInfo[vehicleId[i]][vLock] = lock;
                    vehicleInfo[vehicleId[i]][vTrunk1] = dini_Get(vehFile, "Trunk1");
                    vehicleInfo[vehicleId[i]][vTrunk2] = dini_Get(vehFile, "Trunk2");
                    vehicleInfo[vehicleId[i]][vTrunk3] = dini_Get(vehFile, "Trunk3");
                    vehicleInfo[vehicleId[i]][vAmount1] = dini_Int(vehFile, "Amount1");
                    vehicleInfo[vehicleId[i]][vAmount2] = dini_Int(vehFile, "Amount2");
                    vehicleInfo[vehicleId[i]][vAmount3] = dini_Int(vehFile, "Amount3");
                    
                }
            }
        }
    }
    return 1;
}
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{	
    // Get the damage status of all the components
    new panels, doors, lights, tires;	
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
 
    // Set the tires to 0, which means none are popped
    tires = 0;
 
    // Update the vehicle's damage status with unpopped tires
    UpdateVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    return 1;	
}
hook OnPlayerDisconnect(playerid, reason){
    if(!IsPlayerNPC(playerid)){
        if(isPlayerLogged[playerid] != 0 && Logged[playerid] != 0)
        {
            for(new i=0; i<MAX_CUSTOM_VEH; i++)
            {
                if(vehicleId[i] != INVALID_VEHICLE_ID)
                {
                    new vehFile[128];
                    format(vehFile, sizeof(vehFile), "Veh/%d.ini", i);
                    if(isOwnerOfVeh(playerid, vehicleInfo[vehicleId[i]][ownerName]) && strlen(vehicleInfo[vehicleId[i]][ownerName]) > 0 && dini_Exists(vehFile))
                    {
                        
                        
                        new Float:rotation;
                        new Float:x, Float:y, Float:z;
                        new Float:health;
                        GetVehiclePos(vehicleId[i], x, y, z);
                        GetVehicleZAngle(vehicleId[i], rotation);
                        GetVehicleHealth(vehicleId[i], health);

                        
                        
                        dini_Set(vehFile, "Owner", vehicleInfo[vehicleId[i]][ownerName]);
                        dini_IntSet(vehFile, "Model", vehicleInfo[vehicleId[i]][vModel]);
                        dini_IntSet(vehFile, "Col1",vehicleInfo[vehicleId[i]][vColor1]);
                        dini_IntSet(vehFile, "Col2",vehicleInfo[vehicleId[i]][vColor2]);
                        dini_FloatSet(vehFile, "Rot", rotation);
                        dini_FloatSet(vehFile, "X", x);
                        dini_FloatSet(vehFile, "Y", y);
                        dini_FloatSet(vehFile, "Z", z);
                        dini_FloatSet(vehFile, "Health", health);
                        dini_IntSet(vehFile, "Fuel", vehicleInfo[vehicleId[i]][vFuel]);
                        dini_IntSet(vehFile, "Lock", vehicleInfo[vehicleId[i]][vLock]);
                        dini_Set(vehFile, "Trunk1", vehicleInfo[vehicleId[i]][vTrunk1]);
                        dini_Set(vehFile, "Trunk2", vehicleInfo[vehicleId[i]][vTrunk2]);
                        dini_Set(vehFile, "Trunk3", vehicleInfo[vehicleId[i]][vTrunk3]);
                        dini_IntSet(vehFile, "Amount1", vehicleInfo[vehicleId[i]][vAmount1]);
                        dini_IntSet(vehFile, "Amount2", vehicleInfo[vehicleId[i]][vAmount2]);
                        dini_IntSet(vehFile, "Amount3", vehicleInfo[vehicleId[i]][vAmount3]);
                        KillTimer(vehicleFuelTimer[vehicleId[i]]);
                        DestroyVehicle(vehicleId[i]);

                        vehicleId[i] = INVALID_PLAYER_ID;
                    }
        
                }
            }
        }
    }
    return 1;
}
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger){
    if(vehicleInfo[vehicleid][vLock] == 1)
    {
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid,x,y,z);
        sendErrorMessage(playerid, "Mobil terkunci!");
        SetPlayerPos(playerid, x, y, z+0.5);
        
    }
    return 1;
}
hook OnPlayerEnterCheckpoint(playerid){
    
    return 1;
}
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
 	if(newstate == PLAYER_STATE_DRIVER)
	{
        new vid = GetPlayerVehicleID(playerid);
        if(vid != 0)
        {
            new Float:health;
            new vehicleid = vid;
            GetVehicleHealth(vid, health);
            if(vehicleInfo[vid][vFuel] <= 0 || health <= 390)
            {
                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                engine = 0;
                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                sendInfoMessage(playerid, "Kendaraan anda rusak");
            }
            else
            {
                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                engine = 1;
                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
            }
        }
    }
}

hook OnPlayerUpdate(playerid){
     if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) {
	    new vehicle = GetPlayerVehicleID( playerid );
        if(vehicle != 0)
        {
            new Float:health;
            new vid = vehicle;
            new vehicleid = vehicle;
            GetVehicleHealth(vid, health);
            if(vehicleInfo[vid][vFuel] <= 0 || health <= 390)
            {
                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                engine = 0;
                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                
            }
            else
            {
                new engine, lights, alarm, doors, bonnet, boot, objective;
                GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
                engine = 1;
                SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
            }
        }

     }
    return 1;
}

public OnVehicleDeath(vehicleid, killerid){ 
   
    new Float:x, Float:y, Float:z;
    new col1, col2;
    new modelid;
    new Float:rotation;
    
    x = vehicleInfo[vehicleid][vX];
    y = vehicleInfo[vehicleid][vY];
    z = vehicleInfo[vehicleid][vZ];
    rotation = vehicleInfo[vehicleid][vRotation];
    
    modelid = vehicleInfo[vehicleid][vModel];
   
    col1 = vehicleInfo[vehicleid][vColor1];
    col2 = vehicleInfo[vehicleid][vColor2];
    
    for(new i =0; i<MAX_CUSTOM_VEH; i++)
    {
        if(vehicleId[i] == vehicleid)
        {
            DestroyVehicle(vehicleId[i]);
            vehicleId[i] = CreateVehicle(modelid,x,y,z,rotation,col1,col2, -1);
            
            SetVehicleHealth(vehicleId[i], 390);
            
            for(new j=0; j< MAX_PLAYERS; j++)
            {
                if(IsPlayerConnected(j) && !IsPlayerNPC(j))
                {
                    new name[MAX_PLAYER_NAME];
                    GetPlayerName(j ,name, sizeof(name));
                    if(strlen(name) > 0 && strcmp(name, vehicleInfo[vehicleId[i]][ownerName]) == 0)
                    {
                        new msg[256];
                        format(msg, sizeof(msg), "Kendaraan "EMBED_YELLOW"%s(%d) "EMBED_WHITE"telah rusak atau jatuh ke air", GetCarName(vehicleId[i]), vehicleId[i]);
                        sendInfoMessage(j, msg);
                        return 1;
                    }
                }
            }
            return 1;
        }
    }
    return 1;
}