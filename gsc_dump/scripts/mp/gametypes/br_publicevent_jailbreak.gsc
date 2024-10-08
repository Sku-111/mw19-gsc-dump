// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = spawnstruct();
    var_0.weight = getdvarfloat( "scr_br_pe_jailbreak_weight", 1.0 );
    var_0._id_140CF = ::_id_140CF;
    var_0.attackerswaittime = ::attackerswaittime;
    var_0._id_14382 = ::_id_14382;
    var_0.postinitfunc = ::postinitfunc;
    var_0._id_11B78 = getdvarint( "scr_br_pe_jailbreak_max_times", 1 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "jailbreak", "0    0   5   10          10  5   5   1" );
    var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter.gsc::getdvarpemetereventweights( "jailbreak" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 3, var_0 );
}

postinitfunc()
{
    game["dialog"]["public_events_jailbreak_incoming_active"] = "public_events_jailbreak_start_inmatch";
    game["dialog"]["public_events_jailbreak_incoming_active_alt"] = "public_events_jailbreak_start_alive";
    game["dialog"]["public_events_jailbreak_incoming_gulag"] = "public_events_jailbreak_start_gulag";
    game["dialog"]["public_events_jailbreak_incoming_spectate"] = "public_events_jailbreak_start_eliminated";
    game["dialog"]["public_events_jailbreak_now_active"] = "public_events_jailbreak_begin_inmatch";
    game["dialog"]["public_events_jailbreak_now_active_alt"] = "public_events_jailbreak_end_alive";
    game["dialog"]["public_events_jailbreak_now_gulag"] = "public_events_jailbreak_end_gulag";
    game["dialog"]["public_events_jailbreak_now_spectate"] = "public_events_jailbreak_begin_eliminated";
}

_id_140CF()
{
    var_0 = !scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee( "oneLife" );
    var_1 = istrue( level.usegulag );
    return var_0 || var_1;
}

_id_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var_0 = forest_combat();
    wait( var_0 );
}

attackerswaittime()
{
    level endon( "game_ended" );
    _id_12217( 1 );
    _id_14370();
    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_pe_jailbreak_incoming" );
    _id_1274A( "incoming" );
    var_0 = getdvarfloat( "scr_br_pe_jailbreak_duration", 30.0 );
    var_1 = gettime() + var_0 * 1000;
    setomnvar( "ui_publicevent_timer_type", 2 );
    setomnvar( "ui_publicevent_timer", var_1 );
    var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_2 hide();

    if ( var_0 > 5.0 )
    {
        wait( var_0 - 5.0 );

        for ( var_3 = 0; var_3 < 5; var_3++ )
        {
            var_2 playsound( "ui_mp_fire_sale_timer" );
            wait 1.0;
        }
    }

    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_pe_jailbreak_active" );
    _id_1274A( "now" );
    setomnvar( "ui_publicevent_timer_type", 0 );
    var_2 delete();
    wait 1.0;
    _id_12CAD();
    _id_12217( 0 );
}

