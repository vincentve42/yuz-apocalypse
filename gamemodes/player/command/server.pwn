#include <YSI_Coding\y_hooks>


hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/stats", true))
    {
        new judul[256];
        new isi[512];
        new name[128];

        GetPlayerName(playerid, name, sizeof(name));

        format(judul, sizeof(judul), "Informasi Akun %s", name);

        format(isi, sizeof(isi), ""EMBED_GOLD"[Informasi Umum]\n"EMBED_WHITE"Nama : "EMBED_YELLOW"%s"EMBED_WHITE" | Xp : "EMBED_YELLOW"%d/%d"EMBED_WHITE" | Level : "EMBED_YELLOW"%d"EMBED_WHITE" | Admin : "EMBED_YELLOW"%d\n"EMBED_WHITE"Skin : "EMBED_YELLOW"%d "EMBED_WHITE" | Money : "EMBED_GREEN"%d", name,Player[playerid][pXp],Player[playerid][pAdvance], Player[playerid][pLevel],Player[playerid][pAdmin], Player[playerid][pSkin], Player[playerid][pMoney]);

        if(Player[playerid][pFam] != -1)
        {
            format(isi, sizeof(isi), "%s\n\n"EMBED_GOLD"[Informasi Family]\n"EMBED_WHITE"Family : "EMBED_RED"%s"EMBED_WHITE""" | "EMBED_WHITE"Rank : "EMBED_RED"%s", isi,familyInfo[Player[playerid][pFam]][fName], Player[playerid][pFamRankName]);
        }
        showMsgBox(playerid, judul, isi);

        
        return 1;
    }
    if(!strcmp(cmdtext, "/disablecheckpoint", true)){
        DisablePlayerCheckpoint(playerid);
        sendSuccessMessage(playerid, "Anda berhasil menghilangkan semua checkpoint yang ada");
        return 1;
    }
    if(!strcmp(cmdtext, "/help", true) || !strcmp(cmdtext, "/bantuan", true))
    {
        new str[2056];
        format(str, sizeof(str), "Nama\tKeterangan");
        format(str, sizeof(str), "%s\nPlayer\tMelihat  perintah player yang penting",str);
        format(str, sizeof(str), "%s\nPlayer Interaksi\tMelihat semua perintah antar player",str);
        format(str, sizeof(str), "%s\nTas\tMelihat semua perintah inventory / tas",str);
        format(str, sizeof(str), "%s\nVehicle\tMelihat semua perintah kendaraan pribadi",str);
        format(str, sizeof(str), "%s\nFamily\tMelihat semua perintah family",str);
        format(str, sizeof(str), "%s\nRandom Event\tMelihat semua keterangan mengenai random event",str);
        ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Pemain", str, "Pilih", "Tutup");

        return 1;
    }
    if(!strcmp(cmdtext, "/togpm", true))
    {
        if(playerTogPm[playerid] == 1)
        {
            playerTogPm[playerid] = 0;
            return sendSuccessMessage(playerid, "Anda menghidupkan kembali fitur pm");
        }
        playerTogPm[playerid] = 1;
        return sendSuccessMessage(playerid, "Anda mematikan fitur pm");
    }
    new command[128];
    new arg1[512];

    sscanf(cmdtext, "s[128]s[512]", command, arg1);

    if(!strcmp(command, "/pm", true))
    {
        new target;
        new msg[256];
        if(sscanf(arg1, "ds[512]", target, msg))
        {
            return sendErrorMessage(playerid, "Gunakan /pm [id_pemain] [pesan]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target) || playerid == target)
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        if(playerTogPm[playerid] == 1)
            return sendErrorMessage(playerid, "Anda sedang mematikan fitur pm");
        if(playerTogPm[target] == 1)
            return sendErrorMessage(playerid, "Player yang anda tuju mematikan fitur pm");
        new str1[512];
        new str2[512];
        new targetName[MAX_PLAYER_NAME];
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(target, targetName, sizeof(targetName));
        GetPlayerName(playerid, playerName, sizeof(playerName));
        format(str1,sizeof(str1), ""EMBED_YELLOW"[PM To %s]"EMBED_WHITE" %s", targetName,msg);
        format(str2,sizeof(str2), ""EMBED_YELLOW"[PM From %s]"EMBED_WHITE" %s", playerName,msg);
        SendClientMessage(playerid, -1,str1);
        SendClientMessage(target, -1,str2);
        return 1;
    }
    if(!strcmp(command, "/whisper", true) || !strcmp(command, "/w", true))
    {
        new target;
        new msg[256];
        if(sscanf(arg1, "ds[512]", target, msg))
        {
            return sendErrorMessage(playerid, "Gunakan /whisper [id_pemain] [pesan]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target) || playerid == target)
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        new Float:x, Float:y,Float:z;
        GetPlayerPos(target, x, y, z);
        if(!IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z))
        {
            return sendErrorMessage(playerid, "Anda tidak berada player ingin dibisikkan");
        }
        new str1[512];
        new str2[512];
        new targetName[MAX_PLAYER_NAME];
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(target, targetName, sizeof(targetName));
        GetPlayerName(playerid, playerName, sizeof(playerName));
        format(str1,sizeof(str1), ""EMBED_CYAN"[Whisper To %s]"EMBED_WHITE" %s", targetName,msg);
        format(str2,sizeof(str2), ""EMBED_CYAN"[%s whisper to you]"EMBED_WHITE" %s", playerName,msg);
        SendClientMessage(playerid, -1,str1);
        SendClientMessage(target, -1,str2);
        return 1;
    }
    return 0;
}
