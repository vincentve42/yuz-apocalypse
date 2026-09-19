
#include <YSI_Coding\y_hooks>

new PlayerText:vehSpeedo[ MAX_PLAYERS ][ 14 ];
new const vehNames[212][] = {
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Article Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Article Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};
bool:isWawVehicle(vehid)
{
	switch(GetVehicleModel(vehid))
	{
		case 481, 509, 510: return true;
	}
	return false;
}
Float:GetVehicleSpeed(vehicleid)
{
	new
	    Float:x,
	    Float:y,
	    Float:z;
 
	if(GetVehicleVelocity(vehicleid, x, y, z))
	{
		return floatsqroot((x * x) + (y * y) + (z * z)) * 181.5;
	}
 
	return 0.0;
}
GetCarName(vehicleid)
{
	new
		modelid = GetVehicleModel(vehicleid),
		name[32];
 
	if(400 <= modelid <= 611)
	    strcat(name, vehNames[modelid - 400]);
	else
	    name = "Unknown";
 
	return name;
}
hook OnPlayerConnect(playerid){
    vehSpeedo[ playerid ][ 0 ] = CreatePlayerTextDraw(playerid, 492.884338, 341.250000, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 0 ], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, vehSpeedo[ playerid ][ 0 ], 147.115661, 106.750000);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 0 ], 1);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 0 ], 378714367);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 0 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 0 ], 0);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 0 ], 4);
 
	vehSpeedo[ playerid ][ 1 ] = CreatePlayerTextDraw(playerid, 640.594421, 344.500000, "usebox");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 1 ], 0.000000, 11.090743);
	PlayerTextDrawTextSize(playerid, vehSpeedo[ playerid ][ 1 ], 491.821380, 0.000000);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 1 ], 1);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 1 ], 0);
	PlayerTextDrawUseBox(playerid, vehSpeedo[ playerid ][ 1 ], true);
	PlayerTextDrawBoxColor(playerid, vehSpeedo[ playerid ][ 1 ], 102);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 1 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 1 ], 0);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 1 ], 0);
 
	vehSpeedo[ playerid ][ 2 ] = CreatePlayerTextDraw(playerid, 494.289947, 342.999969, "LD_SPAC:white");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 2 ], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, vehSpeedo[ playerid ][ 2 ], 57.159606, 16.916687);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 2 ], 1);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 2 ], 378714367);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 2 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 2 ], 0);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 2 ], 4);
 
	vehSpeedo[ playerid ][ 3 ] = CreatePlayerTextDraw(playerid, 552.043945, 346.249908, "usebox");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 3 ], 0.000000, 1.080372);
	PlayerTextDrawTextSize(playerid, vehSpeedo[ playerid ][ 3 ], 493.226928, 0.000000);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 3 ], 1);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 3 ], 0);
	PlayerTextDrawUseBox(playerid, vehSpeedo[ playerid ][ 3 ], true);
	PlayerTextDrawBoxColor(playerid, vehSpeedo[ playerid ][ 3 ], 102);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 3 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 3 ], 0);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 3 ], 0);
 
	vehSpeedo[ playerid ][ 4 ] = CreatePlayerTextDraw(playerid, 505.534606, 347.666625, "speedo");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 4 ], 0.204963, 0.800833);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 4 ], 1);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 4 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 4 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 4 ], 1);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 4 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 4 ], 3);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 4 ], 1);
 
	vehSpeedo[ playerid ][ 5 ] = CreatePlayerTextDraw(playerid, 564.099731, 331.916717, "izgled auta");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 5 ], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, vehSpeedo[ playerid ][ 5 ], 79.180076, 89.833328);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 5 ], 1);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 5 ], -1);
	PlayerTextDrawUseBox(playerid, vehSpeedo[ playerid ][ 5 ], true);
	PlayerTextDrawBoxColor(playerid, vehSpeedo[ playerid ][ 5 ], 0);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 5 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 5 ], 1);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 5 ], 0x00000000);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 5 ], 5);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 5 ], 1);
	PlayerTextDrawSetPreviewModel( playerid, vehSpeedo[ playerid ][ 5 ], 411);
	PlayerTextDrawSetPreviewRot( playerid, vehSpeedo[ playerid ][ 5 ], 0.000000, 0.000000, -35.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol( playerid, vehSpeedo[ playerid ][ 5 ], 1, 1);
 
	vehSpeedo[ playerid ][ 6 ] = CreatePlayerTextDraw(playerid, 602.518493, 350.000000, "infernus");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 6 ], 0.181068, 0.619999);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 6 ], 2);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 6 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 6 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 6 ], 0);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 6 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 6 ], 2);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 6 ], 1);
 
	vehSpeedo[ playerid ][ 7 ] = CreatePlayerTextDraw(playerid, 529.960449, 383.666687, "speed:");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 7 ], 0.167950, 0.654999);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 7 ], 2);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 7 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 7 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 7 ], 0);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 7 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 7 ], 2);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 7 ], 1);
 
	vehSpeedo[ playerid ][ 8 ] = CreatePlayerTextDraw(playerid, 530.960510, 391.666656, "220km/h");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 8 ], 0.167950, 0.654999);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 8 ], 2);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 8 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 8 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 8 ], 0);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 8 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 8 ], 2);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 8 ], 1);
 
	vehSpeedo[ playerid ][ 9 ] = CreatePlayerTextDraw(playerid, 531.960449, 414.250061, "health:");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 9 ], 0.167950, 0.654999);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 9 ], 2);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 9 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 9 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 9 ], 0);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 9 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 9 ], 2);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 9 ], 1);
 
	vehSpeedo[ playerid ][ 10 ] = CreatePlayerTextDraw(playerid, 533.428955, 422.833435, "100%");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 10 ], 0.167950, 0.654999);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 10 ], 2);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 10 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 10 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 10 ], 0);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 10 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 10 ], 2);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 10 ], 1);
 
	vehSpeedo[ playerid ][ 11 ] = CreatePlayerTextDraw(playerid, 562.694458, 399.583374, "kantica");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 11 ], 0.449999, 1.600000);
	PlayerTextDrawTextSize(playerid, vehSpeedo[ playerid ][ 11 ], 26.237184, 35.000000);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 11 ], 1);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 11 ], 378714367);
	PlayerTextDrawUseBox(playerid, vehSpeedo[ playerid ][ 11 ], true);
	PlayerTextDrawBoxColor(playerid, vehSpeedo[ playerid ][ 11 ], 0);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 11 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 11 ], 1);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 11 ], 0x00000000);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 11 ], 5);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 11 ], 1);
	PlayerTextDrawSetPreviewModel( playerid, vehSpeedo[ playerid ][ 11 ], 1650);
	PlayerTextDrawSetPreviewRot( playerid, vehSpeedo[ playerid ][ 11 ], 0.000000, 0.000000, 0.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol( playerid, vehSpeedo[ playerid ][ 11 ], 1, 1);
 
	vehSpeedo[ playerid ][ 12 ] = CreatePlayerTextDraw(playerid, 600.427734, 410.583404, "fuel:");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 12 ], 0.167950, 0.654999);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 12 ], 2);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 12 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 12 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 12 ], 0);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 12 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 12 ], 2);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 12 ], 1);
 
	vehSpeedo[ playerid ][ 13 ] = CreatePlayerTextDraw(playerid, 600.022155, 418.000030, "45l");
	PlayerTextDrawLetterSize(playerid, vehSpeedo[ playerid ][ 13 ], 0.167950, 0.654999);
	PlayerTextDrawAlignment(playerid, vehSpeedo[ playerid ][ 13 ], 2);
	PlayerTextDrawColor(playerid, vehSpeedo[ playerid ][ 13 ], -1);
	PlayerTextDrawSetShadow(playerid, vehSpeedo[ playerid ][ 13 ], 0);
	PlayerTextDrawSetOutline(playerid, vehSpeedo[ playerid ][ 13 ], 0);
	PlayerTextDrawBackgroundColor(playerid, vehSpeedo[ playerid ][ 13 ], 51);
	PlayerTextDrawFont(playerid, vehSpeedo[ playerid ][ 13 ], 2);
	PlayerTextDrawSetProportional(playerid, vehSpeedo[ playerid ][ 13 ], 1);
    return 1;
}
hook OnPlayerUpdate(playerid)
{
 
    if( IsPlayerInAnyVehicle( playerid ) && GetPlayerState( playerid ) == PLAYER_STATE_DRIVER ) {
	    new vehicle = GetPlayerVehicleID( playerid );
	    if( !isWawVehicle( vehicle ) ) {
 
			new string[ 32 ];
			format( string, sizeof( string ), "~w~%.0fkm/H", GetVehicleSpeed( vehicle ) );
			PlayerTextDrawSetString( playerid, vehSpeedo[ playerid ][ 8 ], string );
			new stringic[ 32 ];
			format( stringic, sizeof( stringic ), "~w~_%dL", vehicleInfo[vehicle][vFuel]);
			PlayerTextDrawSetString( playerid, vehSpeedo[ playerid ][ 13 ], stringic );
 
            new str[ 32 ]; new Float:H; GetVehicleHealth( vehicle, H );
            format( str, sizeof( str ), "~w~HP:_%.1f", H );
			PlayerTextDrawSetString( playerid, vehSpeedo[ playerid ][ 10 ], str );
            /*SetPlayerProgressBarValue( playerid, vehSpeedoHealth[ playerid ], H/10 );
            if( H >= 700 && H <= 1000 ) {
                SetPlayerProgressBarColour( playerid, vehSpeedoHealth[ playerid ], 0x00FF00FF );
            }
            else if( H >= 400 && H < 700 ) {
                SetPlayerProgressBarColour( playerid, vehSpeedoHealth[ playerid ], 0xF0FF00FF );
            }
            else if( H < 400 ) {
                SetPlayerProgressBarColour( playerid, vehSpeedoHealth[ playerid ], 0xFF0000FF );
            }*/
 
		}
	}
	return 1;
}
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
 	if(newstate == PLAYER_STATE_DRIVER)
	{
        new vstr[ 30 ];
		format( vstr, sizeof( vstr ), "~w~%s", GetCarName(GetPlayerVehicleID(playerid)));
		PlayerTextDrawSetString( playerid, vehSpeedo[ playerid ][ 6 ], vstr );
 
        PlayerTextDrawSetPreviewModel( playerid, vehSpeedo[ playerid ][ 5 ], GetVehicleModel( GetPlayerVehicleID( playerid ) ) );
	    PlayerTextDrawShow( playerid, vehSpeedo[ playerid ][ 5 ] );
		if( !isWawVehicle( GetPlayerVehicleID( playerid ) ) ) {
			new vid = GetPlayerVehicleID(playerid);
			SetTimerEx("updateFuel", 1200000, true, "id", playerid,vid);
			for( new i = 0; i < 14; i++) {
				PlayerTextDrawShow( playerid, vehSpeedo[ playerid ][ i ] );
			}
		}
	}
	else if(oldstate == PLAYER_STATE_DRIVER)
	{
	    for( new i = 0; i < 14; i++) {
			PlayerTextDrawHide( playerid, vehSpeedo[ playerid ][ i ] );
		}
	}
	return 1;
}