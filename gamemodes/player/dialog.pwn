
forward showMsgBox(playerid,titles[], textt[]);

stock showMsgBox(playerid,titles[] ,textt[])
{
    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, titles, textt, "Okay","Lanjut");
    return 1;
}
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_REGISTER)
    {
        if(response){
            HideLoginTextDraws(playerid);
            if(strlen(inputtext) < 5 || strlen(inputtext) > 64)
            {
                ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "Register", ""EMBED_RED"Anda belum terdaftar dalam server!\n "EMBED_RED"Password harus lebih dari 5 karakter dan kurang dari 64 karakter", "Lanjutkan", "Batal");
            }
            else{
                new hashs[256];
                new str[256];
                GetPlayerName(playerid, str, sizeof(str));
                new playerFileName[64];
                format(playerFileName, sizeof(playerFileName), "acc/%s.ini", str);
                dini_Create(playerFileName);
                SHA256_PassHash(inputtext,str, hashs, sizeof(hashs));
                dini_Set(playerFileName, "Username", str);
                dini_Set(playerFileName, "Password", hashs);
                isPlayerLogged[playerid] = 2;
                stepRegister[playerid] = 0;
                ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Pilih Gender anda", "Laki - Laki\nPerempuan", "Pilih", "");
                // ShowMenuForPlayer(RegisterMenu, playerid);
                // SpawnPlayer(playerid);

            }
        }
        if(!response){
            HideLoginTextDraws(playerid);
            Kick(playerid);
        }
    }
    if(dialogid == DIALOG_LOGIN)
    {
        if(response){

            HideLoginTextDraws(playerid);
            new str[64];
            GetPlayerName(playerid, str, sizeof(str));
            new playerFileName[64];
            new password[256];
           
            format(playerFileName, sizeof(playerFileName), "acc/%s.ini", str);
            new hashs[256];
            format(password, sizeof(password),"%s",dini_Get(playerFileName, "Password"));

            SHA256_PassHash(inputtext, str, hashs, sizeof(hashs));

            if(strcmp(hashs,password) == 0)
            {
                SendClientMessage(playerid,COLOR_LIGHTGREEN, "Login berhasil!");
                isPlayerLogged[playerid] = 1;
                SpawnPlayer(playerid);
              
            }
            else
            {
                if(tryPassword[playerid] >= 3)
                {
                    Kick(playerid);
                    return 0;
                }
                tryPassword[playerid]++;
                new strr[256];
                format(strr, sizeof(strr), ""EMBED_GREEN"Anda telah terdaftar!\n "EMBED_RED"Password Salah %d percobaan tersisa!", (tryPassword[playerid] - 3) *-1);
                ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Login", strr, "Lanjutkan", "Batal");

            }
        }
        if(!response)
        {
            HideLoginTextDraws(playerid);
            Kick(playerid);
        }
        
    }
    if(dialogid == DIALOG_LIST_TRADER)
    {
        if(response){
            if(listitem == 0)
            {
                return 1;
            }
            else
            {
                SetPlayerPos(playerid, TraderNpcInfo[TraderNpc[listitem - 1]][tX], TraderNpcInfo[TraderNpc[listitem - 1]][tY], TraderNpcInfo[TraderNpc[listitem - 1]][tZ] + 5.0);
                new str[128]; 
                format(str, sizeof(str), "Anda sukses teleport kepada bot trader %d", listitem - 1);
                sendSuccessMessage(playerid, str);
                return 1;
            }
        }
        return 1;
    }
    if(dialogid == DIALOG_LIST_ZOMBIE)
    {
        if(response)
        {
            if(listitem == 0)
            {
                return 1;
            }
            else
            {
                new Float:x, Float:y, Float:z;
                FCNPC_GetPosition(npcId[listitem - 1], x, y, z);
                SetPlayerPos(playerid, x, y, z + 5.0);
                new str[128]; 
                format(str, sizeof(str), "Anda sukses teleport kepada bot zombie %d", listitem - 1);
                sendSuccessMessage(playerid, str);
            }
            
        }
        return 1;
    }
    if(dialogid == DIALOG_TRADER_SHOP)
    {
        if(response){
            switch(listitem)
            {
                case 0:{
                    ShowPlayerDialog(playerid, DIALOG_BUY_APEL, DIALOG_STYLE_INPUT, "Trader Shop", "Masukan jumlah apel yang ingin dibeli", "Beli", "Batal");
                }
                case 1:{
                    ShowPlayerDialog(playerid, DIALOG_BUY_PIZZA, DIALOG_STYLE_INPUT, "Trader Shop", "Masukan jumlah pizza yang ingin dibeli", "Beli", "Batal");
                }
                case 2:{
                    ShowPlayerDialog(playerid, DIALOG_BUY_MINUMAN, DIALOG_STYLE_INPUT, "Trader Shop", "Masukan jumlah minuman yang ingin dibeli", "Beli", "Batal");
                }
                case 3:{
                    ShowPlayerDialog(playerid, DIALOG_BUY_BANDAGE, DIALOG_STYLE_INPUT, "Trader Shop", "Masukan jumlah bandage yang ingin dibeli", "Beli", "Batal");
                }
                case 4:{
                    ShowPlayerDialog(playerid, DIALOG_BUY_ANTIBIOTIK, DIALOG_STYLE_INPUT, "Trader Shop", "Masukan jumlah antibiotik yang ingin dibeli", "Beli", "Batal");
                }
                case 5:{
                    ShowPlayerDialog(playerid, DIALOG_BUY_GASMASK, DIALOG_STYLE_INPUT, "Trader Shop", "Masukan jumlah gasmask yang ingin dibeli", "Beli", "Batal");
                }
            }
        }
        return 1;
    }
    if(dialogid == DIALOG_BUY_APEL)
    {
        if(response){
            new price = 100;
            new amnt;
            if(sscanf(inputtext, "d", amnt) || amnt >= 1000 || amnt <= 0)
            {
                new str[256];
                format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Masukan jumlah yang benar!");
                ShowPlayerDialog(playerid, DIALOG_BUY_APEL, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
            }
            else{
                if(Player[playerid][pMoney] < (price * amnt)){
                    new str[256];
                    format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Uang anda tidak cukup\nMasukan jumlah apel yang ingin dibeli");
                    ShowPlayerDialog(playerid, DIALOG_BUY_APEL, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
                }
                else{
                    new str[256];
                    format(str, sizeof(str), "Anda berhasil membeli %d apel dari trader", amnt);
                    sendSuccessMessage(playerid, str);
                    TakeMoney(playerid, price * amnt);
                    Player[playerid][pApel] += amnt;
                }
            }
            
        }
        return 1;
    }
    if(dialogid == DIALOG_BUY_PIZZA)
    {
        if(response){
            new price = 150;
            new amnt;
            if(sscanf(inputtext, "d", amnt) || amnt >= 1000 || amnt <= 0)
            {
                new str[256];
                format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Masukan jumlah pizza yang benar!");
                ShowPlayerDialog(playerid, DIALOG_BUY_PIZZA, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
            }
            else{
                if(Player[playerid][pMoney] < (price * amnt)){
                    new str[256];
                    format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Uang anda tidak cukup\nMasukan jumlah pizza yang ingin dibeli");
                    ShowPlayerDialog(playerid, DIALOG_BUY_PIZZA, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
                }
                else{
                    new str[256];
                    format(str, sizeof(str), "Anda berhasil membeli %d pizza dari trader", amnt);
                    sendSuccessMessage(playerid, str);
                    TakeMoney(playerid, price * amnt);
                    Player[playerid][pPizza] += amnt;
                }
            }
            
        }
        return 1;
    }
    if(dialogid == DIALOG_BUY_MINUMAN)
    {
        if(response){
            new price = 50;
            new amnt;
            if(sscanf(inputtext, "d", amnt) || amnt >= 1000 || amnt <= 0)
            {
                new str[256];
                format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Masukan jumlah minuman yang benar!");
                ShowPlayerDialog(playerid, DIALOG_BUY_MINUMAN, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
            }
            else{
                if(Player[playerid][pMoney] < (price * amnt)){
                    new str[256];
                    format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Uang anda tidak cukup\nMasukan jumlah minuman yang ingin dibeli");
                    ShowPlayerDialog(playerid, DIALOG_BUY_MINUMAN, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
                }
                else{
                    new str[256];
                    format(str, sizeof(str), "Anda berhasil membeli %d minuman dari trader", amnt);
                    sendSuccessMessage(playerid, str);
                    TakeMoney(playerid, price * amnt);
                    Player[playerid][pDrink] += amnt;
                }
            }
            
        }
        return 1;
    } 
    if(dialogid == DIALOG_BUY_BANDAGE)
    {
        if(response){
            new price = 400;
            new amnt;
            if(sscanf(inputtext, "d", amnt) || amnt >= 1000 || amnt <= 0)
            {
                new str[256];
                format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Masukan jumlah bandage yang benar!");
                ShowPlayerDialog(playerid, DIALOG_BUY_BANDAGE, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
            }
            else{
                if(Player[playerid][pMoney] < (price * amnt)){
                    new str[256];
                    format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Uang anda tidak cukup\nMasukan jumlah bandage yang ingin dibeli");
                    ShowPlayerDialog(playerid, DIALOG_BUY_BANDAGE, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
                }
                else{
                    new str[256];
                    format(str, sizeof(str), "Anda berhasil membeli %d bandage dari trader", amnt);
                    sendSuccessMessage(playerid, str);
                    TakeMoney(playerid, price * amnt);
                    Player[playerid][pBandage] += amnt;
                }
            }
            
        }
        return 1;
    }
    if(dialogid == DIALOG_BUY_ANTIBIOTIK)
    {
        if(response){
            new price = 500;
            new amnt;
            if(sscanf(inputtext, "d", amnt) || amnt >= 1000 || amnt <= 0)
            {
                new str[256];
                format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Masukan jumlah antibiotik yang benar!");
                ShowPlayerDialog(playerid, DIALOG_BUY_ANTIBIOTIK, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
            }
            else{
                if(Player[playerid][pMoney] < (price * amnt)){
                    new str[256];
                    format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Uang anda tidak cukup\nMasukan jumlah antibiotik yang ingin dibeli");
                    ShowPlayerDialog(playerid, DIALOG_BUY_ANTIBIOTIK, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
                }
                else{
                    new str[256];
                    format(str, sizeof(str), "Anda berhasil membeli %d antibiotik dari trader", amnt);
                    sendSuccessMessage(playerid, str);
                    TakeMoney(playerid, price * amnt);
                    Player[playerid][pAntibiotic] += amnt;
                }
            }
            
        }
        return 1;
    }
    if(dialogid == DIALOG_BUY_GASMASK)
    {
        if(response){
            new price = 500;
            new amnt;
            if(sscanf(inputtext, "d", amnt) || amnt >= 1000 || amnt <= 0)
            {
                new str[256];
                format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Masukan jumlah gasmask yang benar!");
                ShowPlayerDialog(playerid, DIALOG_BUY_GASMASK, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
            }
            else{
                if(Player[playerid][pMoney] < (price * amnt)){
                    new str[256];
                    format(str, sizeof(str), ""EMBED_RED"[ERROR] "EMBED_WHITE"Uang anda tidak cukup\nMasukan jumlah gasmask yang ingin dibeli");
                    ShowPlayerDialog(playerid, DIALOG_BUY_GASMASK, DIALOG_STYLE_INPUT, "Trader Shop", str, "Beli", "Batal");
                }
                else{
                    new str[256];
                    format(str, sizeof(str), "Anda berhasil membeli %d gasmask dari trader", amnt);
                    sendSuccessMessage(playerid, str);
                    TakeMoney(playerid, price * amnt);
                    Player[playerid][pGasmask] += amnt;
                }
            }
            
        }
        return 1;
    }
    if(dialogid == DIALOG_GUNSHOP)
    {
        if(response){
            switch(listitem){
                case 0:
                {
                    if(Player[playerid][pMoney] < 10000)
                        return sendErrorMessage(playerid, "Anda tidak memiliki cukup uang untuk membeli senjata 9mm");
                    setWeapon(playerid, 22);
                    sendSuccessMessage(playerid, "Anda sukses membeli pistol 9mm silahkan cek inventory anda");
                    TakeMoney(playerid, 10000);
                }
                case 1:
                {
                    if(Player[playerid][pMoney] < 20000)
                        return sendErrorMessage(playerid, "Anda tidak memiliki cukup uang untuk membeli senjata shotgun");
                    
                    sendSuccessMessage(playerid, "Anda sukses membeli shotgun silahkan cek inventory anda");
                    TakeMoney(playerid, 20000);
                    setWeapon(playerid, 25);
                }
                case 2:
                {
                    if(Player[playerid][pMoney] < 30000)
                        return sendErrorMessage(playerid, "Anda tidak memiliki cukup uang untuk membeli senjata uzi");
                    
                    sendSuccessMessage(playerid, "Anda sukses membeli uzi silahkan cek inventory anda");
                    TakeMoney(playerid, 30000);
                    setWeapon(playerid, 28);
                }
                case 3:{
                    if(Player[playerid][pMoney] < 200)
                        return sendErrorMessage(playerid, "Anda tidak memiliki cukup uang untuk membeli peluru pistol 9mm");
                    
                    if(giveAmmo(playerid, 22, 50) == 1)
                    {
                        sendSuccessMessage(playerid, "Anda sukses membeli peluru pistol silahkan cek inventory anda");
                        TakeMoney(playerid, 200);
                        return 1;
                    }
                    return sendErrorMessage(playerid, "Pembelian gagal!");
                    
                }
                case 4:{
                    if(Player[playerid][pMoney] < 500)
                        return sendErrorMessage(playerid, "Anda tidak memiliki cukup uang untuk membeli peluru shotgun");
                    
                    if(giveAmmo(playerid, 25, 50) == 1)
                    {
                        sendSuccessMessage(playerid, "Anda sukses membeli peluru shotgun silahkan cek inventory anda");
                        TakeMoney(playerid, 500);
                        return 1;
                    }
                    return sendErrorMessage(playerid, "Pembelian gagal!");
                    
                }
                case 5:{
                    if(Player[playerid][pMoney] < 1000)
                        return sendErrorMessage(playerid, "Anda tidak memiliki cukup uang untuk membeli peluru uzi");
                    
                    if(giveAmmo(playerid, 28, 200) == 1)
                    {
                        sendSuccessMessage(playerid, "Anda sukses membeli peluru uzi silahkan cek inventory anda");
                        TakeMoney(playerid, 1000);
                        return 1;
                    }
                    return sendErrorMessage(playerid, "Pembelian gagal!");
                    
                }
            }
        }
    }
    if(dialogid == DIALOG_ACCEPT_LOOT)
    {
        if(response)
        {  
            if(IsPlayerInRangeOfPoint(playerid, 1.0, LootInfo[PlayerPickSmth[playerid]][lX], LootInfo[PlayerPickSmth[playerid]][lY], LootInfo[PlayerPickSmth[playerid]][lZ]) && LootPickup[LootID[playerid]] != -1)
            {
                new item[64];
                new str[128];

                switch(LootInfo[PlayerPickSmth[playerid]][lModel])
                {
                    case LOOT_ARMOUR:
                    {
                        format(item, sizeof(item), "body armour");
                    }
                    case LOOT_ANTIBIOTIK:
                    {
                        format(item, sizeof(item), "antibiotik");
                    }
                    case LOOT_BANDAGE:
                    {
                        format(item, sizeof(item), "bandage"); 
                    }
                    case LOOT_SCRAP:
                    {
                        format(item, sizeof(item), "scrap");
                    }
                    case LOOT_MINUMAN:
                    {
                        format(item, sizeof(item), "minuman");
                    }
                    case LOOT_APEL:
                    {
                        format(item, sizeof(item), "apel");
                    }
                    case LOOT_PIZZA:
                    {
                        format(item, sizeof(item), "pizza");
                    }
                    case LOOT_MONEY:
                    {
                        format(item, sizeof(item), "uang");
                    }


                }
                format(str, sizeof(str), "Anda mencoba mengambil %s", item);
                sendInfoMessage(playerid,  str);
                setLootActivity(playerid, LootInfo[PlayerPickSmth[playerid]][lModel], LootInfo[PlayerPickSmth[playerid]][lAmount]);
            }
            else{
                PlayerPickSmth[playerid] = -1;
                sendErrorMessage(playerid, "Anda tidak berada di dekat loot!");
            }
               
        }
        if(!response)
        {
            TogglePlayerControllable(playerid, 1);
            PlayerPickSmth[playerid] = -1;
            LootID[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_LOOT_DEATH)
    {
        if(response)
        {
            if(!IsPlayerInRangeOfPoint(playerid, 1.0, deathItem[deathItemPickup[playerid]][dX], deathItem[deathItemPickup[playerid]][dY], deathItem[deathItemPickup[playerid]][dZ]) && deathObject[deathID[playerid]] != -1)
            {
                sendErrorMessage(playerid, "Anda tidak berada di dekat loot");
                deathItemPickup[playerid] = -1;
                deathID[playerid] = -1;
                return 1;
            }
            sendInfoMessage(playerid, "Anda mencoba mengambil sebuah senjata");
            setWeaponLootActivity(playerid, deathItem[deathObject[deathID[playerid]]][dWeapon], deathItem[deathObject[deathID[playerid]]][dAmmo]);
            return 1;
        }
        if(!response){
            deathItemPickup[playerid] = -1;
            deathID[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_LIST_REBEL)
    {
        if(response)
        {
            SetPlayerPos(playerid, rebelNpcInfo[rebelNpc[listitem]][rrX], rebelNpcInfo[rebelNpc[listitem]][rrY], rebelNpcInfo[rebelNpc[listitem]][rrZ]);
            new success[128];
            format(success, sizeof(success), "Anda berhasil teleport ke npc rebel id %d", listitem);
            sendSuccessMessage(playerid, success);
            return 1;
        }
    }
    if(dialogid == DIALOG_FAM_MENU)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:{
                    new str[1024];
                    new rankname[64];
                    new famid = Player[playerid][pFam];
                    format(str, sizeof(str), "Nama\tRank");
                    if(strlen(familyInfo[famid][fmName1]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank1], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName1], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName2]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank2], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName2], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName3]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank3], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName3], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName4]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank4], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName4], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName5]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank5], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName5], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName6]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank6], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName6], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName7]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank7], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName7], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName8]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank8], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName8], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName9]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank9], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName9], rankname);
                    }
                    if(strlen(familyInfo[famid][fmName10]) > 0)
                    {
                        getRankName(familyInfo[famid][fmRank10], rankname);
                        format(str, sizeof(str), "%s\n%s\t%s", str, familyInfo[famid][fmName10], rankname);
                    }
                    ShowPlayerDialog(playerid, DIALOG_LIST_FAM_MEMBER, DIALOG_STYLE_TABLIST_HEADERS, "List Member", str, "Close", "");
                }
                case 1:
                {
                    new str[1024];
                    format(str, sizeof(str), "ID\tX\tY\tZ");
                    for(new i=0; i<MAX_FAM_ZONE; i++)
                    {
                        if(famZone[i][ffamId] == Player[playerid][pFam] && famZoneExist[i] != -1)
                        {
                            new Float:z;
                            MapAndreas_FindZ_For2DCoord(famZone[i][ffMinX], famZone[i][ffMinY], z);
                            format(str, sizeof(str), "%s\n%d\t%.2f\t%.2f\t%.2f", str,i,  famZone[i][ffMinX], famZone[i][ffMinY], z);
                        }
                    }
                    ShowPlayerDialog(playerid, DIALOG_LIST_FAM_LAND, DIALOG_STYLE_TABLIST_HEADERS, "List Lahan", str, "Batal", "");
                }
                case 2:
                {
                    if(Player[playerid][pFamRank] < 3)
                    {
                        sendErrorMessage(playerid, "Anda harus menjadi general untuk menambahkan seseorang");
                        return  ShowPlayerDialog(playerid, DIALOG_FAM_MENU, DIALOG_STYLE_TABLIST_HEADERS, "Fam Menu", "Menu\tDeskripsi\nList Member\tMelihat semua member\nAdd Member\tMenambahkan anggota\nSet Rank\tMengubah status rank member\nKick Member\tMengeluarkan member", "Choose", "Close");
                    }
                    if(!getEmptyName(Player[playerid][pFam]))
                    {
                        if(Player[playerid][pFam] != -1)
                        {
                            ShowPlayerDialog(playerid, DIALOG_FAM_MENU, DIALOG_STYLE_TABLIST_HEADERS, "Fam Menu", "Menu\tDeskripsi\nList Member\tMelihat semua member\nAdd Member\tMenambahkan anggota\nSet Rank\tMengubah status rank member\nKick Member\tMengeluarkan member", "Choose", "Close");
                            return 1;
                        }
                    }
                    ShowPlayerDialog(playerid, DIALOG_FAM_INPUT_ID_INVITE, DIALOG_STYLE_INPUT, "Fam Invitation", "Masukan ID player yang ingin di invite", "Invite", "Batal");
                }
                case 3:
                {
                    if(Player[playerid][pFam] == -1)
                    {
                        return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
                    }
                    if(Player[playerid][pFamRank] < 4)
                    {
                        return sendErrorMessage(playerid, "Anda harus menjadi leader family untuk mengubah rank member");
                    }
                    return ShowPlayerDialog(playerid, DIALOG_SET_FAM_MEMBER_RANK, DIALOG_STYLE_INPUT, "Set Rank Member", "Masukan nama member", "Lanjut", "Batal");
                }
                case 4:
                {
                    if(Player[playerid][pFam] == -1)
                    {
                        return sendErrorMessage(playerid, "Anda tidak tergabung dalam family manapun");
                    }
                    if(Player[playerid][pFamRank] < 4)
                    {
                        return sendErrorMessage(playerid, "Anda harus menjadi leader family untuk menendang member");
                    }
                    ShowPlayerDialog(playerid, DIALOG_KICK_FAM_MEMBER, DIALOG_STYLE_INPUT, "Kick Member", "Masukan nama member yang ingin anda kick", "Kick", "Batal");
                }
            }

        }
            
    }
        
    if(dialogid == DIALOG_FAM_INPUT_ID_INVITE)
    {
        if(response){
            new target;
            if(sscanf(inputtext, "d", target))
            {
                ShowPlayerDialog(playerid, DIALOG_FAM_INPUT_ID_INVITE, DIALOG_STYLE_INPUT, "Fam Invitation", "Masukan ID player dengan benar!", "Invite", "Batal");
            }       
            if(IsPlayerConnected(target) && !IsPlayerNPC(target) && Player[target][pFam] == -1)
            {     
                new Float:x, Float:y, Float:z;
                GetPlayerPos(target, x, y, z);
                if(!IsPlayerInRangeOfPoint(playerid,7.0, x, y, z))
                {
                    return ShowPlayerDialog(playerid, DIALOG_FAM_INPUT_ID_INVITE, DIALOG_STYLE_INPUT, "Fam Invitation", "Player tidak berada di dekat anda\nMasukan ID player yang ingin di invite", "Invite", "Batal"); 
                }
                tempInvite[target] = Player[playerid][pFam];
                new targetName[MAX_PLAYER_NAME];
                new playerName[MAX_PLAYER_NAME];
                GetPlayerName(playerid, playerName, sizeof(playerName));
                GetPlayerName(target, targetName, sizeof(targetName));
                new success[128];
                format(success, sizeof(success), "Anda sukses mengundang %s kedalam family anda", targetName);
                sendSuccessMessage(playerid, success);
                ShowPlayerDialog(playerid, DIALOG_FAM_MENU, DIALOG_STYLE_TABLIST_HEADERS, "Fam Menu", "Menu\tDeskripsi\nList Member\tMelihat semua member\nAdd Member\tMenambahkan anggota\nSet Rank\tMengubah status rank member\nKick Member\tMengeluarkan member", "Choose", "Close");
                new invit[256];
                format(invit, sizeof(invit), "%s mengundang anda untuk bergabung dalam family "EMBED_RED" %s", playerName, familyInfo[Player[playerid][pFam]][fName]);
                ShowPlayerDialog(target, DIALOG_ACCEPT_FAM_INVITE, DIALOG_STYLE_MSGBOX, "Family Invitation", invit, "Terima", "Tolak");
            }
            if(!IsPlayerConnected(target))
            {
                return ShowPlayerDialog(playerid, DIALOG_FAM_INPUT_ID_INVITE, DIALOG_STYLE_INPUT, "Fam Invitation", "Player tidak terkoneksi dengan server\nMasukan ID player yang ingin di invite", "Invite", "Batal");
            }
            if(IsPlayerNPC(target))
            {
                return ShowPlayerDialog(playerid, DIALOG_FAM_INPUT_ID_INVITE, DIALOG_STYLE_INPUT, "Fam Invitation", "Player tidak terkoneksi dengan server\nMasukan ID player yang ingin di invite", "Invite", "Batal");
            }
            if(playerid == target)
            {
                return ShowPlayerDialog(playerid, DIALOG_FAM_INPUT_ID_INVITE, DIALOG_STYLE_INPUT, "Fam Invitation", "Player tidak valid\nMasukan ID player yang ingin di invite", "Invite", "Batal");
            }
            if(Player[target][pFam] != -1)
            {
                return ShowPlayerDialog(playerid, DIALOG_FAM_INPUT_ID_INVITE, DIALOG_STYLE_INPUT, "Fam Invitation", "Player sudah bergabung dalam family lain\nMasukan ID player yang ingin di invite", "Invite", "Batal");
            }

        }
    }
    if(dialogid == DIALOG_ACCEPT_FAM_INVITE)
    {
        if(response){
            new slotkosong = getEmptyName(tempInvite[playerid]);
            new playerName[255];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            switch(slotkosong)
            {
                case 0:
                {
                    new error[128];
                    format(error, sizeof(error), "Anggota family "EMBED_RED" %s "EMBED_WHITE" penuh", familyInfo[tempInvite[playerid]][fName]);
                    sendErrorMessage(playerid, error);
                    tempInvite[playerid] = -1;
                    return 1;
                }
                case 1:
                {
                    format(familyInfo[tempInvite[playerid]][fmName1], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank1] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 2:
                {
                    format(familyInfo[tempInvite[playerid]][fmName2], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank2] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 3:
                {
                    format(familyInfo[tempInvite[playerid]][fmName3], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank3] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 4:
                {
                    format(familyInfo[tempInvite[playerid]][fmName4], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank4] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 5:
                {
                    format(familyInfo[tempInvite[playerid]][fmName5], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank5] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 6:
                {
                    format(familyInfo[tempInvite[playerid]][fmName6], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank6] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 7:
                {
                    format(familyInfo[tempInvite[playerid]][fmName7], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank7] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 8:
                {
                    format(familyInfo[tempInvite[playerid]][fmName8], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank8] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 9:
                {
                    format(familyInfo[tempInvite[playerid]][fmName9], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank9] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;
                }
                case 10:
                {
                    format(familyInfo[tempInvite[playerid]][fmName10], DINI_MAX_STRING, "%s", playerName);
                    familyInfo[tempInvite[playerid]][fmRank10] = 1;
                    Player[playerid][pFam] = tempInvite[playerid];
                    Player[playerid][pFamRank] = 1;
                    getPlayerRankName(playerid);
                    tempInvite[playerid] = -1;

                }
            }
            if(slotkosong > 0)
            {
                new success[128];
                format(success, sizeof(success), "Anda berhasil bergabung dalam family "EMBED_RED"%s.", familyInfo[Player[playerid][pFam]][fName]);
                sendSuccessMessage(playerid, success);
                saveFam();
            }

        }
        if(!response){
            tempInvite[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_KICK_FAM_MEMBER)
    {

        if(response){
            new ada;
            new playername[64];
            
            if(sscanf(inputtext, "s[64]", playername))
            {
                return ShowPlayerDialog(playerid, DIALOG_KICK_FAM_MEMBER, DIALOG_STYLE_INPUT, "Kick Family Member", "Nama Player tidak valid!\nMasukan nama player yang benar", "Kick", "Batal");
            }
            ada = checkIfPlayerInFam(Player[playerid][pFam],playername);
            new nullstr[DINI_MAX_STRING];
            new isinfam = ada;
            new famid = Player[playerid][pFam];
            new adminName[MAX_PLAYER_NAME];
            if(isinfam == 0)
            {
                new error[128];
                format(error, sizeof(error), "Player %s tidak berada dalam family %s", playername, familyInfo[famid][fName]);
                return sendErrorMessage(playerid, error);
            }
            GetPlayerName(playerid, adminName, sizeof(adminName));
            new targetid = INVALID_PLAYER_ID;
            for(new i=0; i<MAX_PLAYERS; i++)
            {
                if(i != INVALID_PLAYER_ID)
                {
                    new playernames[MAX_PLAYER_NAME];
                    GetPlayerName(i, playernames, sizeof(playernames));
                    if(strcmp(playername, playernames) == 0)
                    {
                        targetid = i;
                        break;
                    }
                }
            }
            if(IsPlayerConnected(targetid) || !IsPlayerNPC(targetid))
            {
                
                new info[128];
                format(info, sizeof(info), "%s telah menendang anda dari family "EMBED_RED"%s", adminName, familyInfo[famid][fName]);
                sendInfoMessage(targetid, info);
                Player[targetid][pFam] = -1;
            }
            switch(isinfam)
            {
                case 1:
                {
                    format(familyInfo[famid][fmName1], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank1] = 0;
                }
                case 2:
                {
                    format(familyInfo[famid][fmName2], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank2] = 0;
                }
                case 3:
                {
                    format(familyInfo[famid][fmName3], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank3] = 0;
                }
                case 4:
                {
                    format(familyInfo[famid][fmName4], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank4] = 0;
                }
                case 5:
                {
                    format(familyInfo[famid][fmName5], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank5] = 0;
                }
                case 6:
                {
                    format(familyInfo[famid][fmName6], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank6] = 0;
                }
                case 7:
                {
                    format(familyInfo[famid][fmName7], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank7] = 0;
                }
                case 8:
                {
                    format(familyInfo[famid][fmName8], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank8] = 0;
                }
                case 9:
                {
                    format(familyInfo[famid][fmName9], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank9] = 0;
                }
                case 10:
                {
                    format(familyInfo[famid][fmName10], DINI_MAX_STRING, "%s", nullstr);
                    familyInfo[famid][fmRank10] = 0;
                }
            }
            new success[128];
            format(success, sizeof(success), "Anda berhasil menendang %s dari family "EMBED_RED"%s",playername ,familyInfo[famid][fName]);
            sendSuccessMessage(playerid, success);
            saveFam();
        }
    }
    if(dialogid == DIALOG_SET_FAM_MEMBER_RANK)
    {
        if(response)
        {
            new playerName[64];
            if(sscanf(inputtext, "s[64]", playerName) && strlen(playerName) > 0)
            {
                return ShowPlayerDialog(playerid, DIALOG_LIST_FAM_RANK, DIALOG_STYLE_INPUT, "Set Rank Member", "Nama yang anda masukan tidak valid!\nMasukan nama member", "Lanjut", "Batal");
            }
            new isinfam = checkIfPlayerInFam(Player[playerid][pFam], playerName);
            if(isinfam > 0)
            {
                format(tempSetRank[playerid], MAX_PLAYER_NAME, "%s", playerName);
                ShowPlayerDialog(playerid, DIALOG_LIST_FAM_RANK, DIALOG_STYLE_LIST, "Rank Member", "Soldier\nCaptain\nGeneral\nLeader", "Pilih", "Batal");
            }
            else
            {
                new nullstr[MAX_PLAYER_NAME];
                format(tempSetRank[playerid], MAX_PLAYER_NAME, "%s", nullstr);
                return ShowPlayerDialog(playerid, DIALOG_SET_FAM_MEMBER_RANK, DIALOG_STYLE_INPUT, "Set Rank Member", "Nama yang anda masukan tidak berada dalam family anda\nMasukan nama member", "Lanjut", "Batal");
            }
            
        }
    }
    if(dialogid == DIALOG_LIST_FAM_RANK)
    {
        if(!response){
            new nullstr[MAX_PLAYER_NAME];
            format(tempSetRank[playerid], MAX_PLAYER_NAME, "%s", nullstr);
        }
        if(response){
            new leaderName[MAX_PLAYER_NAME];
            GetPlayerName(playerid, leaderName, sizeof(leaderName));
            new rank = 0;
            switch(listitem)
            {
                case 0:
                {
                    rank = 1;
                }
                case 1:
                {
                    rank = 2;
                }
                case 2:
                {
                    rank = 3;
                }
                case 3:
                {
                    rank = 4;
                }
            }
            new isinfam = checkIfPlayerInFam(Player[playerid][pFam],tempSetRank[playerid]);
            if(isinfam <= 0)
            {
                new error[128];
                format(error, sizeof(error), "Player %s tidak berada dalam family anda", tempSetRank[playerid]);
                new nullstr[MAX_PLAYER_NAME];
                format(tempSetRank[playerid], MAX_PLAYER_NAME, "%s", nullstr);
                return sendErrorMessage(playerid, error);
            }
            switch(isinfam)
            {
                case 1:
                {
                    familyInfo[Player[playerid][pFam]][fmRank1] = rank;
                }
                case 2:
                {
                    familyInfo[Player[playerid][pFam]][fmRank2] = rank;
                }
                case 3:
                {
                    familyInfo[Player[playerid][pFam]][fmRank3] = rank;
                }
                case 4:
                {
                    familyInfo[Player[playerid][pFam]][fmRank4] = rank;
                }
                case 5:
                {
                    familyInfo[Player[playerid][pFam]][fmRank5] = rank;
                }
                case 6:
                {
                    familyInfo[Player[playerid][pFam]][fmRank6] = rank;
                }
                case 7:
                {
                    familyInfo[Player[playerid][pFam]][fmRank7] = rank;
                }
                case 8:
                {
                    familyInfo[Player[playerid][pFam]][fmRank8] = rank;
                }
                case 9:
                {
                    familyInfo[Player[playerid][pFam]][fmRank9] = rank;
                }
                case 10:
                {
                    familyInfo[Player[playerid][pFam]][fmRank10] = rank;
                }
            }
            
            new targetid = INVALID_PLAYER_ID;
            for(new i=0; i<MAX_PLAYERS; i++)
            {
                if(IsPlayerConnected(i) && !IsPlayerNPC(i))
                {
                    new namePlayer[MAX_PLAYER_NAME];
                    GetPlayerName(i, namePlayer, sizeof(namePlayer));
                    if(strcmp(namePlayer, tempSetRank[playerid]) == 0 && strlen(namePlayer) > 0)
                    {
                        targetid = i;
                    }
                }
            }
            if(targetid != INVALID_PLAYER_ID)
            {
                new info[128];
                Player[targetid][pFamRank] = rank;
                getPlayerRankName(targetid);
                format(info, sizeof(info), "%s mengubah rank anda menjadi %s", leaderName, Player[targetid][pFamRankName]);
                sendInfoMessage(targetid, info);
            }
            new success[128];
            new rankName[64];
            getRankName(rank, rankName);
            format(success, sizeof(success), "Anda berhasil mengubah rank %s menjadi %s", tempSetRank[playerid], rankName);
            saveFam();
            return sendInfoMessage(playerid, success);
        }
    }
    if(dialogid == DIALOG_GENDER){
        if(response){
            switch(listitem){
                case 0:
                {
                    Player[playerid][pGender] = 0;
                    ShowModelSelectionMenu(playerid, maleSkinList, "Pilih Skin", 0x4A5A6BBB, COLOR_CYAN, COLOR_BLUE);
                }
                case 1:{
                    Player[playerid][pGender] = 1;
                    ShowModelSelectionMenu(playerid, femaleSkinList, "Pilih Skin", 0x4A5A6BBB, COLOR_CYAN, COLOR_BLUE);
                }
            }
        }
        
        stepRegister[playerid]++;
    }
    if(dialogid == DIALOG_HELP){
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    new str[1024];
                    format(str, sizeof(str), "Perintah\tKeterangan\n/stats\tMelihat informasi akun anda\n/report [id] [penjelasan]\tMelaporkan player lain karena telah melanggar aturan\n/ask [pertanyaan]\tMenanyakan sesuatu kepada admin yang online");
                    ShowPlayerDialog(playerid, DIALOG_HELP2, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Player", str, "Tutup", "");
                }
                case 1:
                {
                    new str[1024];
                    format(str, sizeof(str), "Perintah\tKeterangan\n/pm [id_pemain] [message]\tMengirimkan pesan kepada player lain\n/w [id_pemain] [message]\tMembisikan sesuatu");
                    ShowPlayerDialog(playerid, DIALOG_HELP2, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Player", str, "Tutup", "");
                }
                case 2:
                {
                    new str[1024];
                    format(str, sizeof(str), "Perintah\tKeterangan\n/i\tMelihat isi tas\n/use [nama_item]\tMenggunakan barang di dalam tas\n/give [id] [nama_item] [jumlah_barang]\tMemberikan barang kepada player lain\n/giveweapon\tMemberikan senjata kepada player lain\n/dropweapon\tMenaruh senjata di tanah");
                    ShowPlayerDialog(playerid, DIALOG_HELP2, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Inventory", str, "Tutup", "");
                }
                case 3:
                {
                    new str[1024];
                    format(str, sizeof(str), "Perintah\tKeterangan\n/vmenu\tMengatur kendaraan\n/vfuel\tMengisi bensin kendaraan\n/vrepair\tMemperbaiki kendaraan");
                    ShowPlayerDialog(playerid, DIALOG_HELP2, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Kendaraan", str, "Tutup", "");
                }
                case 4:
                {
                    new str[1024];
                    format(str, sizeof(str), "Perintah\tKeterangan\n/fmenu\tMengatur family anda\n/buylahan\tMembeli lahan\n/lahaninfo\tMengatur lahan");
                    ShowPlayerDialog(playerid, DIALOG_HELP2, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Family", str, "Tutup", "");
                }
                case 5:
                {
                    new str[1024];
                    format(str, sizeof(str), "Badai Radiasi\nTruk Militer\nHelikopter Militer\nAirdrop");
                    ShowPlayerDialog(playerid, DIALOG_RANDOM_EVENT_HELP, DIALOG_STYLE_LIST, "Bantuan Random Event", str,"Tutup", "");
                }
            }
        }
    }
    if(dialogid == DIALOG_RANDOM_EVENT_HELP)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Badai Radiasi", ""EMBED_WHITE"Badai radiasi terjadi setiap 15 menit hingga 60 menit\nAnda harus berada di dalam safezone jika badai sedang terjadi\nPaparan yang lama akan menyebabkan "EMBED_RED"kematian perlahan","Tutup","");
                }
                case 1:
                {
                    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Truk Militer", ""EMBED_WHITE"Truk militer akan berjalan dari pelabuhan menuju ke gudang di kota kecil\nJika menghancurkannya sebuah senjata langka akan jatuh dari truk!\nPastikan punya radio dan membuat frekuensinya menjadi 1 agar dapat mengetahui informasi mengenai truk militer","Tutup","");
                }
                case 2:
                {
                    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Helikopter Militer", ""EMBED_WHITE"Helikopter militer akan berjalan dari pelabuhan menuju ke gudang di kota kecil\nJika menghancurkannya sebuah senjata langka akan jatuh dari helikopter!\nPastikan punya radio dan membuat frekuensinya menjadi 1 agar dapat mengetahui informasi mengenai helikopter militer","Tutup","");
                }
                case 3:
                {
                    ShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "Airdrop", ""EMBED_WHITE"Airdrop yang berisi 2 senjata akan drop di tempat random\nPastikan anda memiliki radio dan membuat frekuensinya ke 1 untuk mendapatkan titik jatuh!","Tutup", "");
                }
            }
        }
    }
    if(dialogid == DIALOG_ADMIN_HELP)
    {
        if(response)
        {
            switch(listitem){
                case 0:
                {
                    new str[1512];
                    format(str, sizeof(str), "Command\tDeskripsi");
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/aduty\t"EMBED_WHITE"On / off duty admin", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/spec\t"EMBED_WHITE"Spectate player", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/specoff\t"EMBED_WHITE"Stop spectating player",str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/listask\t"EMBED_WHITE"Melihat pertanyaan player", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/goto\t"EMBED_WHITE"Teleport ke player",str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/gethere\t"EMBED_WHITE"Teleport ke player",str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/jetpack\t"EMBED_WHITE"Memakai jetpack",str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/listmember\t"EMBED_WHITE"Menampilkan list anggota family",str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/checkinventory\t"EMBED_WHITE"Melihat isi tas player", str);
                    ShowPlayerDialog(playerid, DIALOG_ADMIN_HELP_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Volunteer",str, "Tutup", "");
                }
                case 1:
                {
                    new str[1024];
                    format(str, sizeof(str), "Command\tDeskripsi");
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/gotoco\t"EMBED_WHITE"Teleport ke titik tertentu", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/kick\t"EMBED_WHITE"Menendang player dari server", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/sethealth\t"EMBED_WHITE"Mengatur darah pemain", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/setarmour\t"EMBED_WHITE"Mengatur armor pemain", str);
                    ShowPlayerDialog(playerid, DIALOG_ADMIN_HELP_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Helper",str, "Tutup", "");
                    
                }
                case 2:
                {
                    new str[1024];
                    format(str, sizeof(str), "Command\tDeskripsi");
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/setitem\t"EMBED_WHITE"Mengatur item pemain", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/givemoney\t"EMBED_WHITE"Memberikan player uang", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/ban\t"EMBED_WHITE"melarang player bermain selama sejangka waktu", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/oban\t"EMBED_WHITE"melarang player bermain selama sejangka waktu ketika player offline", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/pardon\t"EMBED_WHITE"Menghapus larangan bermain", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/giveweap\t"EMBED_WHITE"Memberikan senjata sementara kepada pemain", str);
                    ShowPlayerDialog(playerid, DIALOG_ADMIN_HELP_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Junior Admin",str, "Tutup", "");
                    
                }
                case 3:
                {
                    new str[2048];
                    format(str, sizeof(str), "Command\tDeskripsi");
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/createairdrop\t"EMBED_WHITE"Mentrigger event airdrop", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/gotoairdrop\t"EMBED_WHITE"Teleport ke objek airdrop", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/starthelicopter\t"EMBED_WHITE"Mentrigger event helikopter", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/gotohelicopter\t"EMBED_WHITE"Teleport ke helikopter", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/starttruck\t"EMBED_WHITE"Mentrigger event truck", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/gototruck\t"EMBED_WHITE"Teleport ke truck", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/createfamily\t"EMBED_WHITE"Membuat organisasi atau family", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/deletefamily\t"EMBED_WHITE"Menghapus organisasi atau family", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/setfamilyleader\t"EMBED_WHITE"Menset family leader", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/kickfamilymember\t"EMBED_WHITE"Menendang player dari family", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/unsetlahan\t"EMBED_WHITE"Mereset lahan dari family", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/setweap\t"EMBED_WHITE"Menset weapon player permanen", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/createvehicle\t"EMBED_WHITE"Membuat vehicle permanen buat player", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/setvehhealth\t"EMBED_WHITE"Mengatur darah kendaraan", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/setvehmaxslot\t"EMBED_WHITE"Mengatur max slot kendaraan player", str);
                    ShowPlayerDialog(playerid, DIALOG_ADMIN_HELP_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan High Admin",str, "Tutup", "");
                    
                }
                case 4:
                {
                    new str[2048];
                    format(str, sizeof(str), "Command\tDeskripsi");
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/createlahan\t"EMBED_WHITE"Membuat lahan baru", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/deletelahan\t"EMBED_WHITE"Menghapus lahan", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/createrebel\t"EMBED_WHITE"Membuat rebel", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/listrebel\t"EMBED_WHITE"Menampilkan list rebel", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/deleterebel\t"EMBED_WHITE"Menghapus rebel", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/createtrader\t"EMBED_WHITE"Membuat trader", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/listtrader\t"EMBED_WHITE"Menampilkan list trader", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/listloot\t"EMBED_WHITE"Menampilkan list loot", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/deleteloot\t"EMBED_WHITE"Menghapus loot", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/respawnloot\t"EMBED_WHITE"Mereset loot", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/startstorm\t"EMBED_WHITE"Menjalankan badai radiasi", str);
                    format(str, sizeof(str), "%s\n"EMBED_YELLOW"/respawnraid\t"EMBED_WHITE"Mereset loot raid", str);
                    
                    ShowPlayerDialog(playerid, DIALOG_ADMIN_HELP_LIST, DIALOG_STYLE_TABLIST_HEADERS, "Bantuan Developer",str, "Tutup", "");
                    
                }
            }
        }
    }
    return 1;
}