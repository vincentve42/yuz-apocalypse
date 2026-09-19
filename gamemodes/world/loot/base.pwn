#include <YSI_Coding\y_hooks>
new Base1Loot[3];
new Base2Loot;
new Float:Base2Lok[3];
new Float:Base2Pos[][3] = {{1020.2291,-2842.2261,12.9328}, {1041.7336,-2897.2202,10.9679}, {1014.1478,-2804.8691,21.5522}, {1060.9608,-2774.7480,12.5681}, {940.0756,-2774.8423,23.3868}};
new Base3Loot;
new Base4Loot;
forward respawnBase4();
public respawnBase4()
{
    if(Base4Loot == -1)
    {
        new str[128];
        format(str, sizeof(str), ""EMBED_YELLOW"[INFO]"EMBED_WHITE" Loot Pulau Terpencil telah di respawn");
        Base4Loot = CreatePickup(348,1,-2128.3125,1753.3145,4.8889, -1);
        SendClientMessageToAll(-1, str);
    }
    return 1;
}
forward respawnBase3();
public respawnBase3()
{
    if(Base3Loot == -1)
    {
        new str[128];
        format(str, sizeof(str), ""EMBED_YELLOW"[INFO]"EMBED_WHITE" Loot Area 51 telah di respawn");
        SendClientMessageToAll(-1, str);
        Base3Loot = CreatePickup(359,1,214.3931,1822.7318,6.4141, -1);
    }
    return 1;
}
forward respawnBase2();
public respawnBase2()
{
    if(Base2Loot == -1)
    {
        new str[128];
        format(str, sizeof(str), ""EMBED_YELLOW"[INFO]"EMBED_WHITE" Loot Pembangkit Nuklir telah di respawn");
        SendClientMessageToAll(-1, str);
        new rand = random(sizeof(Base2Pos));
        Base2Lok[0] = Base2Pos[rand][0];
        Base2Lok[1] = Base2Pos[rand][1];
        Base2Lok[2] = Base2Pos[rand][2];
        Base2Loot = CreateDynamicPickup(362,1,Base2Lok[0], Base2Lok[1], Base2Lok[0], -1);
        return 1;
    }
    return 1;
}
forward reloadBase1();
public reloadBase1(){
    for(new i=0; i<sizeof(Base1Loot); i++)
    {
        if(Base1Loot[i] != -1)
        {
            DestroyPickup(Base1Loot[i]);
        }
    }
    DestroyPickup(Base1Loot[0]);
    DestroyPickup(Base1Loot[1]);
    DestroyPickup(Base1Loot[2]);
    new str[128];
    format(str, sizeof(str), ""EMBED_YELLOW"[INFO]"EMBED_WHITE" Loot Hotel Terbengkalai telah di respawn");
    SendClientMessageToAll(-1, str);
    Base1Loot[0] = CreatePickup(356, 1, 1027.5332,2674.9331,58.0263, -1); // M4 500 ammo
    Base1Loot[1] = CreatePickup(1550, 1, 1025.3779,2617.0757,65.2469, -1); // Money 75k
    Base1Loot[2] = CreatePickup(358, 1, 1038.8926,2615.7952,96.5282, -1); // sniper 50 ammo
    
    return 1;
}

hook OnPlayerConnect(playerid){
    SetPlayerMapIcon(playerid, 0, 1038.8926,2615.7952,96.5282, 37, 0, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 1, 1014.1714,-2782.6277,56.9594, 37, 0, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 2, 172.3931,1878.7318,20.8593, 37, 0, MAPICON_LOCAL);
    SetPlayerMapIcon(playerid, 3, -2104.3049,1754.1272,25.3099, 37, 0, MAPICON_LOCAL);
    return 1;
}

hook OnGameModeInit()
{
    Base1Loot[0] = CreatePickup(356, 1, 1027.5332,2674.9331,58.0263, -1); // M4 500 ammo
    Base1Loot[1] = CreatePickup(1550, 1, 1025.3779,2617.0757,65.2469, -1); // Money 75k
    Base1Loot[2] = CreatePickup(358, 1, 1038.8926,2615.7952,96.5282, -1); // sniper 50 ammo
    SetTimer("reloadBase1", 14400000, true);
    SetTimer("respawnBase2", 14400000, true);
    SetTimer("respawnBase3", 14400000, true);
    SetTimer("respawnBase4", 14400000, true);
    new rand = random(sizeof(Base2Pos));
    Base2Lok[0] = Base2Pos[rand][0];
    Base2Lok[1] = Base2Pos[rand][1];
    Base2Lok[2] = Base2Pos[rand][2];
    Base2Loot = CreatePickup(362,1,Base2Lok[0], Base2Lok[1], Base2Lok[2], -1);
    Base3Loot = CreatePickup(359,1,214.3931,1822.7318,6.4141, -1);
    Base4Loot = CreatePickup(348,1,-2128.3125,1753.3145,4.8889, -1);
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[]){
    if(!strcmp(cmdtext, "/respawnraid", true))
    {
        if(Player[playerid][pAdmin] < 1)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin");
        }
        if(Player[playerid][pAdmin] < 5)
        {
            return sendErrorMessage(playerid, "Anda bukan seorang admin level 5");
        }
        SetTimer("reloadBase1", 1000, false);
        SetTimer("respawnBase2", 1000, false);
        SetTimer("respawnBase3", 1000, false);
        SetTimer("respawnBase4", 1000, false);
        return sendSuccessMessage(playerid, "Anda sukses melakukan respawn rare loot");
    }
    return 0;
}
