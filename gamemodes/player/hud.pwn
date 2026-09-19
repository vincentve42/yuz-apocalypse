#include <YSI_Coding\y_hooks>

new UseGasmask[MAX_PLAYERS];

forward updateDrink(playerid);
forward updateHunger(playerid);
forward updateRadiation(playerid);

public updateRadiation(playerid){
    if(!isPlayerInSafeZone(playerid)){
        if(UseGasmask[playerid] == 1)
        {
            if(Player[playerid][pRadiation] <= 0)
            {
                sendInfoMessage(playerid, "Masker gas anda rusak silahkan pakai ulang");
                UseGasmask[playerid] = 0;
            } 
            else{
                new Float:addi = 0.0;
                if(radiationStorm == 1)
                {
                    addi = 4.0;
                }
                if(isPlayerInContZone(playerid))
                {
                    Player[playerid][pRadiation] -= 2.0 + addi;
                }
                else
                {
                    Player[playerid][pRadiation] -= 1.0 + addi;
                }
            }
        }
        else{
            Player[playerid][pHealth] -= 5.0;
            sendInfoMessage(playerid, "Anda keracunan radiasi nuklir silahkan pakai masker gas anda");
        }
    }
    setRadiationVal(playerid);
    return 1;
}
public updateHunger(playerid){
    if(Player[playerid][pHunger] <= 0)
    {
        Player[playerid][pHealth] -= 1.0;
        SetPlayerHealth(playerid, Player[playerid][pHealth]);
        sendInfoMessage(playerid, "Anda kelaparan cari makanan segera!!");
        
    }
    else
    {
        Player[playerid][pHunger] -= 1.0;
        setHungerVal(playerid);
    }
    return 1;
}
public updateDrink(playerid){
    if(Player[playerid][pThrist] <= 0)
    {
        Player[playerid][pHealth] -= 1.0;
        SetPlayerHealth(playerid, Player[playerid][pHealth]);
        sendInfoMessage(playerid, "Anda kehausan cari minum segera!!");
        
    }
    else
    {
        Player[playerid][pThrist] -= 1.0;
        setThristVal(playerid);
    }
    return 1;
}
