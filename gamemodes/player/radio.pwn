#include <YSI_Coding\y_hooks>

new playerFreq[MAX_PLAYERS];
new playerUseRadio[MAX_PLAYERS];
stock sendUniversalRadioMessage(text[]){
    new msg[1024];
    format(msg, sizeof(msg), ""EMBED_YELLOW"[TIDAK DIKETAHUI] "EMBED_WHITE"%s", text);
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(playerUseRadio[i] == 1 && playerFreq[i] == 1){
            SendClientMessage(i, -1, msg);
            PlayAudioStreamForPlayer(i,"http://f.top4top.io/m_3883wana51.mp3",0.0,0.0,0.0,0.0,false);
            SetTimerEx("stopSound", 4000, false, "i", i);
            
        }
    }
    return 1;
}
stock sendRadioMessage(playerid, text[]){
    new frequency = playerFreq[playerid];
    new msg[1024];
    new playerName[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    format(msg, sizeof(msg), ""EMBED_GREY"[RADIO]"EMBED_WHITE" %s says %s.", playerName, text);
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(i != playerid && playerUseRadio[i] == 1 && playerFreq[i] == frequency){
            SendClientMessage(i, -1, msg);
            
            
        }
        
    }
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/radio", true))
    {
        if(Player[playerid][pRadio] == 0)
            return sendErrorMessage(playerid, "Anda tidak memiliki radio");
        new judulstr[256];
        if(playerUseRadio[playerid] == 0)
        {
            format(judulstr, sizeof(judulstr), "Radio "EMBED_RED"Mati");
        }
        else
        {
            format(judulstr, sizeof(judulstr), "Radio "EMBED_LIGHTGREEN"Hidup");
        }  
        new str[1024];
        format(str, sizeof(str), "Interaksi\tKeterangan\nON/OFF Radio\tGunakan atau matikan radio\nFrekuensi\tMengatur frekuensi radio\nChat\tMengirimkan chat ke radio");
        ShowPlayerDialog(playerid, DIALOG_RADIO, DIALOG_STYLE_TABLIST_HEADERS, judulstr, str, "Pilih", "Batal");
        return 1;
    }
    new command[128];
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command, arg1);
    if(!strcmp(command, "/r", true)){
        if(Player[playerid][pRadio] == 0)
            return sendErrorMessage(playerid, "Anda tidak memiliki radio");
        if(playerUseRadio[playerid] == 0)
        {
            return sendErrorMessage(playerid, "Radio anda mati!");
        }
        new text[128];
        if(sscanf(arg1, "s[128]", text))
        {
            return sendErrorMessage(playerid, "Gunakan /r [pesan]");
        }
      
        return sendRadioMessage(playerid, text);
       
    }
    return 0;
}
hook OnPlayerUpdate(playerid){
    if(Player[playerid][pRadio] == 0 && playerUseRadio[playerid] == 1){
        playerFreq[playerid] = 0;
        playerUseRadio[playerid] = 0;
    }
    return 1;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_RADIO){
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    if(playerUseRadio[playerid] == 0)
                    {
                        playerFreq[playerid] = 1;
                        playerUseRadio[playerid] = 1;
                        return sendSuccessMessage(playerid, "Berhasil menghidupkan radio");
                    }
                    if(playerUseRadio[playerid] == 1)
                    {
                        playerFreq[playerid] = 0;
                        playerUseRadio[playerid] = 0;
                        return sendSuccessMessage(playerid, "Berhasil mematikan radio");
                    }
                }
                case 1:
                {
                    if(playerUseRadio[playerid] == 0)
                    {
                        return sendErrorMessage(playerid, "Radio anda mati!");
                    }
                    ShowPlayerDialog(playerid, DIALOG_SET_FREQ, DIALOG_STYLE_INPUT, "Set Frekuensi Radio","Masukan frekuensi radio [1-1000]", "Set", "Batal");
                }
                case 2:{
                    if(playerUseRadio[playerid] == 0)
                    {
                        return sendErrorMessage(playerid, "Radio anda mati!");
                    }
                    ShowPlayerDialog(playerid, DIALOG_RADIO_CHAT, DIALOG_STYLE_INPUT, "Radio Chat", "Ketikan pesan anda", "Kirim", "Batal");
                }
            }
        }
    }
    if(dialogid == DIALOG_RADIO_CHAT)
    {
        if(response){
            if(strlen(inputtext) > 0)
            {
                sendRadioMessage(playerid, inputtext);
            }
        }
    }
    if(dialogid == DIALOG_SET_FREQ)
    {
        if(response)
        {
            new freq;
            if(sscanf(inputtext, "d", freq)){
                return ShowPlayerDialog(playerid, DIALOG_SET_FREQ, DIALOG_STYLE_INPUT, "Set Frekuensi Radio",""EMBED_RED"Frekuensi tidak valid!"EMBED_WHITE"\nMasukan frekuensi radio [1-1000]", "Set", "Batal");
            }
            if(freq <= 0 || freq > 1000)
            {
                return ShowPlayerDialog(playerid, DIALOG_SET_FREQ, DIALOG_STYLE_INPUT, "Set Frekuensi Radio",""EMBED_RED"Frekuensi diluar range [1-1000]!"EMBED_WHITE"\nMasukan frekuensi radio [1-1000]", "Set", "Batal");
            }
            playerFreq[playerid] = freq;
            new success[128];
            format(success, sizeof(success), "Anda berhasil menset frekuensi radio anda menjadi %d", freq);
            return sendSuccessMessage(playerid, success);
        }
    }
    return 1;
}
