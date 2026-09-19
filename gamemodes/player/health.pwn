#include <YSI_Coding\y_hooks>

new FallTimer[MAX_PLAYERS];
new FallEndTimer[MAX_PLAYERS];
forward healBodyPart(playerid, bodypart);
public healBodyPart(playerid, bodypart){
    if(bodypart == 1){
        if(Player[playerid][pLeftArm] >= 100)
        {
            return 0;
        }
        Player[playerid][pLeftArm] += 10.0;
        return 1;
    }
    if(bodypart == 2){
        if(Player[playerid][pRightArm] >= 100)
        {
            return 0;
        }
        Player[playerid][pRightArm] += 10.0;
        return 1;
    }
    if(bodypart == 3){
        if(Player[playerid][pLeftFoot] >= 100)
        {
            return 0;
        }
        Player[playerid][pLeftFoot] += 10.0;
        return 1;
    }
    if(bodypart == 4){
        if(Player[playerid][pRightFoot] >= 100)
        {
            return 0;
        }
        Player[playerid][pRightFoot] += 10.0;
        return 1;
    }
    return 1;
}
forward playerFallEnd(playerid);
public playerFallEnd(playerid){
    
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    ApplyAnimation(playerid,"ped", "getup",4.1, 0,0,0,0, 1,1);
    return 1;
}
forward playerFall(playerid);
public playerFall(playerid){
    
    ApplyAnimation(playerid,"ped", "BIKE_fall_off",4.1, 0,0,0,1, 5000,1);
    FallEndTimer[playerid] = SetTimerEx("playerFallEnd", 5000, false, "i", playerid);
    return 1;
}
stock ensureHealthNotNegative(playerid){
    if(isPlayerLogged[playerid] == 0 && Logged[playerid] == 0) return 0;
    if(Player[playerid][pRightArm] <= 0.0)
    {
        Player[playerid][pRightArm] = 0.0;
    }
    if(Player[playerid][pLeftArm] <= 0.0)
    {
        Player[playerid][pLeftArm] = 0.0;
    }
    if(Player[playerid][pLeftFoot] <= 0.0)
    {
        Player[playerid][pLeftFoot] = 0.0;
    }
    if(Player[playerid][pRightFoot] <= 0)
    {
        Player[playerid][pRightFoot] = 0.0;
    }
    return 1;
}

stock checkArmHealth(playerid){
    new apayangrusak = 0;
    if(Player[playerid][pLeftArm] <= 25.0)
    {
        apayangrusak += 1;
    }
    if(Player[playerid][pRightArm] <= 25.0)
    {
        apayangrusak += 2;
    }
    return apayangrusak;
}

stock checkFootHealth(playerid){
    new apayangrusak = 0;
    if(Player[playerid][pRightFoot] <= 25.0)
    {
        apayangrusak += 2;
    }
    if(Player[playerid][pLeftFoot] <= 25.0)
    {
        apayangrusak += 1;
    }
    return apayangrusak;
}

