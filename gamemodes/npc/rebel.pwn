#include <YSI_Coding\y_hooks>

new rebelIsAiming[MAX_REBEL];

new rebelIsChasing[MAX_REBEL];

forward updateRebel(rebelid);

public updateRebel(rebelid)
{
    // cari player
    
    new Float:dist = 99999.0;
    new target = INVALID_PLAYER_ID;
    for(new i =0; i<MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerNPC(i)) continue;
        if(playerIsDead[i]) continue;

        new Float:tempdist = GetPlayerDistanceToPlayer(rebelid, i);

        if(tempdist <= 30.0 && tempdist < dist){
            dist = tempdist;
            target = i;
        }
    }
    if(target != INVALID_PLAYER_ID)
    {
        new Float:distt = GetPlayerDistanceToPlayer(rebelid, target);
        if(FCNPC_IsMovingAtPlayer(rebelid, target))
        {
            new Float:x , Float:y, Float:z;

            new Float:nX, Float:nY, Float:nZ;

            new Float:rX, Float:rY, Float:rZ;

            FCNPC_GetPosition(rebelid, nX, nY, nZ);

            GetPlayerPos(target, x, y,  z);

            new col = CA_RayCastLine(nX, nY, nZ, x, y, z, rX, rY,rZ);

            if(col)
            {
                FCNPC_Stop(rebelid);
             
                return 1;
            }
        }
    
        if(distt > 15.0)
        {
            rebelIsAiming[rebelid] = 0;
            FCNPC_StopAim(rebelid);
            FCNPC_GoToPlayer(rebelid, target,  FCNPC_MOVE_TYPE_RUN,
            FCNPC_MOVE_SPEED_RUN,
            FCNPC_MOVE_MODE_AUTO,
            FCNPC_MOVE_PATHFINDING_AUTO);
            rebelIsChasing[rebelid] = 1;
        }
        if(rebelIsAiming[rebelid] == 0 && distt < 15.0)
        {
            FCNPC_Stop(rebelid);
            rebelIsAiming[rebelid] = 1;
            FCNPC_AimAtPlayer(rebelid, target, true);
            rebelIsChasing[rebelid] = 0;
        }
        
        return 1;
    }
    if(target == INVALID_PLAYER_ID)
    {
        if(rebelIsChasing[rebelid] == 1)
        {
            rebelIsChasing[rebelid] = 0;
            FCNPC_Stop(rebelid);
        }
        if(rebelIsAiming[rebelid] == 1)
        {
            FCNPC_StopAim(rebelid);
            rebelIsAiming[rebelid] = 0;
        }
        if(!FCNPC_IsMoving(rebelid))
        {
            new Float:randX;
            new Float:randY;
            new Float:z;
            new Float:x;
            new Float:y;
            new Float:currX, Float:currY, Float:currZ;
            FCNPC_GetPosition(rebelid, x, y, z);
            currX = x;
            currY = y;
            currZ = z;
            randX = float(random(20));
            randY = float(random(20));
            new postive = random(2);
            switch(postive)
            {
                case 0:
                {
                    x += randX;
                    y += randY;
                }
                case 1:
                {
                    x -= randX;
                    y -= randY;
                }
            }
            new Float:Rx, Float:Ry, Float:Rz;   
            MapAndreas_FindZ_For2DCoord(x,y,z);

            new col = CA_RayCastLine(currX, currY, currZ, x, y, z, Rx, Ry, Rz);   

            new Float:calculateZ = z - currZ;

            if(calculateZ >= -5 && calculateZ <=5 && !col)
            {
                FCNPC_GoTo(
                    rebelid,
                    x,
                    y,
                    z,
                    FCNPC_MOVE_TYPE_WALK,
                    FCNPC_MOVE_SPEED_WALK,
                    FCNPC_MOVE_MODE_AUTO,
                    FCNPC_MOVE_PATHFINDING_AUTO
                );
            }
            return 1;
        }
    }
    return 1;
}

forward updateRebelStats();
public updateRebelStats(){
    for(new i =0; i<MAX_REBEL; i++)
    {
        if(rebelNpc[i] != -1)
        {
            updateRebel(rebelNpc[i]);
        }
    }
    return 1;
}

