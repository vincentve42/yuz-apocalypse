new DrinkTimer[MAX_PLAYERS];
new HungerTimer[MAX_PLAYERS];
new RadiationTimer[MAX_PLAYERS];
new LoginKickTimer[MAX_PLAYERS];
forward KickTimer(playerid);
forward LoginKick(playerid);
public LoginKick(playerid)
{
   if(isPlayerLogged[playerid]  == 0)
   {
        sendInfoMessage(playerid, "Anda di kick karena tidak melakukan register / login selama 30 detik");
        SetTimerEx("KickTimer", 3000, false, "i", playerid);
        return 1;
   }
   KillTimer(LoginKickTimer[playerid]);
   return 1;
}
stock checkBan(playerid)
{
    new playerName[128];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    new playerFile[256];
    format(playerFile, sizeof(playerFile), "Ban/%s.ini", playerName);
    if(dini_Exists(playerFile))
    {
        new year, month, day;

        year = dini_Int(playerFile, "Year");
        month = dini_Int(playerFile, "Month");
        day = dini_Int(playerFile, "Day");

        new duration = dini_Int(playerFile, "Duration");
        new str[256];

        format(str, sizeof(str), ""EMBED_RED"Akun anda dibanned!\n"EMBED_WHITE"Waktu Dibanned : %d-%d-%d\nMasa Banned : %d\nSilahkan Hubungi admin jika masa banned sudah lewat", day, month, year, duration);
        showMsgBox(playerid,"Informasi Banned", str);
        return 1;
    }
    else
    {
        return 0;
    }
}

forward GiveMoney(playerid, money);

