// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

activate_laser_trap_parent()
{

}

init()
{
    thread_endon_death();
    var_0 = spawnstruct();
    var_0.weight = getdvarfloat( "scr_pe_bonus_point_crate_weight", 1.0 );
    var_0.attackerswaittime = ::attackerswaittime;
    var_0._id_140CF = ::_id_140CF;
    var_0._id_14382 = ::_id_14382;
    var_0._id_11B78 = getdvarint( "scr_pe_bonus_point_crate_max_times", 1 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "hardpoint", "10   5   0   0    0   0   0   0" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 102, var_0 );
    subtract_from_spawn_count_from_group();
}

subtract_from_spawn_count_from_group()
{
    game["dialog"]["bonus_point_crates_started"] = "bonus_point_crates_started";
}

thread_endon_death()
{
    if ( !isdefined( level.current_safehouse_spawn_structs ) )
        level.current_safehouse_spawn_structs = spawnstruct();

    level.current_safehouse_spawn_structs.spectatenumber = getdvarint( "scr_pe_bonus_point_crate_incoming_warning_time", 20 );
    level.current_safehouse_spawn_structs.parachute_spawn = getdvarint( "scr_pe_bonus_point_crate_splash_duration", 3.0 );
    level.current_safehouse_spawn_structs.specialistbr = getdvarint( "scr_pe_bonus_point_crate_drops_total", 6 );
    level.current_safehouse_spawn_structs.specialdayloadouts = getdvarint( "scr_pe_bonus_point_crate_drops_first", 3 );
    level.current_safehouse_spawn_structs.spectateprop = getdvarint( "scr_pe_points_per_crate_capture", 10 );
    level.current_safehouse_spawn_structs.parachutecancutautodeploy = getdvarfloat( "scr_pe_delay_between_crate_drops", 30.0 );
    level.current_safehouse_spawn_structs.spectatableprops = getdvarint( "scr_pe_dogtags_accept_double_points", 0 );
    level.current_safehouse_spawn_structs.spawnzombiedogtags = getdvarfloat( "scr_pe_bonus_point_crate_capture_time", 5.0 );
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
    var_0 = getdvarfloat( "scr_pe_bonus_point_crate_starttime_min", 795 );
    var_1 = getdvarfloat( "scr_pe_bonus_point_crate_starttime_max", 1110 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}

attackerswaittime()
{
    level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "bonus_point_crates_started", 0 );
    _id_12293();
}

_id_12AEE( var_0 )
{
    if ( !isdefined( self.arena_bot_pickup_weapon ) )
        self.arena_bot_pickup_weapon = [];

    self.arena_bot_pickup_weapon[self.arena_bot_pickup_weapon.size] = var_0;
}

_id_12293()
{
    level endon( "game_ended" );
    _id_12291();
    level thread _id_12290( level.current_safehouse_spawn_structs.specialdayloadouts );

    if ( getdvarint( "scr_rumble_skip_event_wait_times", 0 ) == 0 )
    {
        _utilflare_lerpflare::_id_12424( "br_rumble_pe_bonus_point_crates_incoming" );
        wait( level.current_safehouse_spawn_structs.spectatenumber );
    }

    _utilflare_lerpflare::_id_12424( "br_rumble_pe_bonus_point_crates_online" );
    wait( level.current_safehouse_spawn_structs.parachute_spawn );
    level thread _id_12292();
}

_id_12291()
{
    level.current_safehouse_spawn_structs._id_12E29 = spawnstruct();
    level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate = [];
    level.current_safehouse_spawn_structs._id_12E29.are_all_alive_players_touching_plane = [];

    if ( !isdefined( level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon ) )
    {
        var_0 = ( 0, 0, 0 );

        if ( isdefined( level.current_safehouse_spawn_structs._id_12E2C.ground_detection_think ) )
            var_0 = level.current_safehouse_spawn_structs._id_12E2C.ground_detection_think;

        level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = [ var_0 + ( 0, 0, 0 ), var_0 + ( 1500, 1500, 0 ), var_0 + ( 1500, -1500, 0 ), var_0 + ( -1500, 1500, 0 ), var_0 + ( -1500, -1500, 0 ), var_0 + ( 3000, 3000, 0 ), var_0 + ( 3000, -3000, 0 ), var_0 + ( -3000, 3000, 0 ), var_0 + ( -3000, -3000, 0 ) ];
    }

    level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon = scripts\engine\utility::array_randomize( level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon );
    var_1 = scripts\cp_mp\killstreaks\airdrop::getleveldata( "ri_bonus_points_crate" );
    var_1.capturestring = &"MP/GENERIC_LOOT_CRATE_CAPTURE";
    var_1.dummymodel = "military_carepackage_01_br_legendary";
    var_1.friendlymodel = undefined;
    var_1.enemymodel = undefined;
    var_1.mountmantlemodel = undefined;
    var_1.supportsownercapture = 0;
    var_1.headicon = undefined;
    var_1.minimapicon = undefined;
    var_1.usepriority = -1;
    var_1.usefov = 180;
    var_1.timeout = undefined;
    var_1.friendlyuseonly = 0;
    var_1.ownerusetime = level.current_safehouse_spawn_structs.spawnzombiedogtags;
    var_1.otherusetime = level.current_safehouse_spawn_structs.spawnzombiedogtags;
    var_1.activatecallback = ::_id_1228A;
    var_1.capturecallback = ::_id_1228B;
    var_1.destroyoncapture = 1;
}

