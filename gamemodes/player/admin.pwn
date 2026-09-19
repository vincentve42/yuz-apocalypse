#include <YSI_Coding\y_hooks>

new adminOnDuty[MAX_PLAYERS];

hook OnPlayerConnect(playerid)
{
    adminOnDuty[playerid] = 0;
    return 1;
}
hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(Player[playerid][pAdmin] >= 5)
        SetPlayerPosFindZ(playerid, fX, fY, fZ);
    return 1;
}
forward sendErrorMessage(playerid, message[]);
forward sendSuccessMessage(playerid, message[]);
forward sendInfoMessage(playerid, message[]);
stock sendErrorMessage(playerid, message[])
{
    new str[128];
    format(str, sizeof(str), ""EMBED_RED"[ERROR]"EMBED_WHITE" %s", message);
    SendClientMessage(playerid, -1, str);
    PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
    return 1;
}
stock sendSuccessMessage(playerid, message[])
{
    new str[128];
    format(str, sizeof(str), ""EMBED_LIGHTGREEN"[SUCCESS]"EMBED_WHITE" %s", message);
    SendClientMessage(playerid, -1, str);
    PlayerPlaySound(playerid, 1057,0.0, 0.0, 0.0);
    return 1;
}
stock sendInfoMessage(playerid, message[])
{
    new str[128];
    format(str, sizeof(str), ""EMBED_YELLOW"[INFO]"EMBED_WHITE" %s", message);
    SendClientMessage(playerid, -1, str);
    PlayerPlaySound(playerid, 1057,0.0, 0.0, 0.0);
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[])
{
    new command[128]; 
    new arg1[128];
    sscanf(cmdtext, "s[64]s[64]", command, arg1);
    // if(!strcmp(command, "/setadminlevel", true))
    // {
        
    //     if(Player[playerid][pAdmin] < 5)
    //     {
    //         return sendErrorMessage(playerid, "Anda bukan admin level 5");
    //     }
    //     new target;
    //     new level;
    //     if(sscanf(arg1, "dd", target, level))
    //     {
    //         return sendErrorMessage(playerid, "Gunakan /setadminlevel [idplayer] [level 1-5]");
    //     }
    //     if(level > 5 || level < 0)
    //     {
    //         return sendErrorMessage(playerid, "Level harus berada diantara 1-5");
    //     }
    //     if(!IsPlayerConnected(target) || IsPlayerNPC(target))
    //     {
    //         return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
    //     }
    //     Player[target][pAdmin] = level;

    //     new str1[128];
    //     new str2[128];

    //     format(str1, sizeof(str1), "Anda berhasil menset level admin player dengan id %d menjadi %d", playerid, level);
    //     format(str2, sizeof(str2), "Seorang admin telah menset anda menjadi admin level %d", level);
    //     sendSuccessMessage(playerid, str1);
    //     sendSuccessMessage(target,str2);

    //     return 1;

    // }
    if(!strcmp(command, "/sethbe", true))
    {
        
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        new target;
        new Float:hbe;
        if(sscanf(arg1, "df", target, hbe))
        {
            return sendErrorMessage(playerid, "Gunakan /sethbe [idplayer] [jumlahhbe]");
        }
        
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        }
        Player[target][pHunger] = hbe;

        Player[target][pThrist] = hbe;

        Player[target][pRadiation] = hbe;

        updateHunger(target);

        updateDrink(target);

        updateRadiation(target);

        new str1[128];
        new str2[128];

        new targetName[MAX_PLAYER_NAME];
        new playerName[MAX_PLAYER_NAME];

        GetPlayerName(playerid, playerName, sizeof(playerName));

        GetPlayerName(target, targetName, sizeof(targetName));

        format(str1, sizeof(str1), "Anda berhasil mengubah hbe %s menjadi %.2f", targetName, hbe);
        sendSuccessMessage(playerid, str1);
        format(str2, sizeof(str2), "Admin %s mengubah hbe anda menjadi %.2f", playerName, hbe);
        sendSuccessMessage(target,str2);

        return 1;

    }
    if(!strcmp(command, "/adminhelp") || !strcmp(command, "/ahelp"))
    {
        new str[1024];
        format(str, sizeof(str), "Rank\tDeskripsi");
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] >= 1)
        {
            format(str, sizeof(str), "%s\n"EMBED_RED"Volunteer\t"EMBED_WHITE"Melihat semua command volunteer", str);
        }
        if(Player[playerid][pAdmin] >= 2)
        {
            format(str, sizeof(str), "%s\n"EMBED_REALRED"Helper\t"EMBED_WHITE"Melihat semua command helper", str);
        }
        if(Player[playerid][pAdmin] >= 3)
        {
            format(str, sizeof(str), "%s\n"EMBED_LIGHTBLUE"Junior Admin\t"EMBED_WHITE"Melihat semua command junior admin", str);
        }
        if(Player[playerid][pAdmin] >= 4)
        {
            format(str, sizeof(str), "%s\n"EMBED_DARKBLUE"High Admin\t"EMBED_WHITE"Melihat semua command high admin", str);
        }
        if(Player[playerid][pAdmin] >= 5)
        {
            format(str, sizeof(str), "%s\n"EMBED_YELLOW"Developer\t"EMBED_WHITE"Melihat semua command developer", str);
        }
        ShowPlayerDialog(playerid, DIALOG_ADMIN_HELP, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Admin", str, "Pilih", "Tutup");
        return 1;
    }
    if(!strcmp(command, "/spectate") || !strcmp(command, "/spec"))
    {
        new target;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(sscanf(arg1, "d", target))
        {
            return sendErrorMessage(playerid, "Gunakan /spec [target]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        }
        TogglePlayerSpectating(playerid, 1);
        PlayerSpectatePlayer(playerid, target);
        new targetName[MAX_PLAYER_NAME];
        GetPlayerName(target, targetName, sizeof(targetName));
        new str[128];
        format(str, sizeof(str), "Anda sedang mengawasi player bernama %s /specoff untuk keluar", targetName);
        sendInfoMessage(playerid, str);
        return 1;
    }
    if(!strcmp(command, "/specoff", true) || !strcmp(command, "/spectateoff", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        TogglePlayerSpectating(playerid, 0);
        SetPlayerPos(playerid, Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ]);
        SetPlayerSkin(playerid, Player[playerid][pSkin]);
        SetPlayerHealth(playerid, Player[playerid][pHealth]);
        SetPlayerArmour(playerid, Player[playerid][pArmour]);
        sendSuccessMessage(playerid, "Anda telah berhasil keluar dari mode spectator");
        return 1;
    }
    if(!strcmp(command, "/gethere", true)){
        new target;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(sscanf(arg1, "d", target))
        {
            return sendErrorMessage(playerid, "Gunakan /gethere [target]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        }
        new playername[MAX_PLAYER_NAME];
        new adminName[MAX_PLAYER_NAME];
        GetPlayerName(target, playername, sizeof(playername));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z);
        new str1[128];
        format(str1, sizeof(str1), "Anda menarik player bernama %s", playername);
        new str2[128];
        format(str2, sizeof(str2), "Admin %s menarik anda", adminName);
        SetPlayerPos(target, x, y, z+0.5);
        sendInfoMessage(target, str2);
        sendSuccessMessage(playerid, str1);
        return 1;
    }
    if(!strcmp(command, "/goto", true)){
        new target;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(sscanf(arg1, "d", target))
        {
            return sendErrorMessage(playerid, "Gunakan /goto [target]");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        }
        new playername[MAX_PLAYER_NAME];
        new adminName[MAX_PLAYER_NAME];
        GetPlayerName(target, playername, sizeof(playername));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        new Float:x, Float:y, Float:z;
        GetPlayerPos(target, x, y, z);
        new str1[128];
        format(str1, sizeof(str1), "Anda melakukan teleportasi ke player bernama %s", playername);
        new str2[128];
        format(str2, sizeof(str2), "Admin %s melakukan teleportasi ke posisi anda", adminName);
        SetPlayerPos(playerid, x, y, z+0.5);
        sendInfoMessage(target, str2);
        sendSuccessMessage(playerid, str1);
        return 1;
    }
    if(!strcmp(command, "/setvehmaxslot", true)){
        new target;
        new maxslot;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 4)
            return sendErrorMessage(playerid, "Anda Bukan Admin level 4");
        if(sscanf(arg1, "dd", target, maxslot))
        {
            return sendErrorMessage(playerid, "Gunakan /setvehmaxslot [target] [slot]");
        }
        if(maxslot < 1)
        {
            return sendErrorMessage(playerid, "Slot harus lebih atau sama dengan 1");
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            return sendErrorMessage(playerid, "Player yang anda tuju tidak valid");
        }
        new playername[MAX_PLAYER_NAME];
        new adminName[MAX_PLAYER_NAME];
        GetPlayerName(target, playername, sizeof(playername));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        new str1[128];
        format(str1, sizeof(str1), "Anda mengubah maksimal slot kendaraan player bernama %s menjadi %d", playername, maxslot);
        new str2[128];
        format(str2, sizeof(str2), "Admin %s mengubah maksimal slot kendaraan anda menjadi %d", adminName, maxslot);
        Player[target][pVehSlot] = maxslot;
        sendInfoMessage(target, str2);
        sendSuccessMessage(playerid, str1);
        return 1;
    }
    if(!strcmp(command, "/gotoco", true)){
        new Float:x, Float:y, Float:z;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 2)
            return sendErrorMessage(playerid, "Anda Bukan Admin level 3");
        if(sscanf(arg1, "fff", x,y,z))
        {
            return sendErrorMessage(playerid, "Gunakan /goto [x] [y] [z]");
        }
        new str[64];
        format(str, sizeof(str), "Anda diteleportasi ke %.2f %.2f %.2f", x, y, z);
        SetPlayerPos(playerid, x, y, z);
        sendSuccessMessage(playerid, str);
        return 1;
    }
    if(!strcmp(command, "/setitem", true))
    {
        new item[128];
        new target;
        new amount;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 3)
            return sendErrorMessage(playerid, "Anda Bukan Admin level 3");
        if(sscanf(arg1, "ds[128]d", target ,item,amount))
        {
            return sendErrorMessage(playerid, "Gunakan /setitem [id] [namaitem] [jumlah]");
        }
        if(!strcmp(item, "bandage", true))
        {
            new itemname[] = "bandage";
            Player[target][pBandage] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else if(!strcmp(item, "antibiotik", true))
        {
            new itemname[] = "antibiotik";
            Player[target][pAntibiotic] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else if(!strcmp(item, "pizza", true))
        {
            new itemname[] = "pizza";
            Player[target][pPizza] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else if(!strcmp(item, "scrap", true))
        {
            new itemname[] = "scrap";
            Player[target][pScrap] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else if(!strcmp(item, "gas", true))
        {
            new itemname[] = "gas";
            Player[target][pGas] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else if(!strcmp(item, "apel", true))
        {
            new itemname[] = "apel";
            Player[target][pApel] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else if(!strcmp(item, "minuman", true))
        {
            new itemname[] = "minuman";
            Player[target][pDrink] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else if(!strcmp(item, "gasmask", true))
        {
            new itemname[] = "gasmask";
            Player[target][pGasmask] = amount;
            new msg1[128];
            new msg2[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(target, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(msg1, sizeof(msg1), "Anda berhasil memberikan item %s dengan jumlah %d kepada player %s", itemname, amount, playerName);
            format(msg2, sizeof(msg2), "Admin %s memberikan anda item %s dengan jumlah %d", adminName, itemname, amount);
            sendSuccessMessage(playerid, msg1);
            sendInfoMessage(target, msg2);

        }
        else
        {
            sendErrorMessage(playerid, "Nama item tidak valid");
        }
        return 1;
    }
    if(!strcmp(command, "/jetpack", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
        sendSuccessMessage(playerid, "Anda Sukses menggunakan jetpack!");
        return 1;
        // Returning 1 informs the server that the command has been processed.
        // OnPlayerCommandText won't be called in other scripts.
    }
    else if(!strcmp(command, "/aduty", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(adminOnDuty[playerid] == 0)
        {
            SetPlayerHealth(playerid, 1000000000);
            GivePlayerWeapon(playerid, 38, 10000000);
            sendSuccessMessage(playerid, "Anda Sukses on duty");
            new adminDuty[128];
            new adminName[128];
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(adminDuty, sizeof(adminDuty), ""EMBED_RED"[SERVER]"EMBED_WHITE"%s telah onduty /report atau /ask", adminName);
            SendClientMessageToAll(-1,adminDuty);
            adminOnDuty[playerid] = 1;
        }
        else
        {
            adminOnDuty[playerid] = 0;
            sendSuccessMessage(playerid, "Anda Sukses off duty");
            new adminDuty[128];
            new adminName[128];
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(adminDuty, sizeof(adminDuty), ""EMBED_RED"[SERVER]"EMBED_WHITE"%s telah offduty terimakasih!", adminName);
            SendClientMessageToAll(-1,adminDuty);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, Player[playerid][pWeap1],Player[playerid][pAmmo1]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap2],Player[playerid][pAmmo2]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap3],Player[playerid][pAmmo3]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap4],Player[playerid][pAmmo4]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap5],Player[playerid][pAmmo5]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap6],Player[playerid][pAmmo6]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap7],Player[playerid][pAmmo7]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap7],Player[playerid][pAmmo7]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap8],Player[playerid][pAmmo8]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap9],Player[playerid][pAmmo9]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap10],Player[playerid][pAmmo10]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap11],Player[playerid][pAmmo11]);
            GivePlayerWeapon(playerid, Player[playerid][pWeap12],Player[playerid][pAmmo12]);
            SetPlayerHealth(playerid, Player[playerid][pHealth]);
            SetPlayerArmour(playerid, Player[playerid][pArmour]);
        }

        return 1;
        // Returning 1 informs the server that the command has been processed.
        // OnPlayerCommandText won't be called in other scripts.
    }
    
    else if(!strcmp(command, "/sethealth", true))
    {
        new target;
        new Float:health; 
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 2)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 2");

        if(sscanf(arg1,"uf", target, health))
        {
            sendErrorMessage(playerid, "Gunakan /sethealth [playerid] [healthvalue]");
            return 1;
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            sendErrorMessage(playerid, "Player yang dituju tidak terkoneksi");
            return 1;
        }
        new successMsg[128];
        new infoMsg[128];
        new playerName[128];
        new adminName[128];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        format(successMsg, sizeof(successMsg), "Sukses mengubah darah pemain %s menjadi %f",playerName, health);
        format(infoMsg, sizeof(infoMsg), "Admin %s mengubah darah anda menjadi %f",adminName, health);
        sendSuccessMessage(playerid, successMsg);
        sendInfoMessage(target, infoMsg);
        Player[target][pHealth] = health;
        SetPlayerHealth(playerid, health);
        return 1;
    }
    else if(!strcmp(command, "/a", true))
    {
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda bukan seorang admin!");
        new str[256];

        if(sscanf(arg1, "s[256]", str)){
            return sendErrorMessage(playerid, "Gunakan /a [pesan]");
        }
        new playerName[MAX_PLAYER_NAME];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        format(str, sizeof(str), ""EMBED_RED"[ADMIN] "EMBED_YELLOW"%s "EMBED_WHITE"%s", playerName,str);
        for(new i=0; i<MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i) && !IsPlayerNPC(i) && Player[i][pAdmin] > 0)
            {
                SendClientMessage(i, -1, str);
            }
        }
        return 1;
    }
    else if(!strcmp(command, "/givemoney", true))
    {
        new target;
        new mny;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 3)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 3");

        if(sscanf(arg1,"ud", target, mny))
        {
            sendErrorMessage(playerid, "Gunakan /givemoney [playerid] [money]");
            return 1;
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            sendErrorMessage(playerid, "Player yang dituju tidak terkoneksi");
            return 1;
        }
        new successMsg[128];
        new infoMsg[128];
        new playerName[128];
        new adminName[128];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        format(successMsg, sizeof(successMsg), "Sukses memberikan uang kepada pemain %s berjumlah %d",playerName, mny);
        format(infoMsg, sizeof(infoMsg), "Admin %s memberikan anda uang sebanyak %d",adminName, mny);
        sendSuccessMessage(playerid, successMsg);
        sendInfoMessage(target, infoMsg);
        GiveMoney(target, mny);
        return 1;
    }
    else if(!strcmp(command, "/kick", true))
    {
        new target;
     
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 2)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 2");

        if(sscanf(arg1,"u", target))
        {
            sendErrorMessage(playerid, "Gunakan /kick [playerid]");
            return 1;
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            sendErrorMessage(playerid, "Player yang dituju tidak terkoneksi");
            return 1;
        }
        new successMsg[128];
        new infoMsg[128];
        new playerName[128];
        new adminName[128];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        format(successMsg, sizeof(successMsg), "Sukses mengeluarkan pemain %s dari server",playerName);
        format(infoMsg, sizeof(infoMsg), "Admin %s mengeluarkan anda dari server",adminName);
        sendSuccessMessage(playerid, successMsg);
        sendInfoMessage(target, infoMsg);
        Kick(target);
        return 1;
    }
    else if(!strcmp(command, "/ban", true))
    {
        new target;
        new duration;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 3)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 3");
        if(sscanf(arg1, "ud", target, duration))
        {
            sendErrorMessage(playerid, "Gunakan /ban [playerid] [days]");
            return 1;
        }
        new year, month, day;
        getdate(year,month,day);
        new playerName[64];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        new bannedFile[128];

        format(bannedFile, sizeof(bannedFile), "Ban/%s.ini", playerName);

        dini_Create(bannedFile);
        dini_IntSet(bannedFile, "Year", year);
        dini_IntSet(bannedFile, "Month", month);
        dini_IntSet(bannedFile, "Days", day);
        dini_IntSet(bannedFile, "Duration", duration);

        new infoMsg[128];
        format(infoMsg, sizeof(infoMsg), "Anda membanned player %s selama %d hari", playerName, duration);
        new adminName[128];
        GetPlayerName(playerid, adminName, sizeof(adminName));  
        new errorMsg[128];
        format(errorMsg, sizeof(errorMsg), "%s membanned anda selama %d hari", adminName, duration);
        sendInfoMessage(target, errorMsg);
        sendSuccessMessage(playerid, infoMsg);
        if(playerid == target)
        {
            sendErrorMessage(playerid, "Anda tidak bisa ban diri anda sendiri");
            return 1;
        }
        Kick(target);
        return 1;
    }
    else if(!strcmp(command, "/pardon", true))
    {
        new target[128];
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 3)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 3");
        if(sscanf(arg1, "s[128]", target))
        {
            return sendErrorMessage(playerid, "Gunakan /pardon [namaplayer]");
        }
        new banFile[128];
        format(banFile, sizeof(banFile), "Ban/%s.ini", target);
        if(!dini_Exists(banFile))
        {
            new errorMsg[128];
            format(errorMsg, sizeof(errorMsg), "Player %s tidak sedang dalam masa hukuman", target);
            sendErrorMessage(playerid, errorMsg);
            return 1;
        }
        dini_Remove(banFile);
        new errorMsg[128];
        format(errorMsg, sizeof(errorMsg), "Anda telah menangguhkan hukuman player %s", target);
        sendSuccessMessage(playerid, errorMsg);
        return 1;
    }
    else if(!strcmp(command, "/oban", true))
    {
        new duration;
        new target[128];
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 3)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 3");
        if(sscanf(arg1, "s[128]d", target, duration))
        {
            return sendErrorMessage(playerid, "Gunakan /oban [namaplayer] [durasi]");
        }
        new banFile[128];
        format(banFile, sizeof(banFile), "Ban/%s.ini", target);
        if(!dini_Exists(banFile))
        {
            new year, month, day;
            getdate(year,month,day);
            dini_Create(banFile);
            dini_IntSet(banFile, "Year", year);
            dini_IntSet(banFile, "Month", month);
            dini_IntSet(banFile, "Days", day);
            dini_IntSet(banFile, "Duration", duration);
            new errorMsg[128];
            format(errorMsg, sizeof(errorMsg), "Anda memberikan hukuman kepada %s selama %d hari", target, duration);
            sendSuccessMessage(playerid, errorMsg);
            return 1;
        }
        new errorMsg[128];
        format(errorMsg, sizeof(errorMsg), "Player %s masih dalam masa hukuman", target);
        sendErrorMessage(playerid, errorMsg);
        return 1;
    }
    else if(!strcmp(command, "/setarmour", true))
    {
        new target;
        new Float:armour; 
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 2)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 2");

        if(sscanf(arg1,"uf", target, armour))
        {
            sendErrorMessage(playerid, "Gunakan /setarmour [playerid] [armour]");
            return 1;
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            sendErrorMessage(playerid, "Player yang dituju tidak terkoneksi");
            return 1;
        }
        new successMsg[128];
        new infoMsg[128];
        new playerName[128];
        new adminName[128];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        format(successMsg, sizeof(successMsg), "Sukses mengubah armor pemain %s menjadi %f",playerName, armour);
        format(infoMsg, sizeof(infoMsg), "Admin %s mengubah armor anda menjadi %f",adminName, armour);
        sendSuccessMessage(playerid, successMsg);
        sendInfoMessage(target, infoMsg);
        Player[target][pArmour] = armour;
        SetPlayerArmour(playerid, armour);
        return 1;
    }
    
    else if(!strcmp(command, "/giveweap", true))
    {
        new target;
        new weapid; 
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 3)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 3");
        if(sscanf(arg1,"ud", target, weapid))
        {
            sendErrorMessage(playerid, "Gunakan /giveweap [playerid] [weapid]");
            return 1;
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            sendErrorMessage(playerid, "Player yang dituju tidak terkoneksi");
            return 1;
        }
        if(weapid < 0 || weapid > 46)
        {
            sendErrorMessage(playerid, "Senjata tidak terdefinisi [0-46]");
            return 1;
        }
        new successMsg[128];
        new infoMsg[128];
        new playerName[128];
        new adminName[128];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        GetPlayerName(playerid, adminName, sizeof(adminName));
        format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
        format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d sementara kepada anda",adminName, weapid);
        sendSuccessMessage(playerid, successMsg);
        sendInfoMessage(target, infoMsg);
        GivePlayerWeapon(target, weapid, 500);
        return 1;
    }
    else if(!strcmp(command, "/setweap", true))
    {
        new target;
        new weapid; 
        new ammo;
        if(Player[playerid][pAdmin] < 1)
            return sendErrorMessage(playerid, "Anda Bukan Admin");
        if(Player[playerid][pAdmin] < 4)
            return sendErrorMessage(playerid, "Anda Bukan Admin dengan level 4");
        if(sscanf(arg1,"udd", target, weapid, ammo))
        {
            sendErrorMessage(playerid, "Gunakan /setweap [playerid] [weapid] [ammo]");
            return 1;
        }
        if(!IsPlayerConnected(target) || IsPlayerNPC(target))
        {
            sendErrorMessage(playerid, "Player yang dituju tidak terkoneksi");
            return 1;
        }
        if(weapid < 0 || weapid > 46)
        {
            sendErrorMessage(playerid, "Senjata tidak terdefinisi [0-46]");
            return 1;
        }
        
        if(Player[target][pWeap1] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d  kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap1] = weapid;
            Player[target][pAmmo1] = ammo;
        }
        else if(Player[target][pWeap2] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap2] = weapid;
            Player[target][pAmmo2] = ammo;
        }
        else if(Player[target][pWeap3] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d  kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap3] = weapid;
            Player[target][pAmmo3] = ammo;
        }
        else if(Player[target][pWeap4] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d  kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap4] = weapid;
            Player[target][pAmmo4] = ammo;
        }
        else if(Player[target][pWeap5] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d  kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap5] = weapid;
            Player[target][pAmmo5] = ammo;
        }
        else if(Player[target][pWeap6] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d  kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap6] = weapid;
            Player[target][pAmmo6] = ammo;
        }
        else if(Player[target][pWeap7] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d  kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap7] = weapid;
            Player[target][pAmmo7] = ammo;
        }
        else if(Player[target][pWeap8] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap8] = weapid;
            Player[target][pAmmo8] = ammo;
        }
        else if(Player[target][pWeap9] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap9] = weapid;
            Player[target][pAmmo9] = ammo;
        }
        else if(Player[target][pWeap10] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap10] = weapid;
            Player[target][pAmmo10] = ammo;
        }
        else if(Player[target][pWeap11] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap11] = weapid;
            Player[target][pAmmo11] = ammo;
        }
        else if(Player[target][pWeap12] == 0)
        {
            new successMsg[128];
            new infoMsg[128];
            new playerName[128];
            new adminName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            GetPlayerName(playerid, adminName, sizeof(adminName));
            format(successMsg, sizeof(successMsg), "Sukses memberikan senjata dengan id %d kepada player yang bernama %s",weapid ,playerName);
            format(infoMsg, sizeof(infoMsg), "Admin %s memberikan senjata dengan id %d kepada anda",adminName, weapid);
            sendSuccessMessage(playerid, successMsg);
            sendInfoMessage(target, infoMsg);
            GivePlayerWeapon(target, weapid, ammo);
            Player[target][pWeap12] = weapid;
            Player[target][pAmmo12] = ammo;
        }
        else
        {
            new playerName[128];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            new errorMsg[128];
            format(errorMsg, sizeof(errorMsg), "Slot senjata player %s full", playerName);
            sendErrorMessage(playerid, errorMsg);
        }
        
        return 1;
    }
    if(!strcmp(command, "/startstorm", true))
    {
        if(Player[playerid][pAdmin] < 5)
            return sendErrorMessage(playerid, "Anda bukan admin level 5!");
        
        randomStorm();
        return 1;
    }
    if(!strcmp(command, "/stopanim", true))
    {
        ClearAnimations(playerid);
        return 1;
    }
    return 0;
}
stock showInventory(playerid, forplayerid){
    new str[1024];
    format(str, sizeof(str), "Item\tAmount");
    if(Player[playerid][pMoney] > 0)
    {
        format(str, sizeof(str), "%s\nMoney\t"EMBED_GREEN"%d",str, Player[playerid][pMoney]);
    }
    if(Player[playerid][pDrink] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Minuman\t"EMBED_WHITE"%d", str,Player[playerid][pDrink]);
    }
    if(Player[playerid][pPizza] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Pizza\t"EMBED_WHITE"%d", str,Player[playerid][pPizza]);
    }
    if(Player[playerid][pApel] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Apel\t"EMBED_WHITE"%d", str,Player[playerid][pApel]);
    } 
    if(Player[playerid][pGasmask] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Gasmask\t"EMBED_WHITE"%d", str,Player[playerid][pGasmask]);
    } 
    if(Player[playerid][pScrap] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Scrap\t"EMBED_YELLOW"%d", str,Player[playerid][pScrap]);
    }
    if(Player[playerid][pBandage] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Bandage\t"EMBED_WHITE"%d", str,Player[playerid][pBandage]);
    }
    if(Player[playerid][pAntibiotic] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Antibiotik\t"EMBED_WHITE"%d", str,Player[playerid][pAntibiotic]);
    }
    if(Player[playerid][pGas] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Gas Tank\t"EMBED_WHITE"%d", str,Player[playerid][pGas]);
    }
    if(Player[playerid][pRadio] > 0)
    {
        format(str, sizeof(str), "%s\n"EMBED_WHITE"Radio\t"EMBED_WHITE"%d", str,Player[playerid][pRadio]);
    }
    if(Player[playerid][pWeap1] != 0)
    {
        new weapon1[64];
        GetWeaponName(Player[playerid][pWeap1], weapon1, sizeof(weapon1));
        format(str, sizeof(str), "%s\n"EMBED_WHITE"%s (slot1)\t"EMBED_RED"%d ammo",str, weapon1, Player[playerid][pAmmo1]);
    }
    if(Player[playerid][pWeap2] != 0)
    {
        new weapon2[64];
        GetWeaponName(Player[playerid][pWeap2], weapon2, sizeof(weapon2));
        format(str, sizeof(str), "%s\n"EMBED_WHITE"%s (slot2)\t"EMBED_RED"%d ammo",str, weapon2, Player[playerid][pAmmo2]);
    }
    if(Player[playerid][pWeap3] != 0)
    {
        new weapon3[64];
        GetWeaponName(Player[playerid][pWeap3], weapon3, sizeof(weapon3));
        format(str, sizeof(str), "%s\n"EMBED_WHITE"%s (slot3)\t"EMBED_RED"%d ammo",str, weapon3, Player[playerid][pAmmo3]);
    }
    ShowPlayerDialog(forplayerid, DIALOG_INVENTORY,DIALOG_STYLE_TABLIST_HEADERS,"Inventory", str, "Close","");
    return 1;
}