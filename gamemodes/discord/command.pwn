DCMD:register(user, channel, params[]){
    if(channel != channelRegister)
    {
        return DCC_SendChannelMessage(channel, "Anda tidak berada di channel register!");
    }
    new userName[MAX_PLAYER_NAME];
    if(sscanf(params,"s[24]", userName))
    {
        return DCC_SendChannelMessage(channel, "Nama tidak valid!");
    }
    new playerFile[128];
    format(playerFile, sizeof(playerFile), "Whitelist/%s.ini", userName);
    if(dini_Exists(playerFile))
    {
        new error[64];
        format(error, sizeof(error), "Nama %s telah terdaftar");
        return DCC_SendChannelMessage(channel, error);
    }
   
    dini_Create(playerFile);
    dini_IntSet(playerFile, "id", user);
    DCC_RemoveGuildMemberRole(guildId, user, roleUnverified);
    DCC_AddGuildMemberRole(guildId, user, roleVerified);
    new success[128];
    
    format(success, sizeof(success), "Anda berhasil mendaftarkan %s ke dalam server", userName);
    DCC_SendChannelMessage(channel, success);
    return 1;
}
DCMD:ban(user, channel, params[])
{

    return 1;
}
DCMD:pardon(user, channel, params[])
{
    return 1;
}