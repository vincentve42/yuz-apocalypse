public OnPlayerEditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    switch(response){
        
        case EDIT_RESPONSE_FINAL:
        {
            if(!isSpecificCoordinateInLand(playerid, x, y))
            {
                SetDynamicObjectPos(objectid, ObjectInfo[objectid][oX], ObjectInfo[objectid][oY], ObjectInfo[objectid][oZ]);
                SetDynamicObjectRot(objectid, ObjectInfo[objectid][oRx], ObjectInfo[objectid][oRy], ObjectInfo[objectid][oRz]);
                return sendErrorMessage(playerid, "Object tidak bisa disave karena berada diluar batas lahan");
                // kembali ke semula
            }
            ObjectInfo[objectid][oX] = x;
            ObjectInfo[objectid][oY] = y;
            ObjectInfo[objectid][oZ] = z;
            ObjectInfo[objectid][oRx] = rx;
            ObjectInfo[objectid][oRy] = ry;
            ObjectInfo[objectid][oRz] = rz;
            SetDynamicObjectPos(objectid, ObjectInfo[objectid][oX], ObjectInfo[objectid][oY], ObjectInfo[objectid][oZ]);
            SetDynamicObjectRot(objectid, ObjectInfo[objectid][oRx], ObjectInfo[objectid][oRy], ObjectInfo[objectid][oRz]);
            saveSpecificObject(tempObjectID[playerid]);     
            tempObjectID[playerid] = 0;
            return sendSuccessMessage(playerid, "Berhasil menyimpan posisi objek");
            
        }
        case EDIT_RESPONSE_CANCEL:
        {
            SetDynamicObjectPos(objectid, ObjectInfo[objectid][oX], ObjectInfo[objectid][oY], ObjectInfo[objectid][oZ]);
            SetDynamicObjectRot(objectid, ObjectInfo[objectid][oRx], ObjectInfo[objectid][oRy], ObjectInfo[objectid][oRz]);
            return 1;
        }
    }
    return 1;
}