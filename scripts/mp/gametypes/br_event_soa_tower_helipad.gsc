// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\mp\flags::gameflaginit( "activate_cash_helis", 0 );
    setdvar( "scr_dmz_lc_active", 1 );
    level._id_14086 = 1;
    scripts\engine\scriptable::scriptable_addusedcallback( ::scriptable_used );
    scripts\engine\scriptable::_id_12F58( ::_id_12F5D );
    level scripts\mp\gametypes\br_lootchopper.gsc::init();
    level._effect["vfx_c4_red_light"] = loadfx( "vfx/iw8_br/gameplay/vfx_br_soa_c4_volumetric_glow" );
    tr_vis_radius_override_lod2();
    level thread object_is_valid();
}

tr_vis_radius_override_lod2()
{
    level._id_13460 = spawnstruct();
    level._id_13460.time = getdvarint( "scr_br_soa_tower_helipad_event_time", 120 );
    level._id_13460.chosencodephones = getdvarint( "scr_br_soa_tower_base_jump_threshold", 800 );
    level._id_13460._id_1345A = getdvarint( "scr_br_soa_tower_helipad_event_chopper_health", 5000 );
    level._id_13460._id_1345E = getdvarint( "scr_br_soa_tower_helipad_event_chopper_speed", 100 );
    level._id_13460._id_13458 = getdvarint( "scr_br_soa_tower_helipad_event_chopper_acceleration", 50 );
    level._id_13460._id_13459 = getdvarint( "scr_br_soa_tower_helipad_event_chopper_accuracy", 35 );
    level._id_13460._id_1345C = getdvarint( "scr_br_soa_tower_helipad_event_chopper_min_wait_time", 6 );
    level._id_13460._id_1345B = getdvarint( "scr_br_soa_tower_helipad_event_chopper_max_wait_time", 11 );
    level._id_13460._id_13466 = getdvarfloat( "scr_br_soa_tower_skydive_challenge_complete_threshold", 3 );
}

object_is_valid()
{
    waitframe();
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    level._id_13460.active = 0;
    level._id_13460.states = [ "inactive", "active" ];
    level._id_13460.current_state = "inactive";
    level._id_13460.cp_dntsk_raid_sound_load = 4;
    level._id_13460.cpcpammoarmorcratecapturecallback = [];

    if ( !isdefined( level._id_13460.choppers ) )
        level._id_13460.choppers = [];

    level._id_1345D = [];
    level._id_13460.occupied_rpg_trig = getent( "br_soa_tower_c4_event_vol", "targetname" );
    level._id_13460._id_12D83 = ( 20213, -14849, 5000 );
    level._id_13460 scripts\mp\utility\trigger::makeenterexittrigger( level._id_13460.occupied_rpg_trig, ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5 );
    level._id_13460._id_12659 = [];
    level._id_13460._id_12662 = [];
    level._id_13460._id_12663 = [];
    level._id_13460._id_12660 = [];
    level._id_13460._id_13B97 = -1;
    level scripts\mp\gametypes\br_lootchopper.gsc::init();
    level._id_13460 _id_131DB();
}

