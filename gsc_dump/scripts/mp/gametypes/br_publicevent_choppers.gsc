// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = spawnstruct();
    var_0._id_140CF = ::_id_140CF;
    var_0.weight = getdvarfloat( "scr_br_pe_choppers_weight", 1.0 );
    var_0._id_14382 = ::_id_14382;
    var_0.attackerswaittime = ::attackerswaittime;
    var_0.postinitfunc = ::postinitfunc;
    var_0._id_11B78 = getdvarint( "scr_br_pe_choppers_max_times", 1 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "choppers", "5    5   5   10          15  15  5   5" );
    var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter.gsc::getdvarpemetereventweights( "choppers" );
    var_1 = scripts\engine\utility::ter_op( scripts\mp\gametypes\br_publicevents.gsc::_id_11E05(), 120.0, 0 );
    var_2 = getdvarint( "scr_br_pe_choppers_lifetime", var_1 );
    var_0.sol_5_6_pool = var_2;
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 1, var_0 );
}

postinitfunc()
{
    game["dialog"]["public_events_choppers_start"] = "public_events_supply_choppers_start";
}

_id_140CF()
{
    var_0 = scripts\mp\utility\game::round_vehicle_logic() == "dmz" || scripts\mp\utility\game::round_vehicle_logic() == "rat_race" || scripts\mp\utility\game::round_vehicle_logic() == "risk" || scripts\mp\utility\game::round_vehicle_logic() == "gold_war";
    return !var_0;
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
    var_0 = getdvarint( "scr_br_pe_choppers_count", 5 );
    level forest_fire_setup( var_0 );
    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_pe_choppers_start" );
    scripts\mp\gametypes\br_public.gsc::brleaderdialog( "public_events_choppers_start" );
    setomnvar( "ui_publicevent_minimap_pulse", 1 );
    thread _id_13622( var_0 );
    var_1 = 10.0;
    thread scripts\mp\gametypes\br_publicevents.gsc::resetminimappulse( var_1 );
    _id_14404( var_1 );
}

