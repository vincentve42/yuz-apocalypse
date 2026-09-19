#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    if(!IsPlayerNPC(playerid))
    {
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        new str[64];
        format(str, sizeof(str), "[CONNECT] %s terkoneksi ke dalam server", playerName);
        DCC_SendChannelMessage(channelJoinLeave, str);
    }
    return 1;
}
hook OnPlayerDisconnect(playerid, reason){
    if(!IsPlayerNPC(playerid))
    {
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        new str[100];
        switch(reason){
            case 0:
            {
                format(str, sizeof(str), "[DISCONNECT] %s keluar dari server (timeout/crash) ke dalam server", playerName);
            }
            case 1:
            {
                format(str, sizeof(str), "[DISCONNECT] %s keluar dari server (quit) ke dalam server", playerName);
            }
            case 2:
            {
                format(str, sizeof(str), "[DISCONNECT] %s keluar dari server (kick/ban) ke dalam server", playerName);
            }
        }
        
        DCC_SendChannelMessage(channelJoinLeave, str);
    }
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[])
{
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    new str[256];
    format(str, sizeof(str), "[COMMAND] %s melakukan command %s", playerName, cmdtext);
    DCC_SendChannelMessage(channelCommand, str);
    return 0;
}