forest_combat()
{
    var_0 = getdvarfloat( "scr_br_pe_jailbreak_starttime_min", 795.0 );
    var_1 = getdvarfloat( "scr_br_pe_jailbreak_starttime_max", 1110.0 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}

_id_12217( var_0 )
{
    scripts\mp\gametypes\br_gulag.gsc::_id_12219( var_0 );
}

_id_14370()
{
    level endon( "game_ended" );
    wait 1.0;

    for (;;)
    {
        if ( !scripts\mp\gametypes\br_gulag.gsc::calloutmarkerping_cp_setupcptimeouts() )
            break;

        waitframe();
    }
}

fix_badcover_atend( var_0 )
{
    var_1 = [];
    var_2 = isdefined( level.gulag ) && !istrue( level.gulag.shutdown );

    foreach ( var_4 in level.teamnamelist )
    {
        var_5 = level.teamdata[var_4]["aliveCount"] > 0;

        if ( var_0 )
            var_5 = level.teamdata[var_4]["teamCount"] > 0;

        if ( var_5 )
        {
            foreach ( var_7 in level.teamdata[var_4]["players"] )
            {
                var_8 = var_2 && var_7 scripts\mp\gametypes\br_public.gsc::updateinstantclassswapallowedinternal();

                if ( !isalive( var_7 ) && !var_8 )
                {
                    var_1[var_1.size] = var_7;
                    continue;
                }

                if ( isalive( var_7 ) && var_8 )
                    var_1[var_1.size] = var_7;
            }
        }
    }

    return var_1;
}

_id_12CAC()
{
    var_0 = isalive( self ) && isdefined( level.gulag ) && !istrue( level.gulag.shutdown ) && scripts\mp\gametypes\br_public.gsc::updateinstantclassswapallowedinternal();

    if ( var_0 )
        thread scripts\mp\gametypes\br_gulag.gsc::vehicle_compass_cp_shouldbevisibletoplayer();
    else
        thread scripts\mp\gametypes\br_gulag.gsc::playergulagautowin( "jailbreak", undefined, undefined, 1, 1 );
}

_id_12CAD()
{
    level endon( "game_ended" );
    var_0 = getdvarint( "scr_br_pe_jailbreak_includeeliminatedteams", 1 );
    var_1 = fix_badcover_atend( var_0 );

    foreach ( var_3 in var_1 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        if ( var_0 )
            var_3 _id_12C78();

        var_3 thread _id_12CAC();
        waitframe();
    }
}

_id_12C78()
{
    self._id_12396 = undefined;
    self.emergency_cleanupents = undefined;
    self._id_128AF = undefined;
    self.dialog_wait_ready = undefined;
    self.br_spectatorinitialized = undefined;
    self setclientomnvar( "ui_br_player_position", 155 );
    self setclientomnvar( "ui_br_squad_eliminated_active", 0 );
    self setclientomnvar( "ui_round_end_title", 0 );
    self setclientomnvar( "ui_round_end_reason", 0 );
}

_id_1274A( var_0 )
{
    var_1 = [];
    var_2 = [];
    var_3 = [];
    var_4 = isdefined( level.gulag ) && !istrue( level.gulag.shutdown );
    var_5 = getdvarint( "scr_br_pe_jailbreak_includeeliminatedteams", 1 );

    foreach ( var_7 in level.teamnamelist )
    {
        var_8 = level.teamdata[var_7]["aliveCount"] > 0;

        if ( var_5 )
            var_8 = level.teamdata[var_7]["teamCount"] > 0;

        if ( var_8 )
        {
            foreach ( var_10 in level.teamdata[var_7]["players"] )
            {
                var_11 = var_4 && var_10 scripts\mp\gametypes\br_public.gsc::updateinstantclassswapallowedinternal();

                if ( !isalive( var_10 ) && !var_11 )
                {
                    var_3[var_3.size] = var_10;
                    continue;
                }

                if ( isalive( var_10 ) && var_11 )
                {
                    var_2[var_2.size] = var_10;
                    continue;
                }

                if ( isalive( var_10 ) )
                    var_1[var_1.size] = var_10;
            }
        }
    }

    if ( var_1.size > 0 )
    {
        var_14 = scripts\engine\utility::ter_op( scripts\engine\utility::cointoss(), "_active", "_active_alt" );
        scripts\mp\gametypes\br_public.gsc::brleaderdialog( "public_events_jailbreak_" + var_0 + var_14, 0, var_1, 1 );
    }

    if ( var_2.size > 0 )
    {
        var_15 = "_gulag";
        scripts\mp\gametypes\br_public.gsc::brleaderdialog( "public_events_jailbreak_" + var_0 + var_15, 0, var_2, 1 );
    }

    if ( var_3.size > 0 )
    {
        var_16 = "_spectate";
        scripts\mp\gametypes\br_public.gsc::brleaderdialog( "public_events_jailbreak_" + var_0 + var_16, 0, var_3, 1 );
    }
}