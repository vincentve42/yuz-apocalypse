#include <YSI_Coding\y_hooks>

hook OnPlayerCommandText(playerid, cmdtext[])
{
    new command[128];
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);
    if(!strcmp(command, "/deletefamily", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");
        }
        new famid;
        if(sscanf(arg1,"d", famid))
        {
            return sendErrorMessage(playerid, "Gunakan /deletefamily [famid]");
        }
        if(familyExist[famid] == -1)
        {
            new error[128];
            format(error, sizeof(error), "Family dengan id %d tidak ada", famid);
            return sendErrorMessage(playerid, error);
        }
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i) && !IsPlayerNPC(i))
            {
                if(Player[i][pFam] == famid)
                {
                    sendInfoMessage(i, "Anda dikeluarkan secara paksa dari family karena ingin dihapus");
                    Player[i][pFam] = -1;
                    Player[i][pFamRank] = 0;
                }
            }
        }
        new familyFile[128];
        format(familyFile, sizeof(familyFile), "Family/Fam%d.ini", famid);
        dini_Remove(familyFile);
        familyExist[famid] = -1;
        new success[128];
        format(success, sizeof(success), "Anda berhasil menghapus family dengan id %d", famid);
        sendSuccessMessage(playerid, success);
        return 1;
    }
    if(!strcmp(command, "/createfamily", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");
        }
        new familyName[64];
        if(sscanf(arg1, "s[64]", familyName))
        {
            return sendErrorMessage(playerid, "Gunakan /createfamily [nama_faksi]");
        }
        for(new i =0; i<MAX_FAMILY; i++)
        {
            new familyFile[128];
            format(familyFile, sizeof(familyFile), "Family/Fam%d.ini",i);
            if(!dini_Exists(familyFile))
            {
                dini_Create(familyFile);
                format(familyInfo[i][fName], 255, "%s", familyName);

                new str[128];
                format(str, sizeof(str), "Sukses membuat family %s dengan id %d", familyName, i);
                familyExist[i] = 1;
                saveFam();
                return sendSuccessMessage(playerid, str);
            }
        }
        return 1;
    }
    if(!strcmp(command, "/setfamilyleader", true)){
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 4");
        }
        new famid;
        new target;
        if(sscanf(arg1,"dd", target, famid))
        {
            return sendErrorMessage(playerid, "Gunakan /setfamilyleader [playerid] [famid]");
        }
        if(familyExist[famid] == -1)
        {
            new error[128];
            format(error, sizeof(error), "Family dengan id %d tidak ada", famid);
            return sendErrorMessage(playerid, error);
        }
        new playername[MAX_PLAYER_NAME];
        GetPlayerName(target, playername, sizeof(playername));
        new isinfam = checkIfPlayerInFam(famid, playername);
        if(!IsPlayerConnected(target))
        {
            new error[128];
            format(error, sizeof(error), "Player %d tidak terkoneksi", target);
            return sendErrorMessage(playerid, error);
        }
        if(isinfam == 0)
        {
            new checkavail = getEmptyName(famid);
            switch(checkavail)
            {
                case 0:
                {
                    new error[64];
                    format(error, sizeof(error), "Anggota family %s penuh!", familyInfo[famid][fName]);
                    return sendErrorMessage(playerid, "Anggota family penuh!");
                }
                case 1:
                {
                    format(familyInfo[famid][fmName1], DINI_MAX_STRING, "%s", playername);
                    
                    familyInfo[famid][fmRank1] = 4;
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 2:
                {
                    format(familyInfo[famid][fmName2], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank2] = 4;
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 3:
                {
                    format(familyInfo[famid][fmName3], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank3] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 4:
                {
                    format(familyInfo[famid][fmName4], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank4] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 5:
                {
                    format(familyInfo[famid][fmName5], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank5] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 6:
                {
                    format(familyInfo[famid][fmName6], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank6] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 7:
                {
                    format(familyInfo[famid][fmName7], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank7] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 8:
                {
                    format(familyInfo[famid][fmName8], DINI_MAX_STRING, "%s", playername);
                   
                    familyInfo[famid][fmRank8] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 9:
                {
                    format(familyInfo[famid][fmName9], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank9] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
                case 10:
                {
                    format(familyInfo[famid][fmName10], DINI_MAX_STRING, "%s", playername);
                    familyInfo[famid][fmRank10] = 4; 
                    new success[256];
                    format(success, sizeof(success), "Anda berhasil membuat %s menjadi leader %s", playername, familyInfo[famid][fName]);
                    sendSuccessMessage(playerid, success);
                }
            }
            new info[128];
            new adminName[128];
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(info, sizeof(info), "Admin %s membuat anda menjadi leader "EMBED_RED" %s", adminName,familyInfo[famid][fName]);
            sendInfoMessage(target, info);
            saveFam();
            Player[playerid][pFam] = getPlayerFamily(playerid, Player[playerid][pFamRank]);
            if(Player[playerid][pFam] != -1)
            {
                getPlayerRankName(playerid);
            }
            return 1;
        }
        else
        {
            switch(isinfam)
            {
                case 1:
                {
                    familyInfo[famid][fmRank1] = 4; 
                }
                case 2:
                {
                    familyInfo[famid][fmRank2] = 4; 
                }
                case 3:
                {
                    familyInfo[famid][fmRank3] = 4; 
                }
                case 4:
                {
                    familyInfo[famid][fmRank4] = 4; 
                }
                case 5:
                {
                    familyInfo[famid][fmRank5] = 4; 
                }
                case 6:
                {
                    familyInfo[famid][fmRank6] = 4; 
                }
                case 7:
                {
                    familyInfo[famid][fmRank7] = 4; 
                }
                case 8:
                {
                    familyInfo[famid][fmRank8] = 4; 
                }
                case 9:
                {
                    familyInfo[famid][fmRank9] = 4; 
                }
                case 10:
                {
                    familyInfo[famid][fmRank10] = 4; 
                }
            }
            new success[128];
            new info[128];
            new adminName[128];
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(info, sizeof(info), "Admin %s membuat anda menjadi leader "EMBED_RED" %s", adminName,familyInfo[famid][fName]);
            sendInfoMessage(target, info);
            format(success, sizeof(success), "Anda sukses membuat %s menjadi leader "EMBED_RED"%s", playername, familyInfo[famid][fName]);
            sendSuccessMessage(playerid, success);
            return 1;
        }
    }
    if(!strcmp(command, "/listfam", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        new str[1024];
        format(str, sizeof(str), "ID\tNama Family");
        for(new i=0; i<MAX_FAMILY; i++)
        {
            if(familyExist[i] != -1)
            {
                format(str, sizeof(str), "%s\n%d\t%s", str, i, familyInfo[i][fName]);
            }
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_FAM, DIALOG_STYLE_TABLIST_HEADERS, "List Family", str, "Tutup", "");
        return 1;
    }
    if(!strcmp(command, "/listmember", true))
    {
        new famid;
        if(Player[playerid][pAdmin] < 3)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(sscanf(arg1, "d", famid))
        {
            return sendErrorMessage(playerid, "Gunakan /listmember [famid]");
        }
        if(familyExist[famid] == -1)
        {
            new error[128];
            format(error, sizeof(error), "Fam dengan id %d tidak ada", famid);
            return sendErrorMessage(playerid, error);
        }
        new str[1024];
        format(str, sizeof(str), "Nama\tRank");
        new rankname[64];
        if(strlen(familyInfo[famid][fmName1]) > 0)
        {
            getRankName(familyInfo[famid][fmRank1], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName1], rankname);
        }
        if(strlen(familyInfo[famid][fmName2]) > 0)
        {
            getRankName(familyInfo[famid][fmRank2], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName2], rankname);
        }
        if(strlen(familyInfo[famid][fmName3]) > 0)
        {
            getRankName(familyInfo[famid][fmRank3], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName3], rankname);
        }
        if(strlen(familyInfo[famid][fmName4]) > 0)
        {
            getRankName(familyInfo[famid][fmRank4], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName4], rankname);
        }
        if(strlen(familyInfo[famid][fmName5]) > 0)
        {
            getRankName(familyInfo[famid][fmRank5], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName5], rankname);
        }
        if(strlen(familyInfo[famid][fmName6]) > 0)
        {
            getRankName(familyInfo[famid][fmRank6], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName6], rankname);
        }
        if(strlen(familyInfo[famid][fmName7]) > 0)
        {
            getRankName(familyInfo[famid][fmRank7], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName7], rankname);
        }
        if(strlen(familyInfo[famid][fmName8]) > 0)
        {
            getRankName(familyInfo[famid][fmRank8], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName8], rankname);
        }
        if(strlen(familyInfo[famid][fmName9]) > 0)
        {
            getRankName(familyInfo[famid][fmRank9], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName9], rankname);
        }
        if(strlen(familyInfo[famid][fmName10]) > 0)
        {
            getRankName(familyInfo[famid][fmRank10], rankname);
            format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName10], rankname);
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_FAM, DIALOG_STYLE_TABLIST_HEADERS, "List Family", str, "Tutup", "");
        return 1;
    }
    if(!strcmp(command, "/checkinventory", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        new target;
        if(sscanf(arg1, "d", target)){
            return sendErrorMessage(playerid, "Gunakan /checkinventory [targetid]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        }
        new str[128];
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(target, playerName, sizeof(playerName));
        format(str, sizeof(str), "Anda sedang melihat isi tas pemain bernama %s", playerName);
        sendSuccessMessage(playerid, str);
        showInventory(target, playerid);
        return 1;
    }
    if(!strcmp(command, "/kickfamilymember", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 4");
        }
        new famid;
        new target[128];
        if(sscanf(arg1,"ds[128]", target, famid))
        {
            return sendErrorMessage(playerid, "Gunakan /kickfamilymember [namaplayer] [famid]");
        }
        if(familyExist[famid] == 0)
        {
            new error[128];
            format(error, sizeof(error), "Family dengan id %d tidak ada", famid);
            return sendErrorMessage(playerid, error);
        }
        
        new adminName[MAX_PLAYER_NAME];
        
        new isinfam = checkIfPlayerInFam(famid, target);
        if(isinfam == 0)
        {
            new error[128];
            format(error, sizeof(error), "Player %s tidak berada dalam family %s", target, familyInfo[famid][fName]);
            return sendErrorMessage(playerid, error);
        }
        GetPlayerName(playerid, adminName, sizeof(adminName));
        new targetid = INVALID_PLAYER_ID;
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            if(i != INVALID_PLAYER_ID)
            {
                new playername[MAX_PLAYER_NAME];
                GetPlayerName(i, playername, sizeof(playername));
                if(strcmp(playername, target) == 0)
                {
                    targetid = i;
                    break;
                }
            }
        }
        if(IsPlayerConnected(targetid))
        {
            
            new info[128];
            format(info, sizeof(info), "Admin %s telah menendang anda dari family "EMBED_RED"%s", adminName, familyInfo[famid][fName]);
            sendInfoMessage(targetid, info);
            Player[targetid][pFam] = -1;
        }
        new nullstr[DINI_MAX_STRING];
        switch(isinfam)
        {
            case 1:
            {
                format(familyInfo[famid][fmName1], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank1] = 0;
            }
            case 2:
            {
                format(familyInfo[famid][fmName2], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank2] = 0;
            }
            case 3:
            {
                format(familyInfo[famid][fmName3], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank3] = 0;
            }
            case 4:
            {
                format(familyInfo[famid][fmName4], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank4] = 0;
            }
            case 5:
            {
                format(familyInfo[famid][fmName5], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank5] = 0;
            }
            case 6:
            {
                format(familyInfo[famid][fmName6], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank6] = 0;
            }
            case 7:
            {
                format(familyInfo[famid][fmName7], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank7] = 0;
            }
            case 8:
            {
                format(familyInfo[famid][fmName8], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank8] = 0;
            }
            case 9:
            {
                format(familyInfo[famid][fmName9], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank9] = 0;
            }
            case 10:
            {
                format(familyInfo[famid][fmName10], DINI_MAX_STRING, "%s", nullstr);
                familyInfo[famid][fmRank10] = 0;
            }
        }
        new success[128];
        format(success, sizeof(success), "Anda berhasil menendang %s dari family "EMBED_RED"%s", familyInfo[famid][fName]);
        sendSuccessMessage(playerid, success);
        saveFam();
        return 1;
    }
    if(!strcmp(command, "/f", true)){
        if(Player[playerid][pFam] == -1)
            return sendErrorMessage(playerid, "Anda tidak berada di family manapun");
        new msg[65];
        if(sscanf(arg1, "s[128]", msg))
            return sendErrorMessage(playerid, "/f [pesan]");
        if(strlen(msg) > 64)
            return sendErrorMessage(playerid, "Pesan tidak boleh lebih dari 64 karakter");
        new str[100];
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playerName, sizeof(playerName));

        format(str, sizeof(str), ""EMBED_RED"[FAMILY] "EMBED_WHITE" %s says:"EMBED_WHITE" %s.",playerName, msg);
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            if(Player[playerid][pFam] == Player[i][pFam])
            {
                SendClientMessage(i, -1, str);
            }
        }
        
        return 1;
    }
    if(!strcmp(command, "/fmenu", true) || !strcmp(command, "/familymenu", true))
    {
        if(Player[playerid][pFam] != -1)
        {
            ShowPlayerDialog(playerid, DIALOG_FAM_MENU, DIALOG_STYLE_TABLIST_HEADERS, "Fam Menu", "Menu\tDeskripsi\nList Member\tMelihat semua member\nList Lahan\tMelihat semua lahan\nAdd Member\tMenambahkan anggota\nSet Rank\tMengubah status rank member\nKick Member\tMengeluarkan member", "Choose", "Close");
            return 1;
        }
        return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
    }
    return 0;
}
