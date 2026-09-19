#define PROGRESS_BANDAGE 25.0
#define PROGRESS_ANTIBIOTIC 50.0
#define PROGRESS_LOOTING 25.0

hook OnPlayerConnect(playerid){
    ActivityTimer[playerid] = 0;
    return 1;
}
hook OnPlayerDisconnect(playerid, reason){
    KillTimer(ActivityTimer[playerid]);
    return 1;
}
forward setActivity(playerid, type);

public setActivity(playerid, type)
{
    if(playerActivity[playerid] != 0)
    {
        return sendErrorMessage(playerid, "Anda sedang beraktivitas");
    }
    if(type == 0){
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        ApplyAnimation(playerid,"BOMBER", "BOM_Plant",4.1, 1,1,1,1, 4000);
        ActivityTimer[playerid] = SetTimerEx("updateTextDrawProgress", 1000, true, "ifd", playerid, PROGRESS_LOOTING, 0);
    } //loot
    if(type == 1) // bandage leftarm
    {
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        ApplyAnimation(playerid,"BOMBER", "BOM_Plant",4.1, 0,0,0,0, 4000,1);
        ActivityTimer[playerid] = SetTimerEx("updateTextDrawProgress", 1000, true, "ifd", playerid, PROGRESS_BANDAGE, 1);
        
    }
    
    if(type == 2) // antibiotic
    {
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        ApplyAnimation(playerid,"BAR", "dnk_stndM_loop",4.1, 0,0,0,0, 2000,1);
        ActivityTimer[playerid] = SetTimerEx("updateTextDrawProgress", 1000, true, "ifd", playerid, PROGRESS_ANTIBIOTIC, 2);
    }
    if(type == 3) // minum
    {
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        ApplyAnimation(playerid,"BAR", "dnk_stndM_loop",4.1, 0,0,0,0, 2000,1);
        ActivityTimer[playerid] = SetTimerEx("updateTextDrawProgress", 1000, true, "ifd", playerid, PROGRESS_ANTIBIOTIC, type);
    }
    if(type == 4) // makan apel
    {
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        ApplyAnimation(playerid,"FOOD", "EAT_Burger",4.1, 0,0,0,0, 5000,1);
        ActivityTimer[playerid] = SetTimerEx("updateTextDrawProgress", 1000, true, "ifd", playerid, 20.0, type);
    }
    if(type == 5) // makan pizza
    {
        ActivityProgress[playerid] = 0.0;
        showPlayerActivityTextdraw(playerid);
        TogglePlayerControllable(playerid, false);
        playerActivity[playerid] = 1;
        ApplyAnimation(playerid,"FOOD", "EAT_Pizza",4.1, 0,0,0,0, 5000,1);
        ActivityTimer[playerid] = SetTimerEx("updateTextDrawProgress", 1000, true, "ifd", playerid, 25.0, type);
    }
    return 1;
}