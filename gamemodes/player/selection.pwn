#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
    maleSkinList = LoadModelSelectionMenu("male.txt");
    femaleSkinList = LoadModelSelectionMenu("female.txt");
    objectList = LoadModelSelectionMenu("object.txt");
    return 1;
}

public OnPlayerModelSelection(playerid, response, listid, modelid)
{
    if(listid == maleSkinList){
        if(response){
            Player[playerid][pSkin] = modelid;
            stepRegister[playerid]++;
            SpawnPlayer(playerid);
            
        }
    }
    if(listid == femaleSkinList){
        if(response){
            Player[playerid][pSkin] = modelid;
            stepRegister[playerid]++;
            SpawnPlayer(playerid);
        }
    }
    if(listid == objectList)
    {
        if(response){
            if(Player[playerid][pScrap] < OBJECT_COST)
            {
                new str[128];
                format(str, sizeof(str), "Anda harus memiliki %d scrap untuk membuat object", OBJECT_COST);
                return sendErrorMessage(playerid, str);
            }
            for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
            {
                if(ObjectId[i] == -1)
                {
                    new Float:x, Float:y, Float:z;
                    GetPlayerPos(playerid, x, y, z);
                    ObjectId[i] = CreateDynamicObject(modelid, x, y, z, 0.0, 0.0, 0.0, -1);
                    new objectFile[64];
                    format(objectFile, sizeof(objectFile), "Object/%d.ini", i);
                    dini_Create(objectFile);
                    ObjectInfo[ObjectId[i]][oX] = x;
                    ObjectInfo[ObjectId[i]][oY] = y;
                    ObjectInfo[ObjectId[i]][oZ] = z;
                    ObjectInfo[ObjectId[i]][oModel] = modelid;
                    ObjectInfo[ObjectId[i]][famZoneId] = tempManageLand[playerid];
                    ObjectInfo[ObjectId[i]][oRx] = 0.0;
                    ObjectInfo[ObjectId[i]][oRy] = 0.0;
                    ObjectInfo[ObjectId[i]][oRz] = 0.0;
                    dini_IntSet(objectFile, "Model", ObjectInfo[ObjectId[i]][oModel]);
                    dini_IntSet(objectFile, "FamZone", ObjectInfo[ObjectId[i]][famZoneId]);
                    dini_FloatSet(objectFile, "X", ObjectInfo[ObjectId[i]][oX]);
                    dini_FloatSet(objectFile, "Y", ObjectInfo[ObjectId[i]][oY]);
                    dini_FloatSet(objectFile, "Z", ObjectInfo[ObjectId[i]][oZ]);
                    dini_FloatSet(objectFile, "rX", ObjectInfo[ObjectId[i]][oRx]);
                    dini_FloatSet(objectFile, "rY", ObjectInfo[ObjectId[i]][oRy]);
                    dini_FloatSet(objectFile, "rZ", ObjectInfo[ObjectId[i]][oRz]);
                    new str[128];
                    format(str, sizeof(str), "Berhasil membuat objek id %d", i);
                    return sendSuccessMessage(playerid, str);

                }
            }
        }
    }
    return 1;
}