_id_131DB()
{
    var_0 = scripts\engine\utility::getstructarray( "soa_tower_helipad_bomb", "targetname" );
    var_1 = [];
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 20419, -15537, 4404 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 19640, -15161, 4354 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 19717, -14381, 4362 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 20180, -14144, 4354 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 20901, -14742, 4354 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 20817, -15180, 4354 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 19934, -15043, 4338 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 20514, -15072, 4338 );
    var_1[var_1.size] = spawnstruct();
    var_1[var_1.size - 1].origin = ( 20349, -14795, 4336 );
    var_0 = scripts\engine\utility::array_randomize( var_0 );

    for ( var_2 = 0; var_2 < 4; var_2++ )
    {
        var_3 = spawn( "script_model", var_0[var_2].origin );
        var_3.angles = var_0[var_2].angles;
        var_3 setmodel( "soa_tower_bomb" );
        var_3 thread cp_raid_complex_behavior();
        var_3.offset3d = ( 0, 0, 16 );
        var_3.curorigin = var_3.origin;
        var_3 scripts\mp\gameobjects::requestid( 0, 1 );
        var_3.ownerteam = "friendly";
        var_3.numtouching["axis"] = 0;
        var_3.numtouching["allies"] = 0;

        if ( isdefined( var_3.objidnum ) && var_3.objidnum != -1 )
        {
            var_4 = var_3.objidnum;
            scripts\mp\objidpoolmanager::update_objective_setfriendlylabel( var_4, "BR_SOA_EVENT/DISARM_C4" );
            scripts\mp\objidpoolmanager::update_objective_setneutrallabel( var_4, "BR_SOA_EVENT/DISARM_C4" );
            scripts\mp\objidpoolmanager::update_objective_setenemylabel( var_4, "BR_SOA_EVENT/DISARM_C4" );
            scripts\mp\objidpoolmanager::update_objective_icon( var_4, "ui_mp_br_loot_icon_equipment_c4" );
            scripts\mp\objidpoolmanager::update_objective_position( var_4, var_3.origin + ( 0, 0, 10 ) );
            scripts\mp\objidpoolmanager::update_objective_setbackground( var_4, 1 );
            scripts\mp\objidpoolmanager::objective_set_play_intro( var_4, 0 );
            scripts\mp\objidpoolmanager::objective_set_play_outro( var_4, 0 );
            getbnetigrbattlepassxpmultiplier( var_4, 150, 200 );
            getscriptcachecontents( var_4, 0.5, 1.0 );
        }

        var_3._id_140B8 = scripts\engine\utility::getclosest( var_3.origin, var_1 );
        level._id_13460.cpcpammoarmorcratecapturecallback[var_2] = var_3;
    }
}

getallextractspawninstances()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self._id_133EB = spawnstruct();
    self._id_133EC = 1;
    self._id_133EB notify( "stop_skydive_tracking" );
    self._id_133EB endon( "stop_skydive_tracking" );
    self._id_133EB.states = [ "soa_tower_top", "skydiving", "completed", "failed" ];
    self._id_133EB.current_state = "soa_tower_top";
    self._id_133EB.loot_getitemcount = 0;
    self._id_133EB._id_1381C = 0;
    self._id_133EB.initlocs_radio = 0;
    self._id_133EB._id_133F6 = 0;
    var_0 = level._id_13460._id_13466;

    for (;;)
    {
        if ( self isonground() && objectiveids() && !self isparachuting() )
        {
            self._id_133EB.current_state = "soa_tower_top";
            self._id_133EB._id_121CB = 0;
            self._id_133EB._id_1381C = 0;
            self._id_133EB.initlocs_radio = 0;
            self._id_133EB._id_133F6 = 0;
        }

        if ( !self isonground() && !objectiveids() )
        {
            if ( self._id_133EB.current_state != "failed" )
            {
                if ( self._id_133EB.current_state == "soa_tower_top" )
                    self._id_133EB._id_1381C = gettime() / 1000;

                self._id_133EB.current_state = "skydiving";
                self._id_133EB.initlocs_radio = gettime() / 1000;
                self._id_133EB._id_133F6 = self._id_133EB.initlocs_radio - self._id_133EB._id_1381C;
            }
        }
        else if ( self isonground() && !objectiveids() )
        {
            var_1 = 4300;
            var_2 = 1500;
            var_3 = scripts\engine\utility::ter_op( var_1 - self.origin[2] > var_2, "completed", "failed" );
            wait 0.1;

            if ( scripts\mp\utility\player::unset_relic_trex( self ) || !isalive( self ) )
                var_3 = "failed";

            self._id_133EB.current_state = var_3;

            switch ( self._id_133EB.current_state )
            {
                case "completed":
                    self._id_133EC = 0;

                    if ( getdvarint( "MLNNMOPQOP", 0 ) == 6 )
                        scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F( "t9_ch_global_ntower_jump_for_s3_5_event_wz", 1 );

                    self._id_133EB notify( "stop_skydive_tracking" );
                    break;
                case "failed":
                    self._id_133EC = 0;
                    self._id_133EB.current_state = "failed";
                    self._id_133EB notify( "stop_skydive_tracking" );
                    break;
            }

            self._id_133EC = 0;
            self._id_133EB notify( "stop_skydive_tracking" );
        }

        waitframe();
    }
}

