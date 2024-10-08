// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

outlineenableforall( var_0, var_1, var_2 )
{
    var_3 = level.players;
    var_4 = scripts\mp\outline::outlineprioritygroupmap( var_2 );
    return scripts\mp\outline::outlineenableinternal( var_0, var_3, var_1, var_4, "ALL" );
}

outlineenableforteam( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = scripts\mp\utility\teams::getteamdata( var_1, "players" );

    if ( isdefined( var_4 ) && isdefined( var_4.team ) && var_4.team == var_1 )
        var_5 = scripts\engine\utility::array_remove( var_5, var_4 );

    var_6 = scripts\mp\outline::outlineprioritygroupmap( var_3 );
    return scripts\mp\outline::outlineenableinternal( var_0, var_5, var_2, var_6, "TEAM", var_1 );
}

outlineenableforsquad( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = level.squaddata[var_1][var_2].players;
    var_6 = scripts\mp\outline::outlineprioritygroupmap( var_4 );
    return scripts\mp\outline::outlineenableinternal( var_0, var_5, var_3, var_6, "SQUAD", var_1, var_2 );
}

outlineenableforplayer( var_0, var_1, var_2, var_3 )
{
    var_4 = scripts\mp\outline::outlineprioritygroupmap( var_3 );

    if ( isagent( var_1 ) )
        return scripts\mp\outline::outlinegenerateuniqueid();

    return scripts\mp\outline::outlineenableinternal( var_0, [ var_1 ], var_2, var_4, "ENTITY" );
}

outlinedisable( var_0, var_1 )
{
    scripts\mp\outline::outlinedisableinternal( var_0, var_1 );
}

outlinerefresh( var_0 )
{
    scripts\mp\outline::outlinerefreshinternal( var_0 );
}

initoutlineoccluders()
{
    level.outlineoccluders = [];
    level.outlineoccludersid = 0;
}

addoutlineoccluder( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.position = var_0;
    var_2.radius = var_1;
    var_3 = level.outlineoccludersid;
    level.outlineoccluders[var_3] = var_2;
    level.outlineoccludersid++;
    return var_3;
}

removeoutlineoccluder( var_0 )
{
    level.outlineoccluders[var_0] = undefined;
}

outlineoccluded( var_0, var_1 )
{
    foreach ( var_3 in level.outlineoccluders )
    {
        if ( !isdefined( var_3 ) || !isdefined( var_3.position ) || !isdefined( var_3.radius ) )
            continue;

        if ( scripts\engine\math::segmentvssphere( var_0, var_1, var_3.position, var_3.radius ) )
            return 1;
    }

    return 0;
}

_hudoutlineviewmodeldisable()
{
    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
        return;

    self hudoutlineviewmodeldisable();
}

_hudoutlineviewmodelenable( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isplayer( self ) )
    {

    }

    if ( !var_1 && !scripts\cp_mp\utility\player_utility::_isalive() )
    {

    }

    if ( var_1 && !scripts\cp_mp\utility\player_utility::_isalive() )
    {
        thread hudoutlineviewmodelenableonnextspawn( var_0 );
        return;
    }

    self hudoutlineviewmodelenable( var_0 );
}

hudoutlineviewmodelenableonnextspawn( var_0 )
{
    level endon( "game_ended" );
    self waittill( "spawned" );

    if ( !isdefined( self ) )
        return;

    if ( !scripts\cp_mp\utility\player_utility::_isalive() )
        return;

    if ( !isplayer( self ) )
        return;

    self hudoutlineviewmodelenable( var_0 );
}