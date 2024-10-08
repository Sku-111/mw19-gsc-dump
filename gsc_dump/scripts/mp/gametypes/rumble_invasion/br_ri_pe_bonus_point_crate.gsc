// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    _killstreakneedslocationselection::thread_endon_death();
    level.current_safehouse_spawn_structs.specialistbr = getdvarint( "scr_ri_pe_bonus_point_crate_drops_total", 6 );
    level.current_safehouse_spawn_structs.specialdayloadouts = getdvarint( "scr_ri_pe_bonus_point_crate_drops_first", 3 );
    level.current_safehouse_spawn_structs.spectateprop = getdvarint( "scr_ri_pe_points_per_crate_capture", 10 );
    level.current_safehouse_spawn_structs.parachutecancutautodeploy = getdvarfloat( "scr_ri_pe_delay_between_crate_drops", 30.0 );
    level.current_safehouse_spawn_structs.spectatableprops = getdvarint( "scr_ri_pe_dogtags_accept_double_points", 0 );
    level.current_safehouse_spawn_structs.spawnzombiedogtags = getdvarfloat( "scr_ri_pe_bonus_point_crate_capture_time", 5.0 );
    level.current_safehouse_spawn_structs.spectateprop = getdvarint( "scr_ri_pe_bonus_points_per_crate", 10 );
    level.current_safehouse_spawn_structs.specialistperk = getdvar( "scr_ri_pe_bonus_point_crate_objective", "bonus_points_ri_10" );
    var_0 = spawnstruct();
    var_0.weight = getdvarfloat( "scr_ri_pe_bonus_point_crate_weight", 1.0 );
    var_0.attackerswaittime = ::attackerswaittime;
    var_0._id_140CF = ::_id_140CF;
    var_0._id_14382 = ::_id_14382;
    var_0._id_11B78 = getdvarint( "scr_ri_pe_bonus_point_crate_max_times", 1 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "hardpoint", "10   5   0   0    0   0   0   0" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 102, var_0 );
    _killstreakneedslocationselection::subtract_from_spawn_count_from_group();
    thread zombienumhitscar();
}

_id_140CF()
{
    return 0;
}

_id_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var_0 = forest_combat();
    wait( var_0 );
}

forest_combat()
{
    var_0 = getdvarfloat( "scr_ri_pe_bonus_point_crate_starttime_min", 795 );
    var_1 = getdvarfloat( "scr_ri_pe_bonus_point_crate_starttime_max", 1110 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}

attackerswaittime()
{
    level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "bonus_point_crates_started", 0 );
    _killstreakneedslocationselection::_id_12293();
}

zombienumhitscar()
{
    waitframe();

    if ( !isdefined( level.current_safehouse_spawn_structs._id_12E2C ) )
    {
        level.current_safehouse_spawn_structs._id_12E2C = spawnstruct();
        level.current_safehouse_spawn_structs._id_12E2C._id_13904 = "rumble_incursion";
    }

    level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = undefined;
    var_0 = level.currentability;

    if ( var_0.size > 0 )
    {
        var_1 = [];

        foreach ( var_3 in var_0 )
            var_1[var_1.size] = var_3.origin;

        level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = var_1;

        if ( var_1.size <= level.current_safehouse_spawn_structs.specialistbr )
        {
            level.current_safehouse_spawn_structs.specialistbr = var_1.size;

            if ( level.current_safehouse_spawn_structs.specialdayloadouts > var_1.size )
                level.current_safehouse_spawn_structs.specialdayloadouts = var_1.size;
        }
    }
}

killed_by_chopper()
{
    waittillframeend;
    scripts\mp\gametypes\br_rumble_invasion_bpc_mp_wz_island.gsc::initstructs();
    level.currentability = scripts\engine\utility::getstructarray( "brRumbleInv_bonus_point_crate_drops", "targetname" );
}