_id_12292()
{
    level endon( "game_ended" );
    var_0 = level.current_safehouse_spawn_structs.specialdayloadouts;
    var_1 = level.current_safehouse_spawn_structs.specialistbr - var_0;
    _id_12294( var_0 );

    if ( level.current_safehouse_spawn_structs.parachutecancutautodeploy > level.current_safehouse_spawn_structs.spectatenumber )
        wait( level.current_safehouse_spawn_structs.parachutecancutautodeploy - level.current_safehouse_spawn_structs.spectatenumber );

    level thread _id_12290( var_1, var_0 );
    wait( level.current_safehouse_spawn_structs.spectatenumber );
    _utilflare_lerpflare::_id_12424( "br_rumble_pe_bonus_point_crates_online" );
    wait( level.current_safehouse_spawn_structs.parachute_spawn );
    _id_12294( var_1, var_0 );
}

_id_12294( var_0, var_1 )
{
    level endon( "game_ended" );

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    for ( var_2 = 0; var_2 < var_0; var_2++ )
    {
        var_3 = level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon[var_2 + var_1];
        var_3 = var_3 + ( 0, 0, 2000 );
        var_4 = scripts\cp_mp\killstreaks\airdrop::dropcrate( undefined, undefined, "ri_bonus_points_crate", var_3, ( 0, randomint( 360 ), 0 ) );
        level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate[level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate.size] = var_4;
        var_4 thread _id_1228D();
        var_4 thread _id_1228E();
        wait 2.5;
    }
}

_id_1228D()
{
    var_0 = scripts\engine\utility::drop_to_ground( self.origin, 50, -3000, ( 0, 0, 1 ) );
    self.molotov_delete_oldest_trigger = spawn( "script_model", var_0 + ( 0, 0, 3 ) );
    self.molotov_delete_oldest_trigger setmodel( "scr_smoke_grenade" );
    wait 1.0;
    self.molotov_delete_oldest_trigger setscriptablepartstate( "smoke", "on" );
    self.molotov_delete_oldest_trigger setscriptablepartstate( "br_rumble_bonus_point_audio", "smoke_sfx" );
}

_id_1228E()
{
    var_0 = scripts\engine\utility::ter_op( level.current_safehouse_spawn_structs.spectateprop == 10, "bonus_points_10", "bonus_points" );

    if ( isdefined( level.current_safehouse_spawn_structs.specialistperk ) )
        var_0 = level.current_safehouse_spawn_structs.specialistperk;

    self setscriptablepartstate( "objective", var_0 );
}

_id_12290( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 0;

    for ( var_2 = 0; var_2 < var_0; var_2++ )
    {
        if ( !isdefined( level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon[var_2 + var_1] ) )
            return;

        level thread _id_1228F( var_2 + var_1 );
        wait 2.0;
    }
}

_id_1228F( var_0 )
{
    var_1 = level.current_safehouse_spawn_structs._id_12E2C.arena_bot_pickup_weapon[var_0];
    scripts\mp\gametypes\br_quest_util.gsc::_id_140B1( var_1, "dom" );
}

_id_1228A( var_0 )
{
    if ( istrue( var_0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "airdrop", "registerCrateForCleanup" ) )
            [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "airdrop", "registerCrateForCleanup" ) ]]( self );
    }
}

_id_1228B( var_0 )
{
    level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate = scripts\engine\utility::array_remove( level.current_safehouse_spawn_structs._id_12E29.aq_ontimerupdate, self );
    self setscriptablepartstate( "jugg_drop_beacon", "off" );
    self setscriptablepartstate( "bonus_points_audio", "expl_sfx" );
    level thread _id_1228C( var_0.team );
    self notify( "captured" );
    playfx( scripts\engine\utility::getfx( "vfx_golden_loot_explosion_flare" ), self.origin );
    var_1 = randomintrange( 3, 5 );
    level thread _handlevehiclerepair::_id_13673( "bonus_points_crate", self.origin, var_1, 0 );
    level scripts\mp\gamescore::giveteamscoreforobjective( var_0.pers["team"], level.current_safehouse_spawn_structs.spectateprop, 0 );

    if ( isdefined( self.objectiveiconid ) )
        objective_delete( self.objectiveiconid );

    playfx( level.conf_fx["vanish"], self.molotov_delete_oldest_trigger.origin );
    self.molotov_delete_oldest_trigger delete();
}

_id_1228C( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( isdefined( var_2 ) && isdefined( var_2.team ) && var_2.team == var_0 )
            var_2 thread scripts\mp\hud_message::showsplash( "br_rumble_pe_bonus_point_crate_captured_ally" );
    }
}
