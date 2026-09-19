#include <YSI_Coding\y_hooks>

hook OnDialogResponse(playerid, dialogid, response ,listitem, inputtext[])
{
    if(dialogid == DIALOG_CLAIM_FAM_ZONE)
    {
        if(response){
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            if(isPlayerInSafeZone(playerid))
            {
                return sendErrorMessage(playerid, "Anda tidak boleh mengklaim area safe zone");
            }
            if(isPlayerInContZone(playerid))
            {
                return sendErrorMessage(playerid, "Anda tidak boleh mengklaim area contaminated zone");
            }
            
            switch(listitem){
                case 0:
                {
                    tempMinX[playerid] = x;
                    tempMinY[playerid] = y;
                }
                case 1:
                {
                    if(tempMinX[playerid] == 0)
                    {
                        return sendErrorMessage(playerid, "Anda belum mengset min koordinat x");
                    }
                    if(tempMinY[playerid] == 0)
                    {
                        return sendErrorMessage(playerid, "Anda belum mengset min koordinat y");
                    }
                    tempMaxX[playerid] = x;
                    tempMaxY[playerid] = y;
                    if(tempMaxX[playerid] < tempMinX[playerid]){
                        new Float:temp = tempMaxX[playerid];
                        tempMaxX[playerid] = tempMinX[playerid];
                        tempMinX[playerid] = temp;
                    }
                    if(tempMaxY[playerid] < tempMinY[playerid]){
                        new Float:temp = tempMaxY[playerid];
                        tempMaxY[playerid] = tempMinY[playerid];
                        tempMinY[playerid] = temp;
                    }
                
                    
                }
                case 2:
                {
                    for(new i=0; i<MAX_FAM_ZONE; i++)
                    {
                        new zoneFile[128];
                        format(zoneFile, sizeof(zoneFile), "Zone/%d.ini", i);
                        if(!dini_Exists(zoneFile))
                        {
                            dini_Create(zoneFile);
                            dini_FloatSet(zoneFile, "MinX", tempMinX[playerid]);
                            dini_FloatSet(zoneFile, "MinY", tempMinY[playerid]);
                            dini_FloatSet(zoneFile, "MaxX", tempMaxX[playerid]);
                            dini_FloatSet(zoneFile, "MaxY", tempMaxY[playerid]);
                            dini_IntSet(zoneFile, "Duration", 0);
                            dini_IntSet(zoneFile, "Money", calculateLandPrice(tempMinX[playerid], tempMinY[playerid], tempMaxX[playerid], tempMaxY[playerid]));
                            dini_IntSet(zoneFile, "FamId", -1);
                            famZoneExist[i] = 1;
                            famZone[i][ffamId] = -1;
                            famZone[i][ffMoney] = calculateLandPrice(tempMinX[playerid], tempMinY[playerid], tempMaxX[playerid], tempMaxY[playerid]);
                            famZone[i][ffDuration] = 0;
                            famZone[i][ffMinX] = tempMinX[playerid];
                            famZone[i][ffMinY] = tempMinY[playerid];
                            famZone[i][ffMaxX] = tempMaxX[playerid];
                            famZone[i][ffMaxY] = tempMaxY[playerid];

                            famGangZone[i] = GangZoneCreate(famZone[i][ffMinX], famZone[i][ffMinY], famZone[i][ffMaxX], famZone[i][ffMaxY]);

                            for(new j =0; j<MAX_PLAYERS; j++)
                            {
                                if(IsPlayerConnected(playerid) && !IsPlayerNPC(playerid))
                                    GangZoneShowForPlayer(playerid, famGangZone[i],0x007FFF99);
                            }
                            new success[128];
                            format(success, sizeof(success), "Anda berhasil membuat land dengan id %d", i);
                            sendSuccessMessage(playerid, success);
                            tempMinX[playerid] = 0.0;
                            tempMaxX[playerid] = 0.0;
                            tempMinY[playerid] = 0.0;
                            tempMaxY[playerid] = 0.0;
                            return 1;
                            
                        }
                    }
               
                    sendErrorMessage(playerid, "lahan sudah penuh!");
                }
            }
            
            if(isSafeZoneInsideCoordinate(playerid, tempMinX[playerid], tempMinY[playerid], tempMaxX[playerid], tempMaxY[playerid]))
            {
                tempMinX[playerid] = 0.0;
                tempMinY[playerid] = 0.0;
                tempMaxY[playerid] = 0.0;
                tempMaxX[playerid] = 0.0;
                return sendErrorMessage(playerid, "Anda tidak boleh mengklaim area safe zone");
            }

        }
    }
    if(dialogid == DIALOG_LIST_LAND)
    {
        if(response){
            if(famZoneExist[listitem] == -1)
            {
                new error[128];
                format(error, sizeof(error), "Lahan dengan id %d tidak ada", listitem);
                return sendErrorMessage(playerid, error);
            }
            new Float:z;
            MapAndreas_FindZ_For2DCoord(famZone[listitem][ffMinX], famZone[listitem][ffMinY], z);
            SetPlayerPos(playerid, famZone[listitem][ffMinX], famZone[listitem][ffMinY], z);
            new success[128];
            format(success, sizeof(success), "Sukses teleportasi ke lahan %d", listitem);
            sendSuccessMessage(playerid, success);
        }
    }
    if(dialogid == DIALOG_BUY_LAND)
    {
        if(response){
            if(Player[playerid][pFam] == -1)
            {
                return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
            }
            if(Player[playerid][pFamRank] < 4)
            {
                return sendErrorMessage(playerid, "Anda bukan leader dari suatu family");
            }
            if(famZone[tempBuyLand[playerid]][ffamId] != -1)
            {
                return sendErrorMessage(playerid, "Lahan ini telah dimiliki oleh family lain");
            }
            if(Player[playerid][pMoney] < famZone[tempBuyLand[playerid]][ffMoney])
            {
                return sendErrorMessage(playerid, "Uang anda tidak cukup untuk membeli lahan ini");
            }
            TakeMoney(playerid, famZone[tempBuyLand[playerid]][ffMoney]);
            famZone[tempBuyLand[playerid]][ffamId] = Player[playerid][pFam];
            famZone[tempBuyLand[playerid]][ffDuration] = 72;
            GangZoneHideForAll(famGangZone[tempBuyLand[playerid]]);
            for(new i=0; i<MAX_PLAYERS; i++)
            {
                if(IsPlayerConnected(i) && !IsPlayerNPC(i))
                {
                    if(Player[i][pFam] != famZone[tempBuyLand[playerid]][ffamId])
                        GangZoneShowForPlayer(i, famGangZone[tempBuyLand[playerid]],0x0000FF99);
                    else
                        GangZoneShowForPlayer(i, famGangZone[tempBuyLand[playerid]],0x00FFFF99);
                }
            }
            saveFamZone();
            sendSuccessMessage(playerid, "Anda sukses membeli lahan ini");
        }
        if(!response){
            tempBuyLand[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_FAM_LAHAN_INFO)
    {
        if(!response)
        {
            tempManageLand[playerid] = -1;
        }
        if(response){
            if(Player[playerid][pFam] == -1)
            {
                tempManageLand[playerid] = -1;
                return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
            }
            if(Player[playerid][pFamRank] < 4)
            {
                tempManageLand[playerid] = -1;
                return sendErrorMessage(playerid, "Anda bukan leader dari suatu family");
            }
            if(Player[playerid][pFam] != famZone[tempManageLand[playerid]][ffamId])
            {
                tempManageLand[playerid] = -1;
                return sendErrorMessage(playerid, "Lahan ini bukan milik family anda");
            }
            new str[256];
            format(str, sizeof(str), "Nama\tDeskripsi\nPerpanjang\tMemperpanjang durasi lahan selama 3 hari\nJual Lahan\tMenjual lahan kepada server\nList Object\tLihat informasi object dan mengedit\nCreate Object\tMenambahkan object ke dalam lahan anda\nDelete object\tMenghapus object");
            ShowPlayerDialog(playerid, DIALOG_MANAGE_LAHAN, DIALOG_STYLE_TABLIST_HEADERS, "Manage Lahan", str, "Pilih", "Batal");
        }
    }
    if(dialogid == DIALOG_MANAGE_LAHAN)
    {
        if(response){
            if(Player[playerid][pFam] == -1)
            {
                tempManageLand[playerid] = -1;
                return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
            }
            if(Player[playerid][pFamRank] < 4)
            {
                tempManageLand[playerid] = -1;
                return sendErrorMessage(playerid, "Anda bukan leader dari suatu family");
            }
            if(Player[playerid][pFam] != famZone[tempManageLand[playerid]][ffamId])
            {
                tempManageLand[playerid] = -1;
                return sendErrorMessage(playerid, "Lahan ini bukan milik family anda");
            }
            switch(listitem){
                case 0:
                {
                    if(famZone[tempManageLand[playerid]][ffDuration] <= 24)
                    {
                        if(Player[playerid][pMoney] >= famZone[tempManageLand[playerid]][ffMoney]){
                            new success[256];
                            format(success, sizeof(success), "Anda berhasil memperpanjang lahan anda selama 3 hari sebesar "EMBED_GREEN"%d", famZone[tempManageLand[playerid]][ffMoney]);
                            TakeMoney(playerid, famZone[tempManageLand[playerid]][ffMoney]);
                            famZone[tempManageLand[playerid]][ffDuration] += 72;
                            sendSuccessMessage(playerid, success);
                        }
                        else
                            sendErrorMessage(playerid, "Uang anda tidak cukup");
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Anda hanya dapat memperpanjang jika durasi kurang dari atau sama dengan 24 jam");
                    }
                    tempManageLand[playerid] = -1;
                    return 1;
                }
                case 1:
                {
                    if(famZone[tempManageLand[playerid]][ffDuration] > 1)
                    {
                        new i = tempManageLand[playerid];
                        new playerName[MAX_PLAYER_NAME];
                        new price = famZone[tempManageLand[playerid]][ffDuration] * PRICE_PER_METER;
                        Player[playerid][pMoney] += price;
                        GivePlayerMoney(playerid, price);
                        new success[128]; 
                        format(success, sizeof(success), "Anda berhasil menjual lahan dan mendapatkan uang sebesar %d", price);
                        sendSuccessMessage(playerid, success);
                        GetPlayerName(playerid, playerName, sizeof(playerName));
                        GangZoneHideForAll(famGangZone[i]);
                        GangZoneShowForAll(famGangZone[i], 0x007FFF99);
                        new info[128];
                        format(info, sizeof(info), "Salah satu lahan anda telah dijual oleh %s", playerName);
                        for(new j=0; j<MAX_PLAYERS; j++)
                        {
                            if(IsPlayerConnected(j) && !IsPlayerNPC(j)){
                                if(Player[j][pFam] == famZone[i][ffamId])
                                {
                                    sendInfoMessage(j, info);
                                }
                            }
                        }
                        famZone[i][ffamId] = -1;
                        famZone[i][ffDuration] = 0;
                        tempManageLand[playerid] = -1;
                        return 1;
                    }
                    else
                    {
                        sendErrorMessage(playerid, "Lahan anda harus memiliki durasi lebih dari 1 jam");
                        tempManageLand[playerid] = -1;
                        return 1;
                    }
                }
                case 3:
                {
                    new count = 0;
                    for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
                    {
                        if(ObjectId[i] != -1)
                        {
                            if(ObjectInfo[ObjectId[i]][famZoneId] == tempManageLand[playerid])
                            {
                                count++;
                            }
                        }
                    }
                    if(count > MAX_OBJECT_LAHAN)
                    {
                        tempManageLand[playerid] = -1;
                        return sendErrorMessage(playerid, "Slot object lahan sudah penuh");
                    }
                    
                    ShowModelSelectionMenu(playerid, objectList, "Pilih Object", 0x4A5A6BBB, COLOR_CYAN, COLOR_BLUE);
                    return 1;
                    
                }
                case 2:
                {
                    
                    new str[2056];
                    format(str, sizeof(str), "ID\tModel ID");
                    for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
                    {
                        if(ObjectId[i] != -1)
                        {
                            if(ObjectInfo[ObjectId[i]][famZoneId] == tempManageLand[playerid])
                            {
                                format(str, sizeof(str), "%s\n%d\t%d", str,ObjectId[i], ObjectInfo[ObjectId[i]][oModel]);
                            }
                        }
                    }
                    ShowPlayerDialog(playerid, DIALOG_LIST_OBJECT, DIALOG_STYLE_TABLIST_HEADERS, "Edit Object", str, "Edit", "Close");
                }
                case 4:{
                    new str[2056];
                    format(str, sizeof(str), "ID\tModel ID");
                    for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
                    {
                        if(ObjectId[i] != -1)
                        {
                            if(ObjectInfo[ObjectId[i]][famZoneId] == tempManageLand[playerid])
                            {
                                format(str, sizeof(str), "%s\n%d\t%d", str,ObjectId[i], ObjectInfo[ObjectId[i]][oModel]);
                            }
                        }
                    }
                    ShowPlayerDialog(playerid, DIALOG_LIST_OBJECT_DELETE, DIALOG_STYLE_TABLIST_HEADERS, "Delete Object", str, "Delete", "Close");
                }
            }
           
        }
        if(!response){
            tempManageLand[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_LIST_OBJECT)
    {
        if(Player[playerid][pFam] == -1)
        {
            tempManageLand[playerid] = -1;
            return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
        }
        if(Player[playerid][pFamRank] < 4)
        {
            tempManageLand[playerid] = -1;
            return sendErrorMessage(playerid, "Anda bukan leader dari suatu family");
        }
        if(Player[playerid][pFam] != famZone[tempManageLand[playerid]][ffamId])
        {
            tempManageLand[playerid] = -1;
            return sendErrorMessage(playerid, "Lahan ini bukan milik family anda");
        }
        new count = 0;
        for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
        {
            if(ObjectId[i] != -1)
            {
                if(ObjectInfo[ObjectId[i]][famZoneId] == tempManageLand[playerid])
                {
                    if(count == listitem){
                        if(!IsPlayerInRangeOfPoint(playerid, 7.0, ObjectInfo[ObjectId[i]][oX], ObjectInfo[ObjectId[i]][oY], ObjectInfo[ObjectId[i]][oZ]))
                            return sendErrorMessage(playerid, "Anda harus berada di dekat object!");
                        if(tempManageLand[playerid] == -1)
                            return sendErrorMessage(playerid, "Sesi berakhir");
                        tempObjectID[playerid] = i;
                        EditDynamicObject(playerid, ObjectId[i]);
                        return 1;
                    }
                    count++;
                }
            }
        }
    }
    if(dialogid == DIALOG_LIST_OBJECT_DELETE)
    {
        if(Player[playerid][pFam] == -1)
        {
            tempManageLand[playerid] = -1;
            return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
        }
        if(Player[playerid][pFamRank] < 4)
        {
            tempManageLand[playerid] = -1;
            return sendErrorMessage(playerid, "Anda bukan leader dari suatu family");
        }
        if(Player[playerid][pFam] != famZone[tempManageLand[playerid]][ffamId])
        {
            tempManageLand[playerid] = -1;
            return sendErrorMessage(playerid, "Lahan ini bukan milik family anda");
        }
        new count = 0;
        for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
        {
            if(ObjectId[i] != -1)
            {
                if(ObjectInfo[ObjectId[i]][famZoneId] == tempManageLand[playerid])
                {
                    if(count == listitem){
                        if(!IsPlayerInRangeOfPoint(playerid, 7.0, ObjectInfo[ObjectId[i]][oX], ObjectInfo[ObjectId[i]][oY], ObjectInfo[ObjectId[i]][oZ]))
                            return sendErrorMessage(playerid, "Anda harus berada di dekat object!");
                        if(tempManageLand[playerid] == -1)
                            return sendErrorMessage(playerid, "Sesi berakhir");
                        tempObjectID[playerid] = i;
                        DestroyDynamicObject(ObjectId[i]);
                        new objectFile[128];
                        format(objectFile, sizeof(objectFile), "Object/%d.ini", i);
                        dini_Remove(objectFile);
                        ObjectId[i] = -1;
                        new str[128];
                        format(str, sizeof(str), "Sukses menghapus object %d", i);
                        return sendErrorMessage(playerid, str);
                    }
                    count++;
                }
            }
        }
    }
    return 1;
}