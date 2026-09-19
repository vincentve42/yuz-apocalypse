#include <YSI_Coding\y_hooks>

new PlayerText:td_proses[MAX_PLAYERS];
new PlayerBar:activity_bar[MAX_PLAYERS];
// Activity TextDraw Properties
new playerActivity[MAX_PLAYERS];
new Float:ActivityProgress[MAX_PLAYERS];
new ActivityTimer[MAX_PLAYERS];
// Nama Server
new Text:namaserver4;
new Text:nameserver5;
new PlayerText:namaserver1[MAX_PLAYERS];
new PlayerText:namaserver2[MAX_PLAYERS];

// Zone Info

new PlayerText:terkontaminasi[MAX_PLAYERS];
new PlayerText:areaman[MAX_PLAYERS];
// HUD

new PlayerText:hungertd[MAX_PLAYERS];
new PlayerText:drinktd[MAX_PLAYERS];
new PlayerText:drinkvaluetd[MAX_PLAYERS];
new PlayerText:radiationvaluetd[MAX_PLAYERS];
new PlayerText:radiationtd[MAX_PLAYERS];
new PlayerText:Makan[MAX_PLAYERS];

// Login
#define LT_ServerName "Yuz Apocalypse"
#define LoginTextDrawColor 0xFF0000FF
#define TextDrawHoverColor 0x80FF80FF
#define RandomLoginColors //Uncomment if you want to have Random Colors for each player

new Text:GlobalLoginTextDraw[29],
PlayerText:PlayerLoginTextDraw[MAX_PLAYERS][4],
realtimer[MAX_PLAYERS],
bool:pRegistered[MAX_PLAYERS];
//
new PlayerText:lootinfotd[MAX_PLAYERS];

#if defined RandomLoginColors

static RandomLoginColorsArray[] = 
{
  0xFF0000FF, //Light Red
  0x5E0000FF, //Dark Red
  0x80FF00FF, //Light Green
  0x005100FF, //Dark Green
  0x0080C0FF, //Light Blue
  0x000088FF, //Dark Blue
  0xFFFFFFFF, //White
  0x9E9E9EFF //Light Grey
};

#endif

