// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( !level.onlinestatsenabled )
        return;

    level.playerstats = spawnstruct();
    var_0 = level.playerstats;
    var_0.statgroups = [];
    var_0.disabledstats = [];
    var_0.enabled = 1;
    var_0.readonly = 0;
    var_0.ratios = [];
    var_0.ratiochildren = [];
    var_0.disabledpaths = [];
    scripts\mp\playerstats_interface::registerplayerstatratio( [ "combatStats", "kdRatio" ], [ "combatStats", "kills" ], [ "combatStats", "deaths" ] );
    scripts\mp\playerstats_interface::registerplayerstatratio( [ "combatStats", "accuracy" ], [ "combatStats", "hits" ], [ "combatStats", "totalShots" ] );
    scripts\mp\playerstats_interface::registerplayerstatratio( [ "matchStats", "winLossRatio" ], [ "matchStats", "wins" ], [ "matchStats", "losses" ] );
    addtostatgroup( "kdr", "combatStats", "kills" );
    addtostatgroup( "kdr", "combatStats", "deaths" );
    addtostatgroup( "kdr", "combatStats", "kdRatio" );
    addtostatgroup( "winLoss", "matchStats", "wins" );
    addtostatgroup( "winLoss", "matchStats", "losses" );
    addtostatgroup( "winLoss", "matchStats", "winLossRatio" );
    addtostatgroup( "winLoss", "matchStats", "winStreak" );
    addtostatgroup( "winLoss", "matchStats", "ties" );
    addtostatgroup( "losses", "matchStats", "losses" );
}

initplayer()
{
    if ( !level.onlinestatsenabled )
        return;

    if ( isdefined( self.pers["playerstats"] ) )
        self.playerstats = self.pers["playerstats"];
    else
    {
        self.playerstats = spawnstruct();
        var_0 = self.playerstats;
        self.playerstats.values = [];
        self.playerstats.paths = [];
        self.playerstats.bufferedstats = [];
    }

    if ( !scripts\mp\utility\game::runleanthreadmode() )
        thread bufferedstatwritethink();
}

bufferedstatwritethink()
{
    self endon( "disconnect" );

    while ( !scripts\mp\flags::levelflag( "game_over" ) )
    {
        writebufferedstats();
        wait 2.0;
    }

    writebufferedstats();
}

writebufferedstats()
{
    if ( isai( self ) )
        return;

    foreach ( var_4, var_1 in self.playerstats.bufferedstats )
    {
        var_2 = self.playerstats.paths[var_4];
        var_3 = self.playerstats.values[var_4];
        writeplayerstat( var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4] );
    }

    self.playerstats.bufferedstats = [];
}

getplayerstatpathkey( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = "";

    if ( isdefined( var_4 ) )
        var_5 = var_0 + "." + var_1 + "." + var_2 + "." + var_3 + "." + var_4;
    else if ( isdefined( var_3 ) )
        var_5 = var_0 + "." + var_1 + "." + var_2 + "." + var_3;
    else if ( isdefined( var_2 ) )
        var_5 = var_0 + "." + var_1 + "." + var_2;
    else if ( isdefined( var_1 ) )
        var_5 = var_0 + "." + var_1;
    else if ( isdefined( var_0 ) )
        var_5 = var_0;

    return var_5;
}

writeplayerstat( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_5 ) )
        self setplayerdata( "mp", "playerStats", var_1, var_2, var_3, var_4, var_5, var_0 );
    else if ( isdefined( var_4 ) )
        self setplayerdata( "mp", "playerStats", var_1, var_2, var_3, var_4, var_0 );
    else if ( isdefined( var_3 ) )
        self setplayerdata( "mp", "playerStats", var_1, var_2, var_3, var_0 );
    else if ( isdefined( var_2 ) )
        self setplayerdata( "mp", "playerStats", var_1, var_2, var_0 );
    else if ( isdefined( var_1 ) )
        self setplayerdata( "mp", "playerStats", var_1, var_0 );
}

readplayerstat( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_4 ) )
        return self getplayerdata( "mp", "playerStats", var_0, var_1, var_2, var_3, var_4 );
    else if ( isdefined( var_3 ) )
        return self getplayerdata( "mp", "playerStats", var_0, var_1, var_2, var_3 );
    else if ( isdefined( var_2 ) )
        return self getplayerdata( "mp", "playerStats", var_0, var_1, var_2 );
    else if ( isdefined( var_1 ) )
        return self getplayerdata( "mp", "playerStats", var_0, var_1 );
    else if ( isdefined( var_0 ) )
        return self getplayerdata( "mp", "playerStats", var_0 );
}

