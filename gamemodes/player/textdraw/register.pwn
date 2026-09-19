//Includes

#include <a_samp> // SA-MP Team

/*

@ Titel: Elegant Login / Register TextDraws
@ Author: JustMe.77
@ Version: 1.0.4
@ Download: https://github.com/JustMe77/Elegant-Login-Register-TextDraws

*/

//Settings



enum
{
  D_Login = 10100,
  D_Register = 10101,
  D_About = 10102,
  D_Rules = 10103,
  D_Credits = 10104
};






public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
  new string[512]; //Adapt the size..
  if(clickedid == GlobalLoginTextDraw[11])
  {   
    //About us Button
    strcat(string,"{FF0000}About the server:{FFFFFF}\n\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    ShowPlayerDialog(playerid, D_About, DIALOG_STYLE_MSGBOX, "About the Server", string, "Ok", "");
  }

  if(clickedid == GlobalLoginTextDraw[12])
  {
    //Rules Button
    strcat(string,"{FF0000}Rules:{FFFFFF}\n\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    ShowPlayerDialog(playerid, D_Rules, DIALOG_STYLE_MSGBOX, "Our Rules", string, "Ok", "");

  }

  if(clickedid == GlobalLoginTextDraw[13])
  {
    //Credits Button
    strcat(string,"{FF0000}Credits:{FFFFFF}\n\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    strcat(string,"< Insert your text here >\n");
    ShowPlayerDialog(playerid, D_Credits, DIALOG_STYLE_MSGBOX, "Credits", string, "Ok", "");
  }

  #if defined ETD_OnPlayerClickTextDraw
  return ETD_OnPlayerClickTextDraw(playerid, clickedid);
  #else
  return 1;
  #endif
}




//Callback Hooks

#if defined _ALS_OnGameModeInit
#undef OnGameModeInit
#else
#define _ALS_OnGameModeInit
#endif

#define OnGameModeInit ETD_OnGameModeInit
#if defined ETD_OnGameModeInit
forward ETD_OnGameModeInit();
#endif

#if defined _ALS_OnPlayerConnect
#undef OnPlayerConnect
#else
#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect ETD_OnPlayerConnect
#if defined ETD_OnPlayerConnect
forward ETD_OnPlayerConnect();
#endif

#if defined _ALS_OnPlayerDisconnect
#undef OnPlayerDisconnect
#else
#define _ALS_OnPlayerDisconnect
#endif

#define OnPlayerDisconnect ETD_OnPlayerDisconnect
#if defined ETD_OnPlayerDisconnect
forward ETD_OnPlayerDisconnect();
#endif


#if defined _ALS_OnPlayerClickTextDraw
#undef OnPlayerClickTextDraw
#else
#define _ALS_OnPlayerClickTextDraw
#endif

#define OnPlayerClickTextDraw ETD_OnPlayerClickTextDraw
#if defined ETD_OnPlayerClickTextDraw
forward ETD_OnPlayerClickTextDraw();
#endif

#if defined _ALS_OnPlayerClickPlayerTD
#undef OnPlayerClickPlayerTextDraw
#else
#define _ALS_OnPlayerClickPlayerTD
#endif

#define OnPlayerClickPlayerTextDraw elr_OnPlayerClickPlayerTD
#if defined elr_OnPlayerClickPlayerTD
forward elr_OnPlayerClickPlayerTD(playerid, PlayerText:playertextid);
#endif