hook OnGameModeInit()
{
    nameserver5 = TextDrawCreate(328.000000, 15.000000, "ld_dual:ex2");
    TextDrawFont(nameserver5, 4);
    TextDrawLetterSize(nameserver5, 0.600000, 2.000000);
    TextDrawTextSize(nameserver5, 26.000000, 26.500000);
    TextDrawSetOutline(nameserver5, 1);
    TextDrawSetShadow(nameserver5, 0);
    TextDrawAlignment(nameserver5, 1);
    TextDrawColor(nameserver5, -1);
    TextDrawBackgroundColor(nameserver5, 255);
    TextDrawBoxColor(nameserver5, 50);
    TextDrawUseBox(nameserver5, 1);
    TextDrawSetProportional(nameserver5, 1);
    TextDrawSetSelectable(nameserver5, 0);

    namaserver4 = TextDrawCreate(288.000000, 30.000000, "Apocalypse");
    TextDrawFont(namaserver4, 1);
    TextDrawLetterSize(namaserver4, 0.308333, 1.249999);
    TextDrawTextSize(namaserver4, 400.000000, 17.000000);
    TextDrawSetOutline(namaserver4, 1);
    TextDrawSetShadow(namaserver4, 0);
    TextDrawAlignment(namaserver4, 1);
    TextDrawColor(namaserver4, -1);
    TextDrawBackgroundColor(namaserver4, 255);
    TextDrawBoxColor(namaserver4, 50);
    TextDrawUseBox(namaserver4, 0);
    TextDrawSetProportional(namaserver4, 1);
    TextDrawSetSelectable(namaserver4, 0);

	  CreateGlobalLoginTextDraws();

    return 1;
}
hook OnGameModeExit()
{
    TextDrawDestroy(namaserver4);
	  TextDrawDestroy(nameserver5);
    return 1;
}
hook OnPlayerConnect(playerid)
{
    pRegistered[playerid] = false;
    CreatePlayerLoginTextDraws(playerid);
    lootinfotd[playerid] = CreatePlayerTextDraw(playerid, 423.000000, 332.000000, "[LOOT] Tekan N untuk berinteraksi");
    PlayerTextDrawFont(playerid, lootinfotd[playerid], 1);
    PlayerTextDrawLetterSize(playerid, lootinfotd[playerid], 0.212500, 1.200000);
    PlayerTextDrawTextSize(playerid, lootinfotd[playerid], 560.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, lootinfotd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, lootinfotd[playerid], 0);
    PlayerTextDrawAlignment(playerid, lootinfotd[playerid], 1);
    PlayerTextDrawColor(playerid, lootinfotd[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, lootinfotd[playerid], 255);
    PlayerTextDrawBoxColor(playerid, lootinfotd[playerid], 50);
    PlayerTextDrawUseBox(playerid, lootinfotd[playerid], 1);
    PlayerTextDrawSetProportional(playerid, lootinfotd[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, lootinfotd[playerid], 0);


    td_proses[playerid] = CreatePlayerTextDraw(playerid, 275.000000, 349.000000, "Memproses...");
    PlayerTextDrawFont(playerid, td_proses[playerid], 1);
    PlayerTextDrawLetterSize(playerid, td_proses[playerid], 0.400000, 1.650000);
    PlayerTextDrawTextSize(playerid, td_proses[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, td_proses[playerid], 1);
    PlayerTextDrawSetShadow(playerid, td_proses[playerid], 0);
    PlayerTextDrawAlignment(playerid, td_proses[playerid], 1);
    PlayerTextDrawColor(playerid, td_proses[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, td_proses[playerid], 255);
    PlayerTextDrawBoxColor(playerid, td_proses[playerid], 50);
    PlayerTextDrawUseBox(playerid, td_proses[playerid], 0);
    PlayerTextDrawSetProportional(playerid, td_proses[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, td_proses[playerid], 0);

    activity_bar[playerid] = CreatePlayerProgressBar(playerid, 268.000000, 369.000000, 103.500000, 9.500000, 16711935, 100.000000, 0);
    SetPlayerProgressBarValue(playerid, activity_bar[playerid], 0.000000);

    namaserver1[playerid] = CreatePlayerTextDraw(playerid, 264.000000, 12.000000, "ld_dual:rockshp");
    PlayerTextDrawFont(playerid, namaserver1[playerid], 4);
    PlayerTextDrawLetterSize(playerid, namaserver1[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, namaserver1[playerid], 29.000000, 28.500000);
    PlayerTextDrawSetOutline(playerid, namaserver1[playerid], 1);
    PlayerTextDrawSetShadow(playerid, namaserver1[playerid], 0);
    PlayerTextDrawAlignment(playerid, namaserver1[playerid], 1);
    PlayerTextDrawColor(playerid, namaserver1[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, namaserver1[playerid], 255);
    PlayerTextDrawBoxColor(playerid, namaserver1[playerid], 50);
    PlayerTextDrawUseBox(playerid, namaserver1[playerid], 0);
    PlayerTextDrawSetProportional(playerid, namaserver1[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, namaserver1[playerid], 0);

    namaserver2[playerid] = CreatePlayerTextDraw(playerid, 286.000000, 13.000000, "Yuz");
    PlayerTextDrawFont(playerid, namaserver2[playerid], 1);
    PlayerTextDrawLetterSize(playerid, namaserver2[playerid], 0.533333, 2.099998);
    PlayerTextDrawTextSize(playerid, namaserver2[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, namaserver2[playerid], 1);
    PlayerTextDrawSetShadow(playerid, namaserver2[playerid], 0);
    PlayerTextDrawAlignment(playerid, namaserver2[playerid], 1);
    PlayerTextDrawColor(playerid, namaserver2[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, namaserver2[playerid], 255);
    PlayerTextDrawBoxColor(playerid, namaserver2[playerid], 50);
    PlayerTextDrawUseBox(playerid, namaserver2[playerid], 0);
    PlayerTextDrawSetProportional(playerid, namaserver2[playerid], 0);
    PlayerTextDrawSetSelectable(playerid, namaserver2[playerid], 0);

    terkontaminasi[playerid] = CreatePlayerTextDraw(playerid, 29.000000, 312.000000, "Area Terkontaminasi");
    PlayerTextDrawFont(playerid, terkontaminasi[playerid], 1);
    PlayerTextDrawLetterSize(playerid, terkontaminasi[playerid], 0.291666, 1.450000);
    PlayerTextDrawTextSize(playerid, terkontaminasi[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, terkontaminasi[playerid], 1);
    PlayerTextDrawSetShadow(playerid, terkontaminasi[playerid], 0);
    PlayerTextDrawAlignment(playerid, terkontaminasi[playerid], 1);
    PlayerTextDrawColor(playerid, terkontaminasi[playerid], -16776961);
    PlayerTextDrawBackgroundColor(playerid, terkontaminasi[playerid], 255);
    PlayerTextDrawBoxColor(playerid, terkontaminasi[playerid], 50);
    PlayerTextDrawUseBox(playerid, terkontaminasi[playerid], 0);
    PlayerTextDrawSetProportional(playerid, terkontaminasi[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, terkontaminasi[playerid], 0);

    areaman[playerid] = CreatePlayerTextDraw(playerid, 52.000000, 312.000000, "Area Aman");
    PlayerTextDrawFont(playerid, areaman[playerid], 1);
    PlayerTextDrawLetterSize(playerid, areaman[playerid], 0.291666, 1.450000);
    PlayerTextDrawTextSize(playerid, areaman[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, areaman[playerid], 1);
    PlayerTextDrawSetShadow(playerid, areaman[playerid], 0);
    PlayerTextDrawAlignment(playerid, areaman[playerid], 1);
    PlayerTextDrawColor(playerid, areaman[playerid], 16711935);
    PlayerTextDrawBackgroundColor(playerid, areaman[playerid], 255);
    PlayerTextDrawBoxColor(playerid, areaman[playerid], 50);
    PlayerTextDrawUseBox(playerid, areaman[playerid], 0);
    PlayerTextDrawSetProportional(playerid, areaman[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, areaman[playerid], 0);

    hungertd[playerid] = CreatePlayerTextDraw(playerid, 497.000000, 102.000000, "HUD:radar_datefood");
    PlayerTextDrawFont(playerid, hungertd[playerid], 4);
    PlayerTextDrawLetterSize(playerid, hungertd[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, hungertd[playerid], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, hungertd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, hungertd[playerid], 0);
    PlayerTextDrawAlignment(playerid, hungertd[playerid], 1);
    PlayerTextDrawColor(playerid, hungertd[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, hungertd[playerid], 255);
    PlayerTextDrawBoxColor(playerid, hungertd[playerid], 50);
    PlayerTextDrawUseBox(playerid, hungertd[playerid], 1);
    PlayerTextDrawSetProportional(playerid, hungertd[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, hungertd[playerid], 0);

    drinktd[playerid] = CreatePlayerTextDraw(playerid, 542.000000, 102.000000, "HUD:radar_diner");
    PlayerTextDrawFont(playerid, drinktd[playerid], 4);
    PlayerTextDrawLetterSize(playerid, drinktd[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, drinktd[playerid], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, drinktd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, drinktd[playerid], 0);
    PlayerTextDrawAlignment(playerid, drinktd[playerid], 1);
    PlayerTextDrawColor(playerid, drinktd[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, drinktd[playerid], 255);
    PlayerTextDrawBoxColor(playerid, drinktd[playerid], 50);
    PlayerTextDrawUseBox(playerid, drinktd[playerid], 0);
    PlayerTextDrawSetProportional(playerid, drinktd[playerid], 0);
    PlayerTextDrawSetSelectable(playerid, drinktd[playerid], 0);

    drinkvaluetd[playerid] = CreatePlayerTextDraw(playerid, 559.000000, 101.000000, "100");
    PlayerTextDrawFont(playerid, drinkvaluetd[playerid], 1);
    PlayerTextDrawLetterSize(playerid, drinkvaluetd[playerid], 0.349999, 2.000000);
    PlayerTextDrawTextSize(playerid, drinkvaluetd[playerid], 563.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, drinkvaluetd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, drinkvaluetd[playerid], 0);
    PlayerTextDrawAlignment(playerid, drinkvaluetd[playerid], 1);
    PlayerTextDrawColor(playerid, drinkvaluetd[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, drinkvaluetd[playerid], 255);
    PlayerTextDrawBoxColor(playerid, drinkvaluetd[playerid], 50);
    PlayerTextDrawUseBox(playerid, drinkvaluetd[playerid], 0);
    PlayerTextDrawSetProportional(playerid, drinkvaluetd[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, drinkvaluetd[playerid], 0);

    radiationvaluetd[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 101.000000, "100");
    PlayerTextDrawFont(playerid, radiationvaluetd[playerid], 1);
    PlayerTextDrawLetterSize(playerid, radiationvaluetd[playerid], 0.349999, 2.000000);
    PlayerTextDrawTextSize(playerid, radiationvaluetd[playerid], 550.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, radiationvaluetd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, radiationvaluetd[playerid], 0);
    PlayerTextDrawAlignment(playerid, radiationvaluetd[playerid], 1);
    PlayerTextDrawColor(playerid, radiationvaluetd[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, radiationvaluetd[playerid], 255);
    PlayerTextDrawBoxColor(playerid, radiationvaluetd[playerid], 50);
    PlayerTextDrawUseBox(playerid, radiationvaluetd[playerid], 0);
    PlayerTextDrawSetProportional(playerid, radiationvaluetd[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, radiationvaluetd[playerid], 0);

    radiationtd[playerid] = CreatePlayerTextDraw(playerid, 587.000000, 102.000000, "HUD:radar_locosyndicate");
    PlayerTextDrawFont(playerid, radiationtd[playerid], 4);
    PlayerTextDrawLetterSize(playerid, radiationtd[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, radiationtd[playerid], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, radiationtd[playerid], 1);
    PlayerTextDrawSetShadow(playerid, radiationtd[playerid], 0);
    PlayerTextDrawAlignment(playerid, radiationtd[playerid], 1);
    PlayerTextDrawColor(playerid, radiationtd[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, radiationtd[playerid], 255);
    PlayerTextDrawBoxColor(playerid, radiationtd[playerid], 50);
    PlayerTextDrawUseBox(playerid, radiationtd[playerid], 1);
    PlayerTextDrawSetProportional(playerid, radiationtd[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, radiationtd[playerid], 0);

    Makan[playerid] = CreatePlayerTextDraw(playerid, 514.000000, 101.000000, "100");
    PlayerTextDrawFont(playerid, Makan[playerid], 1);
    PlayerTextDrawLetterSize(playerid, Makan[playerid], 0.349999, 2.000000);
    PlayerTextDrawTextSize(playerid, Makan[playerid], 550.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, Makan[playerid], 1);
    PlayerTextDrawSetShadow(playerid, Makan[playerid], 0);
    PlayerTextDrawAlignment(playerid, Makan[playerid], 1);
    PlayerTextDrawColor(playerid, Makan[playerid], -1);
    PlayerTextDrawBackgroundColor(playerid, Makan[playerid], 255);
    PlayerTextDrawBoxColor(playerid, Makan[playerid], 50);
    PlayerTextDrawUseBox(playerid, Makan[playerid], 0);
    PlayerTextDrawSetProportional(playerid, Makan[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, Makan[playerid], 0);

    return 1;

}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) //You might move this into your gamemode
{
  if(playertextid == PlayerLoginTextDraw[playerid][0])
  {
    if(pRegistered[playerid] == true)
    {
      ShowPlayerDialog(playerid,DIALOG_LOGIN,DIALOG_STYLE_PASSWORD,"Log in","Ketik password anda pada kolom dibawah ini","Sign In","Keluar");
    }

    else
    {
      ShowPlayerDialog(playerid,DIALOG_REGISTER,DIALOG_STYLE_PASSWORD,"Registering","Ketik password anda untuk terdaftar dalam server","Register","Keluar");
    }
  }
  return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
  new string[512]; //Adapt the size..
  if(clickedid == GlobalLoginTextDraw[11])
  {   
    //About us Button
    strcat(string,"{FF0000}About the server:{FFFFFF}\n\n");
    strcat(string,"Server ini merupakan server yang bertema kiamat nuklir\n");
    strcat(string,"Terdapat berbagai jenis zombie yang dapat menyerang player\n");
    strcat(string,"Jangan pernah ke zona yang telah terkontaminasi karena zombie semakin ganas\n");
    strcat(string,"Cari barang dan serang fraksi lain\n");
    strcat(string,"Eksplor semua bangunan terbengkalai\n");
    ShowPlayerDialog(playerid, DIALOG_ABOUT_US, DIALOG_STYLE_MSGBOX, "Tentang Server", string, "Ok", "");
  }

  if(clickedid == GlobalLoginTextDraw[12])
  {
    //Rules Button
    strcat(string,"{FF0000}Rules:{FFFFFF}\n\n");
    strcat(string,"1. Jangan Cheat\n");
    strcat(string,"2. Jangan Insult Personal\n");
    strcat(string,"3. Jangan RTM\n");
    ShowPlayerDialog(playerid, DIALOG_RULES, DIALOG_STYLE_MSGBOX, "Our Rules", string, "Ok", "");

  }

  if(clickedid == GlobalLoginTextDraw[13])
  {
    //Credits Button
    strcat(string,"{FF0000}Credits:{FFFFFF}\n\n");
    strcat(string,"1. Yesus Kristus\n");
    strcat(string,"2. Sayuz a.k.a developer\n");
    strcat(string,"3. OrdeneauxBiggar377 ( Yang membuat ui login )\n");
    ShowPlayerDialog(playerid, DIALOG_CREDIT, DIALOG_STYLE_MSGBOX, "Credits", string, "Ok", "");
  }
}
hook OnPlayerDisconnect(playerid, reason)
{
    PlayerTextDrawDestroy(playerid, namaserver1[playerid]);
    PlayerTextDrawDestroy(playerid, namaserver2[playerid]);
    PlayerTextDrawDestroy(playerid, td_proses[playerid]);
    DestroyPlayerProgressBar(playerid, activity_bar[playerid]);
    PlayerTextDrawDestroy(playerid, areaman[playerid]);
    PlayerTextDrawDestroy(playerid, terkontaminasi[playerid]);
    PlayerTextDrawDestroy(playerid, hungertd[playerid]);
    PlayerTextDrawDestroy(playerid, drinktd[playerid]);
    PlayerTextDrawDestroy(playerid, drinkvaluetd[playerid]);
    PlayerTextDrawDestroy(playerid, radiationvaluetd[playerid]);
    PlayerTextDrawDestroy(playerid, radiationtd[playerid]);
    PlayerTextDrawDestroy(playerid, Makan[playerid]);
    PlayerTextDrawDestroy(playerid, lootinfotd[playerid]);
    pRegistered[playerid] = false;
  	KillTimer(realtimer[playerid]);
	
    return 1;
}
stock setThristVal(playerid){
    new str[64];
    format(str, sizeof(str), "%.0f", Player[playerid][pThrist]);
    PlayerTextDrawSetString(playerid, drinkvaluetd[playerid], str);
    return 1;
}
stock setHungerVal(playerid){
    new str[64];
    format(str, sizeof(str), "%.0f", Player[playerid][pHunger]);
    PlayerTextDrawSetString(playerid, Makan[playerid], str);
    return 1;
}
stock setRadiationVal(playerid){
    new str[64];
    format(str, sizeof(str), "%.0f", Player[playerid][pRadiation]);
    PlayerTextDrawSetString(playerid, radiationvaluetd[playerid], str);
    return 1;
}
hook OnPlayerSpawn(playerid){
    TextDrawShowForPlayer(playerid, namaserver4);
    TextDrawShowForPlayer(playerid, nameserver5);
    PlayerTextDrawShow(playerid, namaserver1[playerid]);
    PlayerTextDrawShow(playerid, namaserver2[playerid]);
    PlayerTextDrawShow(playerid, hungertd[playerid]);
    PlayerTextDrawShow(playerid, drinktd[playerid]);
    PlayerTextDrawShow(playerid, drinkvaluetd[playerid]);
    PlayerTextDrawShow(playerid, radiationvaluetd[playerid]);
    PlayerTextDrawShow(playerid, radiationtd[playerid]);
    PlayerTextDrawShow(playerid, Makan[playerid]);
	
    return 1;
}
stock hideActivityTextDraw(playerid)
{
    HidePlayerProgressBar(playerid, activity_bar[playerid]);
    PlayerTextDrawHide(playerid, td_proses[playerid]);
    return 1;
}
forward showPlayerActivityTextdraw(playerid);

public showPlayerActivityTextdraw(playerid)
{
    PlayerTextDrawShow(playerid, td_proses[playerid]);
	ShowPlayerProgressBar(playerid, activity_bar[playerid]);
    SetPlayerProgressBarValue(playerid, activity_bar[playerid], 0.0);
    return 1;
}

forward updateTextDrawProgress(playerid, Float:bar, type);

public updateTextDrawProgress(playerid, Float:bar, type){
	if(type == 0)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            KillTimer(ActivityTimer[playerid]);
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
        }
    }
    if(type == 1)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            if(Player[playerid][pHealth] >= 100)
            {
              Player[playerid][pHealth] = 100;
            }
            else{
            Player[playerid][pHealth] += 10.0;
            }
            SetPlayerHealth(playerid, Player[playerid][pHealth]);
            KillTimer(ActivityTimer[playerid]);
            sendSuccessMessage(playerid, "Anda berhasil menggunakan bandage");
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            healBodyPart(playerid, 1);
            healBodyPart(playerid, 2);
            healBodyPart(playerid, 3);
            healBodyPart(playerid, 4);
        }
    }
    if(type == 2)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            Player[playerid][pInfected] = 0;
            SetPlayerHealth(playerid, Player[playerid][pHealth]);
            KillTimer(ActivityTimer[playerid]);
            KillTimer(InfectedTimer[playerid]);
            infectedAlrRun[playerid] = 0;
            sendSuccessMessage(playerid, "Anda berhasil meminum antibiotik");
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
            SetPlayerDrunkLevel(playerid, 0);
        }
    }
	if(type == 3)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            Player[playerid][pThrist] += 20.0;
			if(Player[playerid][pThrist] >= 100)
			{
				Player[playerid][pThrist] = 100;
			}
            KillTimer(ActivityTimer[playerid]);
            sendSuccessMessage(playerid, "Anda berhasil meminum air");
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
			setThristVal(playerid);
			

        }
    }
	if(type == 4)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            Player[playerid][pHunger] += 20.0;
			if(Player[playerid][pHunger] >= 100)
			{
				Player[playerid][pHunger] = 100;
			}
            KillTimer(ActivityTimer[playerid]);
            sendSuccessMessage(playerid, "Anda berhasil memakan apel");
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
			setHungerVal(playerid);

        }
    }
	if(type == 5)
    {
        ActivityProgress[playerid] += bar;
        SetPlayerProgressBarValue(playerid, activity_bar[playerid], ActivityProgress[playerid]);
        if(ActivityProgress[playerid] >= 100)
        {
            Player[playerid][pHunger] += 50.0;
			if(Player[playerid][pHunger] >= 100)
			{
				Player[playerid][pHunger] = 100;
			}
            KillTimer(ActivityTimer[playerid]);
            sendSuccessMessage(playerid, "Anda berhasil memakan pizza");
            TogglePlayerControllable(playerid, 1);
            hideActivityTextDraw(playerid);
            playerActivity[playerid] = 0;
			setHungerVal(playerid);

        }
    }
    return 1;
}
stock CreatePlayerLoginTextDraws(playerid)
{
  new str[128];
  PlayerLoginTextDraw[playerid][0] = CreatePlayerTextDraw(playerid,192.000000, 166.000000, !"      Login");
  PlayerTextDrawBackgroundColor(playerid,PlayerLoginTextDraw[playerid][0], 255);
  PlayerTextDrawFont(playerid,PlayerLoginTextDraw[playerid][0], 2);
  PlayerTextDrawLetterSize(playerid,PlayerLoginTextDraw[playerid][0], 0.189999, 1.299999);
  PlayerTextDrawTextSize(playerid, PlayerLoginTextDraw[playerid][0], 240.0, 15.0);
  PlayerTextDrawColor(playerid,PlayerLoginTextDraw[playerid][0], -1);
  PlayerTextDrawSetOutline(playerid,PlayerLoginTextDraw[playerid][0], 1);
  PlayerTextDrawSetProportional(playerid,PlayerLoginTextDraw[playerid][0], 1);
  PlayerTextDrawSetSelectable(playerid,PlayerLoginTextDraw[playerid][0], 1);

  PlayerLoginTextDraw[playerid][1] = CreatePlayerTextDraw(playerid,269.000000, 123.000000, !"Selamat datang di Yuz Apocalypse");
  PlayerTextDrawBackgroundColor(playerid,PlayerLoginTextDraw[playerid][1], 255);
  PlayerTextDrawFont(playerid,PlayerLoginTextDraw[playerid][1], 2);
  PlayerTextDrawLetterSize(playerid,PlayerLoginTextDraw[playerid][1], 0.140000, 0.799998);
  PlayerTextDrawColor(playerid,PlayerLoginTextDraw[playerid][1], -1);
  PlayerTextDrawSetOutline(playerid,PlayerLoginTextDraw[playerid][1], 1);
  PlayerTextDrawSetProportional(playerid,PlayerLoginTextDraw[playerid][1], 1);
  PlayerTextDrawSetSelectable(playerid,PlayerLoginTextDraw[playerid][1], 0);
  format(str, sizeof(str),"Welcome to %s", LT_ServerName);
  PlayerTextDrawSetString(playerid, PlayerLoginTextDraw[playerid][1], str);

  PlayerLoginTextDraw[playerid][2] = CreatePlayerTextDraw(playerid,427.000000, 123.000000, !"00:00 Time");
  PlayerTextDrawBackgroundColor(playerid,PlayerLoginTextDraw[playerid][2], 255);
  PlayerTextDrawFont(playerid,PlayerLoginTextDraw[playerid][2], 2);
  PlayerTextDrawLetterSize(playerid,PlayerLoginTextDraw[playerid][2], 0.140000, 0.799998);
  PlayerTextDrawColor(playerid,PlayerLoginTextDraw[playerid][2], -1);
  PlayerTextDrawSetOutline(playerid,PlayerLoginTextDraw[playerid][2], 1);
  PlayerTextDrawSetProportional(playerid,PlayerLoginTextDraw[playerid][2], 1);
  PlayerTextDrawSetSelectable(playerid,PlayerLoginTextDraw[playerid][2], 0);

  PlayerLoginTextDraw[playerid][3] = CreatePlayerTextDraw(playerid,346.000000, 162.000000, !"Nama ini telah ~g~terdaftar~w~.~n~Sekarang Anda dapat ~g~masuk~w~ ke akun Anda.");
  PlayerTextDrawBackgroundColor(playerid,PlayerLoginTextDraw[playerid][3], 255);
  PlayerTextDrawFont(playerid,PlayerLoginTextDraw[playerid][3], 2);
  PlayerTextDrawLetterSize(playerid,PlayerLoginTextDraw[playerid][3], 0.129997, 0.899999);
  PlayerTextDrawColor(playerid,PlayerLoginTextDraw[playerid][3], -1);
  PlayerTextDrawSetOutline(playerid,PlayerLoginTextDraw[playerid][3], 1);
  PlayerTextDrawSetProportional(playerid,PlayerLoginTextDraw[playerid][3], 1);
  PlayerTextDrawSetSelectable(playerid,PlayerLoginTextDraw[playerid][3], 0);

  KillTimer(realtimer[playerid]);
  realtimer[playerid] = SetTimerEx("LR_UpdateRealTime", 1000, true, "i", playerid);
}
stock CreateGlobalLoginTextDraws()
{
  GlobalLoginTextDraw[0] = TextDrawCreate(169.000000, 121.000000, !"__");
  TextDrawBackgroundColor(GlobalLoginTextDraw[0], 255);
  TextDrawFont(GlobalLoginTextDraw[0], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[0], 0.500000, 26.200000);
  TextDrawColor(GlobalLoginTextDraw[0], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[0], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[0], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[0], 1);
  TextDrawUseBox(GlobalLoginTextDraw[0], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[0], 255);
  TextDrawTextSize(GlobalLoginTextDraw[0], 470.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[0], 0);

  GlobalLoginTextDraw[1] = TextDrawCreate(170.000000, 123.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[1], 255);
  TextDrawFont(GlobalLoginTextDraw[1], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[1], 0.500000, 25.799999);
  TextDrawColor(GlobalLoginTextDraw[1], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[1], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[1], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[1], 1);
  TextDrawUseBox(GlobalLoginTextDraw[1], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[1], 286331391);
  TextDrawTextSize(GlobalLoginTextDraw[1], 469.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[1], 0);

  GlobalLoginTextDraw[2] = TextDrawCreate(170.000000, 122.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[2], 255);
  TextDrawFont(GlobalLoginTextDraw[2], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[2], 0.500000, 1.200000);
  TextDrawColor(GlobalLoginTextDraw[2], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[2], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[2], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[2], 1);
  TextDrawUseBox(GlobalLoginTextDraw[2], 1);
  TextDrawTextSize(GlobalLoginTextDraw[2], 469.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[2], 0);

  GlobalLoginTextDraw[3] = TextDrawCreate(177.000000, 156.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[3], 255);
  TextDrawFont(GlobalLoginTextDraw[3], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[3], 0.500000, 3.700000);
  TextDrawColor(GlobalLoginTextDraw[3], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[3], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[3], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[3], 1);
  TextDrawUseBox(GlobalLoginTextDraw[3], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[3], 255);
  TextDrawTextSize(GlobalLoginTextDraw[3], 264.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[3], 0);

  GlobalLoginTextDraw[4] = TextDrawCreate(178.000000, 157.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[4], 255);
  TextDrawFont(GlobalLoginTextDraw[4], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[4], 0.500000, 3.500000);
  TextDrawColor(GlobalLoginTextDraw[4], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[4], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[4], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[4], 1);
  TextDrawUseBox(GlobalLoginTextDraw[4], 1);
  TextDrawTextSize(GlobalLoginTextDraw[4], 263.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[4], 0);

  GlobalLoginTextDraw[5] = TextDrawCreate(177.000000, 206.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[5], 255);
  TextDrawFont(GlobalLoginTextDraw[5], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[5], 0.500000, 3.700000);
  TextDrawColor(GlobalLoginTextDraw[5], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[5], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[5], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[5], 1);
  TextDrawUseBox(GlobalLoginTextDraw[5], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[5], 255);
  TextDrawTextSize(GlobalLoginTextDraw[5], 264.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[5], 0);

  GlobalLoginTextDraw[6] = TextDrawCreate(178.000000, 207.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[6], 255);
  TextDrawFont(GlobalLoginTextDraw[6], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[6], 0.500000, 3.500000);
  TextDrawColor(GlobalLoginTextDraw[6], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[6], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[6], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[6], 1);
  TextDrawUseBox(GlobalLoginTextDraw[6], 1);
  TextDrawTextSize(GlobalLoginTextDraw[6], 263.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[6], 0);

  GlobalLoginTextDraw[7] = TextDrawCreate(177.000000, 256.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[7], 255);
  TextDrawFont(GlobalLoginTextDraw[7], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[7], 0.500000, 3.700000);
  TextDrawColor(GlobalLoginTextDraw[7], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[7], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[7], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[7], 1);
  TextDrawUseBox(GlobalLoginTextDraw[7], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[7], 255);
  TextDrawTextSize(GlobalLoginTextDraw[7], 264.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[7], 0);

  GlobalLoginTextDraw[8] = TextDrawCreate(178.000000, 257.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[8], 255);
  TextDrawFont(GlobalLoginTextDraw[8], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[8], 0.500000, 3.500000);
  TextDrawColor(GlobalLoginTextDraw[8], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[8], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[8], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[8], 1);
  TextDrawUseBox(GlobalLoginTextDraw[8], 1);
  TextDrawTextSize(GlobalLoginTextDraw[8], 263.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[8], 0);

  GlobalLoginTextDraw[9] = TextDrawCreate(177.000000, 306.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[9], 255);
  TextDrawFont(GlobalLoginTextDraw[9], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[9], 0.500000, 3.700000);
  TextDrawColor(GlobalLoginTextDraw[9], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[9], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[9], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[9], 1);
  TextDrawUseBox(GlobalLoginTextDraw[9], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[9], 255);
  TextDrawTextSize(GlobalLoginTextDraw[9], 264.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[9], 0);

  GlobalLoginTextDraw[10] = TextDrawCreate(178.000000, 307.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[10], 255);
  TextDrawFont(GlobalLoginTextDraw[10], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[10], 0.500000, 3.500000);
  TextDrawColor(GlobalLoginTextDraw[10], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[10], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[10], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[10], 1);
  TextDrawUseBox(GlobalLoginTextDraw[10], 1);
  TextDrawTextSize(GlobalLoginTextDraw[10], 263.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[10], 0);

  GlobalLoginTextDraw[11] = TextDrawCreate(191.000000, 217.000000, !"	About Us");
  TextDrawBackgroundColor(GlobalLoginTextDraw[11], 255);
  TextDrawFont(GlobalLoginTextDraw[11], 2);
  TextDrawLetterSize(GlobalLoginTextDraw[11], 0.189999, 1.299999);
  TextDrawTextSize( GlobalLoginTextDraw[11], 260.0, 20.0);
  TextDrawColor(GlobalLoginTextDraw[11], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[11], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[11], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[11], 1);

  GlobalLoginTextDraw[12] = TextDrawCreate(202.000000, 267.000000, !" Rules");
  TextDrawBackgroundColor(GlobalLoginTextDraw[12], 255);
  TextDrawFont(GlobalLoginTextDraw[12], 2);
  TextDrawLetterSize(GlobalLoginTextDraw[12], 0.189999, 1.299999);
  TextDrawTextSize( GlobalLoginTextDraw[12], 240.0, 15.0);
  TextDrawColor(GlobalLoginTextDraw[12], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[12], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[12], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[12], 1);

  GlobalLoginTextDraw[13] = TextDrawCreate(202.000000, 316.000000, !"Credits");
  TextDrawBackgroundColor(GlobalLoginTextDraw[13], 255);
  TextDrawFont(GlobalLoginTextDraw[13], 2);
  TextDrawLetterSize(GlobalLoginTextDraw[13], 0.189999, 1.299999);
  TextDrawTextSize( GlobalLoginTextDraw[13], 240.0, 15.0);
  TextDrawColor(GlobalLoginTextDraw[13], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[13], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[13], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[13], 1);

  GlobalLoginTextDraw[14] = TextDrawCreate(340.000000, 155.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[14], 255);
  TextDrawFont(GlobalLoginTextDraw[14], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[14], 0.500000, 3.799999);
  TextDrawColor(GlobalLoginTextDraw[14], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[14], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[14], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[14], 1);
  TextDrawUseBox(GlobalLoginTextDraw[14], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[14], 255);
  TextDrawTextSize(GlobalLoginTextDraw[14], 460.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[14], 0);

  GlobalLoginTextDraw[15] = TextDrawCreate(341.000000, 156.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[15], 255);
  TextDrawFont(GlobalLoginTextDraw[15], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[15], 0.500000, 3.599999);
  TextDrawColor(GlobalLoginTextDraw[15], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[15], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[15], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[15], 1);
  TextDrawUseBox(GlobalLoginTextDraw[15], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[15], 505290495);
  TextDrawTextSize(GlobalLoginTextDraw[15], 459.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[15], 0);

  GlobalLoginTextDraw[16] = TextDrawCreate(340.000000, 206.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[16], 255);
  TextDrawFont(GlobalLoginTextDraw[16], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[16], 0.500000, 3.799999);
  TextDrawColor(GlobalLoginTextDraw[16], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[16], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[16], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[16], 1);
  TextDrawUseBox(GlobalLoginTextDraw[16], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[16], 255);
  TextDrawTextSize(GlobalLoginTextDraw[16], 460.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[16], 0);

  GlobalLoginTextDraw[17] = TextDrawCreate(341.000000, 207.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[17], 255);
  TextDrawFont(GlobalLoginTextDraw[17], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[17], 0.500000, 3.599999);
  TextDrawColor(GlobalLoginTextDraw[17], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[17], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[17], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[17], 1);
  TextDrawUseBox(GlobalLoginTextDraw[17], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[17], 505290495);
  TextDrawTextSize(GlobalLoginTextDraw[17], 459.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[17], 0);

  GlobalLoginTextDraw[18] = TextDrawCreate(318.000000, 203.000000, !"~<~");
  TextDrawBackgroundColor(GlobalLoginTextDraw[18], 255);
  TextDrawFont(GlobalLoginTextDraw[18], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[18], 0.539999, 3.900000);
  TextDrawColor(GlobalLoginTextDraw[18], -16776961);
  TextDrawSetOutline(GlobalLoginTextDraw[18], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[18], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[18], 0);

  GlobalLoginTextDraw[19] = TextDrawCreate(340.000000, 259.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[19], 255);
  TextDrawFont(GlobalLoginTextDraw[19], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[19], 0.500000, 3.799999);
  TextDrawColor(GlobalLoginTextDraw[19], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[19], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[19], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[19], 1);
  TextDrawUseBox(GlobalLoginTextDraw[19], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[19], 255);
  TextDrawTextSize(GlobalLoginTextDraw[19], 460.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[19], 0);

  GlobalLoginTextDraw[20] = TextDrawCreate(341.000000, 260.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[20], 255);
  TextDrawFont(GlobalLoginTextDraw[20], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[20], 0.500000, 3.599999);
  TextDrawColor(GlobalLoginTextDraw[20], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[20], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[20], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[20], 1);
  TextDrawUseBox(GlobalLoginTextDraw[20], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[20], 505290495);
  TextDrawTextSize(GlobalLoginTextDraw[20], 459.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[20], 0);

  GlobalLoginTextDraw[21] = TextDrawCreate(340.000000, 309.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[21], 255);
  TextDrawFont(GlobalLoginTextDraw[21], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[21], 0.500000, 3.799999);
  TextDrawColor(GlobalLoginTextDraw[21], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[21], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[21], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[21], 1);
  TextDrawUseBox(GlobalLoginTextDraw[21], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[21], 255);
  TextDrawTextSize(GlobalLoginTextDraw[21], 460.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[21], 0);

  GlobalLoginTextDraw[22] = TextDrawCreate(341.000000, 310.000000, !"_");
  TextDrawBackgroundColor(GlobalLoginTextDraw[22], 255);
  TextDrawFont(GlobalLoginTextDraw[22], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[22], 0.500000, 3.599999);
  TextDrawColor(GlobalLoginTextDraw[22], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[22], 0);
  TextDrawSetProportional(GlobalLoginTextDraw[22], 1);
  TextDrawSetShadow(GlobalLoginTextDraw[22], 1);
  TextDrawUseBox(GlobalLoginTextDraw[22], 1);
  TextDrawBoxColor(GlobalLoginTextDraw[22], 505290495);
  TextDrawTextSize(GlobalLoginTextDraw[22], 459.000000, 0.000000);
  TextDrawSetSelectable(GlobalLoginTextDraw[22], 0);

  GlobalLoginTextDraw[23] = TextDrawCreate(318.000000, 152.000000, !"~<~");
  TextDrawBackgroundColor(GlobalLoginTextDraw[23], 255);
  TextDrawFont(GlobalLoginTextDraw[23], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[23], 0.539999, 3.900000);
  TextDrawColor(GlobalLoginTextDraw[23], -16776961);
  TextDrawSetOutline(GlobalLoginTextDraw[23], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[23], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[23], 0);

  GlobalLoginTextDraw[24] = TextDrawCreate(318.000000, 256.000000, !"~<~");
  TextDrawBackgroundColor(GlobalLoginTextDraw[24], 255);
  TextDrawFont(GlobalLoginTextDraw[24], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[24], 0.539999, 3.900000);
  TextDrawColor(GlobalLoginTextDraw[24], -16776961);
  TextDrawSetOutline(GlobalLoginTextDraw[24], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[24], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[24], 0);

  GlobalLoginTextDraw[25] = TextDrawCreate(318.000000, 306.000000, !"~<~");
  TextDrawBackgroundColor(GlobalLoginTextDraw[25], 255);
  TextDrawFont(GlobalLoginTextDraw[25], 1);
  TextDrawLetterSize(GlobalLoginTextDraw[25], 0.539999, 3.900000);
  TextDrawColor(GlobalLoginTextDraw[25], -16776961);
  TextDrawSetOutline(GlobalLoginTextDraw[25], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[25], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[25], 0);

  GlobalLoginTextDraw[26] = TextDrawCreate(348.000000, 213.000000, !"Klik di sini untuk ~g~informasi~w~ penting.~n~Pelajari cara kerja server..");
  TextDrawBackgroundColor(GlobalLoginTextDraw[26], 255);
  TextDrawFont(GlobalLoginTextDraw[26], 2);
  TextDrawLetterSize(GlobalLoginTextDraw[26], 0.129997, 0.899999);
  TextDrawColor(GlobalLoginTextDraw[26], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[26], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[26], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[26], 0);

  GlobalLoginTextDraw[27] = TextDrawCreate(348.000000, 266.000000, !"~w~Harap baca semua ~g~Peraturan~w~~n~ dengan saksama");
  TextDrawBackgroundColor(GlobalLoginTextDraw[27], 255);
  TextDrawFont(GlobalLoginTextDraw[27], 2);
  TextDrawLetterSize(GlobalLoginTextDraw[27], 0.129997, 0.899999);
  TextDrawColor(GlobalLoginTextDraw[27], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[27], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[27], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[27], 0);

  GlobalLoginTextDraw[28] = TextDrawCreate(348.000000, 317.000000, !"Lihat siapa saja yang telah ~n~~g~berkontribusi~w~ untuk kami.;)");
  TextDrawBackgroundColor(GlobalLoginTextDraw[28], 255);
  TextDrawFont(GlobalLoginTextDraw[28], 2);
  TextDrawLetterSize(GlobalLoginTextDraw[28], 0.129997, 0.899999);
  TextDrawColor(GlobalLoginTextDraw[28], -1);
  TextDrawSetOutline(GlobalLoginTextDraw[28], 1);
  TextDrawSetProportional(GlobalLoginTextDraw[28], 1);
  TextDrawSetSelectable(GlobalLoginTextDraw[28], 0);

  #if defined RandomLoginColors
  new Randomtextdrawcolor = RandomLoginColorsArray[random(sizeof(RandomLoginColorsArray))];
  TextDrawBoxColor(GlobalLoginTextDraw[2], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[4], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[6], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[8], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[10], Randomtextdrawcolor);
  #else
  TextDrawBoxColor(GlobalLoginTextDraw[2], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[4], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[6], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[8], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[10], LoginTextDrawColor);
  #endif

}
forward LR_UpdateRealTime(playerid);
public LR_UpdateRealTime(playerid)
{
  new str[16];
  gettime(str[0], str[1]);
  format(str,sizeof(str),"%02d:%02d Time",str[0],str[1]);
  PlayerTextDrawSetString(playerid,PlayerLoginTextDraw[playerid][2], str);
  return 1;
}

stock PlayerIsRegistered(playerid)
{
  pRegistered[playerid] = true;
  PlayerTextDrawSetString(playerid, PlayerLoginTextDraw[playerid][3], !"Nama ini telah ~g~terdaftar~w~.~n~Silakan ~g~masuk~w~ ke akun Anda.");
  PlayerTextDrawSetString(playerid, PlayerLoginTextDraw[playerid][0], !"      Login"); 
  PlayerTextDrawSetString(playerid, PlayerLoginTextDraw[playerid][1], !"          Welcome back!"); 
}

stock PlayerIsNotRegistered(playerid)
{
  pRegistered[playerid] = false;
  new str[128]; //Adapt the size..
  PlayerTextDrawSetString(playerid, PlayerLoginTextDraw[playerid][3], !"Nama ini ~r~belum~w~ terdaftar.~n~Silakan buat ~g~akun~w~ terlebih dahulu.");
  PlayerTextDrawSetString(playerid, PlayerLoginTextDraw[playerid][0], !"   Register");
  format(str, sizeof(str),"Welcome to %s", LT_ServerName);
  PlayerTextDrawSetString(playerid, PlayerLoginTextDraw[playerid][1], str);
}

stock ShowLoginTextDraws(playerid)
{
  for(new i; i < sizeof(PlayerLoginTextDraw[]); i++)
  {
    PlayerTextDrawShow(playerid, PlayerLoginTextDraw[playerid][i]);
  }

  for(new i; i<sizeof(GlobalLoginTextDraw); i++)
  {
    TextDrawShowForPlayer(playerid, GlobalLoginTextDraw[i]);
  }

  SelectTextDraw(playerid, TextDrawHoverColor);
  #if defined RandomLoginColors
  new Randomtextdrawcolor = RandomLoginColorsArray[random(sizeof(RandomLoginColorsArray))];
  TextDrawBoxColor(GlobalLoginTextDraw[2], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[4], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[6], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[8], Randomtextdrawcolor);
  TextDrawBoxColor(GlobalLoginTextDraw[10], Randomtextdrawcolor);
  #else
  TextDrawBoxColor(GlobalLoginTextDraw[2], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[4], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[6], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[8], LoginTextDrawColor);
  TextDrawBoxColor(GlobalLoginTextDraw[10], LoginTextDrawColor);
  #endif
}

stock HideLoginTextDraws(playerid)
{
  for(new i; i < sizeof(PlayerLoginTextDraw[]); i++)
  {
    PlayerTextDrawHide(playerid, PlayerLoginTextDraw[playerid][i]);
  }

  for(new i; i<sizeof(GlobalLoginTextDraw); i++)
  {
    TextDrawHideForPlayer(playerid, GlobalLoginTextDraw[i]);
  }

  CancelSelectTextDraw(playerid);
  KillTimer(realtimer[playerid]);
}

stock DestroyPlayerLoginTextDraws(playerid)
{
  for(new i; i < sizeof(PlayerLoginTextDraw[]); i++)
  {
    PlayerTextDrawDestroy(playerid, PlayerLoginTextDraw[playerid][i]);
  }

  CancelSelectTextDraw(playerid);
  KillTimer(realtimer[playerid]);
}

stock DestroyGlobalLoginTextDraws()
{
  for(new i; i<sizeof(GlobalLoginTextDraw); i++)
  {
    TextDrawDestroy(GlobalLoginTextDraw[i]);
  }
}