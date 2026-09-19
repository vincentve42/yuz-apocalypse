#include <YSI_Coding\y_hooks>

hook OnPlayerCommandText(playerid, cmdtext[]){
    new command[128];
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);
    if(!strcmp(command, "/lahaninfo", true))
    {
        new lahanid = isPlayerInLand(playerid);
        new pemilik[255];
        if(famZone[lahanid][ffamId] == -1)
        {
            format(pemilik, sizeof(pemilik), "Tidak ada "EMBED_YELLOW" /buylahan "EMBED_WHITE"untuk membeli lahan");
        }
        else
        {
            format(pemilik, sizeof(pemilik), "%s",familyInfo[famZone[lahanid][ffamId]][fName]);
        }
        if(famZone[lahanid][ffamId] == -1)
        {
            new str[512];
            format(str, sizeof(str), "[ID] : "EMBED_WHITE"%d\nPemilik : "EMBED_RED"%s\n"EMBED_WHITE"Harga : "EMBED_GREEN"%d\n"EMBED_WHITE"Expire dalam : "EMBED_YELLOW"%d jam", lahanid, pemilik, famZone[lahanid][ffMoney], famZone[lahanid][ffDuration]);
            ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Informasi Lahan", str, "Tutup", "");
            return 1;
        }
        if(Player[playerid][pFam] != famZone[lahanid][ffamId])
        {
            new str[512];
            format(str, sizeof(str), "[ID] : "EMBED_WHITE"%d\nPemilik : "EMBED_RED"%s\n"EMBED_WHITE"Harga : "EMBED_GREEN"%d\n"EMBED_WHITE"Expire dalam : "EMBED_YELLOW"%d jam", lahanid, pemilik, famZone[lahanid][ffMoney], famZone[lahanid][ffDuration]);
            ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Informasi Lahan", str, "Tutup", "");
            return 1;
        }
        if(famZone[lahanid][ffamId] != -1 && Player[playerid][pFam] == famZone[lahanid][ffamId])
        {
            new str[512];
            format(str, sizeof(str), "[ID] : "EMBED_WHITE"%d\nPemilik : "EMBED_RED"%s\n"EMBED_WHITE"Harga : "EMBED_GREEN"%d\n"EMBED_WHITE"Expire dalam : "EMBED_YELLOW"%d jam", lahanid, pemilik, famZone[lahanid][ffMoney], famZone[lahanid][ffDuration]);
            ShowPlayerDialog(playerid, DIALOG_FAM_LAHAN_INFO, DIALOG_STYLE_MSGBOX, "Informasi Lahan", str, "Manage", "Tutup");
            tempManageLand[playerid] = lahanid;
            return 1;
        }
        return 1;
    }
    if(!strcmp(command, "/unsetlahan", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 4");
        }
        new lahanid;
        if(sscanf(arg1, "d", lahanid))
        {
            return sendErrorMessage(playerid, "Gunakan /unsetlahan [lahanid]");
        }
        if(famZone[lahanid][ffamId] == -1)
        {
            new error[128];
            format(error, sizeof(error), "Lahan %d tidak dimiliki oleh family manapun", lahanid);
            return sendErrorMessage(playerid, error);
        }
        famZone[lahanid][ffamId] = -1;
        GangZoneHideForAll(famGangZone[lahanid]);
        GangZoneShowForAll(famGangZone[lahanid], 0x007FFF99);
        new success[128];
        format(success, sizeof(success), "Berhasil mereset lahan %d", lahanid);
        saveFamZone();
        return sendSuccessMessage(playerid, success);
    }
    if(!strcmp(command, "/createlahan", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 5)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");
        }
        new str[256];
        format(str, sizeof(str), "Position\tX\tY\nMin\t%.2f\t%.2f\nMax\t%.2f\t%.2f\nComplete", tempMinX[playerid], tempMinY[playerid], tempMaxX[playerid], tempMaxY[playerid]);
        ShowPlayerDialog(playerid, DIALOG_CLAIM_FAM_ZONE, DIALOG_STYLE_TABLIST_HEADERS, "Position", str, "Update", "Batal");
        return 1;
    }
    if(!strcmp(command, "/listlahan", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        new str[1024];
        format(str, sizeof(str), "ID\tFamily");
        for(new i =0; i<MAX_FAM_ZONE; i++)
        {
            if(famZoneExist[i] != -1)
            {
                new famName[DINI_MAX_STRING];
                if(famZone[i][ffamId] == -1)
                {
                    format(famName, sizeof(famName), "None");
                }
                else
                {
                    format(famName, sizeof(famName), familyInfo[famZone[i][ffamId]][fName]);
                }
                format(str, sizeof(str), "%s\n"EMBED_WHITE"%d\t"EMBED_RED"%s", str, i, famName);

            }
            else
            {
                format(str, sizeof(str), "%s\n"EMBED_WHITE"%d\t"EMBED_RED"%s", str, -1, "Belum Dibuat");
            }
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_LAND, DIALOG_STYLE_TABLIST_HEADERS, "List Lahan", str, "Teleport", "Batal");
        return 1;
    
    }
    if(!strcmp(command, "/deletelahan", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 5)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");
        }
        new landid; 
        if(sscanf(arg1, "d", landid))
        {
            return sendErrorMessage(playerid, "Gunakan /deletelahan [lahanid]");
        }
        new landFile[64];
        format(landFile, sizeof(landFile), "Zone/%d.ini", landid);
        if(!dini_Exists(landFile))
        {
            new error[128];
            format(error, sizeof(error), "Lahan dengan id %d tidak ada", landid);
            return sendErrorMessage(playerid, error);
        }
        dini_Remove(landFile);
        GangZoneHideForAll(famGangZone[landid]);
        GangZoneDestroy(famGangZone[landid]);
        famZoneExist[landid] = -1;
        new success[128];
        format(success, sizeof(success), "Anda berhasil menghapus lahan dengan id %d", landid);
        sendSuccessMessage(playerid, success);
        return 1;
    }
    if(!strcmp(command, "/buylahan", true))
    {
        if(Player[playerid][pFam] == -1)
        {
            return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
        }
        if(Player[playerid][pFamRank] < 4)
        {
            return sendErrorMessage(playerid, "Anda bukan leader dari suatu family");
        }
        new landid = isPlayerInLand(playerid);
        if(landid == -1)
        {
            return sendErrorMessage(playerid, "Anda tidak berada di dalam suatu lahan");
        }
        if(famZone[landid][ffamId] != -1 && Player[playerid][pFam] == famZone[landid][ffamId])
        {
            return sendErrorMessage(playerid, "Lahan telah dimiliki oleh family anda");
        }
        if(famZone[landid][ffamId] != -1)
        {
            return sendErrorMessage(playerid, "Lahan telah dimiliki oleh family lain");
        }
        tempBuyLand[playerid] = landid;
        new str[256];
        format(str, sizeof(str), "Apakah anda yakin untuk membeli lahan seharga "EMBED_GREEN" %d", famZone[landid][ffMoney]);
        ShowPlayerDialog(playerid, DIALOG_BUY_LAND, DIALOG_STYLE_MSGBOX, "Membeli lahan", str, "Beli", "Batal");
        return 1;

    }
    return 0;
}