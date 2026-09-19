#include <YSI_Coding\y_hooks>

stock isWeapFull(playerid){
    if(Player[playerid][pWeap1] == 0)
    {   
        return 0;
    }
    if(Player[playerid][pWeap2] == 0)
    {   
        return 0;
    }
    if(Player[playerid][pWeap3] == 0)
    {   
        return 0;
    }
    return 1;
}
stock isWeapHaveSameModel(playerid, weapid){
    
    
    
    if(Player[playerid][pWeap1] == weapid)
    {   
        return 1;
    }
    if(Player[playerid][pWeap2] == weapid)
    {   
        return 1;
    }
    if(Player[playerid][pWeap3] == weapid)
    {   
       return 1;
    }
    return 0;
}
stock setWeapon(playerid, model)
{
    if (Player[playerid][pWeap1] == 0)
    {
        Player[playerid][pWeap1] = model;
        return 1;
    }
    if (Player[playerid][pWeap2] == 0)
    {
        Player[playerid][pWeap2] = model;
        return 1;
    }
    if (Player[playerid][pWeap3] == 0)
    {
        Player[playerid][pWeap3] = model;
        return 1;
    }
    else
    {
        sendErrorMessage(playerid, "Slot senjata anda penuh");
        return 0;
    }

}
stock refreshGun(playerid){
    ResetPlayerWeapons(playerid);
    if(UseGun[playerid] == 1)
    {
        GivePlayerWeapon(playerid, Player[playerid][pWeap1], Player[playerid][pAmmo1]);
    }
    if(UseGun[playerid] == 2)
    {
        GivePlayerWeapon(playerid, Player[playerid][pWeap2], Player[playerid][pAmmo2]);
    }
    if(UseGun[playerid] == 3)
    {
        GivePlayerWeapon(playerid, Player[playerid][pWeap3], Player[playerid][pAmmo3]);
    }
    return 0;
}
stock giveAmmo(playerid, model, ammo)
{
    if (Player[playerid][pWeap1] == model)
    {
        Player[playerid][pAmmo1] += ammo;
        return 1;
    }

    else if (Player[playerid][pWeap2] == model)
    {
        Player[playerid][pAmmo2] += ammo;
        return 1;
    }

    else if (Player[playerid][pWeap3] == model)
    {
        Player[playerid][pAmmo3] += ammo;
        return 1;
    }
    else
    {
        sendErrorMessage(playerid, "Anda tidak memiliki senjata tersebut");
        return 0;
    }
}
hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    
    if (UseGun[playerid] >= 1)
    {
        switch (UseGun[playerid])
        {
            case 1:
            {
                if (Player[playerid][pWeap1] > 15)
                {
                    Player[playerid][pAmmo1] -= 1;
                }

                return 1;
            }
            case 2:
            {
                
                if (Player[playerid][pWeap2] > 15)
                {
                    Player[playerid][pAmmo2] -= 1;
                }

                return 1;

            }
            case 3:
            {
                if (Player[playerid][pWeap3] > 15)
                {
                    Player[playerid][pAmmo3] -= 1;
                }

                return 1;
            }
        }
    }
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    UseGun[playerid] = 0;
    return 1;
}
stock getWeaponPickupModel(weap)
{
    new models;
    switch(weap)
    {
        case 1:
        {
            models = 331;
        }
        case 2:
        {
            models = 333;
        }
        case 3:
        {
            models = 334;
        }
        case 4:
        {
            models = 335;
        }
        case 5:
        {
            models = 336;
        }

        case 6:
        {
            models = 337;
        }
        case 7:
        {
            models = 338;
        }   
        case 8:
        {
            models = 339;
        }
        case 9:
        {
            models = 341;
        }
        case 10:
        {
            models = 321;
        }
        case 11:
        {
            models = 322;
        }
        case 12:
        {
            models = 323;
        }
        case 13:
        {
            models = 324;
        }
        case 14:
        {
            models = 325;
        }
        case 15:
        {
            models = 326;
        }
        case 16:
        {
            models = 342;
        }
        case 17:
        {
            models = 343;
        }
        case 18:
        {
            models = 344;
        }
        case 22:
        {
            models = 346;
        }
        case 23:
        {
            models = 347;
        }
        case 24:
        {
            models = 348;
        }
        case 25:
        {
            models = 349;
        }
        case 26:
        {
            models = 350;
        }
        case 27:
        {
            models = 351;
        }
        case 28:
        {
            models = 352;
        }
        case 29:
        {
            models = 353;
        }
        case 30:
        {
            models = 355;
        }
        case 31:
        {
            models = 356;
        }
        case 32:
        {
            models = 372;
        }
        case 33:
        {
            models = 357;
        }
        case 34:
        {
            models = 358;
        }
        case 35:
        {
            models = 359;
        }
        case 36:
        {
            models = 360;
        }
        case 37:
        {
            models = 361;
        }
        case 38:
        {
            models = 362;
        }
        case 39:
        {
            models = 363;
        }
        case 40:
        {
            models = 364;
        }
        case 41:
        {
            models = 365;
        }
        case 42:
        {
            models = 366;
        }
        case 43:
        {
            models = 367;
        }
        case 44:
        {
            models = 368;
        }
        case 45:
        {
            models = 369;
        }
        case 46:
        {
            models = 371;
        }
    }
    return models;
}
hook OnPlayerUpdate(playerid){
    if(UseGun[playerid] >= 1 )
    {
        new ammo = GetPlayerAmmo(playerid);
        switch(UseGun[playerid])
        {
            case 1:
            {
                if(ammo < Player[playerid][pAmmo1])
                {
                    
                    Player[playerid][pAmmo1] = ammo;
                    if(Player[playerid][pAmmo1] < 0)
                    {
                        Player[playerid][pAmmo1] = 0;
                    }
                }
            }
            case 2:{
                if(ammo < Player[playerid][pAmmo2])
                {
                    Player[playerid][pAmmo2] = ammo;
                }
                if(Player[playerid][pAmmo2] < 0)
                    {
                        Player[playerid][pAmmo2] = 0;
                    }
            }
            case 3:{
                if(ammo < Player[playerid][pAmmo3])
                {
                    Player[playerid][pAmmo3] = ammo;
                }
                if(Player[playerid][pAmmo3] < 0)
                    {
                        Player[playerid][pAmmo3] = 0;
                    }
            }
        }
    }
    return 1;
}