oceanrock()
{
    level endon( "game_ended" );
    level._id_13460 endon( "stop_soa_tower_helipad_event" );
    var_0 = gettime() / 1000;
    var_1 = gettime() / 1000;

    for (;;)
    {
        var_2 = gettime() / 1000;
        var_3 = 120 - ( var_2 - var_0 );

        foreach ( var_5 in level._id_13460._id_12662 )
        {
            if ( var_2 - var_1 > 1.0 )
            {
                var_6 = obj_smuggler_killed_early( var_3 );
                var_5 playlocalsound( var_6 );
                var_1 = gettime() / 1000;
            }
        }

        wait 0.1;
    }
}

obj_smuggler_killed_early( var_0 )
{
    if ( var_0 > 20 )
        return "ui_mp_timer_countdown";
    else if ( var_0 > 10 )
        return "ui_mp_timer_countdown_10";
    else if ( var_0 > 5 )
        return "ui_mp_timer_countdown_half_sec";
    else if ( var_0 > 1.5 )
        return "ui_mp_timer_countdown_quarter_sec";
    else
        return "ui_mp_timer_countdown_1";
}

obj_room_fire_08( var_0 )
{
    if ( isdefined( var_0.attacker ) )
    {
        if ( isplayer( var_0.attacker ) )
            var_0.attacker objective_show_for_mlg_spectator();
    }

    return 1;
}

objectiveachievementkillcount()
{
    level endon( "game_ended" );
    level._id_13460 endon( "stop_soa_tower_helipad_event" );

    for (;;)
    {
        var_0 = scripts\engine\utility::array_combine_unique( level._id_13460._id_12659, level._id_13460._id_12662 );

        foreach ( var_2 in var_0 )
        {
            var_3 = var_2 objective_set_hot();

            if ( !var_3 && var_2 objectiveids() )
                var_2 objective_timers_reset_both();
            else if ( isalive( var_2 ) )
                var_2 objectiveicon();
            else
                var_2 objectivedescription();

            var_4 = gettime() / 1000;

            foreach ( var_2 in level._id_13460._id_12663 )
            {
                var_6 = gettime() / 1000 - var_2._id_13462 / 1000;
                var_7 = var_2.soldier_agent_lwfn6;

                if ( isdefined( var_7 ) )
                {
                    if ( var_7.hidden )
                        var_7 scripts\mp\hud_util::showelem();

                    var_7 setvalue( ceil( 10 - var_6 ) );
                }

                if ( var_2 objectiveids() )
                {
                    var_2 objective_timers_reset_both();

                    if ( isdefined( var_7 ) )
                        var_7 scripts\mp\hud_util::hideelem();

                    continue;
                }

                if ( var_6 >= 10 )
                {
                    var_2 objectivedescription();
                    objective_locations_logic( var_2, "br_soa_tower_event_helipad_unsubscribe" );
                }
            }
        }

        wait 0.1;
    }
}

objective_timers_reset_both()
{
    if ( !isdefined( self ) )
        return;

    if ( !objective_set_hot() )
    {
        level._id_13460._id_12662 = scripts\engine\utility::array_add( level._id_13460._id_12662, self );
        _id_13EF3();

        if ( level._id_13460.current_state == "active" )
            objective_locations_logic( self, "br_soa_tower_event_helipad_explosives" );
    }
    else if ( objective_origin() )
    {
        self._id_13462 = undefined;
        level._id_13460._id_12663 = scripts\engine\utility::array_remove( level._id_13460._id_12663, self );
    }
}

objectivedescription()
{
    if ( !isdefined( self ) )
        return;

    if ( objective_set_hot() )
    {
        _id_13EF4();
        level._id_13460._id_12662 = scripts\engine\utility::array_remove( level._id_13460._id_12662, self );
        level._id_13460._id_12663 = scripts\engine\utility::array_remove( level._id_13460._id_12663, self );
    }
}

