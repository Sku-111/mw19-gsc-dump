// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = spawnstruct();
    var_0.weight = getdvarfloat( "scr_br_pe_outbreak_weight", 1.0 );
    var_0._id_140CF = ::_id_140CF;
    var_0.attackerswaittime = ::attackerswaittime;
    var_0._id_14382 = ::_id_14382;
    var_0.postinitfunc = ::postinitfunc;
    var_0._id_11B78 = getdvarint( "scr_br_pe_outbreak_max_times", 0 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "outbreak", "0    20  20  20          0   0   0   0" );
    var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter.gsc::getdvarpemetereventweights( "outbreak" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 19, var_0 );
}

postinitfunc()
{
    game["dialog"]["zmb_outbreak_meter_25percent"] = "outbreak_meter1";
    game["dialog"]["zmb_outbreak_meter_50percent"] = "outbreak_meter2";
    game["dialog"]["zmb_outbreak_meter_75percent"] = "outbreak_meter3";
    game["dialog"]["zmb_outbreak_announcement"] = "outbreak_announcement";
    game["dialog"]["zmb_outbreak_redeploy"] = "outbreak_redeploy";
    game["dialog"]["zmb_outbreak_redeploy_spectator"] = "outbreak_redeploy_spectator";
    var_0 = createoutbreakmeterstate( 1.0, "zmb_outbreak_announcement", 2.5, 1 );
    var_1 = createoutbreakmeterstate( 0.75, "zmb_outbreak_meter_75percent", 1.5, 0 );
    var_2 = createoutbreakmeterstate( 0.5, "zmb_outbreak_meter_50percent", 1.5, 1 );
    var_3 = createoutbreakmeterstate( 0.1, "zmb_outbreak_meter_25percent", 1.5, 2 );
    level.disable_super_in_turret.outbreakmeterstates = [ var_0, var_1, var_2, var_3 ];
    level.disable_super_in_turret.outbreakmeternextstateindex = 3;
}

_id_140CF()
{
    var_0 = level scripts\mp\utility\game::round_vehicle_logic();
    var_1 = var_0 == "zxp" || var_0 == "brz" || var_0 == "gxp";
    var_2 = 0;
    var_3 = istrue( level.usegulag ) && !scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee( "gulag" );

    if ( var_1 && !var_3 )
        var_2 = 1;

    return var_2;
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
    var_0 = 3.5;
    var_1 = getdvarfloat( "scr_br_pe_outbreak_duration", 15.0 );
    thread init_lbravo_spawn_after_level_restart( var_0 + var_1 );
    showsplashtoaliveplayers( "br_pe_outbreak_incoming" );
    wait( var_0 );
    var_2 = gettime() + var_1 * 1000;
    setomnvar( "ui_publicevent_timer_type", 12 );
    setomnvar( "ui_publicevent_timer", var_2 );
    var_3 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_3 hide();
    var_4 = undefined;
    var_5 = undefined;
    var_6 = getdvarint( "scr_br_pe_outbreak_include_eliminated_teams", 1 );

    if ( var_1 > 5.0 )
    {
        wait( var_1 - 5.0 );
        [var_4, var_5] = fix_badcover_atend( var_6 );
        thread preemtiverespawnplayers( var_4 );

        for ( var_8 = 0; var_8 < 5; var_8++ )
        {
            var_3 playsound( "ui_mp_fire_sale_timer" );
            wait 1.0;
        }
    }

    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_pe_outbreak_active" );
    setomnvar( "ui_publicevent_timer_type", 0 );
    var_3 delete();
    [var_10, var_5] = fix_badcover_atend( var_6 );

    if ( isdefined( var_4 ) )
    {
        var_10 = scripts\engine\utility::array_remove_array( var_10, var_4 );
        var_5 = scripts\engine\utility::array_remove_array( var_5, var_4 );
    }

    thread _id_12CAD( var_10 );

    foreach ( var_12 in var_5 )
    {
        if ( !isdefined( var_12 ) )
            continue;

        if ( scripts\mp\utility\player::isreallyalive( var_12 ) && !istrue( var_12.iszombie ) )
            level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "zmb_outbreak_redeploy", var_12, 1, 0, 2 );
    }
}

