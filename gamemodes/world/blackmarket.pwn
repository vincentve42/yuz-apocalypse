#include <YSI_Coding\y_hooks>

stock showPlayerBlackMarket(playerid)
{
    new str[256];
    format(str, sizeof(str), "Item\tHarga\nPistol 9mm\t"EMBED_GREEN"10000\t"EMBED_WHITE"\nShotgun\t"EMBED_GREEN"20000"EMBED_WHITE"\nUzi\t"EMBED_GREEN"30000"EMBED_WHITE"\n50x 9mm ammo\t"EMBED_GREEN"200"EMBED_WHITE"\n50x Shotgun Ammo\t"EMBED_GREEN"500"EMBED_WHITE"\n200x Uzi Ammo\t"EMBED_GREEN"1000"EMBED_WHITE"");
    ShowPlayerDialog(playerid, DIALOG_GUNSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Pedagang Senjata", str, "Beli", "Batal");
    return 1;
}

hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/gunshop", true)){
        if(IsPlayerInRangeOfPoint(playerid, 7.0, 2179.1343,-2242.9304,13.4824))
        {
            showPlayerBlackMarket(playerid);
            return 1;
        }
        return sendErrorMessage(playerid, "Anda tidak berada di dekat penjual senjata");
        
    }
    return 0;
}