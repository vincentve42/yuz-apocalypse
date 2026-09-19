#include <YSI_Coding\y_hooks>

new objectAirdrop = INVALID_OBJECT_ID;

new airDropObjectTimer;


forward destroyAirDropObject(Float:x,Float:y,Float:z);
public destroyAirDropObject(Float:x,Float:y,Float:z)
{
    DestroyObject(objectAirdrop);
    objectAirdrop = INVALID_OBJECT_ID;
    new count = 0;
    for(new i =0; i<MAX_DEATH_LOOT; i++)
    {
        if(count == 2)
            return 1;
        if(deathObject[i] == -1)
        {
            new Float:randX;
            new Float:randY;
            new Float:randZ;
            randX = float(random(8) - 4);
            randY = float(random(8) - 4);
            MapAndreas_FindZ_For2DCoord(x + randX, y + randY, randZ);
            new models;
            new weap;
            new ammo;
            new rand = random(17) + 22;
            models = getWeaponPickupModel(rand);
            weap = rand;
            new randAmmo = random(50) + 10;
            ammo = randAmmo;
            MapAndreas_FindZ_For2DCoord(x, y, z);
            deathObject[i] = CreateDynamicPickup(models, 1,x + randX,y + randY,randZ + 0.5,-1);
            deathItem[deathObject[i]][dX] = x + randX;
            deathItem[deathObject[i]][dY] = y + randY;
            deathItem[deathObject[i]][dZ] = randZ + 0.5;
            deathItem[deathObject[i]][dWeapon] = weap;
            deathItem[deathObject[i]][dAmmo] = ammo;
            
                    
            count++;

                
        }
    }
    
    return 1;
}
hook OnGameModeInit(){
    new rand = 3600000 + random(1800000);
    SetTimer("createAirDrop", rand, true);
    return 1;
}
forward createAirDrop();
public createAirDrop()
{
    if(objectAirdrop != INVALID_OBJECT_ID)
    {
        DestroyObject(objectAirdrop);
        KillTimer(airDropObjectTimer);
        objectAirdrop = INVALID_OBJECT_ID;
    }
    new Float:x;

    new Float:y;

    new Float:findZ = 0.0;
    do{

        x = float(random(5000) - 2500);
        y = float(random(5000) - 2500);
        MapAndreas_FindZ_For2DCoord(x, y, findZ);
    }
    while(findZ <= 0.0);
    objectAirdrop = CreateObject(2903, x,y, findZ+200.0, 0.0 ,0.0 ,0.0);

    new Float:selisih = 200.0;

    MoveObject(objectAirdrop, x, y, findZ + 7.0, 5.0);

    airDropObjectTimer = SetTimerEx("destroyAirDropObject", 40000, false, "fff", x, y, findZ);

    sendUniversalRadioMessage("Sebuah pesawat menjatuhkan supply silahkan check di map anda");

    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && !IsPlayerNPC(i)  && playerUseRadio[i] == 1 && playerFreq[i] == 1){
            SetPlayerCheckpoint(i,x, y, findZ, 3.0);
        }
    }
}

hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/createairdrop", true)){
        if(Player[playerid][pAdmin] < 4)
            return sendErrorMessage(playerid, "Anda harus menjadi admin level 4");
        createAirDrop();
        sendSuccessMessage(playerid, "Sukses membuat airdrop!");
        return 1;
    }
    if(!strcmp(cmdtext, "/gotoairdrop", true)){
        if(Player[playerid][pAdmin] < 4)
            return sendErrorMessage(playerid, "Anda harus menjadi admin level 4");
        new Float:x, Float:y, Float:z;
        GetObjectPos(objectAirdrop, x, y, z);
        SetPlayerPos(playerid, x, y,z);
        return 1;
    }
    return 0;
}