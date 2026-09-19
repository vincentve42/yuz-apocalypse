#include <YSI_Coding\y_hooks>

#define MAX_FAM_ZONE 128

new Float:tempMaxX[MAX_PLAYERS];
new Float:tempMaxY[MAX_PLAYERS];
new Float:tempMinX[MAX_PLAYERS];
new Float:tempMinY[MAX_PLAYERS];

#define ONE_HOUR 3600000

new tempBuyLand[MAX_PLAYERS];
new tempManageLand[MAX_PLAYERS];
#define PRICE_PER_METER 500

enum FAM_ZONE{
    ffamId,
    Float:ffMinX,
    Float:ffMinY,
    Float:ffMaxX,
    Float:ffMaxY,
    ffMoney,
    ffDuration,
}

new famZone[MAX_FAM_ZONE][FAM_ZONE];
new famZoneExist[MAX_FAM_ZONE];
new famGangZone[MAX_FAM_ZONE];
forward kurangiDurasi();
public kurangiDurasi()
{
    for(new i=0; i<MAX_FAM_ZONE; i++)
    {
        if(famZoneExist[i] != -1)
        {
            if(famZone[i][ffamId] != -1)
            {
                if(familyExist[i] == -1)
                {
                    famZone[i][ffamId] = -1;
                    famZone[i][ffDuration] = 0;
                    GangZoneHideForAll(famGangZone[i]);
                    GangZoneShowForAll(famGangZone[i], 0x007FFF99);
                }
                if(famZone[i][ffDuration] <= 0)
                {
                    GangZoneHideForAll(famGangZone[i]);
                    GangZoneShowForAll(famGangZone[i], 0x007FFF99);
                    for(new j=0; j<MAX_PLAYERS; j++)
                    {
                        if(IsPlayerConnected(j) && !IsPlayerNPC(j)){
                            if(Player[j][pFam] == famZone[i][ffamId])
                            {
                                sendInfoMessage(j, "Salah satu lahan anda telah expire");
                            }
                        }
                    }
                    famZone[i][ffamId] = -1;
                    famZone[i][ffDuration] = 0;
                }
                if(famZone[i][ffDuration] > 0)
                {
                    famZone[i][ffDuration] -= 1;
                }
            }
            else
            {
                famZone[i][ffDuration] = 0;
            }
        }
    }
    saveFamZone();
    return 1;
}
hook OnGameModeInit()
{
    for(new i=0; i<MAX_FAM_ZONE; i++)
    {
        new zoneFile[128];
        format(zoneFile, sizeof(zoneFile), "Zone/%d.ini", i);
        if(dini_Exists(zoneFile))
        {
            famZoneExist[i] = 1;
            famZone[i][ffamId] = dini_Int(zoneFile, "FamId");
            famZone[i][ffMoney] = dini_Int(zoneFile, "Money");
            famZone[i][ffDuration] = dini_Int(zoneFile, "Duration");
            famZone[i][ffMinX] = dini_Float(zoneFile, "MinX");
            famZone[i][ffMinY] = dini_Float(zoneFile, "MinY");
            famZone[i][ffMaxX] = dini_Float(zoneFile, "MaxX");
            famZone[i][ffMaxY] = dini_Float(zoneFile, "MaxY");
            famGangZone[i] = GangZoneCreate(famZone[i][ffMinX], famZone[i][ffMinY], famZone[i][ffMaxX], famZone[i][ffMaxY]);

        }
        else
        {
            famZoneExist[i] = -1;
            famGangZone[i] = -1;
        }
    }

    SetTimer("kurangiDurasi",ONE_HOUR, true);
    return 1;
}
hook OnGameModeExit()
{
    saveFamZone();
    return 1;
}
hook OnPlayerConnect(playerid){
    tempMinX[playerid] = 0.0;
    tempMinY[playerid] = 0.0;
    tempMaxY[playerid] = 0.0;
    tempMaxX[playerid] = 0.0;
    tempBuyLand[playerid] = -1;
    tempManageLand[playerid] = -1;
    return 1;
}
hook OnPlayerSpawn(playerid)
{
    for(new i=0; i<MAX_FAM_ZONE; i++)
    {
        if(famZoneExist[i] != -1)
        {
            if(famZone[i][ffamId] == -1)
                GangZoneShowForPlayer(playerid, famGangZone[i],0x007FFF99);
            else
            {
                if(Player[playerid][pFam] != famZone[i][ffamId])
                    GangZoneShowForPlayer(playerid, famGangZone[i],0x0000FF99);
                else
                    GangZoneShowForPlayer(playerid, famGangZone[i],0x00FFFF99);
            }
        }
    }
    return 1;
}
stock saveFamZone()
{
    for(new i=0; i<MAX_FAM_ZONE; i++)
    {
        new zoneFile[128];
        format(zoneFile, sizeof(zoneFile), "Zone/%d.ini", i);
        if(dini_Exists(zoneFile))
        {
            dini_IntSet(zoneFile, "FamId",famZone[i][ffamId]);
            dini_IntSet(zoneFile, "Money",famZone[i][ffMoney]);
            dini_IntSet(zoneFile, "Duration",famZone[i][ffDuration]);
            dini_FloatSet(zoneFile, "MinX",famZone[i][ffMinX]);
            dini_FloatSet(zoneFile, "MinY",famZone[i][ffMinY]);
            dini_FloatSet(zoneFile, "MaxY",famZone[i][ffMaxY]);
            dini_FloatSet(zoneFile, "MaxX",famZone[i][ffMaxX]);
        }
    }
    return 1;
}