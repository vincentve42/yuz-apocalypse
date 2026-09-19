#include <YSI_Coding\y_hooks>

new vehicleList;

hook OnGameModeInit()
{
    CreateDynamicCP(-2197.9226,-2427.3738,31.4917, 3.0);
    CreateDynamicCP(2303.8335,-16.3179,26.4844, 3.0);
    CreateDynamicCP(-2236.8833,2354.1323,4.9799, 3.0);
    vehicleList = LoadModelSelectionMenu("dealership.txt");
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{  
    if(IsPlayerInRangeOfPoint(playerid, 7.0,-2197.9226,-2427.3738,31.4917 ))
    {
        playerInDealerShip[playerid] = 1;
        ShowModelSelectionMenu(playerid, vehicleList, "Pilih Kendaraan");
        return 1;
    }
    if(IsPlayerInRangeOfPoint(playerid, 7.0,2303.8335,-16.3179,26.4844))
    {
        playerInDealerShip[playerid] = 2;
        ShowModelSelectionMenu(playerid, vehicleList, "Pilih Kendaraan");
        return 1;
    }
    if(IsPlayerInRangeOfPoint(playerid, 7.0,-2236.8833,2354.1323,4.9799 ))
    {
        playerInDealerShip[playerid] = 3;
        ShowModelSelectionMenu(playerid, vehicleList, "Pilih Kendaraan");
        return 1;
    }
        
    
    return 1;
}
hook OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == vehicleList){
        if(response){
            if(isPlayerVehSlotFull(playerid))
            {
                return sendErrorMessage(playerid, "Slot kendaraan anda penuh!");
            }
            switch(modelid){
                case 478:
                {
                    new price = getCarPrice(modelid);
                    if(Player[playerid][pMoney] < price){
                        new error[256];
                        format(error, sizeof(error), "Anda setidaknya harus memiliki uang sebanyak "EMBED_GREEN"%d"EMBED_WHITE" untuk membeli kendaraan %s", getCarPrice(modelid),GetCarName(modelid));
                        playerInDealerShip[playerid] = 0;
                        return sendErrorMessage(playerid, error);
                    }
                }
                case 482:{
                    new price = getCarPrice(modelid);
                    if(Player[playerid][pMoney] < price){
                        new error[256];
                        format(error, sizeof(error), "Anda setidaknya harus memiliki uang sebanyak "EMBED_GREEN"%d"EMBED_WHITE" untuk membeli kendaraan %s", getCarPrice(modelid),GetCarName(modelid));
                        playerInDealerShip[playerid] = 0;
                        return sendErrorMessage(playerid, error);
                    }
                }
                case 483:
                {
                    new price = getCarPrice(modelid);
                    if(Player[playerid][pMoney] < price){
                        new error[256];
                        format(error, sizeof(error), "Anda setidaknya harus memiliki uang sebanyak "EMBED_GREEN"%d"EMBED_WHITE" untuk membeli kendaraan %s", getCarPrice(modelid),GetCarName(modelid));
                        playerInDealerShip[playerid] = 0;
                        return sendErrorMessage(playerid, error);
                    }
                }
                case 498:
                {
                    new price = getCarPrice(modelid);
                    if(Player[playerid][pMoney] < price){
                        new error[256];
                        format(error, sizeof(error), "Anda setidaknya harus memiliki uang sebanyak "EMBED_GREEN"%d"EMBED_WHITE" untuk membeli kendaraan %s", getCarPrice(modelid),GetCarName(modelid));
                        playerInDealerShip[playerid] = 0;
                        return sendErrorMessage(playerid, error);
                    }
                }
                case 549:
                {
                    new price = getCarPrice(modelid);
                    if(Player[playerid][pMoney] < price){
                        new error[256];
                        format(error, sizeof(error), "Anda setidaknya harus memiliki uang sebanyak "EMBED_GREEN"%d"EMBED_WHITE" untuk membeli kendaraan %s", getCarPrice(modelid),GetCarName(modelid));
                        playerInDealerShip[playerid] = 0;
                        return sendErrorMessage(playerid, error);
                    }
                }
                case 468:{
                    new price = getCarPrice(modelid);
                    if(Player[playerid][pMoney] < price){
                        new error[256];
                        format(error, sizeof(error), "Anda setidaknya harus memiliki uang sebanyak "EMBED_GREEN"%d"EMBED_WHITE" untuk membeli kendaraan %s", getCarPrice(modelid),GetCarName(modelid));
                        playerInDealerShip[playerid] = 0;
                        return sendErrorMessage(playerid, error);
                    }
                }
            }
            playerSelectedVehModel[playerid] = modelid;
            new str[128];
            format(str, sizeof(str), "Apakah anda yakin ingin membeli kendaraan "EMBED_YELLOW"%s"EMBED_WHITE" seharga "EMBED_GREEN"%d"EMBED_WHITE"?", GetVehModelName(modelid),getCarPrice(modelid));
            ShowPlayerDialog(playerid, DIALOG_BUY_VEH, DIALOG_STYLE_MSGBOX, "Beli Kendaraan", str,"Beli", "Batal");
        }
    }
    
    return 1;
}

