#define MAX_FAMILY 64

#include <YSI_Coding\y_hooks>

new tempInvite[MAX_PLAYERS];
new tempSetRank[MAX_PLAYERS][MAX_PLAYER_NAME];

enum FAM{
    fName[255],
    fmName1[DINI_MAX_STRING],
    fmRank1,
    fmName2[DINI_MAX_STRING],
    fmRank2,
    fmName3[DINI_MAX_STRING],
    fmRank3,
    fmName4[DINI_MAX_STRING],
    fmRank4,
    fmName5[DINI_MAX_STRING],
    fmRank5,
    fmName6[DINI_MAX_STRING],
    fmRank6,
    fmName7[DINI_MAX_STRING],
    fmRank7,
    fmName8[DINI_MAX_STRING],
    fmRank8,
    fmName9[DINI_MAX_STRING],
    fmRank9,
    fmName10[DINI_MAX_STRING],
    fmRank10,
};

new familyInfo[MAX_FAMILY][FAM];
new familyExist[MAX_FAMILY];

hook OnPlayerConnect(playerid){
    tempInvite[playerid] = INVALID_PLAYER_ID;
    
    return 1;
}

hook OnGameModeInit()
{
    for(new i =0; i<MAX_FAMILY; i++)
    {
        new familyFile[128];
        format(familyFile, sizeof(familyFile), "Family/Fam%d.ini",i);
        if(dini_Exists(familyFile))
        {
            familyExist[i] = 1;
            familyInfo[i][fName] = dini_Get(familyFile, "Name");
            familyInfo[i][fmName1] = dini_Get(familyFile, "MemberName1");
            familyInfo[i][fmName2] = dini_Get(familyFile, "MemberName2");
            familyInfo[i][fmName3] = dini_Get(familyFile, "MemberName3");
            familyInfo[i][fmName4] = dini_Get(familyFile, "MemberName4");
            familyInfo[i][fmName5] = dini_Get(familyFile, "MemberName5");
            familyInfo[i][fmName6] = dini_Get(familyFile, "MemberName6");
            familyInfo[i][fmName7] = dini_Get(familyFile, "MemberName7");
            familyInfo[i][fmName8] = dini_Get(familyFile, "MemberName8");
            familyInfo[i][fmName9] = dini_Get(familyFile, "MemberName9");
            familyInfo[i][fmName10] = dini_Get(familyFile, "MemberName10");
            familyInfo[i][fmRank1] = dini_Int(familyFile, "MemberRank1");
            familyInfo[i][fmRank2] = dini_Int(familyFile, "MemberRank2");
            familyInfo[i][fmRank3] = dini_Int(familyFile, "MemberRank3");
            familyInfo[i][fmRank4] = dini_Int(familyFile, "MemberRank4");
            familyInfo[i][fmRank5] = dini_Int(familyFile, "MemberRank5");
            familyInfo[i][fmRank6] = dini_Int(familyFile, "MemberRank6");
            familyInfo[i][fmRank7] = dini_Int(familyFile, "MemberRank7");
            familyInfo[i][fmRank8] = dini_Int(familyFile, "MemberRank8");
            familyInfo[i][fmRank9] = dini_Int(familyFile, "MemberRank9");
            familyInfo[i][fmRank10] = dini_Int(familyFile, "MemberRank10");
        }
        else
        {
            familyExist[i] = -1;
        }
    }
    return 1;
}
stock saveFam(){
    for(new i =0; i<MAX_FAMILY; i++)
    {
        new familyFile[128];
        format(familyFile, sizeof(familyFile), "Family/Fam%d.ini",i);
        if(dini_Exists(familyFile))
        {
            
            dini_Set(familyFile, "Name", familyInfo[i][fName]);
            dini_Set(familyFile, "MemberName1", familyInfo[i][fmName1]);
            dini_Set(familyFile, "MemberName2", familyInfo[i][fmName2]);
            dini_Set(familyFile, "MemberName3", familyInfo[i][fmName3]);
            dini_Set(familyFile, "MemberName4", familyInfo[i][fmName4]);
            dini_Set(familyFile, "MemberName5", familyInfo[i][fmName5]);
            dini_Set(familyFile, "MemberName6", familyInfo[i][fmName6]);
            dini_Set(familyFile, "MemberName7", familyInfo[i][fmName7]);
            dini_Set(familyFile, "MemberName8", familyInfo[i][fmName8]);
            dini_Set(familyFile, "MemberName9", familyInfo[i][fmName9]);
            dini_Set(familyFile, "MemberName10", familyInfo[i][fmName10]);
            dini_IntSet(familyFile, "MemberRank1", familyInfo[i][fmRank1]);
            dini_IntSet(familyFile, "MemberRank2", familyInfo[i][fmRank2]);
            dini_IntSet(familyFile, "MemberRank3", familyInfo[i][fmRank3]);
            dini_IntSet(familyFile, "MemberRank4", familyInfo[i][fmRank4]);
            dini_IntSet(familyFile, "MemberRank5", familyInfo[i][fmRank5]);
            dini_IntSet(familyFile, "MemberRank6", familyInfo[i][fmRank6]);
            dini_IntSet(familyFile, "MemberRank7", familyInfo[i][fmRank7]);
            dini_IntSet(familyFile, "MemberRank8", familyInfo[i][fmRank8]);
            dini_IntSet(familyFile, "MemberRank9", familyInfo[i][fmRank9]);
            dini_IntSet(familyFile, "MemberRank10", familyInfo[i][fmRank10]);
        }
    }
    return 1;
}
hook OnGameModeExit()
{
    saveFam();
    return 1;
}