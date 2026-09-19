#include <YSI_Coding\y_hooks>

new npcIsDead[1024];
forward respawnNpc(npcid);

public respawnNpc(npcid)
{
    npcIsDead[npcid] = 0;
    FCNPC_Respawn(npcid);
    FCNPC_SetHealth(npcid, 100.0);
    return 1;
}

forward checkObj(npcid, Float:x, Float:y, Float:z, Float:rX,Float:rY, Float:rZ);

public checkObj(npcid, Float:x, Float:y, Float:z, Float:rX, Float:rY, Float:rZ){

    return 1;
}
hook OnGameModeInit()
{
    SetTimer("updateZombieRoam",1000, true);
    FCNPC_SetUpdateRate(50);
    CA_Init();
    
    MapAndreas_Init(MAP_ANDREAS_MODE_FULL);

    new Float:z;
    if (MapAndreas_FindZ_For2DCoord(0.0, 0.0, z))
    {
        print("MapAndreas loaded successfully.");
    }
    else
    {
        print("MapAndreas failed to load.");
    }
    return 1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    playerIsDead[playerid] = 1;
    KillTimer(InfectedTimer[playerid]); 
    return 1;
}
stock setTarget(npcid)
{
    new target = INVALID_PLAYER_ID;
    new Float:bestDist = 99999.0;

    for(new i = 0; i < 50; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        if(IsPlayerNPC(i)) continue;
        if(playerIsDead[i]) continue;

        new Float:dist = GetPlayerDistanceToPlayer(npcid, i);

        if(dist <= 20.0 && dist < bestDist)
        {
            bestDist = dist;
            target = i;
        }
        
    }
    
    if(target != INVALID_PLAYER_ID)
    {
        
        new Float:range = GetPlayerDistanceToPlayer(npcid, target);
        // Attack if close
        if(range <= 1.5)
        {
            if(playerIsDead[target] == 0)
            {
                
                new Float:additional = 0.0;
                if(isPlayerInContZone(target)){
                    additional = 5.0;
                }
                new Float:amnt;
                if(ZombieInfo[npcid][zType] == 0) amnt = float(random(10));
                if(ZombieInfo[npcid][zType] == 1) amnt = float(random(20));
                if(ZombieInfo[npcid][zType] == 2) amnt = float(random(40));
                amnt += additional;
                if(Player[target][pArmour] > amnt)
                {
                    Player[target][pArmour] -= amnt;
                    SetPlayerArmour(target, Player[target][pArmour]);
                    return 1;
                }
                else if(Player[target][pArmour] < amnt && Player[target][pArmour] > 0)
                {
                    Player[target][pArmour] = 0;
                    SetPlayerArmour(target,0);
                    return 1;
                }
                else if(Player[target][pArmour] <= 0)
                {
                    Player[target][pHealth] -= amnt;
                    SetPlayerHealth(target, Player[target][pHealth]);
                    if(Player[target][pInfected] == 0)
                        Player[target][pInfected] = 1;
                }
            }
            return 1;
        }
      
        // Don't restart movement every timer tick
        if(!FCNPC_IsMovingAtPlayer(npcid, target))
        {
            new Float:speed = 0.0;
            if(serverHour >18 || serverHour < 6)
            {
                    speed += 0.2;
            }
            if(isPlayerInContZone(target))
            {
                speed += 0.5;
            }
            if(ZombieInfo[npcid][zType] == 0 && !isPlayerInSafeZone(target))
            {
                
                FCNPC_GoToPlayer(npcid, target,  FCNPC_MOVE_TYPE_RUN,
                FCNPC_MOVE_SPEED_RUN + speed,
                FCNPC_MOVE_MODE_AUTO,
                FCNPC_MOVE_PATHFINDING_AUTO);
            }
            if(ZombieInfo[npcid][zType] == 1 && !isPlayerInSafeZone(target))
            {
                FCNPC_GoToPlayer(npcid, target,  FCNPC_MOVE_TYPE_SPRINT,
                FCNPC_MOVE_SPEED_SPRINT + speed,
                FCNPC_MOVE_MODE_AUTO,
                FCNPC_MOVE_PATHFINDING_AUTO);
            }
            if(ZombieInfo[npcid][zType] == 2 && !isPlayerInSafeZone(target))
            {
                FCNPC_GoToPlayer(npcid, target,  FCNPC_MOVE_TYPE_WALK,
                FCNPC_MOVE_SPEED_WALK + speed,
                FCNPC_MOVE_MODE_AUTO,
                FCNPC_MOVE_PATHFINDING_AUTO);
            }
            isChasing[npcid] = 1;
        }
        if(FCNPC_IsMovingAtPlayer(npcid, target))
        {
            new Float:x , Float:y, Float:z;

            new Float:nX, Float:nY, Float:nZ;

            new Float:rX, Float:rY, Float:rZ;

            FCNPC_GetPosition(npcid, nX, nY, nZ);

            GetPlayerPos(target, x, y,  z);

            new col = CA_RayCastLine(nX, nY, nZ, x, y, z, rX, rY,rZ);

            if(col || isPlayerInSafeZone(target))
            {
                FCNPC_Stop(npcid);
                isChasing[npcid] = 0;
                return 1;
            }
        }
        return 1;
    }
    if(target == INVALID_PLAYER_ID)
    {
        if(isChasing[npcid] == 1)
        {
            FCNPC_Stop(npcid);
            isChasing[npcid] = 0;
            return 1;
        }
       
        if(!FCNPC_IsMoving(npcid))
        {
            new Float:x, Float:y, Float:z;

            FCNPC_GetPosition(npcid, x, y, z);
            new Float:tempZ, Float:tempX, Float:tempY;
            tempZ = z;
            tempX = x;
            tempY = y;
            new isSafeZone = 0;

            if(x >= -2375 && x <= -1927 && y >= -2635.2753295898438 && y <= -2203.2753295898438)
            {
                isSafeZone = 1;
            }
            if(x >= -2709 && x <= -2140 && y >= 2175.9000000953674 && y <= 2558.9000000953674)
            {
                isSafeZone = 1;
            }
            if(x >= 2108 && x <= 2594 && y >= -182.10009765625 && y <= 230.89990234375)
            {
                isSafeZone = 1;
            }
            if(isSafeZone == 1)
            {
                FCNPC_SetPosition(npcid, ZombieInfo[npcid][zX], ZombieInfo[npcid][zY], ZombieInfo[npcid][zZ]);
                return 1;
            }
            x += RandomFloat(-30.0, 30.0);
            y += RandomFloat(-30.0, 30.0);

            new Float:Rx, Float:Ry, Float:Rz;   
            MapAndreas_FindZ_For2DCoord(x,y,z);
            
          
            if(x >= -2375 && x <= -1927 && y >= -2635.2753295898438 && y <= -2203.2753295898438)
            {
                isSafeZone = 1;
            }
            if(x >= -2709 && x <= -2140 && y >= 2175.9000000953674 && y <= 2558.9000000953674)
            {
                isSafeZone = 1;
            }
            if(x >= 2108 && x <= 2594 && y >= -182.10009765625 && y <= 230.89990234375)
            {
                isSafeZone = 1;
            }
            new col = CA_RayCastLine(tempX, tempY, tempZ, x, y, z, Rx, Ry, Rz);                     

            new Float:calculateZ = z - tempZ;
            if(calculateZ >= -5 && calculateZ <=5 && !col && isSafeZone == 0)
            {
                FCNPC_GoTo(
                    npcid,
                    x,
                    y,
                    z,
                    FCNPC_MOVE_TYPE_WALK,
                    FCNPC_MOVE_SPEED_WALK,
                    FCNPC_MOVE_MODE_AUTO,
                    FCNPC_MOVE_PATHFINDING_AUTO
                );
                
            }
            
        }

        return 1;
       
    }
    
    // Patrol only if not already moving
    return 1;
}
forward updateZombieRoam();
public updateZombieRoam()
{
    
    for(new i =0; i<1000; i++)
    {
        if(npcId[i] != -1)
        {
            if(npcIsDead[npcId[i]] == 0)
                setTarget(npcId[i]);
        }
        
    }
    return 1;
}
public FCNPC_OnCreate(npcid)
{
    isChasing[npcid] = 0;
    
    return 1;
}
stock loadZombie()
{
    for(new i=0; i<1024; i++)
    {
        npcId[i] = -1;
    }
    for(new i=0; i<=900; i++)
    {
        
        
        new Float:x;
        new Float:y;
        new Float:z = 0.0;
        new npcName[128];
        new rand = random(3);

            
        format(npcName, sizeof(npcName), "Zom%d", i);
        do{
            x = float(random(5000) - 2500);
            y = float(random(5000) - 2500);
            MapAndreas_FindZ_For2DCoord(x, y, z);
        }
        while(z <= 1 || isPlayerInSafeZone2(x,y));
            

        npcId[i] = FCNPC_Create(npcName);
        ZombieInfo[npcId[i]][zType] = rand;
        ZombieInfo[npcId[i]][zX] = x;
        ZombieInfo[npcId[i]][zY] = y;
        ZombieInfo[npcId[i]][zZ] = z;
        FCNPC_SetHealth(npcId[i], 100);
        if(ZombieInfo[npcId[i]][zType] == 0)
        {
            FCNPC_Spawn(npcId[i], 70, x, y, z);
        }
        if(ZombieInfo[npcId[i]][zType] == 1)
        {
            FCNPC_Spawn(npcId[i], 162, x, y, z);
            FCNPC_SetArmour(npcId[i], 20);
        }
        if(ZombieInfo[npcId[i]][zType] == 2)
        {
            FCNPC_Spawn(npcId[i], 135, x, y, z);
            FCNPC_SetArmour(npcId[i], 100);
        }
            

        isChasing[npcId[i]] = 0;

        npcIsDead[npcId[i]] = 0;

        NpcPickup[npcId[i]] = -1;

    }
    return 1;
}
stock createZombie(playerid)
{
    if(Player[playerid][pAdmin] == 5)
    {
        for(new i=0; i<1000; i++)
        {
            if(npcId[i] == -1)
            {
                
                new Float:Xx;
                new Float:Yy;
                new Float:Zz;

                GetPlayerPos(playerid, Xx, Yy, Zz);

                new str[64];

                format(str, sizeof(str), "Zom%d", i);

                npcId[i] = FCNPC_Create(str);

                ZombieInfo[npcId[i]][zX] = Xx;

                ZombieInfo[npcId[i]][zY] = Yy;

                ZombieInfo[npcId[i]][zZ] = Zz;

                
                FCNPC_SetHealth(npcId[i], 100);
                FCNPC_Spawn(npcId[i],162, ZombieInfo[npcId[i]][zX] + 3.0, ZombieInfo[npcId[i]][zY], ZombieInfo[npcId[i]][zZ]);
                
                new npcFileName[64];

                format(npcFileName, sizeof(npcFileName), "Zombie/Zom%d.ini", i);

                dini_Create(npcFileName);

                dini_FloatSet(npcFileName, "X", ZombieInfo[npcId[i]][zX]);
                dini_FloatSet(npcFileName, "Y", ZombieInfo[npcId[i]][zY]);
                dini_FloatSet(npcFileName, "Z", ZombieInfo[npcId[i]][zZ]);

                ZombieInfo[npcId[i]][zType] = 0;

                new success[128];

                format(success, sizeof(success), "Anda sukses membuat zombie dengan id %d", i);
                sendSuccessMessage(playerid, success);
                return 1;  
            }
        }
        sendErrorMessage(playerid, "Zombie telah mencapai jumlah maksimum");

        return 1;
    }
   
    return sendErrorMessage(playerid, "Anda bukan admin dengan level 5");
    
}
stock deleteZombie(playerid, zombieid){
    if(npcId[zombieid] != -1)
    {
        new zombieFile[128];
        format(zombieFile, sizeof(zombieFile), "Zombie/Zom%d.ini", zombieid);
        dini_Remove(zombieFile);
        FCNPC_Destroy(npcId[zombieid]);
        new str[128];
        format(str, sizeof(str), "Anda berhasil menghapus zombie dengan id %d", zombieid);
        sendSuccessMessage(playerid, str);
        npcId[zombieid] = -1;
    }
    else
    {
        new error[128];
        format(error, sizeof(error), "Zombie dengan id %d tidak ada atau sudah dihapus", zombieid);
        sendErrorMessage(error);
    }
}
hook OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/createzombie", true))
    {
        createZombie(playerid);
    
        return 1;
        // Returning 1 informs the server that the command has been processed.
        // OnPlayerCommandText won't be called in other scripts.
    }
    if(!strcmp(cmdtext, "/listzombie", true))
    {
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5");
        new str[2056];
        format(str, sizeof(str), "ID\tX\tY\tZ\tType");
        for(new i =0; i<1000; i++)
        {
            if(npcId[i] != -1)
            {
                format(str, sizeof(str), "%s\n%d\t%.2f\t%.2f\t%.2f\t%d", str, i, ZombieInfo[npcId[i]][zX], ZombieInfo[npcId[i]][zY], ZombieInfo[npcId[i]][zZ], ZombieInfo[npcId[i]][zType]);
            }
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_ZOMBIE, DIALOG_STYLE_TABLIST, "List Zombie", str, "Teleport", "Cancel");
        return 1;
    }
    new command[128];
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);
    if(!strcmp(cmdtext, "/deletezombie", true))
    {
        new zmbid;
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin dengan level 5");
        if(sscanf(arg1, "d", zmbid))
        {
            return sendErrorMessage(playerid, "Gunakan /deletezombie [zombieid]");
        }

    }
    return 0;
    // Returning 0 informs the server that the command hasn't been processed by this script.
    // OnPlayerCommandText will be called in other scripts until one returns 1.
    // If no scripts return 1, the 'SERVER: Unknown Command' message will be shown to the player.
}

