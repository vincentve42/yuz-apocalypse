#include <YSI_Coding\y_hooks>

#define MAX_DYNAMIC_OBJECT 40000

#define OBJECT_COST 100

#define MAX_OBJECT_LAHAN 100

enum OBJECT{
    famZoneId,
    oModel,
    Float:oX,
    Float:oY,
    Float:oZ,
    Float:oRx,
    Float:oRy,
    Float:oRz
};

new ObjectId[MAX_DYNAMIC_OBJECT];
new ObjectInfo[MAX_DYNAMIC_OBJECT][OBJECT];
new tempObjectID[MAX_PLAYERS];

hook OnPlayerConnect(playerid){
    tempObjectID[playerid] = 0;
}

hook OnGameModeInit()
{
    for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
    {
        new objectFile[64];
        format(objectFile, sizeof(objectFile), "Object/%d.ini", i);
        if(dini_Exists(objectFile))
        {
            
            new modelid = dini_Int(objectFile, "Model");
            new famZoneIds = dini_Int(objectFile, "FamZone");
            new Float:x, Float:y, Float:z;
            x = dini_Float(objectFile, "X");
            y = dini_Float(objectFile, "Y");
            z = dini_Float(objectFile, "Z");
            new Float:rX, Float:rY, Float:rZ;
            rX = dini_Float(objectFile, "rX");
            rY = dini_Float(objectFile, "rY");
            rZ = dini_Float(objectFile, "rZ");
            ObjectId[i] = CreateDynamicObject(modelid, x, y, z, rX,rY,rZ, -1);
            ObjectInfo[ObjectId[i]][oModel] = modelid;
            ObjectInfo[ObjectId[i]][famZoneId] = famZoneIds;
            ObjectInfo[ObjectId[i]][oX] = x;
            ObjectInfo[ObjectId[i]][oY] = y;
            ObjectInfo[ObjectId[i]][oZ] = z;
            ObjectInfo[ObjectId[i]][oRx] = rX;
            ObjectInfo[ObjectId[i]][oRy] = rY;
            ObjectInfo[ObjectId[i]][oRz] = rZ;
        }
        else
        {
            ObjectId[i] = -1;
        }
    }
    return 1;
}

hook OnGameModeExit()
{
    saveObject();
    return 1;
}
stock saveObject()
{
    for(new i=0; i<MAX_DYNAMIC_OBJECT; i++)
    {
        new objectFile[64];
        format(objectFile, sizeof(objectFile), "Object/%d.ini", i);
        if(dini_Exists(objectFile))
        {
            dini_IntSet(objectFile, "Model", ObjectInfo[ObjectId[i]][oModel]);
            dini_IntSet(objectFile, "FamZone", ObjectInfo[ObjectId[i]][famZoneId]);
            dini_FloatSet(objectFile, "X", ObjectInfo[ObjectId[i]][oX]);
            dini_FloatSet(objectFile, "Y", ObjectInfo[ObjectId[i]][oY]);
            dini_FloatSet(objectFile, "Z", ObjectInfo[ObjectId[i]][oZ]);
            dini_FloatSet(objectFile, "rX", ObjectInfo[ObjectId[i]][oRx]);
            dini_FloatSet(objectFile, "rY", ObjectInfo[ObjectId[i]][oRy]);
            dini_FloatSet(objectFile, "rZ", ObjectInfo[ObjectId[i]][oRz]);
        }

    }
    return 1;
}
stock saveSpecificObject(i)
{  
    
    new objectFile[64];
    format(objectFile, sizeof(objectFile), "Object/%d.ini", i);
    if(dini_Exists(objectFile))
    {
        
        dini_IntSet(objectFile, "Model", ObjectInfo[ObjectId[i]][oModel]);
        dini_IntSet(objectFile, "FamZone", ObjectInfo[ObjectId[i]][famZoneId]);
        dini_FloatSet(objectFile, "X", ObjectInfo[ObjectId[i]][oX]);
        dini_FloatSet(objectFile, "Y", ObjectInfo[ObjectId[i]][oY]);
        dini_FloatSet(objectFile, "Z", ObjectInfo[ObjectId[i]][oZ]);
        dini_FloatSet(objectFile, "rX", ObjectInfo[ObjectId[i]][oRx]);
        dini_FloatSet(objectFile, "rY", ObjectInfo[ObjectId[i]][oRy]);
        dini_FloatSet(objectFile, "rZ", ObjectInfo[ObjectId[i]][oRz]);
    }
    return 1;
}