objectiveicon()
{
    if ( !isdefined( self ) )
        return;

    if ( objective_set_hot() && !objective_origin() )
    {
        self._id_13462 = gettime();
        level._id_13460._id_12663 = scripts\engine\utility::array_add( level._id_13460._id_12663, self );
    }
}

objectiveids()
{
    if ( !isdefined( self ) )
        return 0;

    if ( scripts\engine\utility::array_contains( level._id_13460._id_12659, self ) )
        return 1;

    return 0;
}

objective_set_hot()
{
    if ( !isdefined( self ) )
        return 0;

    return scripts\engine\utility::array_contains( level._id_13460._id_12662, self );
}

objective_origin()
{
    if ( !isdefined( self ) )
        return 0;

    return scripts\engine\utility::array_contains( level._id_13460._id_12663, self );
}

objective_show_for_mlg_spectator()
{
    if ( !isdefined( self ) )
        return 0;

    if ( !scripts\engine\utility::array_contains( level._id_13460._id_12660, self ) && objective_set_hot() )
        level._id_13460._id_12660 = scripts\engine\utility::array_add( level._id_13460._id_12660, self );
}

objective_minimapupdate( var_0, var_1 )
{
    var_2 = undefined;

    if ( isdefined( var_1 ) )
    {
        var_2 = spawnstruct();
        var_2.intvar = var_1;
    }

    foreach ( var_4 in level._id_13460._id_12662 )
        scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( var_4, var_0, var_2 );
}

objective_locations_logic( var_0, var_1, var_2 )
{
    var_3 = undefined;

    if ( isdefined( var_2 ) )
    {
        var_3 = spawnstruct();
        var_3.intvar = var_2;
    }

    scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( var_0, var_1, var_3 );
}

_id_13DAB( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isplayer( var_0 ) && level._id_13460.chosencodephones > 0 )
        var_0 thread chosen_airlock_door();

    if ( isplayer( var_0 ) && !scripts\engine\utility::array_contains( level._id_13460._id_12659, var_0 ) )
        level._id_13460._id_12659 = scripts\engine\utility::array_add( level._id_13460._id_12659, var_0 );

    if ( isplayer( var_0 ) && ( !isdefined( var_0._id_133EC ) || !var_0._id_133EC ) )
        var_0 thread getallextractspawninstances();
}

_id_13DAC( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( isplayer( var_0 ) && scripts\engine\utility::array_contains( level._id_13460._id_12659, var_0 ) )
        level._id_13460._id_12659 = scripts\engine\utility::array_remove( level._id_13460._id_12659, var_0 );
}

_id_13DA5( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( !isplayer( var_0 ) )
        return 1;

    return 0;
}

chosen_airlock_door()
{
    self endon( "out_of_range" );
    self endon( "death_or_disconnect" );

    while ( !self isonground() )
        waitframe();

    self skydive_setbasejumpingstatus( 0 );

    for (;;)
    {
        if ( level._id_13460._id_12D83[2] - self.origin[2] > level._id_13460.chosencodephones )
            break;

        wait 0.1;
    }

    self skydive_setbasejumpingstatus( 1 );
    var_0 = [];
    var_0[0] = self;
    var_1 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
    var_2 = scripts\engine\trace::ray_trace( self.origin + ( 0, 0, 30 ), self.origin + ( 0, 0, -80 ), var_0, var_1 );

    if ( !isdefined( var_2 ) )
        self skydive_beginfreefall();

    self notify( "out_of_range" );
}

scriptable_used( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_0 ) && var_0.type == "soa_tower_bomb" )
    {
        if ( !level._id_13460.active )
        {
            level thread start_event();
            level._id_13460.active = 1;
        }

        var_0 thread location_tracker( var_3 );
    }
}

_id_12F5D( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_0 ) && var_0.type == "soa_tower_bomb" )
    {
        if ( !level._id_13460.active )
        {
            level thread start_event();
            level._id_13460.active = 1;
        }
    }
}