public FCNPC_OnDeath(npcid, killerid, reason)
{
    for(new i=0; i<1000; i++)
    {
        if(npcid == npcId[i])
        {

            if(ZombieInfo[npcid][zType] == 2){
                new Float:x, Float:y, Float:z;
                FCNPC_GetPosition(npcid,x , y, z);
                CreateExplosion(x, y, z, 3, 20.0);
            }
        }
        SetTimerEx("respawnNpc", 30000, false, "i", npcid);
        npcIsDead[npcid] = 1;
        return 1;
    }
    
    
    return 1;
}

#define TIMER_INFECTED 20000
forward updatePlayerInfected(playerid);
public updatePlayerInfected(playerid){
    Player[playerid][pHealth] -= 1.0;
    SetPlayerHealth(playerid, Player[playerid][pHealth]);
    SetPlayerDrunkLevel(playerid, 5000);
    sendInfoMessage(playerid, "Infeksi semakin menjalar tolong cari antibiotik dengan segera!");
    return 1;
}
hook OnPlayerConnect(playerid){
    infectedAlrRun[playerid] = 0;
    InfectedTimer[playerid] = 0;
    return 1;
}
hook OnPlayerDisconnect(playerid, reason){
    KillTimer(InfectedTimer[playerid]);
    return 1;
}

hook OnPlayerSpawn(playerid)
{
    if(Player[playerid][pInfected] == 1 && infectedAlrRun[playerid] == 0){
        SetPlayerDrunkLevel(playerid, 2500);
        infectedAlrRun[playerid] = 1;
        InfectedTimer[playerid] = SetTimerEx("updatePlayerInfected", TIMER_INFECTED, true, "i", playerid);
        sendInfoMessage(playerid, "Anda terinfeksi virus tolong cari antibiotik dengan segera!!!");

    }
    
}
hook OnPlayerUpdate(playerid){
    if(Player[playerid][pInfected] == 1 && infectedAlrRun[playerid] == 0){
        
        infectedAlrRun[playerid] = 1;
        InfectedTimer[playerid] = SetTimerEx("updatePlayerInfected", TIMER_INFECTED, true, "i", playerid);
        sendInfoMessage(playerid, "Anda terinfeksi virus tolong cari antibiotik dengan segera!!!");
        
    }
    if(Player[playerid][pInfected] == 0 && infectedAlrRun[playerid] == 0){
        
        
        KillTimer(InfectedTimer[playerid]);
        infectedAlrRun[playerid] = 0;
        
    }
    return 1;
}