stock GiveMoney(playerid, money)
{
    Player[playerid][pMoney] += money;
    GivePlayerMoney(playerid, money);
    return 1;
}
stock TakeMoney(playerid, money){
    Player[playerid][pMoney] -= money;
    GivePlayerMoney(playerid, -money);
    return 1;
}
stock loadAccount(playerid)
{
    new playerName[64];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    new playerFileName[64];
    format(playerFileName, sizeof(playerFileName), "acc/%s.ini", playerName);
    Player[playerid][pAdmin] = dini_Int(playerFileName,"Admin");
    Player[playerid][pX] = dini_Float(playerFileName, "X");
    Player[playerid][pY] = dini_Float(playerFileName, "Y");
    Player[playerid][pZ] = dini_Float(playerFileName, "Z");
    Player[playerid][pHealth] = dini_Float(playerFileName, "Health");
    Player[playerid][pArmour] = dini_Float(playerFileName, "Armour");
    Player[playerid][pSkin] = dini_Int(playerFileName, "Skin");
    Player[playerid][pMoney] = dini_Int(playerFileName, "Money");
    Player[playerid][pWeap1] = dini_Int(playerFileName, "Weap0");
    Player[playerid][pWeap2] = dini_Int(playerFileName, "Weap1");
    Player[playerid][pWeap3] = dini_Int(playerFileName, "Weap2");
    Player[playerid][pWeap4] = dini_Int(playerFileName, "Weap3");
    Player[playerid][pWeap5] = dini_Int(playerFileName, "Weap4");
    Player[playerid][pWeap6] = dini_Int(playerFileName, "Weap5");
    Player[playerid][pWeap7] = dini_Int(playerFileName, "Weap6");
    Player[playerid][pWeap8] = dini_Int(playerFileName, "Weap7");
    Player[playerid][pWeap9] = dini_Int(playerFileName, "Weap8");
    Player[playerid][pWeap10] = dini_Int(playerFileName, "Weap9");
    Player[playerid][pWeap11] = dini_Int(playerFileName, "Weap10");
    Player[playerid][pWeap12] = dini_Int(playerFileName, "Weap11");
    Player[playerid][pAmmo1] = dini_Int(playerFileName, "Ammo0");
    Player[playerid][pAmmo2] = dini_Int(playerFileName, "Ammo1");
    Player[playerid][pAmmo3] = dini_Int(playerFileName, "Ammo2");
    Player[playerid][pAmmo4] = dini_Int(playerFileName, "Ammo3");
    Player[playerid][pAmmo5] = dini_Int(playerFileName, "Ammo4");
    Player[playerid][pAmmo6] = dini_Int(playerFileName, "Ammo5");
    Player[playerid][pAmmo7] = dini_Int(playerFileName, "Ammo6");
    Player[playerid][pAmmo8] = dini_Int(playerFileName, "Ammo7");
    Player[playerid][pAmmo9] = dini_Int(playerFileName, "Ammo8");
    Player[playerid][pAmmo10] = dini_Int(playerFileName, "Ammo9");
    Player[playerid][pAmmo11] = dini_Int(playerFileName, "Ammo10");
    Player[playerid][pAmmo12] = dini_Int(playerFileName, "Ammo11");
    Player[playerid][pLevel] = dini_Int(playerFileName, "Level");
    Player[playerid][pXp] = dini_Int(playerFileName, "Xp");
    Player[playerid][pAdvance] = dini_Int(playerFileName, "Advance");
    Player[playerid][pScrap] = dini_Int(playerFileName, "Scrap");
    Player[playerid][pBandage] = dini_Int(playerFileName, "Bandage");
    Player[playerid][pAntibiotic] = dini_Int(playerFileName, "Antibiotic");
    Player[playerid][pInfected] = dini_Int(playerFileName, "Infected");
    Player[playerid][pPizza] = dini_Int(playerFileName, "Pizza");
    Player[playerid][pApel] = dini_Int(playerFileName, "Apel");
    Player[playerid][pDrink] = dini_Int(playerFileName, "Drink");
    Player[playerid][pGender] = dini_Int(playerFileName, "Gender");
    Player[playerid][pGasmask] = dini_Int(playerFileName, "Gasmask");
    Player[playerid][pHunger] = dini_Float(playerFileName, "Hunger");
    Player[playerid][pThrist] = dini_Float(playerFileName, "Thrist");
    Player[playerid][pRadiation] = dini_Float(playerFileName, "Radiation");
    Player[playerid][pLeftArm] = dini_Float(playerFileName, "LeftArm");
    Player[playerid][pRightArm] = dini_Float(playerFileName, "RightArm");
    Player[playerid][pLeftFoot] = dini_Float(playerFileName, "LeftFoot");
    Player[playerid][pRightFoot] = dini_Float(playerFileName, "RightFoot");
    Player[playerid][pGas] = dini_Int(playerFileName, "Gas");
    Player[playerid][pRadio] = dini_Int(playerFileName, "Radio");
    Player[playerid][pVehSlot] = dini_Int(playerFileName, "VehSlot");
    SetPlayerHealth(playerid, Player[playerid][pHealth]);
    SetPlayerArmour(playerid, Player[playerid][pArmour]);
    SetPlayerPos(playerid, Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ]);
    SetPlayerSkin(playerid, Player[playerid][pSkin]);
    GivePlayerMoney(playerid, Player[playerid][pMoney]);
    SetPlayerScore(playerid, Player[playerid][pLevel]);
    setThristVal(playerid);
	setHungerVal(playerid);
	setRadiationVal(playerid);
    Player[playerid][pFam] = getPlayerFamily(playerid, Player[playerid][pFamRank]);
    if(Player[playerid][pFam] != -1)
    {
        getPlayerRankName(playerid);
    }
    if(Player[playerid][pRadiation] <= 0)
    {
        UseGasmask[playerid] = 0;
    }
    else
    {
        UseGasmask[playerid] = 1;
    }
    return 1;
}
stock saveAccount(playerid)
{
    new playerName[64];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    new playerFileName[64];
    
    format(playerFileName, sizeof(playerFileName), "acc/%s.ini", playerName);
       
    dini_IntSet(playerFileName, "Weap0", Player[playerid][pWeap1]);
    dini_IntSet(playerFileName, "Ammo0", Player[playerid][pAmmo1]);
    dini_IntSet(playerFileName, "Weap1", Player[playerid][pWeap2]);
    dini_IntSet(playerFileName, "Ammo1", Player[playerid][pAmmo2]);
    dini_IntSet(playerFileName, "Weap2", Player[playerid][pWeap3]);
    dini_IntSet(playerFileName, "Ammo2", Player[playerid][pAmmo3]);
    dini_IntSet(playerFileName, "Weap3", Player[playerid][pWeap4]);
    dini_IntSet(playerFileName, "Ammo3", Player[playerid][pAmmo4]);
    dini_IntSet(playerFileName, "Weap4", Player[playerid][pWeap5]);
    dini_IntSet(playerFileName, "Ammo4", Player[playerid][pAmmo5]);
    dini_IntSet(playerFileName, "Weap5", Player[playerid][pWeap6]);
    dini_IntSet(playerFileName, "Ammo5", Player[playerid][pAmmo6]);
    dini_IntSet(playerFileName, "Weap6", Player[playerid][pWeap7]);
    dini_IntSet(playerFileName, "Ammo6", Player[playerid][pAmmo7]);
    dini_IntSet(playerFileName, "Weap7", Player[playerid][pWeap8]);
    dini_IntSet(playerFileName, "Ammo7", Player[playerid][pAmmo8]);
    dini_IntSet(playerFileName, "Weap8", Player[playerid][pWeap9]);
    dini_IntSet(playerFileName, "Ammo8", Player[playerid][pAmmo9]);
    dini_IntSet(playerFileName, "Weap9", Player[playerid][pWeap10]);
    dini_IntSet(playerFileName, "Ammo9", Player[playerid][pAmmo10]);
    dini_IntSet(playerFileName, "Weap10", Player[playerid][pWeap11]);
    dini_IntSet(playerFileName, "Ammo10", Player[playerid][pAmmo11]);
    dini_IntSet(playerFileName, "Weap11", Player[playerid][pWeap12]);
    dini_IntSet(playerFileName, "Ammo11", Player[playerid][pAmmo12]);
    GetPlayerPos(playerid, Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ]);
    dini_IntSet(playerFileName, "Admin", Player[playerid][pAdmin]);
    dini_FloatSet(playerFileName, "X", Player[playerid][pX]);
    dini_FloatSet(playerFileName, "Y", Player[playerid][pY]);
    dini_FloatSet(playerFileName, "Z", Player[playerid][pZ]);
    dini_FloatSet(playerFileName, "Health", Player[playerid][pHealth]);
    dini_FloatSet(playerFileName, "Armour", Player[playerid][pArmour]);
    dini_IntSet(playerFileName, "Skin", Player[playerid][pSkin]);
    dini_IntSet(playerFileName, "Money", Player[playerid][pMoney]);
    dini_IntSet(playerFileName, "Xp", Player[playerid][pXp]);
    dini_IntSet(playerFileName, "Level", Player[playerid][pLevel]);
    dini_IntSet(playerFileName, "Advance", Player[playerid][pAdvance]);
    dini_IntSet(playerFileName, "Scrap", Player[playerid][pScrap]);
    dini_IntSet(playerFileName, "Bandage", Player[playerid][pBandage]);
    dini_IntSet(playerFileName, "Antibiotic", Player[playerid][pAntibiotic]);
    dini_IntSet(playerFileName, "Infected", Player[playerid][pInfected]);
    dini_FloatSet(playerFileName, "Hunger", Player[playerid][pHunger]);
    dini_FloatSet(playerFileName, "Thrist", Player[playerid][pThrist]);
    dini_FloatSet(playerFileName, "Radiation", Player[playerid][pRadiation]);
    dini_IntSet(playerFileName, "Gasmask", Player[playerid][pGasmask]);
    dini_IntSet(playerFileName, "Drink", Player[playerid][pDrink]);
    dini_IntSet(playerFileName, "Pizza", Player[playerid][pPizza]);
    dini_IntSet(playerFileName, "Apel", Player[playerid][pApel]);
    dini_FloatSet(playerFileName, "LeftArm", Player[playerid][pLeftArm]);
    dini_FloatSet(playerFileName, "RightArm", Player[playerid][pRightArm]);
    dini_FloatSet(playerFileName, "LeftFoot", Player[playerid][pLeftFoot]);
    dini_FloatSet(playerFileName, "RightFoot", Player[playerid][pRightFoot]);
    dini_IntSet(playerFileName, "Gender", Player[playerid][pGender]);
    dini_IntSet(playerFileName, "Gas", Player[playerid][pGas]);
    dini_IntSet(playerFileName, "Radio", Player[playerid][pRadio]);
    dini_IntSet(playerFileName, "VehSlot", Player[playerid][pVehSlot]);
    return 1;
}
stock checkIfUserExist(playerid)
{
    new playerName[64];
    GetPlayerName(playerid, playerName, sizeof(playerName));
    new playerFileName[64];
    format(playerFileName, sizeof(playerFileName), "acc/%s.ini", playerName);

    if(dini_Exists(playerFileName))
    {
        return 1;
    }
    return 0;  
}

