#include <a_samp>
#include <Pawn.RakNet>
#include <crashdetect>
#include <Dini>
#include <streamer>

#include <FCNPC>
#define SSCANF_NO_NICE_FEATURES
#include <sscanf2>
#include <mapandreas>
#include <colandreas>
#include <distance>
#include <progress2>


#include <mselection>
// other files



// color

enum playerInfo{
    pId,
    pAdmin,
    Float:pX,
    Float:pY,
    Float:pZ,
    Float:pHealth,
    Float:pArmour,
    pSkin,
    pLapar, 
    pMinum, 
    pRadiasi,
    pWeap1, 
    pAmmo1, 
    pWeap2,
    pAmmo2,
    pWeap3,
    pAmmo3, 
    pWeap4, 
    pAmmo4, 
    pWeap5, 
    pAmmo5,
    pAmmo6,
    pAmmo8,
    pWeap6,
    pWeap7,
    pAmmo7,
    pWeap8,
    pWeap9,
    pAmmo9, 
    pWeap10, 
    pAmmo10,
    pWeap11, 
    pAmmo11, 
    pWeap12,
    pAmmo12,
    pMoney,
    pXp, 
    pLevel,
    pAdvance,
    pScrap,
    pBandage,
    pInfected, 
    pAntibiotic,
    pPizza,
    pApel,
    pDrink,
    pGasmask,
    Float:pHunger, 
    Float:pThrist,
    Float:pRadiation,
    Float:pLeftArm,
    Float:pRightArm,
    Float:pLeftFoot,
    Float:pRightFoot,
    pFam,
    pFamRank,
    pFamRankName[64],
    pGender,
    pGas,
    pRadio,
    pVehSlot
};

// Dialog
#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_INFO 3
#define DIALOG_LIST_TRADER 4
#define DIALOG_LIST_ZOMBIE 5
#define DIALOG_TRADER_SHOP 6 
#define DIALOG_INVENTORY   7
#define DIALOG_LIST_LOOT 8
#define DIALOG_ACCEPT_LOOT 9
#define DIALOG_BUY_APEL 10
#define DIALOG_BUY_PIZZA 11
#define DIALOG_BUY_MINUMAN 12
#define DIALOG_BUY_BANDAGE 13
#define DIALOG_BUY_GASMASK 14
#define DIALOG_BUY_ANTIBIOTIK 15
#define DIALOG_GUNSHOP 16
#define DIALOG_HEALTH 17
#define DIALOG_ABOUT_US 18
#define DIALOG_CREDIT 19
#define DIALOG_RULES 20
#define DIALOG_LOOT_DEATH 21
#define DIALOG_BASE_LOOT 22
#define DIALOG_LIST_REBEL 23
#define DIALOG_FAM_MENU 24
#define DIALOG_LIST_FAM_MEMBER 25
#define DIALOG_FAM_INPUT_ID_INVITE 26
#define DIALOG_ACCEPT_FAM_INVITE 27
#define DIALOG_KICK_FAM_MEMBER 28
#define DIALOG_LIST_FAM 29
#define DIALOG_SET_FAM_MEMBER_RANK 30
#define DIALOG_LIST_FAM_RANK 31
#define DIALOG_CLAIM_FAM_ZONE 32
#define DIALOG_LIST_LAND 33
#define DIALOG_BUY_LAND 34
#define DIALOG_LIST_FAM_LAND 35
#define DIALOG_FAM_LAHAN_INFO 36
#define DIALOG_MANAGE_LAHAN 37
#define DIALOG_GENDER 38
#define DIALOG_LIST_OBJECT 39
#define DIALOG_LIST_OBJECT_DELETE 40
#define DIALOG_VEH_MENU 41
#define DIALOG_VEH_INTERACTION 42
#define DIALOG_JUAL_VEH_SERVER 43
#define DIALOG_JUAL_VEH_PLAYER 44
#define DIALOG_JUAL_VEH_PLAYER_CONFIRM 45
#define DIALOG_CONFIRM_REPAIR 46
#define DIALOG_CONFIRM_REFUEL 47
#define DIALOG_CRAFTING 48
#define DIALOG_CRAFTING_CONFIRM 49
#define DIALOG_CRAFTING_AMMO 50
#define DIALOG_CRAFTING_AMMO_CONFIRM 51
#define DIALOG_RADIO 52
#define DIALOG_SET_FREQ 53
#define DIALOG_RADIO_CHAT 54
#define DIALOG_CRAFT_RADIO 55
#define DIALOG_BUY_VEH 56
#define DIALOG_TRUNK 57
#define DIALOG_TRUNK_SELECT 58
#define DIALOG_HELP 59
#define DIALOG_HELP2 60
#define DIALOG_RANDOM_EVENT_HELP 61
#define DIALOG_LIST_REPORT 62
#define DIALOG_REPORT 63
#define DIALOG_LIST_ASK 64
#define DIALOG_ASK 65
#define DIALOG_ASK_ANSWER 66
#define DIALOG_ADMIN_HELP_LIST 67
#define DIALOG_ADMIN_HELP 68