flagstatforbufferedwrite( var_0 )
{
    var_1 = level.playerstats;

    if ( scripts\mp\flags::levelflag( "game_over" ) )
    {
        var_2 = self.playerstats.paths[var_0];
        var_3 = self.playerstats.values[var_0];
        writeplayerstat( var_3, var_2[0], var_2[1], var_2[2], var_2[3], var_2[4] );
        return;
    }

    self.playerstats.bufferedstats[var_0] = 1;
}

setplayerstat_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = [ var_2 ];
    var_7[var_7.size] = var_3;
    var_7[var_7.size] = var_4;
    var_7[var_7.size] = var_5;
    var_7[var_7.size] = var_6;
    self.playerstats.values[var_1] = var_0;
    self.playerstats.paths[var_1] = var_7;
}

addtoplayerstat_internal( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = [ var_2 ];
    var_7[var_7.size] = var_3;
    var_7[var_7.size] = var_4;
    var_7[var_7.size] = var_5;
    var_7[var_7.size] = var_6;

    if ( !isdefined( self.playerstats.paths[var_1] ) )
    {
        var_8 = readplayerstat( var_2, var_3, var_4, var_5, var_6 );
        self.playerstats.values[var_1] = var_8 + var_0;
        self.playerstats.paths[var_1] = var_7;
    }
    else
        self.playerstats.values[var_1] = self.playerstats.values[var_1] + var_0;
}

modifystatwritability( var_0, var_1 )
{
    var_2 = level.playerstats;

    if ( var_1 )
    {
        var_2.disabledstats[var_0]--;

        if ( var_2.disabledstats[var_0] <= 0 )
            var_2.disabledstats[var_0] = undefined;
    }
    else if ( !isdefined( var_2.disabledstats[var_0] ) )
        var_2.disabledstats[var_0] = 1;
    else
        var_2.disabledstats[var_0]++;
}

isstatwritable_internal( var_0 )
{
    return !scripts\mp\playerstats_interface::areplayerstatsreadonly() && !isdefined( level.playerstats.disabledstats[var_0] );
}

addtostatgroup( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = level.playerstats;
    var_7 = getplayerstatpathkey( var_1, var_2, var_3, var_4, var_5 );

    if ( !isdefined( var_6.statgroups[var_0] ) )
        var_6.statgroups[var_0] = [];

    var_6.statgroups[var_0][var_6.statgroups[var_0].size] = var_7;
}

modifystatgroupwritability( var_0, var_1 )
{
    var_2 = level.playerstats;

    foreach ( var_4 in var_2.statgroups[var_0] )
        modifystatwritability( var_4, var_1 );
}

calculateplayerstatratio( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !scripts\mp\playerstats_interface::areplayerstatsenabled() )
        return undefined;

    var_5 = level.playerstats;
    var_6 = getplayerstatpathkey( var_0, var_1, var_2, var_3, var_4 );

    if ( !isdefined( var_5.ratios[var_6] ) )
    {

    }

    if ( !isstatwritable_internal( var_6 ) )
        return;

    var_7 = var_5.ratios[var_6]["numerator"];
    var_8 = var_5.ratios[var_6]["denominator"];
    var_9 = scripts\mp\playerstats_interface::getplayerstat( var_7[0], var_7[1], var_7[2], var_7[3], var_7[4] );
    var_10 = scripts\mp\playerstats_interface::getplayerstat( var_8[0], var_8[1], var_8[2], var_8[3], var_8[4] );

    if ( var_10 == 0 )
        var_10 = 1;

    return var_9 / var_10;
}

updateplayerstatratio( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = calculateplayerstatratio( var_0, var_1, var_2, var_3, var_4 );
    scripts\mp\playerstats_interface::setplayerstat( var_5, var_0, var_1, var_2, var_3, var_4 );
}

updateplayerstatratiobuffered( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = calculateplayerstatratio( var_0, var_1, var_2, var_3, var_4 );
    scripts\mp\playerstats_interface::setplayerstatbuffered( var_5, var_0, var_1, var_2, var_3, var_4 );
}

updateparentratios( var_0 )
{
    var_1 = level.playerstats;

    if ( !isdefined( var_1.ratiochildren[var_0] ) )
        return;

    foreach ( var_3 in var_1.ratiochildren[var_0] )
        updateplayerstatratio( var_3[0], var_3[1], var_3[2], var_3[3], var_3[4] );
}

updateparentratiosbuffered( var_0 )
{
    var_1 = level.playerstats;

    if ( !isdefined( var_1.ratiochildren[var_0] ) )
        return;

    foreach ( var_3 in var_1.ratiochildren[var_0] )
        updateplayerstatratiobuffered( var_3[0], var_3[1], var_3[2], var_3[3], var_3[4] );
}