forest_combat()
{
    var_0 = getdvarfloat( "scr_br_pe_choppers_starttime_min", 555.0 );
    var_1 = getdvarfloat( "scr_br_pe_choppers_starttime_max", 765.0 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}

_id_14404( var_0 )
{
    level endon( "game_ended" );

    if ( isdefined( var_0 ) )
        wait( var_0 );

    for (;;)
    {
        var_1 = level._id_119E7;

        if ( !isdefined( var_1 ) )
            break;

        var_1 = scripts\engine\utility::array_removeundefined( var_1 );

        if ( var_1.size == 0 )
            break;

        wait 1.0;
    }
}

_id_13622( var_0 )
{
    level endon( "game_ended" );
    var_1 = undefined;
    var_2 = undefined;

    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
    {
        var_1 = scripts\mp\gametypes\br_circle.gsc::getsafecircleorigin();
        var_2 = scripts\mp\gametypes\br_circle.gsc::getsafecircleradius();
    }
    else
    {
        level.binoculars_checkexpirationtimer = 35;
        level._id_12946 = 1;
        level.fly_over_path = 0;
        level thread scripts\mp\gametypes\br_functional_poi.gsc::_id_1325B();
    }

    scripts\mp\gametypes\br_lootchopper.gsc::init();
    scripts\cp_mp\utility\script_utility::registersharedfunc( "br_lootchopper", "lootChopper_onCrateUse", ::_id_1200F );

    if ( !isdefined( level._id_1229F ) )
    {
        var_3 = scripts\mp\gametypes\br_lootchopper.gsc::_id_11A0C( var_1, var_2 );
        scripts\mp\gametypes\br_lootchopper.gsc::_id_11A0D( var_3 );
    }

    var_4 = getdvarint( "scr_br_pe_choppers_mindist", 6000 );

    if ( level.mapname == "mp_br_mechanics" )
        var_4 = 1000;

    for ( var_5 = 0; var_5 < var_0; var_5++ )
    {
        var_6 = undefined;

        if ( isdefined( level._id_1229F ) )
            var_6 = level._id_1229F[var_5];
        else
        {
            var_7 = var_5 % 4 + 1;
            var_6 = scripts\mp\gametypes\br_lootchopper.gsc::_id_11A07( level._id_119E6["quad_" + var_7], var_4 );
        }

        var_8 = scripts\mp\gametypes\br_lootchopper.gsc::_id_11A18( var_6, "veh_chopper_support_pe_mp" );

        if ( isdefined( var_8 ) )
        {
            if ( isdefined( level._id_1229D ) )
                var_8.lootfunc = level._id_1229D;
            else
                var_8.lootfunc = ::dropcrate;

            if ( !getdvarint( "scr_br_pe_choppers_attack", 0 ) )
            {
                var_8.frontturret._id_13E86 = 1;
                var_8.frontturret makeunusable();
                var_8.rearturret._id_13E86 = 1;
                var_8.rearturret makeunusable();
            }

            var_8.flaresreservecount = getdvarint( "scr_br_pe_choppers_flares", 0 );
            var_8.health = getdvarint( "scr_br_pe_choppers_health", 5000 );
            var_8.maxhealth = getdvarint( "scr_br_pe_choppers_health", 5000 );

            if ( scripts\mp\gametypes\br_publicevents.gsc::unset_relic_healthpacks() )
                var_8.lifetime = scripts\mp\gametypes\br_circle.gsc::inithelirepository();
            else if ( self.sol_5_6_pool )
                var_8.lifetime = self.sol_5_6_pool;

            if ( getdvarint( "scr_br_pe_choppers_attack", 0 ) != 0 )
                var_9 = "ui_mp_br_mapmenu_icon_boss_chopper";
            else
                var_9 = "ui_mp_br_mapmenu_icon_boss_chopper_event";

            scripts\mp\objidpoolmanager::update_objective_icon( var_8.objectiveiconid, var_9 );
        }

        wait 1;
    }

    var_10 = getdvarfloat( "scr_br_pe_chopppers_circle_damage_start_time", 10.0 );
    level.delay_turn_on_headlights = gettime() + int( var_10 * 1000.0 );
}

dropcrate()
{
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance( self );
    var_0 = scripts\mp\gametypes\br_lootchopper.gsc::_id_11A06( self.origin + ( 0, 0, 500 ) );

    if ( isdefined( var_0 ) )
    {
        var_1 = scripts\cp_mp\killstreaks\airdrop::missionid( self.origin, var_0 );
        var_2 = scripts\cp_mp\killstreaks\airdrop::gettriggerobject( var_1 );
        var_2._id_140A0 = 10;

        if ( !isdefined( level.delay_turn_off_tum_display ) )
            level.delay_turn_off_tum_display = [];

        level.delay_turn_off_tum_display[level.delay_turn_off_tum_display.size] = var_1;
    }
}

_id_1200F( var_0 )
{
    self.itemsdropped = 0;

    if ( !isdefined( level.delay_turn_off_red_lights_along_track ) )
        level.delay_turn_off_red_lights_along_track = 0;
    else
        level.delay_turn_off_red_lights_along_track = ( level.delay_turn_off_red_lights_along_track + 1 ) % 10;

    var_1 = verifybunkercode( "pe_chopper_crate", level.delay_turn_off_red_lights_along_track );

    if ( isdefined( var_1 ) )
        var_1 = scripts\mp\gametypes\br_lootcache.gsc::_id_11A1A( var_1, var_0 );

    if ( isdefined( var_1 ) && var_0 scripts\mp\utility\perk::_hasperk( "specialty_br_extra_killstreak_chance" ) )
        var_1 = scripts\mp\gametypes\br_lootcache.gsc::_id_11A1D( var_1, var_0 );

    if ( isdefined( var_1 ) )
        var_2 = scripts\mp\gametypes\br_lootcache.gsc::_id_11A02( var_1 );

    if ( !isdefined( var_0._id_11A01 ) )
        var_0._id_11A01 = 1;
    else
        var_0._id_11A01++;

    var_0 scripts\mp\utility\stats::setextrascore1( var_0._id_11A01 );
    var_0 thread scripts\mp\utility\points::giveunifiedpoints( "br_loot_chopper_box_open" );
}

dangercircletick( var_0, var_1 )
{
    if ( !isdefined( level.delay_turn_on_headlights ) || gettime() < level.delay_turn_on_headlights )
        return;

    var_2 = getdvarfloat( "scr_br_pe_choppers_circle_damage_tick", 500.0 );
    var_3 = 240.0;
    var_4 = level._id_119E7;

    if ( isdefined( var_4 ) )
    {
        var_4 = scripts\engine\utility::array_removeundefined( var_4 );

        foreach ( var_6 in var_4 )
        {
            var_7 = 0;
            var_8 = var_6.origin;
            var_9 = distance2d( var_0, var_8 );

            if ( var_9 + var_3 > var_1 )
                var_7 = 1;

            if ( var_7 )
            {
                var_10 = var_6.health;
                var_11 = var_6.maxhealth;
                var_6 dodamage( var_2, var_8, undefined, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }
        }
    }

    var_13 = getdvarfloat( "scr_br_circle_object_cleanup_threshold", 2400.0 );
    var_14 = level.delay_turn_off_tum_display;

    if ( isdefined( var_14 ) )
    {
        var_14 = scripts\engine\utility::array_removeundefined( var_14 );

        foreach ( var_16 in var_14 )
        {
            var_17 = distance2dsquared( var_16.origin, var_0 );
            var_18 = max( 0, var_1 + var_13 );

            if ( var_17 > var_18 * var_18 )
                var_16 thread scripts\cp_mp\killstreaks\airdrop::destroycrate();
        }
    }
}

forest_fire_setup( var_0 )
{
    level endon( "game_ended" );

    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.safecircleent ) )
        return;

    var_1 = scripts\mp\gametypes\br_circle.gsc::getsafecircleorigin();
    var_2 = scripts\mp\gametypes\br_circle.gsc::getsafecircleradius();
    var_3 = 0.3;
    var_4 = 0.8;
    var_5 = var_2 * var_3;
    var_6 = var_2 * var_4;
    [var_8, var_9] = play_tape_machine_animation( var_1, var_5, var_6 );

    if ( var_8 == var_9 )
        return;

    if ( var_8 != 0.0 || var_9 != 360.0 )
    {
        var_8 = var_8 + 20.0;
        var_9 = var_9 - 20.0;

        if ( var_9 <= var_8 )
            return;
    }
    else
    {
        var_10 = randomfloatrange( 0.0, 360.0 );
        var_8 = var_8 + var_10;
        var_9 = var_9 + var_10;
    }

    var_11 = ( var_9 - var_8 ) / max( 1.0, var_0 - 1 );
    level._id_1229F = [];

    for ( var_12 = 0; var_12 < var_0; var_12++ )
    {
        var_13 = var_8 + var_11 * var_12;
        var_14 = anglestoforward( ( 0.0, var_13, 0.0 ) );

        if ( var_6 > var_5 )
            var_15 = randomfloatrange( var_5, var_6 );
        else
            var_15 = var_6;

        var_16 = var_1 + var_14 * var_15;

        if ( isscriptabledefined() )
            var_16 = getclosestpointonnavmesh( var_16 );

        var_17 = spawnstruct();
        var_17.origin = var_16;
        level._id_1229F[var_12] = var_17;
    }
}

