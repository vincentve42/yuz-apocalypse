#include <YSI_Coding\y_hooks>

new isZoneSignShow[MAX_PLAYERS];

new zoneTimer[MAX_PLAYERS];

new safeZone[3];
new contZone[4];
stock isPlayerInSafeZone(playerid){
    
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(x >= -2375 && x <= -1927 && y >= -2635.2753295898438 && y <= -2203.2753295898438)
    {
        
        return true;
    }
    if(x >= -2709 && x <= -2140 && y >= 2175.9000000953674 && y <= 2558.9000000953674)
    {
       
        return true;
    }
    if(x >= 2108 && x <= 2594 && y >= -182.10009765625 && y <= 230.89990234375)
    {
        
        return true;
    }
    return false;
}
stock isPlayerInSafeZone2(Float:x, Float:y){

    if(x >= -2375 && x <= -1927 && y >= -2635.2753295898438 && y <= -2203.2753295898438)
    {
        
        return true;
    }
    if(x >= -2709 && x <= -2140 && y >= 2175.9000000953674 && y <= 2558.9000000953674)
    {
       
        return true;
    }
    if(x >= 2108 && x <= 2594 && y >= -182.10009765625 && y <= 230.89990234375)
    {
        
        return true;
    }
    return false;
}
stock isSafeZoneInsideCoordinate(playerid, Float:minX, Float:minY, Float:maxX, Float:maxY)
{
    if(playerid == INVALID_PLAYER_ID) return false;
    if((minX <= -1927 && maxX >= -2375) && (minY <= -2203.2753295898438 && maxY >= -2635.2753295898438))
    {  
        return true;
    }
    if((-2709 >= minX && -2140 <= maxX) && (2175.9000000953674 >= minY && 2558.9000000953674 <= maxY))
    {   
        return true;
    }
    if((-2375 >= minX && -1927 <= maxX) && (-2635.2753295898438 >= minY && -2203.2753295898438 <= maxY))
    {   
        return true;
    }
    return false;
}
stock isPlayerInContZone(playerid){
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(x >= 99.0623779296875 && x <= 2945.0623779296875 && y >= -2856.387237548828 && y <= -970.3872375488281)
    {
        return true;
    }
    if(x >= 856 && x <= 2789 && y >= 543 && y <= 2928)
    {
        return true;
    }
    if(x >= -3000 && x <= -1502 && y >= -379.35003662109375 && y <= 1554.6499633789062)
    {
        return true;
    }
    if(x >= -112 && x <= 503 && y >= 1599 && y <= 2154)
    {
        return true;
    }
    return false;
}
stock isPlayerInContZone2(Float:x ,Float:y){
    if(x >= 99.0623779296875 && x <= 2945.0623779296875 && y >= -2856.387237548828 && y <= -970.3872375488281)
    {
        return true;
    }
    if(x >= 856 && x <= 2789 && y >= 543 && y <= 2928)
    {
        return true;
    }
    if(x >= -3000 && x <= -1502 && y >= -379.35003662109375 && y <= 1554.6499633789062)
    {
        return true;
    }
    if(x >= -112 && x <= 503 && y >= 1599 && y <= 2154)
    {
        return true;
    }
    return false;
}
stock isZombieInContZone2(Float:x, Float:y){
   
    if(x >= 99.0623779296875 && x <= 2945.0623779296875 && y >= -2856.387237548828 && y <= -970.3872375488281)
    {
        return true;
    }
    if(x >= 856 && x <= 2789 && y >= 543 && y <= 2928)
    {
        return true;
    }
    if(x >= -3000 && x <= -1502 && y >= -379.35003662109375 && y <= 1554.6499633789062)
    {
        return true;
    }
    if(x >= -112 && x <= 503 && y >= 1599 && y <= 2154)
    {
        return true;
    }
    return false;
}
stock showZoneSign(playerid, zonetype)
{
    if(zonetype == 1)
    {
        PlayerTextDrawShow(playerid, terkontaminasi[playerid]);
        isZoneSignShow[playerid] = 1;
    }
    if(zonetype == 2)
    {
        PlayerTextDrawShow(playerid, areaman[playerid]);
        isZoneSignShow[playerid] = 1;
    }
    return 1;
}
stock hideZoneSign(playerid, type){
    if(type == 1){
        PlayerTextDrawHide(playerid,  terkontaminasi[playerid]);
        isZoneSignShow[playerid] = 0;
    }
    if(type == 2)
    {
        PlayerTextDrawHide(playerid,  areaman[playerid]);
        isZoneSignShow[playerid] = 0;
    }
    return 1;
}
forward updateZoneSign(playerid);
public updateZoneSign(playerid)
{
    if(isPlayerInContZone(playerid))
    {
        if(isZoneSignShow[playerid] == 0)
        {
            showZoneSign(playerid, 1);
        }
        
    }
    if(!isPlayerInContZone(playerid))
    {
        hideZoneSign(playerid, 1);
    }
    if(isPlayerInSafeZone(playerid))
    {
        if(isZoneSignShow[playerid] == 0){
            showZoneSign(playerid, 2);
        }
    }
    if(!isPlayerInSafeZone(playerid))
    {
        hideZoneSign(playerid, 2);
    }
    return 1;
}
hook OnGameModeInit()
{
    safeZone[0] = GangZoneCreate(-2375 , -2635.2753295898438, -1927, -2203.2753295898438);
    safeZone[1] = GangZoneCreate(-2709, 2175.9000000953674, -2140, 2558.9000000953674);
    safeZone[2] = GangZoneCreate(2108, -182.10009765625, 2594, 230.89990234375);
    contZone[0] = GangZoneCreate( 99.0623779296875, -2856.387237548828, 2945.0623779296875, -970.3872375488281);
    contZone[1] = GangZoneCreate( 856, 543, 2789, 2928);
    contZone[2] = GangZoneCreate( -3000, -379.35003662109375, -1502, 1554.6499633789062);
    contZone[3] = GangZoneCreate( -112, 1599, 503, 2154);
    return 1;
}
hook OnPlayerSpawn(playerid){
    for(new i =0; i<3; i++)
    {
        GangZoneShowForPlayer(playerid, safeZone[i], 0x00FF0040);
    }
    for(new i=0; i<4; i++)
    {
        GangZoneShowForPlayer(playerid, contZone[i], 0xFF000040);
    }
    zoneTimer[playerid] = SetTimerEx("updateZoneSign",1000, true, "i", playerid);
    return 1;
}
hook OnPlayerConnect(playerid){
    isZoneSignShow[playerid] = 0;
    return 1;
}
hook OnPlayerDisconnect(playerid, reason){
    KillTimer(zoneTimer[playerid]);
    return 1;
}