public KickTimer(playerid){
    Kick(playerid);
    return 1;
}

public OnPlayerSpawn(playerid)
{
    if(!IsPlayerNPC(playerid))
    {
        
        if(playerIsDead[playerid] == 1){
             
             playerIsDead[playerid] = 0;
             SetPlayerSkin(playerid, Player[playerid][pSkin]);
             SetPlayerPos(playerid, Player[playerid][pX], Player[playerid][pY], Player[playerid][pZ]);
             Player[playerid][pHealth] = 100;
             Player[playerid][pArmour] = 0;
             Player[playerid][pRadiation] = 100;
             Player[playerid][pHunger] = 100;
             Player[playerid][pThrist] = 100;
             Player[playerid][pLeftFoot] = 100.0;
             Player[playerid][pRightFoot] = 100.0;
             Player[playerid][pRightArm] = 100.0;
             Player[playerid][pLeftArm] = 100.0;
             SetPlayerHealth(playerid, Player[playerid][pHealth]);
             setRadiationVal(playerid);
             setHungerVal(playerid);
             setThristVal(playerid);
             Player[playerid][pInfected] = 0;
             new rand = random(3);

             switch(rand){
                case 0:{
                    SetPlayerPos(playerid, 2282.6858, 64.3713, 26.4844);
                }
                case 1:{
                    SetPlayerPos(playerid, -2276.4111, 2346.8958, 4.9692);
                }
                case 2:{
                    SetPlayerPos(playerid, -2133.9175, -2429.9802,30.6250);
                }
             }
             return 1;
        }
        
        if(isPlayerLogged[playerid] == 0)
        {
            Kick(playerid);
        }
        if(isPlayerLogged[playerid] == 1 && Logged[playerid] == 0)
        {
            if(checkBan(playerid) == 1)
            {
                SetTimerEx("KickTimer", 3000, false, "i", playerid);
                Logged[playerid] = 0;
                return 1;
            }
            
            loadAccount(playerid);
            Logged[playerid] = 1;
            DrinkTimer[playerid] = SetTimerEx("updateDrink",30000, true, "i", playerid);
            HungerTimer[playerid] = SetTimerEx("updateHunger",32000, true, "i", playerid);
            RadiationTimer[playerid] = SetTimerEx("updateRadiation",25000, true, "i", playerid);
            new playerNames[MAX_PLAYER_NAME];
            GetPlayerName(playerid, playerNames, sizeof(playerNames));
            new playerLabel[128];
            format(playerLabel, sizeof(playerLabel), "[%d] %s", playerid, playerNames);
            player3DTextLabel[playerid] = CreateDynamic3DTextLabel(playerLabel, -1, 0, 0, 0.1, 15.0, playerid);
            
        }
        if(isPlayerLogged[playerid] == 2 && Logged[playerid] == 0 && stepRegister[playerid] == 2)
        {
        
            Player[playerid][pHealth] = 100; 
            SetPlayerSkin(playerid, Player[playerid][pSkin]);

            SetPlayerPos(playerid,-2119.9622,-2411.3245,31.2330);
            Player[playerid][pLevel] = 1;
            Player[playerid][pAdvance] = 1000;
            SetPlayerScore(playerid, 1);
            Logged[playerid] = 1;
            GiveMoney(playerid, 50000);
            Player[playerid][pBandage] += 10;
            Player[playerid][pAntibiotic] += 5;
            Player[playerid][pPizza] += 50;
            Player[playerid][pDrink] += 50;
            Player[playerid][pWeap1] = 22;
            Player[playerid][pAmmo1] = 100;
            Player[playerid][pRadiation] = 100;
            Player[playerid][pHunger] = 100;
            Player[playerid][pThrist] = 100;
            Player[playerid][pGasmask] = 2;
            Player[playerid][pGas] = 5;
            Player[playerid][pLeftArm] = 100.0;
            Player[playerid][pRightArm] = 100.0;
            Player[playerid][pLeftFoot] = 100.0;
            Player[playerid][pRightFoot] = 100.0;
            Player[playerid][pVehSlot] = 3;
            DrinkTimer[playerid] = SetTimerEx("updateDrink",10000, true, "i", playerid);
            HungerTimer[playerid] = SetTimerEx("updateHunger",12000, true, "i", playerid);
            RadiationTimer[playerid] = SetTimerEx("updateRadiation",15000, true, "i", playerid);
            sendSuccessMessage(playerid, "Anda telah menyelesaikan proses pendaftaran");
            new playerNames[MAX_PLAYER_NAME];
            GetPlayerName(playerid, playerNames, sizeof(playerNames));
            new playerLabel[128];
            format(playerLabel, sizeof(playerLabel), "[%d] %s", playerid, playerNames);
            player3DTextLabel[playerid] = CreateDynamic3DTextLabel(playerLabel, -1, 0, 0, 0.1, 15.0, playerid);
            
            

        }
        if(isPlayerLogged[playerid] == 2 && Logged[playerid] == 0 && stepRegister[playerid] < 2)
        {
        
            new playerName[64];
            GetPlayerName(playerid, playerName, sizeof(playerName));
            new playerFileName[64];
            format(playerFileName, sizeof(playerFileName), "acc/%s.ini", playerName);

            if(dini_Exists(playerFileName))
            {
                dini_Remove(playerFileName);
                SetTimerEx("KickTimer", 3000, false, "i", playerid);
                sendInfoMessage(playerid, "Anda tidak mengikuti proses pendaftaran dengan benar");

                return 1;
            }
        }
    }
   
    return 1;
}
public OnPlayerConnect(playerid){
    if(!IsPlayerNPC(playerid))
    {
        playerTogPm[playerid] = 0;
        playerIsDead[playerid] = 0;
        pRegistered[playerid] = false;
        LoginKickTimer[playerid] = SetTimerEx("LoginKick", 30000, false, "i", playerid);
        rmBuilding(playerid);
        playerActivity[playerid] = 0;
        Logged[playerid] = 0;
        new playerName[64];
        GetPlayerName(playerid, playerName, sizeof(playerName));
        isPlayerLogged[playerid] = 0;
        tryPassword[playerid] = 0;
        new userExist = checkIfUserExist(playerid);
        SendClientMessage(playerid, COLOR_WHITE, "Halo survivor selamat datang di server "EMBED_YELLOW"Nuclear apocalypse");
        
        if(userExist == 0)
        {
            PlayerIsNotRegistered(playerid);
            ShowLoginTextDraws(playerid);
            
        }
        if(userExist == 1)
        {
            PlayerIsRegistered(playerid);
            checkBan(playerid);
            ShowLoginTextDraws(playerid);
        }  
    }
    return 1;
}
public OnPlayerDisconnect(playerid, reason){
    if(!IsPlayerNPC(playerid)){
        if(isPlayerLogged[playerid] != 0 && Logged[playerid] != 0)
        {
            saveAccount(playerid);
            KillTimer(DrinkTimer[playerid]);
            KillTimer(HungerTimer[playerid]);
            KillTimer(RadiationTimer[playerid]);
            pRegistered[playerid] = false;
            KillTimer(realtimer[playerid]);
            KillTimer(LoginKickTimer[playerid]);
            if(IsValidDynamic3DTextLabel(player3DTextLabel[playerid]))
                DestroyDynamic3DTextLabel(player3DTextLabel[playerid]);
        }
    }
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    playerIsDead[playerid] = 1;
    return 1;
}
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart){
    return 1;
}
hook OnGameModeExit(){
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        Kick(i);
    }
}