play_tape_machine_animation( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_3 = level.mapcenter - var_0;
    var_3 = ( var_3[0], var_3[1], 0.0 );
    var_3 = vectornormalize( var_3 );
    var_4 = vectortoyaw( var_3 );
    var_5 = var_0 + var_3 * var_1;
    var_6 = var_0 + var_3 * var_2;
    var_7 = !scripts\mp\outofbounds::ispointinoutofbounds( var_5 ) && !scripts\mp\outofbounds::ispointinoutofbounds( var_6 );

    if ( !var_7 )
        return [ 0.0, 0.0 ];

    var_8 = 45.0;
    var_9 = 45.0;
    var_10 = var_4;
    var_11 = var_4 + var_8;
    var_12 = var_4;
    var_13 = var_4 - var_9;
    var_14 = 0;
    var_15 = 180 / int( var_8 );
    var_16 = 0;
    var_17 = 1.0;

    for (;;)
    {
        if ( var_8 >= var_17 )
        {
            var_18 = anglestoforward( ( 0.0, var_11, 0.0 ) );
            var_19 = var_0 + var_18 * var_1;
            var_20 = var_0 + var_18 * var_2;
            var_21 = !scripts\mp\outofbounds::ispointinoutofbounds( var_19 ) && !scripts\mp\outofbounds::ispointinoutofbounds( var_20 );

            if ( var_21 )
            {
                var_10 = var_11;
                var_11 = var_10 + var_8;
            }
            else
            {
                var_16 = 1;
                var_8 = var_8 * 0.5;
                var_11 = var_10 + var_8;
            }
        }

        if ( var_9 >= var_17 )
        {
            var_22 = anglestoforward( ( 0.0, var_13, 0.0 ) );
            var_23 = var_0 + var_22 * var_1;
            var_24 = var_0 + var_22 * var_2;
            var_25 = !scripts\mp\outofbounds::ispointinoutofbounds( var_23 ) && !scripts\mp\outofbounds::ispointinoutofbounds( var_24 );

            if ( var_25 )
            {
                var_12 = var_13;
                var_13 = var_12 - var_9;
            }
            else
            {
                var_16 = 1;
                var_9 = var_9 * 0.5;
                var_13 = var_12 - var_9;
            }
        }

        if ( !var_16 )
        {
            var_14++;

            if ( var_14 >= var_15 )
                return [ 0.0, 360.0 ];
        }

        if ( var_8 < var_17 && var_9 < var_17 )
            return [ var_12, var_10 ];

        waitframe();
    }
}
