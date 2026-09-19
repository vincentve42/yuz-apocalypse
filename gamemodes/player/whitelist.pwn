#include <YSI_Coding\y_hooks>

hook OnPlayerConnect(playerid){
    if(!IsPlayerNPC(playerid)){
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        new playerFile[128];
        format(playerFile, sizeof(playerFile), "Whitelist/%s.ini", playerName);
        if(!dini_Exists(playerFile))
        {
            new str[1024];
            format(str, sizeof(str), "Nama "EMBED_YELLOW"%s"EMBED_WHITE" tidak terdaftar silahkan ke channel register untuk mendaftarkan akun anda");
            ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Whitelist", str, "Oke", "");
            SetTimerEx("KickTimer", 1000, false, "i", playerid);
        }   
    }
    return 1;
}