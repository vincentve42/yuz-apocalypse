#include <YSI_Coding\y_hooks>

#define MAX_ASK 50
enum ASK{
    aPlayerId,
    aAsk[128]
}

new askId[MAX_ASK];
new askInfo[MAX_ASK][ASK];
new playerAlreadyAsk[MAX_PLAYERS];
new tempAsk[MAX_PLAYERS];
hook OnGameModeInit(){
    for(new i=0; i<MAX_ASK; i++)
    {
        askId[i] = -1;
    }
    return 1;
}
hook OnPlayerConnect(playerid)
{
    playerAlreadyAsk[playerid] = 0;
    return 1;
}
hook OnPlayerDisconnect(playerid, reason){
    if(playerAlreadyAsk[playerid] == 1)
    {
        for(new i=0; i<MAX_ASK; i++)
        {
            if(askId[i] != -1)
            {
                if( askInfo[askId[i]][aPlayerId] == playerid){
                    askId[i] = -1;
                }  
            }
        }
    }
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/listask", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        new str[3300];
        format(str, sizeof(str), "ID Pemain\tNama Pemain\tPertanyaan");
        for(new i=0; i<MAX_ASK; i++)
        {
            if(askId[i] != -1)
            {
                new playername[MAX_PLAYER_NAME];
                GetPlayerName(askInfo[askId[i]][aPlayerId], playername, sizeof(playername));
                format(str, sizeof(str), "%s\n%d\t%s\t%16s", str, askInfo[askId[i]][aPlayerId], playername, askInfo[askId[i]][aAsk]);
            }
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_ASK, DIALOG_STYLE_TABLIST_HEADERS, "List Pertanyaan", str, "Jawab", "Tutup");
        return 1;
    }
    
    new command[128];
    new arg1[128];
    sscanf(cmdtext, "s[128]s[128]", command,arg1);
    if(!strcmp(command, "/ask", true))
    {
        new pertanyaan[128];
        if(sscanf(arg1, "s[128]", pertanyaan))
        {
            return sendErrorMessage(playerid, "Gunakan /ask [pertanyaan]");
        }
        if(playerAlreadyAsk[playerid] == 1)
        {
            return sendErrorMessage(playerid, "Anda telah mengajukan pertanyaan silahkan tunggu admin menjawabnya");
        }
        for(new i=0; i<MAX_ASK; i++)
        {
            if(askId[i] == -1)
            {
                askId[i] = i;
                playerAlreadyAsk[playerid] = 1;
                askInfo[askId[i]][aPlayerId] = playerid;
                format(askInfo[askId[i]][aAsk], 128, "%s", pertanyaan);
                new playerName[MAX_PLAYER_NAME];
                GetPlayerName(playerid, playerName,sizeof(playerName));
                new str[128];
                
                format(str, sizeof(str), ""EMBED_YELLOW"[ASK] "EMBED_WHITE"%s menanyakan %32s", playerName,pertanyaan);
                for(new j=0; j<MAX_ASK; j++)
                {
                    if(IsPlayerConnected(j) && !IsPlayerNPC(j) && Player[j][pAdmin] > 0)
                    {
                        SendClientMessage(j, -1, str);
                    }
                }
                return sendSuccessMessage(playerid, "Anda berhasil mengajukan pertanyaan");
            }
            
        }
        return sendErrorMessage(playerid, "Antrian pertanyaan penuh silahkan coba lagi setelah beberapa waktu");
    }   
    return 0;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_LIST_ASK)
    {
        if(response)
        {
            new count = 0;
            for(new i=0; i<MAX_ASK; i++)
            {
                if(askId[i] != -1)
                {
                    if(count == listitem){
                        tempAsk[playerid] = askId[i];
                        break;
                    }
                    count++;
                }
                
            }
            if(tempAsk[playerid] == -1)
                return sendErrorMessage(playerid, "Player telah disconnect atau pertanyaan telah dijawab");
            new str[256];
            new playername[MAX_PLAYER_NAME];
            for(new i=0; i<MAX_PLAYERS; i++)
            {
                if(IsPlayerConnected(i) && !IsPlayerNPC(i))
                {    
                    if(i == askInfo[tempAsk[playerid]][aPlayerId])
                    {
                        GetPlayerName(i, playername, sizeof(playername));
                        break;
                    }
                }
            }
            format(str, sizeof(str), ""EMBED_CYAN"Nama Player: "EMBED_WHITE"%s\n"EMBED_YELLOW"Keterangan: "EMBED_WHITE"%s",playername, askInfo[tempAsk[playerid]][aAsk]);
            ShowPlayerDialog(playerid, DIALOG_ASK, DIALOG_STYLE_MSGBOX, "Pertanyaan",str,"Jawab", "Batal");
        }

    }
    if(dialogid == DIALOG_ASK)
    {
        if(response)
        {
            if(tempAsk[playerid] == -1)
            {
                return sendErrorMessage(playerid, "Player telah disconnect atau pertanyaan telah dijawab");
            }
            ShowPlayerDialog(playerid, DIALOG_ASK_ANSWER, DIALOG_STYLE_INPUT, "Jawab", "Ketikan jawaban dari pertanyaan pada kolom dibawah", "Jawab", "Batal");
        }
    }
    if(dialogid == DIALOG_ASK_ANSWER)
    {
        if(response)
        {
            if(tempAsk[playerid] == -1)
            {
                return sendErrorMessage(playerid, "Player telah disconnect atau pertanyaan telah dijawab");
            }
            new answer[128];
            if(sscanf(inputtext, "s[128]", answer))
            {
                ShowPlayerDialog(playerid, DIALOG_ASK_ANSWER, DIALOG_STYLE_INPUT, "Jawab", "Ketikan jawaban dari pertanyaan pada kolom dibawah", "Jawab", "Batal");
            }
            new str[256];
            new str2[256];
            new adminName[MAX_PLAYER_NAME];
            new playerName[MAX_PLAYER_NAME];
            GetPlayerName(playerid, adminName, sizeof(adminName));
            GetPlayerName(askInfo[tempAsk[playerid]][aPlayerId], playerName, sizeof(playerName));
            format(str, sizeof(str), "Admin "EMBED_RED"%s"EMBED_WHITE" menjawab %s", adminName, answer);
            format(str2, sizeof(str2), "Anda berhasil menjawab pertanyaan player bernama %s", playerName);

            sendSuccessMessage(playerid, str2);
            sendInfoMessage(askInfo[tempAsk[playerid]][aPlayerId], str);
            playerAlreadyAsk[askInfo[tempAsk[playerid]][aPlayerId]] = 0;
            askId[tempAsk[playerid]] = -1;


        }
    }
    return 1;
}