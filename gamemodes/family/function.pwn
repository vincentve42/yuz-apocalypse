

stock getEmptyName(famid){
    if(isnull(familyInfo[famid][fmName1]))
    {
        return 1;
    }
    if(isnull(familyInfo[famid][fmName2]))
    {
        return 2;
    }
    if(isnull(familyInfo[famid][fmName3]))
    {
        return 3;
    }
    if(isnull(familyInfo[famid][fmName4]))
    {
        return 4;
    }
    if(isnull(familyInfo[famid][fmName5]))
    {
        return 5;
    }
    if(isnull(familyInfo[famid][fmName6]))
    {
        return 6;
    }
    if(isnull(familyInfo[famid][fmName7]))
    {
        return 7;
    }
    if(isnull(familyInfo[famid][fmName8]))
    {
        return 8;
    }
    if(isnull(familyInfo[famid][fmName9]))
    {
        return 9;
    }
    if(isnull(familyInfo[famid][fmName10]))
    {
        return 10;
    }
    return 0;
}
stock checkIfPlayerInFam(famid,playername[])
{
    if(strlen(familyInfo[famid][fmName1]) > 0 && strcmp(familyInfo[famid][fmName1], playername) == 0)
    {
        return 1;
    }
    if(strlen(familyInfo[famid][fmName2]) > 0 && strcmp(familyInfo[famid][fmName2], playername) == 0)
    {
        return 2;
    }
    if(strlen(familyInfo[famid][fmName3]) > 0 && strcmp(familyInfo[famid][fmName3], playername) == 0)
    {
        return 3;
    }
    if(strlen(familyInfo[famid][fmName4]) > 0 && strcmp(familyInfo[famid][fmName4], playername) == 0)
    {
        return 4;
    }
    if(strlen(familyInfo[famid][fmName5]) > 0 && strcmp(familyInfo[famid][fmName5], playername) == 0)
    {
        return 5;
    }
    if(strlen(familyInfo[famid][fmName6]) > 0 && strcmp(familyInfo[famid][fmName6], playername) == 0)
    {
        return 6;
    }
    if(strlen(familyInfo[famid][fmName7]) > 0 && strcmp(familyInfo[famid][fmName7], playername) == 0)
    {
        return 7;
    }
    if(strlen(familyInfo[famid][fmName8]) > 0 && strcmp(familyInfo[famid][fmName8], playername) == 0)
    {
        return 8;
    }
    if(strlen(familyInfo[famid][fmName9]) > 0 && strcmp(familyInfo[famid][fmName9], playername) == 0)
    {
        return 9;
    }
    if(strlen(familyInfo[famid][fmName10]) > 0 && strcmp(familyInfo[famid][fmName10], playername) == 0)
    {
        return 10;
    }
    return 0;
}
stock getPlayerFamily(playerid, &rank)
{
    new playerName[64];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    for(new i=0; i<MAX_FAMILY; i++)
    {
        if(familyExist[i] == 1)
        {
            if(familyInfo[i][fmName1] > 0 && strcmp(playerName,familyInfo[i][fmName1]) == 0)
            {
                rank = familyInfo[i][fmRank1];
                return i;
            }
            if(familyInfo[i][fmName2] > 0 && strcmp(playerName,familyInfo[i][fmName2]) == 0)
            {
                rank = familyInfo[i][fmRank2];
                return i;
            }
            if(familyInfo[i][fmName3] > 0 && strcmp(playerName,familyInfo[i][fmName3]) == 0)
            {
                rank = familyInfo[i][fmRank3];
                return i;
            }
            if(familyInfo[i][fmName4] > 0 && strcmp(playerName,familyInfo[i][fmName4]) == 0)
            {
                rank = familyInfo[i][fmRank4];
                return i;
            }
            if(familyInfo[i][fmName5] > 0 && strcmp(playerName,familyInfo[i][fmName5]) == 0)
            {
                rank = familyInfo[i][fmRank5];
                return i;
            }
            if(familyInfo[i][fmName6] > 0 && strcmp(playerName,familyInfo[i][fmName6]) == 0)
            {
                rank = familyInfo[i][fmRank6];
                return i;
            }
            if(familyInfo[i][fmName7] > 0 && strcmp(playerName,familyInfo[i][fmName7]) == 0)
            {
                rank = familyInfo[i][fmRank7];
                return i;
            }
            if(familyInfo[i][fmName8] > 0 && strcmp(playerName,familyInfo[i][fmName8]) == 0)
            {
                rank = familyInfo[i][fmRank8];
                return i;
            }
            if(familyInfo[i][fmName9] > 0 && strcmp(playerName,familyInfo[i][fmName9]) == 0)
            {
                rank = familyInfo[i][fmRank9];
                return i;
            }
            if(familyInfo[i][fmName10] > 0 && strcmp(playerName,familyInfo[i][fmName10]) == 0)
            {
                rank = familyInfo[i][fmRank10];
                return i;
            }
        }
    }
    return -1;
}
stock getPlayerRankName(playerid){
    if(Player[playerid][pFamRank] == 1)
    {
        format(Player[playerid][pFamRankName], 64, "Soldier"); 
    }
    if(Player[playerid][pFamRank] == 2)
    {
        format(Player[playerid][pFamRankName], 64, "Captain"); 
    }
    if(Player[playerid][pFamRank] == 3)
    {
        format(Player[playerid][pFamRankName], 64, "General"); 
    }
    if(Player[playerid][pFamRank] == 4)
    {
        format(Player[playerid][pFamRankName], 64, "Leader"); 
    }
    return 1;
}
stock getRankName(rank, rankname[64]){
    if(rank == 1)
    {
        format(rankname, sizeof(rankname), "Soldier"); 
    }
    if(rank == 2)
    {
        format(rankname, sizeof(rankname),  "Captain"); 
    }
    if(rank == 3)
    {
        format(rankname, sizeof(rankname),  "General"); 
    }
    if(rank == 4)
    {
        format(rankname, sizeof(rankname), "Leader"); 
    }
    return 1;
}