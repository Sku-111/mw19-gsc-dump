// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( !level.rankedmatch )
        return;

    level.matchstats = spawnstruct();
    level.matchstats.datawritten = 0;
    loadgamemodestatmap();
    thread watchplayerconnect();
    thread watchgameend();
    level.matchstats.enabled = 1;
}

loadgamemodestatmap()
{
    var_0 = tablelookuprownum( "mp/gameModeMatchStats.csv", 0, level.gametype );
    var_1 = level.matchstats;

    if ( !isdefined( var_0 ) || var_0 < 0 )
    {
        var_1.modestatsenabled = 0;
        return;
    }

    var_1.modestatsenabled = 1;
    var_1.modestatmap = [];

    for ( var_2 = 1; var_2 < 7; var_2++ )
    {
        var_3 = tablelookupbyrow( "mp/gameModeMatchStats.csv", var_0, var_2 );

        if ( !isdefined( var_3 ) || var_3 == "" )
            continue;

        var_1.modestatmap[var_3] = var_2 - 1;
    }
}

watchplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );

        if ( isai( var_0 ) )
            continue;

        var_0 thread initplayer();
    }
}

initplayer()
{
    if ( isdefined( self.pers["matchstats"] ) )
        self.matchstats = self.pers["matchstats"];
    else
    {
        self.matchstats = spawnstruct();
        var_0 = self.matchstats;
        self.matchstats.values = [];
        self.matchstats.paths = [];
    }
}

watchgameend()
{
    scripts\mp\flags::levelflagwait( "game_over" );
    var_0 = level.players;

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        var_2 writeplayerinfo();
        waitframe();
    }

    level.matchstats.datawritten = 1;
}

writeplayerinfo()
{
    var_0 = self.matchstats;

    if ( !isdefined( var_0 ) )
        return;

    foreach ( var_4, var_2 in var_0.values )
    {
        var_3 = var_0.paths[var_4];

        switch ( var_3.size )
        {
            case 1:
                self setplayerdata( "mp", "matchStats", var_3[0], var_2 );
                break;
            case 2:
                self setplayerdata( "mp", "matchStats", var_3[0], var_3[1], var_2 );
                break;
            case 3:
                self setplayerdata( "mp", "matchStats", var_3[0], var_3[1], var_3[2], var_2 );
                break;
            case 4:
                self setplayerdata( "mp", "matchStats", var_3[0], var_3[1], var_3[2], var_3[3], var_2 );
                break;
            case 5:
                self setplayerdata( "mp", "matchStats", var_3[0], var_3[1], var_3[2], var_3[3], var_3[4], var_2 );
                break;
        }
    }
}

getmatchstatpathkey( var_0 )
{
    var_1 = "";

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( isdefined( var_0[var_2] ) )
            var_1 = var_1 + ( var_0[var_2] + "." );
    }

    return var_1;
}

setmatchstat( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !arematchstatsenabled() )
        return;

    var_6 = [ var_1 ];

    if ( isdefined( var_2 ) )
        var_6[var_6.size] = var_2;

    if ( isdefined( var_3 ) )
        var_6[var_6.size] = var_3;

    if ( isdefined( var_4 ) )
        var_6[var_6.size] = var_4;

    if ( isdefined( var_5 ) )
        var_6[var_6.size] = var_5;

    var_7 = getmatchstatpathkey( var_6 );
    self.matchstats.values[var_7] = var_0;
    self.matchstats.paths[var_7] = var_6;
}

addtomatchstat( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !arematchstatsenabled() )
        return;

    if ( !isdefined( var_0 ) )
        var_0 = 1;

    var_6 = [ var_1 ];

    if ( isdefined( var_2 ) )
        var_6[var_6.size] = var_2;

    if ( isdefined( var_3 ) )
        var_6[var_6.size] = var_3;

    if ( isdefined( var_4 ) )
        var_6[var_6.size] = var_4;

    if ( isdefined( var_5 ) )
        var_6[var_6.size] = var_5;

    var_7 = getmatchstatpathkey( var_6 );

    if ( !isdefined( self.matchstats.paths[var_7] ) )
    {
        self.matchstats.values[var_7] = var_0;
        self.matchstats.paths[var_7] = var_6;
    }
    else
        self.matchstats.values[var_7] = self.matchstats.values[var_7] + var_0;
}

getmatchstat( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !arematchstatsenabled() )
        return undefined;

    var_5 = [ var_0, var_1, var_2, var_3, var_4 ];
    var_6 = getmatchstatpathkey( var_5 );

    if ( !isdefined( self.matchstats.values[var_6] ) )
        return 0;

    return self.matchstats.values[var_6];
}

getmodestatindex( var_0 )
{
    var_1 = level.matchstats;

    if ( !isdefined( var_1.modestatsenabled ) )
        return undefined;

    return var_1.modestatmap[var_0];
}

setgamemodestat( var_0, var_1 )
{
    if ( !arematchstatsenabled() )
        return;

    var_2 = getmodestatindex( var_0 );

    if ( !isdefined( var_2 ) )
        return;

    setmatchstat( var_1, "modeStats", var_2 );
}

addtogamemodestat( var_0, var_1 )
{
    if ( !arematchstatsenabled() )
        return;

    var_2 = getmodestatindex( var_0 );

    if ( !isdefined( var_2 ) )
        return;

    addtomatchstat( var_1, "modeStats", var_2 );
}

getgamemodestat( var_0 )
{
    if ( !arematchstatsenabled() )
        return;

    var_1 = getmodestatindex( var_0 );

    if ( !isdefined( var_1 ) )
        return;

    return getmatchstat( "modeStats", var_1 );
}

arematchstatsenabled()
{
    return isdefined( level.matchstats ) && istrue( level.matchstats.enabled );
}