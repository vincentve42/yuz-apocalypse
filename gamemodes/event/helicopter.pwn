#include <YSI_Coding\y_hooks>

new helicopterVeh;
new helicopterNpc;
new Float:helicopterDmg;
forward startHelicopter();
public startHelicopter()
{
    if(helicopterNpc != INVALID_PLAYER_ID){
        DestroyVehicle(helicopterVeh);
        FCNPC_Destroy(helicopterNpc);
        helicopterDmg = 0.0;
    }
    helicopterVeh = CreateVehicle(548,2605.7419,-2361.6089,13.5436,70.8140, -1, -1, -1);
    vehicleInfo[helicopterVeh][vFuel] = 1000;
    vehicleInfo[helicopterVeh][vLock] = 0;
    helicopterNpc = FCNPC_Create("HelicopterDriver");
    FCNPC_SetHealth(helicopterNpc, 100.0);
    FCNPC_Spawn(helicopterNpc, 287, 0.0, 0.0, 0.0);
    FCNPC_PutInVehicle(helicopterNpc, helicopterVeh, 0);
    FCNPC_StartPlayingPlayback(helicopterNpc, "roaming", FCNPC_INVALID_RECORD_ID);
    sendUniversalRadioMessage("Helikopter tentara telah meninggalkan los santos");
    return 1;
}
stock destroyHelicopter()
{
    DestroyVehicle(helicopterVeh);
    FCNPC_Destroy(helicopterNpc);
    helicopterDmg = 0.0;
    return 1;
}
hook FCNPC_OnFinishPlayback(npcid){
    if(npcid == helicopterNpc)
    {
        destroyHelicopter();
    }
    return 1;

}
hook OnGameModeInit()
{
    new rand = random(1800000) + 1800000;
    SetTimer("startHelicopter", rand, true);
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/starthelicopter", true))
    {
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan admin level 4");
        }
        startHelicopter();
        return sendSuccessMessage(playerid, "Sukses menjalankan npc helicopter");
    }
    if(!strcmp(cmdtext, "/gotohelicopter", true))
    {
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan admin level 4");
        }
        new Float:x, Float:y, Float:z;
        GetVehiclePos(helicopterVeh, x, y, z);
        SetPlayerPos(playerid, x,y, z);

        return sendSuccessMessage(playerid, "Sukses teleport ke helicopter");
    }
    return 0;
}


