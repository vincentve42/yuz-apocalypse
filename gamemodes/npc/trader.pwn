#include <YSI_Coding\y_hooks>

stock createTrader(playerid){
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x,y,z);
    new Float:angle; 
    GetPlayerFacingAngle(playerid, angle);

    for(new i =0; i<100; i++)
    {
        if(TraderNpc[i] == -1)
        {
            new tradeFile[128];
            new tradeFileName[128];

            format(tradeFileName, sizeof(tradeFileName), "Trade%d.ini", i);

            format(tradeFile, sizeof(tradeFile), "Trader/Trade%d.ini", i);

            dini_Create(tradeFile);


            dini_FloatSet(tradeFile, "X", x);

            dini_FloatSet(tradeFile, "Y", y);

            dini_FloatSet(tradeFile, "Z", z);

            dini_FloatSet(tradeFile, "Angle", angle);
            
            TraderNpc[i] = FCNPC_Create(tradeFileName);

            TraderNpcInfo[TraderNpc[i]][tX] = x;
            TraderNpcInfo[TraderNpc[i]][tY] = y;
            TraderNpcInfo[TraderNpc[i]][tZ] = z;
            FCNPC_SetHealth(TraderNpc[i], 100);

            FCNPC_Spawn(TraderNpc[i], 26, x, y, z);

            FCNPC_SetAngle(TraderNpc[i], angle);

            FCNPC_SetArmour(TraderNpc[i], 100);

            
            FCNPC_SetAmmo(TraderNpc[i], 1000);

            new str[128];
            
            format(str, sizeof(str), "Anda berhasil membuat trader dengan id %d", i);

            sendSuccessMessage(playerid, str);

            new strr[128];
            format(strr, sizeof(strr), "[Trader ID:%d]\nGunakan "EMBED_YELLOW"/tshop "EMBED_WHITE" untuk berinteraksi dengan trader", i);
            Create3DTextLabel(strr, -1, TraderNpcInfo[TraderNpc[i]][tX], TraderNpcInfo[TraderNpc[i]][tY], TraderNpcInfo[TraderNpc[i]][tZ], 15.0, 0, 0);

            return 1;
        }
    }
    sendErrorMessage(playerid, "Trader telah mencapai jumlah maksimum");
    return 1;
}
stock LoadTrader()
{
    for(new i=0; i<100; i++){
        new traderFile[128];
        format(traderFile, sizeof(traderFile), "Trader/Trade%d.ini", i);
       
        if(dini_Exists(traderFile))
        {
            new traderName[128];
            format(traderName, sizeof(traderName), "Trade%d", i);
            TraderNpc[i] = FCNPC_Create(traderName);
            FCNPC_SetHealth(TraderNpc[i], 100);
            TraderNpcInfo[TraderNpc[i]][tX]= dini_Float(traderFile, "X");
            TraderNpcInfo[TraderNpc[i]][tY]= dini_Float(traderFile, "Y");
            TraderNpcInfo[TraderNpc[i]][tZ]= dini_Float(traderFile, "Z");
            
            new Float:angle = dini_Float(traderFile, "Angle");
            FCNPC_Spawn(TraderNpc[i], 26, TraderNpcInfo[TraderNpc[i]][tX], TraderNpcInfo[TraderNpc[i]][tY], TraderNpcInfo[TraderNpc[i]][tZ]);
            FCNPC_SetAngle(TraderNpc[i], angle);
            FCNPC_SetArmour(TraderNpc[i], 100);

            new str[128];
            format(str, sizeof(str), "[Trader ID:%d]\nGunakan "EMBED_YELLOW"/tshop "EMBED_WHITE" untuk berinteraksi dengan trader", i);
            Create3DTextLabel(str, -1, TraderNpcInfo[TraderNpc[i]][tX], TraderNpcInfo[TraderNpc[i]][tY], TraderNpcInfo[TraderNpc[i]][tZ], 15.0, 0, 0);
            JumlahTraderNpc++;
        }
        else
        {
            TraderNpc[i] = -1;
        }
    }
    return 1;   
}
stock deleteTrader(playerid, traderid)
{
    if(TraderNpc[traderid] != -1)
    {
        new traderFile[128];
        format(traderFile, sizeof(traderFile), "Trader/Trade%d.ini", traderid);

        dini_Remove(traderFile);

        FCNPC_Destroy(TraderNpc[traderid]);
        TraderNpc[traderid] = -1;       

        new str[128]; 

        format(str, sizeof(str), "Anda berhasil menghapus bot trader dengan id %d", traderid);
        return sendSuccessMessage(playerid, str);
    }
    else
    {
        
        new str[128];
        format(str, sizeof(str), "Bot trader dengan id %d tidak ditemukan atau telah dihapus", traderid);
        return sendErrorMessage(playerid, str);
    }
}
stock showTraderShop(playerid){
    for(new i=0; i<1000; i++)
    {
       
        if(TraderNpc[i] != -1)
        {  
            new Float:x, Float:y, Float:z;

            GetPlayerPos(playerid, x, y, z);
            if(IsPlayerInRangeOfPoint(playerid, 7.0, TraderNpcInfo[TraderNpc[i]][tX], TraderNpcInfo[TraderNpc[i]][tY], TraderNpcInfo[TraderNpc[i]][tZ]))
            {
                new str[256];
                format(str, sizeof(str), "Item\tPrice\tAmount\nApel\t"EMBED_GREEN"100\t"EMBED_WHITE"x1\nPizza\t"EMBED_GREEN"150\t"EMBED_WHITE"x1\nMinuman\t"EMBED_GREEN"50\t"EMBED_WHITE"x1\t"EMBED_WHITE"x1\nBandage\t"EMBED_GREEN"400\t"EMBED_WHITE"x1\nAntibiotic\t"EMBED_GREEN"500\t"EMBED_WHITE"x1\nGasmask\t"EMBED_GREEN"500\t"EMBED_WHITE"x1");
                ShowPlayerDialog(playerid, DIALOG_TRADER_SHOP, DIALOG_STYLE_TABLIST_HEADERS, "Trader Shop", str, "Buy", "Cancel");
                return 1;
            }
        }
    }
    sendErrorMessage(playerid, "Anda tidak berada di dekat trader");
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[]){

    new command[128], arg1[128];

    sscanf(cmdtext, "s[128]s[128]", command, arg1);

    if(!strcmp(command, "/createtrader", true))
    {
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5");
        createTrader(playerid);
        
        
        return 1;
    }
    else if(!strcmp(command, "/listtrader", true))
    {
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5");

        new str[1024];
        format(str, sizeof(str), "ID\tX\tY\tZ");
        for(new i=0; i<100; i++)
        {
            if(TraderNpc[i] != -1)
                format(str,sizeof(str), "%s\n%d\t%.2f\t%.2f\t%.2f", str, i,TraderNpcInfo[TraderNpc[i]][tX], TraderNpcInfo[TraderNpc[i]][tY],TraderNpcInfo[TraderNpc[i]][tZ]);
            
            
        }
        ShowPlayerDialog(playerid, DIALOG_LIST_TRADER, DIALOG_STYLE_TABLIST, "List NPC", str, "Choose", "Cancel");
    }
    else if(!strcmp(command, "/deletetrader", true))
    {
        new traderid; 
        if(sscanf(arg1, "d", traderid))
        {
            return sendErrorMessage(playerid, "Gunakan /deletetrader [traderid]");
        }
        return deleteTrader(playerid,traderid);

    }
    else if(!strcmp(command, "/tshop", true))
    {
        
        showTraderShop(playerid);
        return 1;
    }
    return 0;
}

hook OnGameModeInit()
{
    LoadTrader();
    return 1;
}
