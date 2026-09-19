public OnPlayerText(playerid, text[])
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    new str[256];
    new str2[512];
    
    format(str, sizeof(str), "%s says: %s.", playerName,text);
    format(str2, sizeof(str2), "[CHAT] %s", str);
    
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && !IsPlayerNPC(i)){
            if(IsPlayerInRangeOfPoint(i, 10.0, x, y, z))
            {
                SendClientMessage(i, -1, str);
            }
        }
    }
    return 0;
}