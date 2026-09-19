

new npcId[1024];

new JumlahTraderNpc = 0;

new TraderNpc[1024];

new NpcPickup[1000];

enum NPC_PICKUP{
    Float:npX,
    Float:npY,
    Float:npZ
};

new NpcPickupInfo[1000][NPC_PICKUP];
new InfectedTimer[MAX_PLAYERS];


new infectedAlrRun[MAX_PLAYERS];

enum TRD{
    Float:tX, 
    Float:tY, 
    Float:tZ,
};
new TraderNpcInfo[1000][TRD];

enum ZMB{
    zType,
    Float:zX,
    Float:zY,
    Float:zZ
};
new ZombieInfo[1000][ZMB];

new playerIsDead[MAX_PLAYERS];

new Text3D:player3DTextLabel[MAX_PLAYERS];

new isChasing[1000];

new tryPassword[MAX_PLAYERS];
new isPlayerLogged[MAX_PLAYERS];
new Logged[MAX_PLAYERS];

#define LOOT_BANDAGE 11736
#define LOOT_MONEY 1212
#define LOOT_ANTIBIOTIK 2709
#define LOOT_SCRAP 2057
#define LOOT_PIZZA 1582
#define LOOT_APEL 19320
#define LOOT_ARMOUR 1242
#define LOOT_MINUMAN 1512
#define LOOT_GAS 1650

#define MAX_LOOT 4000
new LootModel[] = {LOOT_BANDAGE, LOOT_ANTIBIOTIK, LOOT_SCRAP, LOOT_ARMOUR, LOOT_PIZZA, LOOT_APEL, LOOT_MONEY, LOOT_MINUMAN, LOOT_GAS}; 

new PlayerPickSmth[MAX_PLAYERS];



enum PickupState{
    piId,
    piType,
    piAmount
};

new LootPickupState[MAX_PLAYERS][PickupState];

new LootPickup[MAX_LOOT];

enum LOOT{
    lModel, 
    Float:lX, 
    Float:lY, 
    Float:lZ,
    lAmount
};

new LootInfo[MAX_LOOT][LOOT];

new LootID[MAX_PLAYERS];

enum DEATH{
    dWeapon,
    dAmmo,
    Float:dX,
    Float:dY,
    Float:dZ
};
#define MAX_DEATH_LOOT 10000
new deathObject[MAX_DEATH_LOOT];
new deathItem[MAX_DEATH_LOOT][DEATH];
new PlayerPickBaseLoot[MAX_PLAYERS];
new deathItemPickup[MAX_PLAYERS];
new deathID[MAX_PLAYERS];

new Float:baseLootX[MAX_PLAYERS];
new Float:baseLootY[MAX_PLAYERS];
new Float:baseLootZ[MAX_PLAYERS];
// function declaration
forward getName(playerid, const str[]);
forward checkIfUserExist(playerid);
// mapping funct

forward worldSetting();
forward rmBuilding(playerid);
forward saveAccount(playerid);
forward loadAccount(playerid);

// rebel
#define MAX_REBEL 1000

new rebelSkin[] = {287, 285, 286, 73};

new rebelWeapon[] = {29, 31, 27};

enum REBEL{
    rSkin, 
    rWeapon,
    Float:rrX, 
    Float:rrY, 
    Float:rrZ
}
new rebelNpc[MAX_REBEL];
new rebelNpcInfo[MAX_REBEL][REBEL];
new rebelNpcDead[MAX_REBEL];

new maleSkinList;
new femaleSkinList;
new objectList;

new stepRegister[MAX_PLAYERS];

new playerTogPm[MAX_PLAYERS];