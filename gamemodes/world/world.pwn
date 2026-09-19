#include <YSI_Coding\y_hooks>

new serverHour;
new radiationStorm = 0;


forward updateWeather();
forward updateTime();
forward randomStorm();
forward stopSound(playerid);
forward stopStorm();

public stopStorm(){
    radiationStorm = 0;
    SetWeather(0);
    new str[128];
    format(str, sizeof(str), ""EMBED_YELLOW"[INFO] "EMBED_WHITE"Badai telah berakhir!");
    SendClientMessageToAll(-1, str);
    new timez = 1800000 + random(3600000);
    SetTimer("randomStorm", timez, false);
    return 1;
}
public stopSound(playerid){
    StopAudioStreamForPlayer(playerid);
    return 1;
}
public randomStorm(){
    radiationStorm = 1;
    SetWeather(19);
    new str[128];
    format(str, sizeof(str), ""EMBED_REALRED"[PERINGATAN] "EMBED_WHITE"Badai radiasi terjadi selama 5 menit silahkan cari tempat aman atau pakai masker gas");
    SendClientMessageToAll(-1, str);
    for(new i=0; i<MAX_PLAYERS; i++)
    {
        if(!IsPlayerNPC(i))
        {
            PlayAudioStreamForPlayer(i,"http://j.top4top.io/m_38557i1sa1.mp3",0.0,0.0,0.0,0.0,false);
            SetTimerEx("stopSound", 60000, false, "i", i);
        }
    }
    SetTimer("stopStorm", 300000, false);
    return 1;
}

stock worldSetting(){
    new hour, minutes, second;
    ShowNameTags(false);
    ShowPlayerMarkers(0);
    gettime(hour, minutes, second);
    new tochange = 3600000 - ((second * 1000) + (minutes * 60000));
    
    SetTimer("updateWeather", 3600000, true);

    SetTimer("updateTime", tochange, false);
    new weather = random(19);
    SetWeather(weather);
    DisableInteriorEnterExits();
    SetWorldTime(hour);
    serverHour = hour;
    new timez = 1800000 + random(3600000);
    SetTimer("randomStorm", timez, false);
    return 1;
}
hook OnPlayerSpawn(playerid){
    if(serverHour >= 18 || serverHour < 6){
        new announcement[128];
        format(announcement, sizeof(announcement), ""EMBED_YELLOW"[INFO] "EMBED_WHITE"Peringatan waktu sudah menunjukan waktu malam zombie akan semakin ganas");
        SendClientMessage(playerid, -1, announcement);
    }
    if(radiationStorm == 1)
    {
        new str[128];
        format(str, sizeof(str), ""EMBED_REALRED"[PERINGATAN] "EMBED_WHITE"Badai radiasi terjadi selama 5 menit silahkan cari tempat aman atau pakai masker gas");
        SendClientMessage(playerid,-1, str);
    }
    return 1;
}
public updateTime(){
    new hour, minutes, second;
    gettime(hour, minutes, second);
    new str[64];
    format(str, sizeof(str), "Waktu Server: %02d:%02d:%02d", hour, minutes, second);

    SendClientMessageToAll( -1, str);
    SetWorldTime(hour);
    new tochange = 3600000 - ((second * 1000) + (minutes * 60000));
    SetTimer("updateTime", tochange, false);
    serverHour = hour;
    if(serverHour >= 18  || serverHour < 6){
        new announcement[128];
        format(announcement, sizeof(announcement), ""EMBED_YELLOW"[INFO] "EMBED_WHITE"Peringatan waktu sudah menunjukan waktu malam zombie akan semakin ganas");
        SendClientMessageToAll(-1, announcement);
    }
    return 1;
}
public updateWeather()
{
    new weather = random(19);
    SetWeather(weather);
    return 1;
}

