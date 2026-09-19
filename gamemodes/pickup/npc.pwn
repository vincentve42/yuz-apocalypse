#include <YSI_Coding\y_hooks>


hook FCNPC_OnDeath(npcid, killerid, reason)
{
    for(new i=0; i<1000; i++)
    {
        if(npcid == npcId[i])
        {
            new Float:x, Float:y, Float:z;
            FCNPC_GetPosition(npcid, x,y, z);
            if(NpcPickup[npcid] == -1)
            {

                NpcPickup[npcid] = CreateDynamicPickup(1279, 8,x,y,z, 0);
                NpcPickupInfo[NpcPickup[npcid]][npX] = x;
                NpcPickupInfo[NpcPickup[npcid]][npY] = y;
                NpcPickupInfo[NpcPickup[npcid]][npZ] = z;
            }
            else
            {
                DestroyPickup(NpcPickup[npcid]);
                NpcPickup[npcid] = CreateDynamicPickup(1279, 8,x,y,z, 0);
            }
        }
    }
    
    return 1;
}