start_event()
{
    level._id_13460 thread objectiveachievementkillcount();
    waitframe();
    level._id_13460.current_state = "active";
    level._id_13460.cp_dntsk_raid_sound_load = 4;
    level._id_13460._id_13B97 = gettime();
    _id_13EE8();
    objective_minimapupdate( "br_soa_tower_event_helipad_explosives" );
    level._id_13460 thread _id_13291( "mp_slam_helicopter" );
    level thread _id_137AA();
    level._id_13460 _id_13467();
    _id_13EEA( "active" );
}

soldier_agent_lwfn3()
{
    thread scripts\mp\gametypes\br_publicevent_tower.gsc::_id_1344E();
}

_id_13467()
{
    if ( level._id_13460.choppers.size == 0 )
        level._id_13460.choppers = [];

    var_0 = scripts\engine\utility::getstruct( "patrol_zone", "targetname" );
    var_1 = _id_1345F();
    var_2 = scripts\mp\gametypes\br_lootchopper.gsc::_id_11A18( var_0, undefined, 1, var_1 );
    var_2 thread scripts\mp\gametypes\br_publicevent_tower.gsc::connectedplayercount();
    var_2.intro_driver_logic = ::_id_13450;
    var_2.intro_enemy_respawner = ::_id_13450;
    var_2.lootfunc = ::soldier_agent_lwfn3;
    var_2.interaction_is_floor_is_lava_client = ::_id_1344D;
    var_2.intermissionspawntime = ::_id_1344F;
    var_2.updateteamscoreplacements = 1;
    var_2.usefuncoverride = 1;
    var_2.health = level._id_13460._id_1345A;
    var_2.speed = level._id_13460._id_1345E;
    var_2.accel = level._id_13460._id_13458;
    var_2._id_13768 = level._id_13460._id_13459;
    var_2 thread _id_13450( var_1[0] );
    level._id_13460.choppers = scripts\engine\utility::array_add( level._id_13460.choppers, var_2 );
    waitframe();
    scripts\mp\vehicles\damage::set_post_mod_damage_callback( "loot_chopper", ::obj_room_fire_08 );
    scripts\mp\flags::gameflagset( "activate_cash_helis" );
    waitframe();
    scripts\mp\flags::gameflagclear( "activate_cash_helis" );

    if ( !isdefined( level.shutdownattractionicontrigger ) )
        level thread scripts\mp\gametypes\br_heavy_weapon_drop.gsc::init();
}

_id_1345F()
{
    var_0 = undefined;
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;

    if ( level.mapname == "mp_don4" )
    {
        var_0 = ( 19077, -17718, 5550 );
        var_1 = ( 17866, -15627, 5550 );
        var_2 = ( 19309, -13691, 5550 );
        var_3 = ( 21973, -13971, 5550 );
        var_4 = ( 22573, -15691, 5550 );
    }
    else
    {
        var_0 = ( 1132.5, 2841.5, 5550.5 );
        var_1 = ( 2337, 746.5, 5551 );
        var_2 = ( 902, -1193.5, 5548.5 );
        var_3 = ( -1763.5, -912, 5549 );
        var_4 = ( -2366, 811.5, 5549.5 );
    }

    var_5 = [ var_0, var_1, var_2, var_3, var_4 ];
    return var_5;
}