preemtiverespawnplayers( var_0 )
{
    level endon( "game_ended" );
    wait 3;
    _id_12CAD( var_0 );
}

forest_combat()
{
    var_0 = getdvarfloat( "scr_br_pe_outbreak_starttime_min", 795.0 );
    var_1 = getdvarfloat( "scr_br_pe_outbreak_starttime_max", 1110.0 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}

fix_badcover_atend( var_0 )
{
    var_1 = [];
    var_2 = [];

    foreach ( var_4 in level.teamnamelist )
    {
        var_5 = level.teamdata[var_4];
        var_6 = var_5["teamCount"];
        var_7 = var_5["aliveCount"];
        var_8 = undefined;

        if ( var_0 )
            var_8 = var_6 > 0 && var_7 != var_6;
        else
            var_8 = var_6 > 0 && var_7 > 0 && var_7 != var_6;

        foreach ( var_10 in var_5["players"] )
        {
            if ( var_8 && !isalive( var_10 ) )
            {
                var_1[var_1.size] = var_10;
                continue;
            }

            var_2[var_2.size] = var_10;
        }
    }

    return [ var_1, var_2 ];
}

_id_12CAD( var_0 )
{
    level endon( "game_ended" );
    var_1 = getdvarint( "scr_br_pe_outbreak_include_eliminated_teams", 1 );

    foreach ( var_3 in var_0 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        if ( var_1 )
            var_3 scripts\mp\gametypes\br_publicevent_jailbreak.gsc::_id_12C78();

        var_3.respawnedfromoutbreak = 1;
        var_3 thread scripts\mp\gametypes\br_alt_mode_zxp.gsc::_id_12723( 0, 1 );
        level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "zmb_outbreak_redeploy_spectator", var_3, 1, 1 );
        waitframe();
    }
}

showsplashtoaliveplayers( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( scripts\mp\utility\player::isreallyalive( var_2 ) || var_2 ismlgspectator() )
            var_2 scripts\mp\hud_message::showsplash( var_0 );
    }
}

createoutbreakmeterstate( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.ratio = var_0;
    var_4.dialog = var_1;
    var_4.dialogdelay = var_2;
    var_4.nextstateindex = var_3;
    return var_4;
}

manageoutbreakmeterdialog()
{
    var_0 = scripts\mp\gametypes\br_publicevents_meter.gsc::getmetercurrentratio();
    var_1 = level.disable_super_in_turret.outbreakmeternextstateindex;

    if ( isdefined( level.disable_super_in_turret.outbreakmeterstates ) )
    {
        foreach ( var_4, var_3 in level.disable_super_in_turret.outbreakmeterstates )
        {
            if ( var_0 >= var_3.ratio && var_1 >= var_4 )
            {
                scripts\mp\gametypes\br_public.gsc::brleaderdialog( var_3.dialog, 1, undefined, 1, var_3.dialogdelay );
                level.disable_super_in_turret.outbreakmeternextstateindex = var_3.nextstateindex;
                return;
            }
        }
    }
}

init_lbravo_spawn_after_level_restart( var_0 )
{
    level notify( "create_siren" );
    var_1 = spawn( "script_model", ( 370, -2679, 3000 ) );
    var_1 setmodel( "rebirth_fx" );
    waitframe();
    var_1 setscriptablepartstate( "sfx", "cine_escape2_infil_siren" );
    level._id_12A76 = 1;
    level scripts\engine\utility::waittill_notify_or_timeout( "create_siren", var_0 );
    var_1 delete();
    level._id_12A76 = 0;
}
