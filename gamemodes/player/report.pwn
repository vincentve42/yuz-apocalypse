#include <YSI_Coding\y_hooks>

#define MAX_REPORT 50
new tempReport[MAX_PLAYERS];
enum REPORT{
    rPlayerName[MAX_PLAYER_NAME],
    rReportedPlayerName[MAX_PLAYER_NAME],
    rKeterangan[128]

}
new reportId[MAX_REPORT];
new reportInfo[MAX_REPORT][REPORT];
new playerIsAlreadyReported[MAX_PLAYERS];
hook OnGameModeInit()
{
    for(new i=0; i<MAX_REPORT; i++)
    {
        reportId[i] = -1;
    }
    return 1;
}
hook OnPlayerConnect(playerid){
    playerIsAlreadyReported[playerid] = -1;
    return 1;
}

hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/listreport", true)){
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        new str[3300];
        format(str, sizeof(str), "Nama Pelapor\tNama Telapor\tAlasan\n");
        for(new i=0; i<MAX_REPORT; i++)
        {
            if(reportId[i] != -1)
            {
                format(str, sizeof(str), "%s\n%s\t%s\t%16s", str, reportInfo[reportId[i]][rPlayerName], reportInfo[reportId[i]][rReportedPlayerName], reportInfo[reportId[i]][rKeterangan]);
            }
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_REPORT, DIALOG_STYLE_TABLIST_HEADERS, "List Laporan", str, "Tindak", "Tutup");
        return 1;
    }
    new command[64];
    new arg1[256];
    sscanf(cmdtext, "s[64]s[256]", command, arg1);
    if(!strcmp(command, "/report", true))
    {
        new target;
        new reason[128];
        if(sscanf(arg1, "ds[128]", target, reason))
        {
            return sendErrorMessage(playerid, "/report [id_pemain_yang_ingin_direport] [keterangan]");
        }
        if(playerIsAlreadyReported[playerid] == 1)
        {
            return sendErrorMessage(playerid, "Anda telah mereport player silahkan tunggu admin menjawabnya");
        }
        for(new i =0; i<MAX_REPORT; i++)
        {
            if(reportId[i] == -1)
            {
                playerIsAlreadyReported[playerid] = 1;
                reportId[i] = i;
                GetPlayerName(playerid, reportInfo[reportId[i]][rPlayerName], MAX_PLAYER_NAME);
                GetPlayerName(target, reportInfo[reportId[i]][rReportedPlayerName], MAX_PLAYER_NAME);
                format(reportInfo[reportId[i]][rKeterangan], 128, "%s", reason);
                new success[128];
                format(success, sizeof(success), "Anda sukses melaporkan player %s kepada admin", reportInfo[reportId[i]][rReportedPlayerName]);
                sendSuccessMessage(playerid, success);
                new infotoadmin[128];
                format(infotoadmin, sizeof(infotoadmin), ""EMBED_RED"[REPORT] "EMBED_WHITE"%s melaporkan player bernama %s", reportInfo[reportId[i]][rPlayerName], reportInfo[reportId[i]][rReportedPlayerName]);
                for(new j=0; j<MAX_PLAYERS; j++)
                {
                    if(IsPlayerConnected(j) && !IsPlayerNPC(j) && Player[j][pAdmin] > 0)
                    {
                        SendClientMessage(j, -1, infotoadmin);
                    }
                }
                return 1;
            }
        }
        sendErrorMessage(playerid, "Maaf saat ini antrian report sedang penuh silahkan coba lagi!");
        return 1;
    }
    return 0;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_LIST_REPORT)
    {
        if(response)
        {
            new count = 0;
            for(new i=0; i<MAX_REPORT; i++)
            {
                if(reportId[i] != -1)
                {
                    if(count == listitem)
                    {
                        tempReport[playerid] = reportId[i];
                        break;
                    }
                    count++;
                }
            }
            new judul[32];
            format(judul, sizeof(judul), "Report ID %d", listitem);
            new str[256];
            format(str, sizeof(str), "Nama Pelapor: "EMBED_YELLOW"%s"EMBED_WHITE"\nNama Telapor: "EMBED_REALRED"%s\n"EMBED_YELLOW"Keterangan: "EMBED_WHITE"%s", reportInfo[listitem][rPlayerName], reportInfo[listitem][rReportedPlayerName], reportInfo[listitem][rKeterangan]);
            
            ShowPlayerDialog(playerid, DIALOG_REPORT, DIALOG_STYLE_MSGBOX, judul, str, "Tindak", "Tutup");

        }

    }
    if(dialogid == DIALOG_REPORT)
    {
        if(response)
        {
            new adminName[MAX_PLAYER_NAME];
            GetPlayerName(playerid, adminName, sizeof(adminName));
            for(new i=0; i<MAX_PLAYERS; i++)
            {
                if(IsPlayerConnected(i) && !IsPlayerNPC(i))
                {
                    new playername[MAX_PLAYER_NAME];
                    GetPlayerName(i, playername, sizeof(playername));
                    if(strcmp(playername, reportInfo[tempReport[playerid]][rPlayerName]) == 0)
                    {
                        new str[128];
                        format(str, sizeof(str), "Admin %s sedang menindak laporan anda", adminName);
                        sendInfoMessage(i, str);
                        new str1[128];
                        format(str1, sizeof(str1), "Anda menindak laporan pemain %s", playername);
                        sendInfoMessage(playerid, str1);
                        playerIsAlreadyReported[i] = 0;
                        break;
                    }
                }
            }
        }
        
        reportId[tempReport[playerid]] = -1;
    }

    return 1;
}