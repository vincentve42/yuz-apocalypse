#include <YSI_Coding\y_hooks>
new vidzz;
new npcTruck = INVALID_PLAYER_ID;
new Float:npcTruckDmgAmount;
new truckWeapon[] = {35, 38};
forward startTruck();

hook OnGameModeInit()
{  
    new rand = random(1800000) + 1800000;
    SetTimer("startTruck", rand, true);
}

public startTruck(){
    if(npcTruck != INVALID_PLAYER_ID)
    {
        FCNPC_Destroy(npcTruck);
        DestroyVehicle(vidzz);
        npcTruckDmgAmount = 0.0;
    }
    vidzz = CreateVehicle(433,2678.8406,-2445.3979,14.4665,70.8140, -1, -1, -1);
    vehicleInfo[vidzz][vFuel] = 1000;
    vehicleInfo[vidzz][vLock] = 0;
    npcTruck = FCNPC_Create("TruckDriver");
    FCNPC_SetHealth(npcTruck, 100000.0);
    FCNPC_Spawn(npcTruck,287, 0.0, 0.0, 0.0);
    FCNPC_PutInVehicle(npcTruck, vidzz, 0);
    FCNPC_StartPlayingPlayback(npcTruck, "heli", FCNPC_INVALID_RECORD_ID);
    sendUniversalRadioMessage("Truk tentara telah meninggalkan pelabuhan di los santos");
    return 1;
}
stock destroyTruck()
{
    DestroyVehicle(vidzz);
    FCNPC_Destroy(npcTruck);
    npcTruckDmgAmount = 0.0;
}
hook FCNPC_OnFinishPlayback(npcid){
    if(npcid == npcTruck)
    {
        destroyTruck();
    }
    return 1;

}
hook OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/starttruck", true))
    {
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan admin level 4");
        }
        startTruck();
        return sendSuccessMessage(playerid, "Sukses menjalankan npc truck");
    }
    if(!strcmp(cmdtext, "/gototruck", true))
    {
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan admin level 4");
        }
        new Float:x, Float:y, Float:z;
        GetVehiclePos(vidzz, x, y, z);
        SetPlayerPos(playerid, x,y, z);

        return sendSuccessMessage(playerid, "Sukses teleport ke truck");
    }
    return 0;
}