#define Account Player
new Player[MAX_PLAYERS][playerInfo];

new UseGun[MAX_PLAYERS];
// Pawno



#include "util/global.pwn"



#include "util/color.pwn"
#include "player/textdraw.pwn"



#include "family/main.pwn"
#include "family/function.pwn"
#include "family/command.pwn"
#include "family_zone/main.pwn"


#include "object/main.pwn"
#include "object/dialog.pwn"
#include "object/callback.pwn"

#include "family_zone/function.pwn"
#include "family_zone/dialog.pwn"
#include "family_zone/command.pwn"

#include "vehicle/main.pwn"
#include "vehicle/speedo.pwn"
#include "vehicle/function.pwn"
#include "vehicle/command.pwn"
#include "vehicle/dialog.pwn"
#include "vehicle/dealership.pwn"

#include "world/map.pwn"
#include "world/zone.pwn"
#include "world/world.pwn"
#include "world/loot/base.pwn"
#include "world/loot/main.pwn"

#include "npc/zombie.pwn"
#include "npc/trader.pwn"
#include "npc/rebel.pwn"

#include "player/hud.pwn"
#include "player/message.pwn"
#include "player/selection.pwn"
#include "player/account.pwn"
#include "player/activity.pwn"
#include "player/dialog.pwn"
#include "player/admin.pwn"
#include "player/anticit.pwn"
#include "player/level.pwn"
#include "player/health.pwn"
#include "player/command/item.pwn"
#include "player/command/server.pwn"
#include "player/animation.pwn"
#include "player/death.pwn"
// #include "player/whitelist.pwn"
#include "player/crafting.pwn"
#include "player/radio.pwn"
#include "player/report.pwn"
#include "player/ask.pwn"

#include "pickup/npc.pwn"
#include "pickup/loot.pwn"
// custom textdraw

// in game object manip
#include "player/weapon.pwn"
// blackmarket
#include "world/blackmarket.pwn"

#include "event/truck.pwn"
#include "event/helicopter.pwn"
#include "event/vehicle.pwn"
#include "event/airdrop.pwn"

// #include "gamemodes/util/color.pwn"
// #include "gamemodes/util/global.pwn"


// #include "gamemodes/player/textdraw.pwn"

// #include "gamemodes/family/main.pwn"
// #include "gamemodes/family/function.pwn"
// #include "gamemodes/family/command.pwn"

// #include "gamemodes/world/map.pwn"
// #include "gamemodes/world/zone.pwn"
// #include "gamemodes/world/world.pwn"
// #include "gamemodes/world/loot/base.pwn"
// #include "gamemodes/world/loot/main.pwn"
// #include "gamemodes/npc/zombie.pwn"
// #include "gamemodes/npc/trader.pwn"
// #include "gamemodes/npc/rebel.pwn"
// #include "gamemodes/player/hud.pwn"

// #include "gamemodes/player/account.pwn"
// #include "gamemodes/player/activity.pwn"
// #include "gamemodes/player/dialog.pwn"
// #include "gamemodes/player/admin.pwn"
// #include "gamemodes/player/anticit.pwn"
// #include "gamemodes/player/level.pwn"
// #include "gamemodes/player/health.pwn"
// #include "gamemodes/player/command/item.pwn"
// #include "gamemodes/player/command/server.pwn"
// #include "gamemodes/player/animation.pwn"
// #include "gamemodes/player/death.pwn"

// #include "gamemodes/pickup/npc.pwn"
// #include "gamemodes/pickup/loot.pwn"
// // custom textdraw

// // in game object manip
// #include "gamemodes/player/weapon.pwn"
// // blackmarket
// #include "gamemodes/world/blackmarket.pwn"



// #include "util/global.pwn"


// #include "player/textdraw.pwn"



// #include "util/color.pwn"
// #include "world/map.pwn"
// #include "world/zone.pwn"
// #include "world/world.pwn"
// #include "npc/zombie.pwn"
// #include "npc/trader.pwn"
// #include "player/hud.pwn"

// #include "player/account.pwn"
// #include "player/activity.pwn"
// #include "player/dialog.pwn"
// #include "player/admin.pwn"
// #include "player/anticit.pwn"
// #include "player/level.pwn"
// #include "player/health.pwn"
// #include "player/command/item.pwn"
// #include "player/animation.pwn"
// #include "player/death.pwn"

// #include "pickup/npc.pwn"
// #include "pickup/loot.pwn"
// // custom textdraw

// // in game object manip
// #include "player/weapon.pwn"
// // blackmarket
// #include "world/blackmarket.pwn"
main()
{
    printf("Gamemode Loaded\n");
}
// Call Back
public OnGameModeInit()
{
    SetGameModeText("Apocalypse v1.0.4b | bug fixed");
    worldSetting();
    loadMap();
    loadZombie();
    return 1;
}