hidetimedrunhudfromplayer( var_0 )
{
    level notify( "stop_soa_tower_helipad_timer" );
    var_0 _id_13546();
    objective_minimapupdate( "br_soa_tower_event_helipad_complete_full_splash" );

    foreach ( var_2 in level._id_13460._id_12660 )
    {
        var_2 scripts\mp\gametypes\br_publicevent_tower.gsc::_id_12D23( "c4_event_participant" );

        if ( getdvarint( "MLNNMOPQOP", 0 ) == 6 )
            var_2 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F( "t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1 );
    }

    handlematchscoreboardinfo();
}

patchoutofboundstrigger()
{
    objective_minimapupdate( "br_soa_tower_event_helipad_timer_expired" );

    foreach ( var_1 in level._id_13460.cpcpammoarmorcratecapturecallback )
    {
        if ( isdefined( var_1 ) )
            var_1 thread lbravo_spawner_jammer4b();
    }

    handlematchscoreboardinfo();
}

handlematchscoreboardinfo()
{
    level endon( "game_ended" );
    level._id_13460.current_state = "inactive";

    foreach ( var_1 in level._id_13460.choppers )
    {
        if ( isdefined( var_1 ) )
        {

        }
    }

    level._id_13460 notify( "stop_soa_tower_helipad_event" );
    level._id_13460.active = 0;
    _id_13EE9();
}

_id_137AA()
{
    level endon( "stop_soa_tower_helipad_timer" );
    level endon( "game_ended" );
    wait 120;
    patchoutofboundstrigger();
}

cp_raid_complex_behavior()
{
    self endon( "death" );
    self endon( "disable_bomb_idle_fx" );
    var_0 = self.origin + anglestoup( self.angles ) * 2.5;

    for (;;)
    {
        playfx( scripts\engine\utility::getfx( "vfx_c4_red_light" ), var_0 );
        playsoundatpos( self.origin, "scn_soa_c4_beep" );
        wait 1.0;
    }
}

location_tracker( var_0 )
{
    var_1 = self.entity;
    var_1 notify( "disable_bomb_idle_fx" );
    level._id_13460.cp_dntsk_raid_sound_load--;
    _id_13EEB();

    if ( level._id_13460.cp_dntsk_raid_sound_load < 1 )
        hidetimedrunhudfromplayer( var_1 );

    playsoundatpos( var_1.origin, "scn_soa_c4_remove" );
    var_0 thread scripts\mp\gametypes\br_public.gsc::_id_12616( "iw8_ges_plyr_loot_pickup", 1.17 );
    var_0 objective_show_for_mlg_spectator();
    var_0 scripts\mp\gametypes\br_publicevent_tower.gsc::_id_12D23( "disarm_c4" );
    var_2 = scripts\mp\gametypes\br_pickups.gsc::test_ai_anim();
    var_3 = vectornormalize( var_1.origin - ( var_1._id_140B8.origin[0], var_1._id_140B8.origin[1], var_1.origin[2] ) ) * 5;
    var_4 = var_1.origin - var_3;
    var_5 = vectortoangles( var_1.origin - var_4 ) + ( 0, 45, 0 );
    scripts\mp\gametypes\br_lootcache.gsc::_id_11A41( "brloot_offhand_c4", var_2, var_4, var_5, 1, 0, 0 );
    level._id_13460.cpcpammoarmorcratecapturecallback = scripts\engine\utility::array_remove( level._id_13460.cpcpammoarmorcratecapturecallback, var_1 );
    var_1 scripts\mp\gameobjects::releaseid();
    var_1 notify( "deleted" );
    var_1 delete();
    waitframe();
}

lbravo_spawner_jammer4b()
{
    self endon( "death" );
    wait( randomfloatrange( 0.0, 1.25 ) );
    self setscriptablepartstate( "soa_tower_bomb", "explode", 0 );
    playsoundatpos( self.origin, "c4_expl_trans" );
    self notify( "disable_bomb_idle_fx" );
    level._id_13460.cpcpammoarmorcratecapturecallback = scripts\engine\utility::array_remove( level._id_13460.cpcpammoarmorcratecapturecallback, self );
    scripts\mp\gameobjects::releaseid();
    self notify( "deleted" );
    wait 10;
    self delete();
}

_id_13546()
{
    var_0 = [];
    var_0[0] = "brloot_plunder_cash_epic_1";
    var_0[1] = "brloot_plunder_cash_epic_2";
    var_0[2] = "brloot_access_card_gold_vault_lockbox_2";

    if ( getdvar( "scr_br_gametype", "" ) == "bodycount" )
    {
        var_0[3] = "brloot_bodycount_dogtag";
        var_0[4] = "brloot_bodycount_dogtag";
    }
    else
    {
        var_0[3] = "brloot_killstreak_uav";
        var_0[4] = "brloot_killstreak_clusterstrike";
    }

    playfx( scripts\engine\utility::getfx( "vfx_golden_loot_explosion_flare" ), self.origin );
    var_1 = scripts\mp\gametypes\br_pickups.gsc::test_ai_anim();
    var_1.ml_p3_to_safehouse_transition = 0;
    var_2 = vectornormalize( self.origin - ( self._id_140B8.origin[0], self._id_140B8.origin[1], self.origin[2] ) ) * 5;
    var_3 = self.origin - var_2;
    var_4 = vectortoangles( self.origin - var_3 ) + ( 0, 90, 0 );

    foreach ( var_6 in var_0 )
    {
        if ( scripts\mp\gametypes\br_lootcache.gsc::get_bonus_targets( var_6 ) )
            scripts\mp\gametypes\br_lootcache.gsc::_id_11A41( var_6, var_1, var_3, var_4, 1, 0, 0 );
    }
}

_id_11A17()
{
    if ( istrue( self.updateteamscoreplacements ) )
    {
        if ( self._id_12200 + 1 >= self._id_1220E.size )
            self.updateteamscoreplacements = 0;
        else
            self._id_12200 = self._id_12200 + 1;
    }
    else if ( self._id_12200 - 1 < 0 )
        self.updateteamscoreplacements = 1;
    else
        self._id_12200 = self._id_12200 - 1;
}

_id_13450( var_0 )
{
    self endon( "death" );

    for (;;)
    {
        if ( !isdefined( var_0 ) )
        {
            self setvehgoalpos( self._id_1220E[0], 1 );
            self.pathgoal = self._id_1220E[0];
        }
        else
        {
            self setvehgoalpos( var_0, 1 );
            self.pathgoal = var_0;
        }

        if ( isdefined( self.currenttarget ) && self.currentaction == "attacking" )
            self setlookatent( self.currenttarget );
        else
            self clearlookatent();

        scripts\engine\utility::_id_143A5( "near_goal", "begin_evasive_maneuvers" );
        var_1 = randomintrange( level._id_13460._id_1345C, level._id_13460._id_1345B );
        var_2 = randomint( 10 );
        wait( var_1 );

        if ( var_2 > 5 )
            self.updateteamscoreplacements = !self.updateteamscoreplacements;

        _id_11A17();
        var_0 = self._id_1220E[self._id_12200];
    }
}

_id_1344D()
{
    var_0 = undefined;

    if ( level.mapname == "mp_don4" )
        var_0 = ( 20213, -14849, 5141 );
    else
        var_0 = ( -479, 909, 5141 );

    return var_0;
}

_id_1344F()
{
    playsoundatpos( self.origin, "veh_lbravo_explode" );
    earthquake( 1, 3, self.origin, 1000 );
    playrumbleonposition( "grenade_rumble", self.origin );
    physicsexplosionsphere( self.origin, 1000, 100, 2 );
}

_id_11A16( var_0 )
{
    if ( self.currentaction != "patrol" )
        self.currentaction = "patrol";
    else if ( self.currentaction == "patrol" && !istrue( var_0 ) )
        return;

    self clearlookatent();
    self setneargoalnotifydist( 500 );
    var_1 = 0;
    var_2 = 0;

    for (;;)
    {
        foreach ( var_4 in self._id_1220E )
        {

        }

        if ( self.currentaction == "attacking" )
        {
            if ( !istrue( var_1 ) )
                var_1 = 1;

            waitframe();
            continue;
        }

        if ( !istrue( var_0 ) && istrue( var_1 ) )
            var_1 = 0;

        scripts\cp_mp\killstreaks\chopper_support::debugtimedelta( self._id_1220E[0], 1 );
        _id_11A17();
        wait 0.5;
    }
}

_id_13EF3()
{
    self.soldier_agent_lwfn4 = _id_13EE0( &"BR_SOA_EVENT/DISARM_COUNT", -1, 1.0, ( 1, 1, 1 ), 0, 50 );
    self.soldier_agent_lwfn5 = _id_13EE1();
    self.soldier_agent_lwfn6 = _id_13EE0( &"SPLASHES/HELIPAD_EXPLOSIVES_UNSUBSCRIBING", -1, 1.2, ( 1, 1, 1 ), -300, 85 );
    _id_13EF5();
    _id_13EF6( level._id_13460.current_state );
}

_id_13EF4()
{
    if ( !isdefined( self._id_13461 ) )
        return;

    foreach ( var_1 in self._id_13461 )
    {
        var_1 scripts\mp\hud_util::destroyelem();
        self._id_13461 = scripts\engine\utility::array_remove( self._id_13461, var_1 );
        var_1 = undefined;
    }

    self._id_13461 = undefined;
}

_id_13EF5()
{
    if ( !isdefined( self._id_13461 ) )
        return;

    foreach ( var_1 in self._id_13461 )
        var_1 scripts\mp\hud_util::hideelem();
}

_id_13EEA( var_0 )
{
    foreach ( var_2 in level._id_13460._id_12662 )
        var_2 _id_13EF6( var_0 );
}

_id_13EE8()
{
    foreach ( var_1 in level._id_13460._id_12662 )
        var_1 _id_13EF3();
}

_id_13EE9()
{
    foreach ( var_1 in level._id_13460._id_12662 )
        var_1 _id_13EF4();
}

_id_13EF6( var_0 )
{
    _id_13EF5();

    switch ( var_0 )
    {
        case "inactive":
            break;
        case "active":
            self.soldier_agent_lwfn4 setvalue( 4 - level._id_13460.cp_dntsk_raid_sound_load );
            self.soldier_agent_lwfn4 scripts\mp\hud_util::showelem();
            var_1 = undefined;

            if ( level._id_13460._id_13B97 <= 0 )
                var_1 = 120;
            else
            {
                var_2 = level._id_13460._id_13B97 / 1000;
                var_3 = gettime() / 1000;
                var_4 = var_3 - var_2;
                var_1 = 120 - var_4;
            }

            self.soldier_agent_lwfn5 settimer( var_1 );
            self.soldier_agent_lwfn5 scripts\mp\hud_util::showelem();
            break;
    }
}

_id_13EEB()
{
    foreach ( var_1 in level._id_13460._id_12662 )
        var_1.soldier_agent_lwfn4 setvalue( 4 - level._id_13460.cp_dntsk_raid_sound_load );
}

_id_13EDF( var_0 )
{
    if ( !isdefined( self._id_13461 ) )
        self._id_13461 = [];

    self._id_13461 = scripts\engine\utility::array_add( self._id_13461, var_0 );
}

_id_13EE0( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_6 ) )
        var_6 = "TOPLEFT";

    var_7 = scripts\mp\hud_util::createfontstring( "default", var_2 );
    var_8 = 40;
    var_9 = ( 1.0 - getdvarfloat( "LQORTPMNLL", 0 ) ) * var_8;
    var_10 = ( 1.0 - getdvarfloat( "NPLKLQMNPL", 0 ) ) * var_8 / 2;
    var_7 scripts\mp\hud_util::setpoint( var_6, var_6, 143 + var_9, var_5 + var_10 );
    var_7.color = var_3;
    var_7.label = var_0;
    var_7 setvalue( var_1 );
    _id_13EDF( var_7 );
    return var_7;
}

_id_13EE1()
{
    var_0 = newclienthudelem( self );
    var_0.elemtype = "timer";
    var_0.font = "default";
    var_0.fontscale = 1.25;
    var_0.basefontscale = 1.25;
    var_0.width = 0;
    var_0.height = 10;
    var_1 = 40;
    var_2 = ( 1.0 - getdvarfloat( "LQORTPMNLL", 0 ) ) * var_1;
    var_3 = ( 1.0 - getdvarfloat( "NPLKLQMNPL", 0 ) ) * var_1 / 2;
    var_0.x = 65 + var_2;
    var_0.y = 60 + var_3;
    var_0.xoffset = 25;
    var_0.yoffset = 0;
    var_0.children = [];
    var_0.hidden = 0;
    _id_13EDF( var_0 );
    return var_0;
}

_id_13291( var_0 )
{
    foreach ( var_2 in level._id_13460._id_12662 )
        var_2 playlocalsound( var_0, undefined, undefined, 1 );
}
