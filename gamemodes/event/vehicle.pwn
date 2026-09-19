public FCNPC_OnVehicleTakeDamage(npcid, issuerid, vehicleid, Float:amount, Weapid, Float:fX, Float:fY, Float:fZ){
    
    if(vehicleid == vidzz)
    {
        new Float:x, Float:y, Float:z;
        GetVehiclePos(vidzz, x, y, z);
        npcTruckDmgAmount += amount;
        if(npcTruckDmgAmount >= 1000.0)
        {
            FCNPC_StopPlayingPlayback(npcTruck);
            for(new i =0; i<MAX_DEATH_LOOT; i++)
            {
                if(deathObject[i] == -1)
                {
                    new models;
                    new weap;
                    new ammo;
                    new rand = random(sizeof(truckWeapon));
                    models = getWeaponPickupModel(truckWeapon[rand]);
                    weap = truckWeapon[rand];
                    new randAmmo = random(50) + 10;
                    ammo = randAmmo;
                    deathObject[i] = CreateDynamicPickup(models, 1,x,y,z,-1);
                    deathItem[deathObject[i]][dX] = x;
                    deathItem[deathObject[i]][dY] = y;
                    deathItem[deathObject[i]][dZ] = z;
                    deathItem[deathObject[i]][dWeapon] = weap;
                    deathItem[deathObject[i]][dAmmo] = ammo;
                    destroyTruck();
                    CreateExplosion(x, y, z, 2, 10.0);
                    CreateExplosion(x+2.0, y, z, 2, 10.0);
                    CreateExplosion(x, y+2.0, z, 2, 10.0);
                    CreateExplosion(x+2.0, y-2.0, z, 2, 20.0);
                    return 1;

                }
            }
            
        }
    }
    if(vehicleid == helicopterVeh)
    {
        new Float:x, Float:y, Float:z;
        GetVehiclePos(helicopterVeh, x, y, z);
        helicopterDmg += amount;
        if(helicopterDmg >= 1000.0)
        {
            FCNPC_StopPlayingPlayback(npcTruck);
            for(new i =0; i<MAX_DEATH_LOOT; i++)
            {
                if(deathObject[i] == -1)
                {
                    new models;
                    new weap;
                    new ammo;
                    new rand = random(sizeof(truckWeapon));
                    models = getWeaponPickupModel(truckWeapon[rand]);
                    weap = truckWeapon[rand];
                    new randAmmo = random(50) + 10;
                    ammo = randAmmo;
                    MapAndreas_FindZ_For2DCoord(x, y, z);
                    deathObject[i] = CreateDynamicPickup(models, 1,x,y,z+0.5,-1);
                    deathItem[deathObject[i]][dX] = x;
                    deathItem[deathObject[i]][dY] = y;
                    deathItem[deathObject[i]][dZ] = z+0.5;
                    deathItem[deathObject[i]][dWeapon] = weap;
                    deathItem[deathObject[i]][dAmmo] = ammo;
                    destroyHelicopter();
                    CreateExplosion(x, y, z, 2, 10.0);
                    CreateExplosion(x+2.0, y, z, 2, 10.0);
                    CreateExplosion(x, y+2.0, z, 2, 10.0);
                    CreateExplosion(x+2.0, y-2.0, z, 2, 20.0);
                   
                    return 1;

                }
            }
            
        }
    }
    
    return 1;
}