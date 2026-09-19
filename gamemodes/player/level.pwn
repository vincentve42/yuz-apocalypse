#include <YSI_Coding\y_hooks>

stock givePlayerXp(playerid, xp)
{
    Player[playerid][pXp] += xp;
    return 1;
}
stock updateLevel(playerid)
{
    if(Player[playerid][pXp] >= Player[playerid][pAdvance])
    {
        Player[playerid][pXp] = 0;
        Player[playerid][pLevel] += 1;
        Player[playerid][pAdvance] += 1000;
        SetPlayerScore(playerid, Player[playerid][pLevel]);
        new str[128];
        format(str, sizeof(str), "Anda berhasil naik ke level %d", Player[playerid][pLevel]);
        sendInfoMessage(playerid, str);
    }
    return 1;
}
hook FCNPC_OnDeath(npcid, killerid, reason){
    if(killerid != INVALID_PLAYER_ID && !IsPlayerNPC(killerid))
    {
        givePlayerXp(killerid, 10);
        updateLevel(killerid);
        
    }
    return 1;
}