hook OnPlayerUpdate(playerid){
    if(UseGun[playerid] == 1){
        new checkhealth = checkArmHealth(playerid);
        if(checkhealth > 0)
        {
            if(checkhealth == 1)
            {
                sendErrorMessage(playerid, "Lengan kiri anda terluka silahkan gunakan bandage");
            }
            if(checkhealth == 2)
            {
                sendErrorMessage(playerid, "Lengan kanan anda terluka silahkan gunakan bandage");
            }
            if(checkhealth == 3)
            {
                sendErrorMessage(playerid, "Kedua lengan anda terluka silahkan gunakan bandage");
            }
            UseGun[playerid] = 0;
            ResetPlayerWeapons(playerid);
        }
    }
    ensureHealthNotNegative(playerid);
    return 1;
}
hook OnPlayerSpawn(playerid){
    ensureHealthNotNegative(playerid);
    return 1;
}
hook OnPlayerDisconnect(playerid){
    KillTimer(FallTimer[playerid]);
    return 1;
}
hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys){
    if(newkeys & KEY_JUMP)
    {
        new checkhealth = checkFootHealth(playerid);
        if(checkhealth > 0)
        {
            switch(checkhealth)
            {
                case 1:{
                    sendErrorMessage(playerid, "Kaki kiri anda terluka silahkan obati dengan bandage");
                }
                case 2:
                {
                    sendErrorMessage(playerid, "Kaki kanan anda terluka silahkan obati dengan bandage");
                }
                case 3:{
                    sendErrorMessage(playerid, "Kedua kaki anda terluka silahkan obati dengan bandage");
                }
               
            }
            
            FallTimer[playerid] = SetTimerEx("playerFall", 1000, false, "i", playerid);
            
            return 0;
        }
        
    }
    return 1;
}
hook OnPlayerCommandText(playerid, cmdtext[])
{
    if(!strcmp(cmdtext, "/health", true))
    {
        new str[256];
        new statusLeftFoot[64];
        new statusRightFoot[64];
        new statusLeftArm[64];
        new statusRightArm[64];
        // Left Arm
        if(Player[playerid][pLeftArm] >= 80.0)
        {
            format(statusLeftArm, sizeof(statusLeftArm), ""EMBED_GREEN"Baik");
        }
        if(Player[playerid][pLeftArm] < 80.0 && Player[playerid][pLeftArm] > 25.0)
        {
            format(statusLeftArm, sizeof(statusLeftArm), ""EMBED_YELLOW"Kurang Baik");
        }
        if(Player[playerid][pLeftArm] <= 25.0)
        {
            format(statusLeftArm, sizeof(statusLeftArm), ""EMBED_RED"Buruk");
        }
        // Right Arm
        if(Player[playerid][pRightArm] >= 80.0)
        {
            format(statusRightArm, sizeof(statusRightArm), ""EMBED_GREEN"Baik");
        }
        if(Player[playerid][pRightArm] < 80.0 && Player[playerid][pRightArm] > 25.0)
        {
            format(statusRightArm, sizeof(statusRightArm), ""EMBED_YELLOW"Kurang Baik");
        }
        if(Player[playerid][pRightArm] <= 25.0)
        {
            format(statusRightArm, sizeof(statusRightArm), ""EMBED_RED"Buruk");
        }
        // Left Foot
        if(Player[playerid][pLeftFoot] >= 80.0)
        {
            format(statusLeftFoot, sizeof(statusLeftFoot), ""EMBED_GREEN"Baik");
        }
        if(Player[playerid][pLeftFoot] < 80.0 && Player[playerid][pLeftFoot] > 25.0)
        {
            format(statusLeftFoot, sizeof(statusLeftFoot), ""EMBED_YELLOW"Kurang Baik");
        }
        if(Player[playerid][pLeftFoot] <= 25.0)
        {
            format(statusLeftFoot, sizeof(statusLeftFoot), ""EMBED_RED"Buruk");
        }
        // Right Foot
        if(Player[playerid][pRightFoot] >= 80.0)
        {
            format(statusRightFoot, sizeof(statusRightFoot), ""EMBED_GREEN"Baik");
        }
        if(Player[playerid][pRightFoot] < 80.0 && Player[playerid][pRightFoot] > 25.0)
        {
            format(statusRightFoot, sizeof(statusRightFoot), ""EMBED_YELLOW"Kurang Baik");
        }
        if(Player[playerid][pRightFoot] <= 25.0)
        {
            format(statusRightFoot, sizeof(statusRightFoot), ""EMBED_RED"Buruk");
        }
        new apakahInfeksi[64];
        if(Player[playerid][pInfected] == 0)
        {
            format(apakahInfeksi, sizeof(apakahInfeksi), ""EMBED_GREEN"Sehat");
        }
        if(Player[playerid][pInfected] == 1)
        {
            format(apakahInfeksi, sizeof(apakahInfeksi), ""EMBED_RED"Sakit");
        }
        format(str, sizeof(str), "Tubuh\tStatus\nInfeksi\t%s\nLengan Kiri\t%s\nLengan Kanan\t%s\nKaki kiri\t%s\nKaki kanan\t%s", apakahInfeksi, statusLeftArm, statusRightArm, statusLeftFoot, statusRightFoot);
        ShowPlayerDialog(playerid, DIALOG_HEALTH, DIALOG_STYLE_TABLIST_HEADERS, "Kesehatan", str, "Close", "");
        return 1;
    }
    return 0;
}