stock createRebel(playerid)
{
    new Float:x, Float:y, Float:z;

    GetPlayerPos(playerid, x, y, z);

    for(new i =0; i<MAX_REBEL; i++)
    {
        new rebelFile[128];
        format(rebelFile, sizeof(rebelFile), "Rebels/Rebel%d.ini", i);
        if(!dini_Exists(rebelFile))
        {
            dini_Create(rebelFile);
            dini_FloatSet(rebelFile, "X", x);
            dini_FloatSet(rebelFile, "Y", y);
            dini_FloatSet(rebelFile, "Z", z);

            new str[64];
            format(str, sizeof(str), "Rebel%d", i);

            rebelNpc[i] = FCNPC_Create(str);
            
            rebelNpcInfo[rebelNpc[i]][rrX] = x;
            rebelNpcInfo[rebelNpc[i]][rrY] = y;
            rebelNpcInfo[rebelNpc[i]][rrZ] = z;
           
            new rand = random(sizeof(rebelSkin));

            rebelNpcInfo[rebelNpc[i]][rSkin] = rebelSkin[rand];

            rebelNpcDead[rebelNpc[i]] = 0;


            FCNPC_Spawn(rebelNpc[i],rebelNpcInfo[rebelNpc[i]][rSkin],rebelNpcInfo[rebelNpc[i]][rrX] , rebelNpcInfo[rebelNpc[i]][rrY], rebelNpcInfo[rebelNpc[i]][rrZ]);
            
            FCNPC_SetArmour(rebelNpc[i], 100.0);

            new rand2 = random(sizeof(rebelWeapon));

            FCNPC_SetWeapon(rebelNpc[i], rebelWeapon[rand2]);
            FCNPC_SetAmmo(rebelNpc[i], 1000000); // basically unlimited awkwk

            new success[128];
            format(success, sizeof(success), "Anda berhasil membuat npc rebel id %d", i);
            rebelIsAiming[rebelNpc[i]] = 0;
            rebelIsChasing[rebelNpc[i]] = 0;
            return sendSuccessMessage(playerid, success);
        }
    }
    return 1;
}
stock deleteRebel(playerid, rebelid){
    if(rebelNpc[rebelid] == -1)
    {
        return sendErrorMessage(playerid, "Bot Rebel tidak valid");
    }
    new rebelFile[128];
    format(rebelFile, sizeof(rebelFile), "Rebels/Rebel%d.ini", rebelid);
    dini_Remove(rebelFile);
    new success[128];
    format(success, sizeof(success), "Anda berhasil menghapus bot rebel %d", rebelid);
    sendSuccessMessage(playerid, success);
    return 1;
    
}
hook OnGameModeInit()
{
    for(new i=0; i<MAX_REBEL; i++)
    {
        new rebelFile[128];
        format(rebelFile, sizeof(rebelFile), "Rebels/Rebel%d.ini", i);
        if(dini_Exists(rebelFile))
        {
            new str[64];
            format(str, sizeof(str), "Rebel%d", i);
            rebelNpc[i] = FCNPC_Create(str);
            rebelNpcInfo[rebelNpc[i]][rrX] = dini_Float(rebelFile, "X");
            rebelNpcInfo[rebelNpc[i]][rrY] = dini_Float(rebelFile, "Y");
            rebelNpcInfo[rebelNpc[i]][rrZ] = dini_Float(rebelFile, "Z");

            new rand = random(sizeof(rebelSkin));

            rebelNpcInfo[rebelNpc[i]][rSkin] = rebelSkin[rand];


            FCNPC_Spawn(rebelNpc[i],rebelNpcInfo[rebelNpc[i]][rSkin],rebelNpcInfo[rebelNpc[i]][rrX] , rebelNpcInfo[rebelNpc[i]][rrY], rebelNpcInfo[rebelNpc[i]][rrZ]);
            
            FCNPC_SetArmour(rebelNpc[i], 100.0);

            new rand2 = random(sizeof(rebelWeapon));
            rebelNpcInfo[rebelNpc[i]][rWeapon] = rebelWeapon[rand2];
            FCNPC_SetWeapon(rebelNpc[i], rebelNpcInfo[rebelNpc[i]][rWeapon]);
            FCNPC_SetAmmo(rebelNpc[i], 1000000); // basically unlimited awkwk

            rebelNpcDead[rebelNpc[i]] = 0;
            rebelIsAiming[rebelNpc[i]] = 0;
            rebelIsChasing[rebelNpc[i]] = 0;
        }
        else
        {
            rebelNpc[i] = -1;

        }

    }
    SetTimer("updateRebelStats", 1000, true);
    return 1;
}

hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/createrebel", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");

        createRebel(playerid);
        return 1;
    }
    if(!strcmp(cmdtext, "/listrebel", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");
        new str[1024];
        format(str, sizeof(str), "ID\tWeapon\tSkin");
        for(new i =0; i<MAX_REBEL; i++)
        {
            if(rebelNpc[i] != -1)
            {
                new weapname[128];
                GetWeaponName(rebelNpcInfo[rebelNpc[i]][rWeapon], weapname, sizeof(weapname));
                format(str, sizeof(str), "%s\n%d\t%s\t%d",str, i, weapname, rebelNpcInfo[rebelNpc[i]][rSkin]);
            }
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_REBEL, DIALOG_STYLE_TABLIST_HEADERS,"List Rebel", str, "Teleport", "Cancel");
        return 1;
    }
    new command[128];
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);
    if(!strcmp(command, "/deleterebel", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");
        new rebelid;
        if(sscanf(arg1, "d", rebelid))
        {
            return sendErrorMessage(playerid, "Gunakan /deleterebel [rebelid]");
        }
        deleteRebel(playerid, rebelid);
        return 1;
    }
    return 0;
}
forward respawnRebel(npcid);
public respawnRebel(npcid){
    if(rebelNpcDead[npcid] == 1)
    {
        FCNPC_Spawn(npcid,rebelNpcInfo[npcid][rSkin],rebelNpcInfo[npcid][rrX] , rebelNpcInfo[npcid][rrY], rebelNpcInfo[npcid][rrZ]);
            
        FCNPC_SetArmour(npcid, 100.0);
        FCNPC_SetWeapon(npcid, rebelNpcInfo[npcid][rWeapon]);
        FCNPC_SetAmmo(npcid, 1000000); // basically unlimited awkwk
        rebelNpcDead[npcid] = 0;
    }
    return 1;
}
hook FCNPC_OnDeath(npcid, killerid, reason){
    for(new i=0; i<1000; i++)
    {
        if(npcid == rebelNpc[i]){
            rebelNpcDead[rebelNpc[i]] = 1;
            SetTimerEx("respawnRebel", 600000, false, "i", npcid);
            
            return 1;
        }
    }
    return 1;
}