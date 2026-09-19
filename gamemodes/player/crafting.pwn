new selectedWeaponToCraft[MAX_PLAYERS];
new AmmoToCraft[MAX_PLAYERS];
stock getAmmoPrice(weapon, ammo){
    switch(weapon){
        case 22:
        {
            return 2 * ammo;
        }
        case 23:
        {
            return 2 * ammo;
        }
        case 24:
        {
            return 10 * ammo;
        }
        case 25:
        {
            return 3 * ammo;
        }
        case 26:
        {
            return 3 * ammo;
        }
        case 27:
        {
            return 3 * ammo;
        }
        case 28:
        {
            return 1 * ammo;
        }
        case 32:
        {
            return 1 * ammo;
        }
        case 29:
        {
            return 2 * ammo;
        }
        case 30:
        {
            return 4 * ammo;
        }
        case 31:
        {
            return 4 * ammo;
        }
        case 33:
        {
            return 15 * ammo;
        }
        case 34:
        {
            return 15 * ammo;
        }
        
    }
    return -1;
}
stock getWeaponPrice(weapon)
{
    switch(weapon){
        case 22:
        {
            return 2000;
        }
        case 25:
        {
            return 5000;
        }
        case 28:
        {
            return 4000;
        }
        case 33:
        {
            return 7000;
        }
        
    }
    return -1;
}
forward updateWeaponCraftingProgress(playerid, Float:bar, weapon);
public updateWeaponCraftingProgress(playerid, Float:bar, weapon)
{
    ActivityProgress[playerid] += bar;
    SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
    if(ActivityProgress[playerid] >= 100)
    {
        if(isWeapFull(playerid))
        {
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            return sendErrorMessage(playerid, "Slot senjata anda full");
        }
        new weapName[64];
        GetWeaponName(weapon, weapName, sizeof(weapName));
        new success[128];
        format(success, sizeof(success), "Sukses membuat senjata %s", weapName);
        sendSuccessMessage(playerid, success);
        setWeapon(playerid, weapon);
        KillTimer(ActivityTimer[playerid]);
        TogglePlayerControllable(playerid, 1);
        hideActivityTextDraw(playerid);
        playerActivity[playerid] = 0;
    }
    return 1;
}
forward updateAmmoCraftingProgress(playerid, Float:bar, weapon, ammo);
public updateAmmoCraftingProgress(playerid, Float:bar, weapon, ammo)
{
    ActivityProgress[playerid] += bar;
    SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
    if(ActivityProgress[playerid] >= 100)
    {
        if(!isWeapHaveSameModel(playerid, weapon))
        {
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            return sendErrorMessage(playerid, "Slot senjata anda full");
        }
        new weapName[64];
        GetWeaponName(weapon, weapName, sizeof(weapName));
        new success[128];
        format(success, sizeof(success), "Sukses membuat ammo sebanyak %d senjata %s",ammo, weapName);
        sendSuccessMessage(playerid, success);
        if(Player[playerid][pWeap1] == selectedWeaponToCraft[playerid]){
            Player[playerid][pAmmo1] += AmmoToCraft[playerid];
            printf("%d", AmmoToCraft[playerid]);
        }
        if(Player[playerid][pWeap2] == selectedWeaponToCraft[playerid]){
            Player[playerid][pAmmo2] += AmmoToCraft[playerid];
            printf("%d", AmmoToCraft[playerid]);
        }
        if(Player[playerid][pWeap3] == selectedWeaponToCraft[playerid]){
            Player[playerid][pAmmo3] += AmmoToCraft[playerid];
            printf("%d", AmmoToCraft[playerid]);
        }
        KillTimer(ActivityTimer[playerid]);
        TogglePlayerControllable(playerid, 1);
        hideActivityTextDraw(playerid);
        playerActivity[playerid] = 0;
        selectedWeaponToCraft[playerid] = -1;
        AmmoToCraft[playerid] = -1;
    }
    return 1;
}
forward updateRadioCraftingProgress(playerid, Float:bar);
public updateRadioCraftingProgress(playerid, Float:bar)
{
    ActivityProgress[playerid] += bar;
    SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
    if(ActivityProgress[playerid] >= 100)
    {
        sendSuccessMessage(playerid, "Anda berhasil membuat sebuah radio");
        Player[playerid][pRadio] += 1;
        KillTimer(ActivityTimer[playerid]);
        TogglePlayerControllable(playerid, 1);
        hideActivityTextDraw(playerid);
        playerActivity[playerid] = 0;
    }
    return 1;
}
stock setWeaponCraftingActivity(playerid, weaponid)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
   
    ActivityProgress[playerid] = 0.0;
    showPlayerActivityTextdraw(playerid);
    TogglePlayerControllable(playerid, false);
    playerActivity[playerid] = 1;
    ApplyAnimation(playerid,"ROB_BANK", "CAT_Safe_Rob",4.1, 0,0,0,0, 10000,1);
    new weapName[64];
    GetWeaponName(playerid, weapName, sizeof(weapName));
    new str[128];
    format(str, sizeof(str), "Mencoba membuat senjata %s", weapName);
    sendInfoMessage(playerid, str);
    ActivityTimer[playerid] = SetTimerEx("updateWeaponCraftingProgress", 1000, true, "ifd", playerid, 10.0, weaponid);
    return 1;
}
stock setAmmoCraftingActivity(playerid, weaponid, ammo)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
   
    ActivityProgress[playerid] = 0.0;
    showPlayerActivityTextdraw(playerid);
    TogglePlayerControllable(playerid, false);
    playerActivity[playerid] = 1;
    new weapName[64];
    GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
    new str[128];
    format(str, sizeof(str), "Mencoba membuat ammo senjata %s sebanyak %d", weapName, ammo);
    sendInfoMessage(playerid, str);
    ApplyAnimation(playerid,"ROB_BANK", "CAT_Safe_Rob",4.1, 0,0,0,0, 10000,1);
    ActivityTimer[playerid] = SetTimerEx("updateAmmoCraftingProgress", 1000, true, "ifdd", playerid, 10.0, weaponid, ammo);
    return 1;
}
stock setRadioCraftingActivity(playerid)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
   
    ActivityProgress[playerid] = 0.0;
    showPlayerActivityTextdraw(playerid);
    TogglePlayerControllable(playerid, false);
    playerActivity[playerid] = 1;
    new weapName[64];
    GetWeaponName(playerid, weapName, sizeof(weapName));
    new str[128];
    format(str, sizeof(str), "Mencoba membuat sebuah radio");
    sendInfoMessage(playerid, str);
    ApplyAnimation(playerid,"ROB_BANK", "CAT_Safe_Rob",4.1, 0,0,0,0, 10000,1);
    ActivityTimer[playerid] = SetTimerEx("updateRadioCraftingProgress", 1000, true, "if", playerid, 10.0);
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/craft", true)){
        new weaponstr[256];
        format(weaponstr, sizeof(weaponstr), "Nama Item\tJumlah Scrap\n"EMBED_WHITE"Pistol 9mm\t"EMBED_YELLOW"%d\n"EMBED_WHITE"Shotgun\t"EMBED_YELLOW"%d"EMBED_WHITE"\n"EMBED_WHITE"Tec-9\t"EMBED_YELLOW"%d"EMBED_WHITE"\n"EMBED_WHITE"Rifle\t"EMBED_YELLOW"%d"EMBED_WHITE"\n"EMBED_WHITE"Radio\t"EMBED_YELLOW"%d", getWeaponPrice(22), getWeaponPrice(25), getWeaponPrice(28), getWeaponPrice(33), 500);
        new str[1024];
        format(str, sizeof(str), "%s", weaponstr);
        if(Player[playerid][pWeap1] >= 22 && Player[playerid][pWeap1] <= 34)
        {
            new weap1Name[64];
            GetWeaponName(Player[playerid][pWeap1], weap1Name, sizeof(weap1Name));

            format(str, sizeof(str), "%s\n"EMBED_WHITE"%s 1x Ammo\t"EMBED_YELLOW"%d", str, weap1Name, getAmmoPrice(Player[playerid][pWeap1], 1));
        }
        if(Player[playerid][pWeap2] >= 22 && Player[playerid][pWeap2] <= 34)
        {
            new weap2Name[64];
            GetWeaponName(Player[playerid][pWeap2], weap2Name, sizeof(weap2Name));

            format(str, sizeof(str), "%s\n"EMBED_WHITE"%s 1x Ammo\t"EMBED_YELLOW"%d", str, weap2Name, getAmmoPrice(Player[playerid][pWeap2], 1));
        }
        if(Player[playerid][pWeap3] >= 22 && Player[playerid][pWeap3] <= 34)
        {
            new weap3Name[64];
            GetWeaponName(Player[playerid][pWeap3], weap3Name, sizeof(weap3Name));

            format(str, sizeof(str), "%s\n"EMBED_WHITE"%s 1x Ammo\t"EMBED_YELLOW"%d", str, weap3Name, getAmmoPrice(Player[playerid][pWeap3], 1));
        }
        
        ShowPlayerDialog(playerid, DIALOG_CRAFTING, DIALOG_STYLE_TABLIST_HEADERS, "Crafting", str, "Craft", "Batal");
        return 1;
    }   
    return 0;
}
hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    if(dialogid == DIALOG_CRAFTING)
    {
        if(response){
            if(listitem >= 5)
            {
                switch(listitem)
                {
                    case 5:
                    {
                        
                        if(Player[playerid][pWeap1] >= 22 && Player[playerid][pWeap1] <= 34)
                        {
                            selectedWeaponToCraft[playerid] = Player[playerid][pWeap1];
                            new weapName[64];
                            GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                            new str[256];
                            format(str, sizeof(str),"Masukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);
                            ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
                            return 1;
                        }
                        if(Player[playerid][pWeap2] >= 22 && Player[playerid][pWeap2] <= 34)
                        {
                            selectedWeaponToCraft[playerid] = Player[playerid][pWeap2];
                            new weapName[64];
                            GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                            new str[256];
                            format(str, sizeof(str),"Masukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);
                            ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjutkan", "Batal");
                            return 1;
                        }
                        if(Player[playerid][pWeap3] >= 22 && Player[playerid][pWeap3] <= 34)
                        {
                            selectedWeaponToCraft[playerid] = Player[playerid][pWeap3];
                            new weapName[64];
                            GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                            new str[256];
                            format(str, sizeof(str),"Masukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);
                            ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
                            return 1;
                        }
                    }
                    case 6:
                    {
                        if(Player[playerid][pWeap2] >= 22 && Player[playerid][pWeap2] <= 34)
                        {
                            selectedWeaponToCraft[playerid] = Player[playerid][pWeap2];
                            new weapName[64];
                            GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                            new str[256];
                            format(str, sizeof(str),"Masukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);
                            ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
                            return 1;
                        }
                        if(Player[playerid][pWeap3] >= 22 && Player[playerid][pWeap3] <= 34)
                        {
                            selectedWeaponToCraft[playerid] = Player[playerid][pWeap3];
                            new weapName[64];
                            GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                            new str[256];
                            format(str, sizeof(str),"Masukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);
                            ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
                            return 1;
                        }
                    }
                    case 7:
                    {
                        if(Player[playerid][pWeap3] >= 22 && Player[playerid][pWeap3] <= 34)
                        {
                            selectedWeaponToCraft[playerid] = Player[playerid][pWeap3];
                            new weapName[64];
                            GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                            new str[256];
                            format(str, sizeof(str),"Masukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);
                            ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
                            return 1;
                        }
                    }
                }
                
                return 1;
            }
            switch(listitem)
            {
                case 0:
                {
                    new weapid = 22;
                    new price = getWeaponPrice(weapid);
                    new weapName[64];
                    GetWeaponName(weapid, weapName, sizeof(weapName));
                    if(Player[playerid][pScrap] < price){
                        new error[128];
                        format(error,sizeof(error), "Anda tidak memiliki cukup scrap untuk membuat %s", weapName);
                        return sendErrorMessage(playerid, error);
                    }
                    if(isWeapFull(playerid))
                    {
                        return sendErrorMessage(playerid, "Slot senjata anda penuh");
                    }
                    selectedWeaponToCraft[playerid] = weapid;
                    new str[256];
                    format(str, sizeof(str), "Apakah anda ingin membuat senjata "EMBED_RED"%s"EMBED_WHITE" dengan menggunakan "EMBED_YELLOW"%d "EMBED_WHITE"scrap?", weapName, price);
                    ShowPlayerDialog(playerid, DIALOG_CRAFTING_CONFIRM, DIALOG_STYLE_MSGBOX, "Crafting Senjata", str,"Ya","Batal");
                }
                case 1:
                {
                    
                    new weapid = 25;
                    new price = getWeaponPrice(weapid);
                    new weapName[64];
                    GetWeaponName(weapid, weapName, sizeof(weapName));
                    if(Player[playerid][pScrap] < price){
                        new error[128];
                        format(error,sizeof(error), "Anda tidak memiliki cukup scrap untuk membuat %s", weapName);
                        return sendErrorMessage(playerid, error);
                    }
                    if(isWeapFull(playerid))
                    {
                        return sendErrorMessage(playerid, "Slot senjata anda penuh");
                    }
                    selectedWeaponToCraft[playerid] = weapid;
                    new str[256];
                    format(str, sizeof(str), "Apakah anda ingin membuat senjata "EMBED_RED"%s"EMBED_WHITE" dengan menggunakan "EMBED_YELLOW"%d "EMBED_WHITE"scrap?", weapName, price);
                    ShowPlayerDialog(playerid, DIALOG_CRAFTING_CONFIRM, DIALOG_STYLE_MSGBOX, "Crafting Senjata", str,"Ya","Batal");
                }
                case 2:
                {
                    new weapid = 28;
                    new price = getWeaponPrice(weapid);
                    new weapName[64];
                    GetWeaponName(weapid, weapName, sizeof(weapName));
                    if(Player[playerid][pScrap] < price){
                        new error[128];
                        format(error,sizeof(error), "Anda tidak memiliki cukup scrap untuk membuat %s", weapName);
                        return sendErrorMessage(playerid, error);
                    }
                    if(isWeapFull(playerid))
                    {
                        return sendErrorMessage(playerid, "Slot senjata anda penuh");
                    }
                    selectedWeaponToCraft[playerid] = weapid;
                    new str[256];
                    format(str, sizeof(str), "Apakah anda ingin membuat senjata "EMBED_RED"%s"EMBED_WHITE" dengan menggunakan "EMBED_YELLOW"%d "EMBED_WHITE"scrap?", weapName, price);
                    ShowPlayerDialog(playerid, DIALOG_CRAFTING_CONFIRM, DIALOG_STYLE_MSGBOX, "Crafting Senjata", str,"Ya","Batal");
                }
                case 3:
                {
                    new weapid = 33;
                    new price = getWeaponPrice(weapid);
                    new weapName[64];
                    GetWeaponName(weapid, weapName, sizeof(weapName));
                    if(Player[playerid][pScrap] < price){
                        new error[128];
                        format(error,sizeof(error), "Anda tidak memiliki cukup scrap untuk membuat %s", weapName);
                        return sendErrorMessage(playerid, error);
                    }
                    if(isWeapFull(playerid))
                    {
                        return sendErrorMessage(playerid, "Slot senjata anda penuh");
                    }
                    selectedWeaponToCraft[playerid] = weapid;
                    new str[256];
                    format(str, sizeof(str), "Apakah anda ingin membuat senjata "EMBED_RED"%s"EMBED_WHITE" dengan menggunakan "EMBED_YELLOW"%d "EMBED_WHITE"scrap?", weapName, price);
                    ShowPlayerDialog(playerid, DIALOG_CRAFTING_CONFIRM, DIALOG_STYLE_MSGBOX, "Crafting Senjata", str,"Ya","Batal");
                }
                case 4:{
                    new price = 500;
                    if(Player[playerid][pScrap] < price){
                        return sendErrorMessage(playerid, "Anda tidak memiliki cukup scrap untuk membuat radio");
                    }
                    ShowPlayerDialog(playerid, DIALOG_CRAFT_RADIO, DIALOG_STYLE_MSGBOX, "Crafting Radio", "Apakah anda ingin membuat sebuah "EMBED_YELLOW"radio"EMBED_WHITE" dengan menggunakan 500 scrap?","Ya","Batal");

                }
                
            }
        }
    }
    if(dialogid == DIALOG_CRAFT_RADIO)
    {
        if(response){
            new price = 500;
            if(Player[playerid][pScrap] < price){
                return sendErrorMessage(playerid, "Anda tidak memiliki cukup scrap untuk membuat radio");
            }
            Player[playerid][pScrap] -= price;
            setRadioCraftingActivity(playerid);
        }
        if(!response){

        }
    }
    if(dialogid == DIALOG_CRAFTING_CONFIRM)
    {
        if(response){
            new weapid = selectedWeaponToCraft[playerid];
            new price = getWeaponPrice(weapid);
            new weapName[64];
            GetWeaponName(weapid, weapName, sizeof(weapName));
            if(Player[playerid][pScrap] < price){
                selectedWeaponToCraft[playerid] = -1;
                new error[128];
                format(error,sizeof(error), "Anda tidak memiliki cukup scrap untuk membuat %s", weapName);
                return sendErrorMessage(playerid, error);
            }
            if(isWeapFull(playerid))
            {
                selectedWeaponToCraft[playerid] = -1;
                return sendErrorMessage(playerid, "Slot senjata anda penuh");
            }
            Player[playerid][pScrap] -= price;
            setWeaponCraftingActivity(playerid, selectedWeaponToCraft[playerid]);
            selectedWeaponToCraft[playerid] = -1;
        }
        if(!response){
            selectedWeaponToCraft[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_CRAFTING_AMMO)
    {
        if(response){
            new amount;
            new weapName[64];
            if(sscanf(inputtext, "d", amount))
            {   
                GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                new str[512];
                format(str, sizeof(str),""EMBED_RED"[ERROR]"EMBED_WHITE" Masukan angka yang valid\nMasukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);       
                return ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
            }
            if(amount > 500 || amount <= 0)
            {
                GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                new str[512];
                format(str, sizeof(str),""EMBED_RED"[ERROR]"EMBED_WHITE" Masukan jumlah ammo [0-500]\nMasukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);       
                return ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
            }
            if(Player[playerid][pScrap] < getAmmoPrice(selectedWeaponToCraft[playerid], amount))
            {
                GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                new str[512];
                format(str, sizeof(str),""EMBED_RED"[ERROR]"EMBED_WHITE" Scrap anda tidak cukup\nMasukan jumlah ammo senjata "EMBED_YELLOW"%s"EMBED_WHITE" yang ingin dibuat", weapName);       
                return ShowPlayerDialog(playerid, DIALOG_CRAFTING_AMMO, DIALOG_STYLE_INPUT, "Crafting Ammo", str, "Lanjut", "Batal");
            }
            AmmoToCraft[playerid] = amount;
            GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
            new str2[512];
            format(str2, sizeof(str2), "Apakah anda ingin membuat %dx ammo senjata"EMBED_YELLOW" %s "EMBED_WHITE"dengan menggunakan "EMBED_GREEN"%d "EMBED_WHITE"scrap?",AmmoToCraft[playerid],weapName, getAmmoPrice(selectedWeaponToCraft[playerid], amount));
            ShowPlayerDialog(playerid,DIALOG_CRAFTING_AMMO_CONFIRM, DIALOG_STYLE_MSGBOX, "Crafting Ammo", str2, "Ya", "Batal");
        }
        if(!response){
            selectedWeaponToCraft[playerid] = -1;
        }
    }
    if(dialogid == DIALOG_CRAFTING_AMMO_CONFIRM){
        if(response){
            
            if(isWeapHaveSameModel(playerid,selectedWeaponToCraft[playerid]) == 0)
            {
                new weapName[64];
                GetWeaponName(selectedWeaponToCraft[playerid], weapName, sizeof(weapName));
                new str[128];
                format(str, sizeof(str), "Anda tidak memiliki senjata %s", weapName);
                selectedWeaponToCraft[playerid] = -1;
                AmmoToCraft[playerid] = -1;
                return sendErrorMessage(playerid, str);
            }
            
            new price = getAmmoPrice(selectedWeaponToCraft[playerid], AmmoToCraft[playerid]);
            if(Player[playerid][pScrap] < price){
                selectedWeaponToCraft[playerid] = -1;
                AmmoToCraft[playerid] = -1;
                return sendErrorMessage(playerid, "Scrap anda tidak cukup!");
            }
            Player[playerid][pScrap] -= price;
            setAmmoCraftingActivity(playerid, selectedWeaponToCraft[playerid], AmmoToCraft[playerid]);
            

        }
        if(!response){
            selectedWeaponToCraft[playerid] = -1;
            AmmoToCraft[playerid] = -1;
        }
    }
    return 1;
}