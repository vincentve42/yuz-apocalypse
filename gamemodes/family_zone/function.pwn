#include <YSI_Coding\y_hooks>

stock calculateLandPrice(Float:minX, Float:minY, Float:maxX, Float:maxY){
    new xRange = floatround(maxX - minX, floatround_ceil);
    new yRange = floatround(maxY - minY, floatround_ceil);


    return (xRange * PRICE_PER_METER) + ( yRange * PRICE_PER_METER);
}
stock isPlayerInLand(playerid){
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    for(new i=0; i<MAX_FAM_ZONE; i++)
    {
    
        if(x >= famZone[i][ffMinX] && x <= famZone[i][ffMaxX] && y >= famZone[i][ffMinY] && y <= famZone[i][ffMaxY])
        {
            return i;
        }

    }
    return -1;
}
stock isPlayerInSpecificLand(playerid, i){
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(i == -1){
        return 0;
    }
    if(x >= famZone[i][ffMinX] && x <= famZone[i][ffMaxX] && y >= famZone[i][ffMinY] && y <= famZone[i][ffMaxY])
    {
        return 1;
    }
    return 0;
}
stock isSpecificCoordinateInLand(playerid, Float:x, Float:y){
    new i = tempManageLand[playerid];
    if(i == -1){
        return 0;
    }
    if(x >= famZone[i][ffMinX] && x <= famZone[i][ffMaxX] && y >= famZone[i][ffMinY] && y <= famZone[i][ffMaxY])
    {
        return 1;
    }
    return 0;
}