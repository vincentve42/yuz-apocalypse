#include <YSI_Coding\y_hooks>

hook OnPlayerTakeDamage(playerid, issuerid, Float:amount, weapid, bodypart)
{
    if(isPlayerInSafeZone(playerid)){
        SetPlayerHealth(playerid, Player[playerid][pHealth]);
        SetPlayerArmour(playerid, Player[playerid][pArmour]);
    }
    else{
        if(weapid >= 0 && weapid <= 46 || weapid == 51)
        {
            if(Player[playerid][pArmour] > amount)
            {
                Player[playerid][pArmour] -= amount;
                SetPlayerArmour(playerid, Player[playerid][pArmour]);
                return 1;
            }
            else if(Player[playerid][pArmour] < amount && Player[playerid][pArmour] > 0)
            {
                Player[playerid][pArmour] = 0;
                SetPlayerArmour(playerid,0);
                return 1;
            }
           
            Player[playerid][pHealth] -= amount;
            SetPlayerHealth(playerid, Player[playerid][pHealth]);
            if(bodypart == 3){
                
                
                new rand = random(2);
                switch(rand){
                    case 0:
                    {
                        if(Player[playerid][pLeftArm] <= 0)
                        {
                            Player[playerid][pLeftArm] = 0.0;
                        }
                        else{
                            Player[playerid][pLeftArm] -= amount;
                        }
                    }
                    case 1:
                    {
                        if(Player[playerid][pRightArm] <= 0)
                        {
                            Player[playerid][pRightArm] = 0.0;
                        }
                        else{
                            Player[playerid][pRightArm] -= amount;
                        }
                    }
                }
            }
            if(bodypart == 4){
                new rand2 = random(2);
                switch(rand2)
                {
                    case 0:{
                        if(Player[playerid][pLeftArm] <= 0)
                        {
                            Player[playerid][pLeftArm] = 0.0;
                        }
                        else{
                            Player[playerid][pLeftArm] -= amount;
                        }
                    }
                    case 1:{
                        if(Player[playerid][pRightArm] <= 0)
                        {
                            Player[playerid][pRightArm] = 0.0;
                        }
                        else{
                            Player[playerid][pRightArm] -= amount;
                        }
                    }
                }
            }
            if(bodypart == 5)
            {
                if(Player[playerid][pLeftArm] <= 0)
                {
                    Player[playerid][pLeftArm] = 0.0;
                }
                else{
                    Player[playerid][pLeftArm] -= amount;
                }
            }
            if(bodypart == 6)
            {
                if(Player[playerid][pRightArm] <= 0)
                {
                    Player[playerid][pRightArm] = 0.0;
                }
                else{
                    Player[playerid][pRightArm] -= amount;
                }
            }
            if(bodypart == 7)
            {
                if(Player[playerid][pLeftFoot] <= 0)
                {
                    Player[playerid][pLeftFoot] = 0.0;
                }
                else{
                    Player[playerid][pLeftFoot] -= amount;
                }
            }
            if(bodypart == 8)
            {
                if(Player[playerid][pRightFoot] <= 0)
                {
                    Player[playerid][pRightFoot] = 0.0;
                }
                else{
                    Player[playerid][pRightFoot] -= amount;
                }
            }
            return 1;
        }
        if(weapid == 50 || weapid == 53 || weapid == 54)
        {
        
            Player[playerid][pHealth] -= amount;
            SetPlayerHealth(playerid, Player[playerid][pHealth]);
            if(weapid == 54){
                
                if(Player[playerid][pLeftFoot] <= 0)
                {
                    Player[playerid][pLeftFoot] = 0.0;
                }
                else{
                    Player[playerid][pLeftFoot] -= amount;
                }
                if(Player[playerid][pRightFoot] <= 0)
                {
                    Player[playerid][pRightFoot] = 0.0;
                }
                else{
                    Player[playerid][pRightFoot] -= amount;
                }
                return 1;
            }
            if(bodypart == 3){
                new rand = random(2);
                switch(rand){
                    case 0:
                    {
                        if(Player[playerid][pLeftArm] <= 0)
                        {
                            Player[playerid][pLeftArm] = 0.0;
                        }
                        else{
                            Player[playerid][pLeftArm] -= amount;
                        }
                    }
                    case 1:
                    {
                        if(Player[playerid][pRightArm] <= 0)
                        {
                            Player[playerid][pRightArm] = 0.0;
                        }
                        else{
                            Player[playerid][pRightArm] -= amount;
                        }
                    }
                }
            }
            if(bodypart == 4){
                new rand2 = random(2);
                switch(rand2)
                {
                    case 0:{
                        if(Player[playerid][pLeftArm] <= 0)
                        {
                            Player[playerid][pLeftArm] = 0.0;
                        }
                        else{
                            Player[playerid][pLeftArm] -= amount;
                        }
                    }
                    case 1:{
                        if(Player[playerid][pRightArm] <= 0)
                        {
                            Player[playerid][pRightArm] = 0.0;
                        }
                        else{
                            Player[playerid][pRightArm] -= amount;
                        }
                    }
                }
            }
            if(bodypart == 5)
            {
                if(Player[playerid][pLeftArm] <= 0)
                {
                    Player[playerid][pLeftArm] = 0.0;
                }
                else{
                    Player[playerid][pLeftArm] -= amount;
                }
            }
            if(bodypart == 6)
            {
                if(Player[playerid][pRightArm] <= 0)
                {
                    Player[playerid][pRightArm] = 0.0;
                }
                else{
                    Player[playerid][pRightArm] -= amount;
                }
            }
            if(bodypart == 7)
            {
                if(Player[playerid][pLeftFoot] <= 0)
                {
                    Player[playerid][pLeftFoot] = 0.0;
                }
                else{
                    Player[playerid][pLeftFoot] -= amount;
                }
            }
            if(bodypart == 8)
            {
                if(Player[playerid][pRightFoot] <= 0)
                {
                    Player[playerid][pRightFoot] = 0.0;
                }
                else{
                    Player[playerid][pRightFoot] -= amount;
                }
            }
            
            return 1;
        }
    }
    return 1;
}