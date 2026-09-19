#include <YSI_Coding\y_hooks>

#define DCMD_PREFIX '!' //If you don't define, by default it is '!'
#define DCMD_STRICT_CASE //Defining this will make commands case-sensitive. !test and !TEST will become different
#define DCMD_ALLOW_BOTS //Defining this will not ignore commands sent on channel by bots.

new playerDiscordCount = 0;

new DCC_Role:roleVerified;
new DCC_Channel:channelRegister;
new DCC_Role:roleUnverified;
new DCC_Guild:guildId;
new DCC_Channel:channelJoinLeave;
new DCC_Channel:channelCommand;
new DCC_Channel:channelChat;


hook OnGameModeInit(){
    roleVerified = DCC_FindRoleById("1537743866843758592");
    channelRegister = DCC_FindChannelById("1535482284633755770");
    roleUnverified = DCC_FindRoleById("1537750078385688616");
    guildId = DCC_FindGuildById("1535319878314103016");
    channelJoinLeave = DCC_FindChannelById("1537758337687363675");
    channelCommand = DCC_FindChannelById("1537761699224879214");
    channelChat = DCC_FindChannelById("1537763183065047100");
    new str[128];
    format(str, sizeof(str), "Watching %d players", playerDiscordCount);
    DCC_SetBotActivity(str);
    return 1;
}

hook OnPlayerConnect(playerid){
    if(!IsPlayerNPC(playerid)){
        new str[128];
        playerDiscordCount+= 1;
        format(str, sizeof(str), "Watching %d players", playerDiscordCount);
        DCC_SetBotActivity(str);
        
    }
    return 1;
}
hook OnPlayerDisconnect(playerid, reason)
{
    if(!IsPlayerNPC(playerid)){
        new str[128];
        playerDiscordCount-= 1;
        format(str, sizeof(str), "Watching %d players", playerDiscordCount);
        DCC_SetBotActivity(str);
       
    }
    return 1;
}