// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "nuke", _calloutmarkerping_handleluinotify_acknowledged::tryusenukefromstruct );
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "nuke_select_location", _calloutmarkerping_handleluinotify_acknowledged::tryusenukefromstruct );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "hostmigration_waitLongDurationWithPause", ::_id_11EEA );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "hostmigration_waitTillHostMigrationDone", ::_id_11EEB );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "delayEndGame", ::nuke_delayendgame );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "addTeamRankXPMultiplier", ::_id_11EDD );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "cankill", ::nuke_cankill );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "killPlayer", ::_id_11EEC );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "killPlayerWithAttacker", ::_id_11EED );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "destroyActiveObjects", ::nuke_destroyactiveobjects );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "isPlayerInRadZone", ::nuke_isplayerinradzone );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nuke", "stopTheClock", ::_id_11EF7 );
}

_id_11EEA( var_0 )
{
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( var_0 );
}

_id_11EEB()
{
    return scripts\mp\hostmigration::waittillhostmigrationdone();
}

nuke_delayendgame( var_0, var_1 )
{
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var_0 );

    if ( istrue( level._id_11BD4 ) )
        level thread scripts\mp\gamelogic::endgame( var_1, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 1, 1 );
    else
        level thread scripts\mp\gamelogic::endgame( var_1, game["end_reason"]["nuke_end"], undefined, 1 );
}

_id_11EDD( var_0, var_1, var_2 )
{
    scripts\mp\rank::addteamrankxpmultiplier( var_0, var_1, var_2 );
}

nuke_cankill( var_0, var_1 )
{
    if ( istrue( level.blocknukekills ) )
        return 0;

    if ( !isdefined( level.nukeinfo ) )
        return 0;

    if ( istrue( var_1 ) )
        return 1;

    if ( level.teambased )
    {
        if ( isdefined( level.nukeinfo.team ) && var_0.team == level.nukeinfo.team )
            return 0;
    }
    else
    {
        var_2 = isdefined( level.nukeinfo.player ) && var_0 == level.nukeinfo.player;
        var_3 = isdefined( level.nukeinfo.player ) && isdefined( var_0.owner ) && var_0.owner == level.nukeinfo.player;

        if ( var_2 || var_3 )
            return 0;
    }

    return 1;
}

nuke_destroyactiveobjects( var_0 )
{
    var_1 = "nuke_mp";
    var_2 = level.activekillstreaks;
    var_3 = [[ level.getactiveequipmentarray ]]();
    var_4 = undefined;

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
        var_4 = scripts\engine\utility::array_combine_unique( var_2, var_3 );
    else if ( isdefined( var_2 ) )
        var_4 = var_2;
    else if ( isdefined( var_3 ) )
        var_4 = var_3;

    if ( isdefined( var_4 ) )
    {
        foreach ( var_6 in var_4 )
        {
            if ( isdefined( var_6 ) )
            {
                if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "killstreak", "doDamageToKillstreak" ) )
                    var_6 [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "killstreak", "doDamageToKillstreak" ) ]]( 10000, level.nukeinfo.player, level.nukeinfo.player, var_0, var_6.origin, "MOD_EXPLOSIVE", var_1 );
            }
        }
    }
}

nuke_isplayerinradzone( var_0, var_1, var_2 )
{
    var_3 = distance2dsquared( var_1, var_0.origin );
    return var_3 < var_2;
}

_id_11EEC( var_0 )
{
    if ( isplayer( var_0 ) )
    {
        var_1 = getcompleteweaponname( "nuke_mp" );
        scripts\mp\damage::addattacker( var_0, level.nukeinfo.player, undefined, var_1, 0, undefined, undefined, undefined, undefined, undefined );
        var_2 = vectornormalize( var_0.origin + ( 0, 0, 1000 ) - level.nuke_inflictor.origin );
        var_0 thread scripts\mp\damage::finishplayerdamagewrapper( level.nuke_inflictor, level.nukeinfo.player, 999999, 0, "MOD_EXPLOSIVE", var_1, var_0.origin, var_2, "none", 0, 0, undefined, undefined );
    }
}

_id_11EED( var_0 )
{
    var_1 = level.nukeinfo.player;

    if ( level.teambased && var_0.team == var_1.team )
        var_1 = var_0;

    var_2 = getcompleteweaponname( "nuke_mp" );
    var_0 dodamage( 999999, level.nuke_inflictor.origin, var_1, level.nuke_inflictor, "MOD_EXPLOSIVE", var_2, "none" );
}

_id_11EF7( var_0 )
{
    var_1 = "scr_" + var_0 + "_timelimit";
    level.watchdvars[var_1].value = 0;
    level.overridewatchdvars[var_1] = 0;
    level.extratime = 0;
    return var_1;
}