// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_120D2()
{
    var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "open_jeep_carpoc", 1 );
    var_0.destroycallback = ::_id_120CB;
    _id_120D8();
    _id_120D6();
    _id_120D9();
    _id_120D4();
    _id_120D3();
    _id_120D5();

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "open_jeep_carpoc", "init" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "open_jeep_carpoc", "init" ) ]]();

    _id_120DA();
    _id_120D7();
}

_id_120D7()
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "open_jeep_carpoc", "initLate" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "open_jeep_carpoc", "initLate" ) ]]();
}

_id_120D8()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( "open_jeep_carpoc", 1 );
    var_0.enterstartcallback = ::_id_120C8;
    var_0.enterendcallback = ::_id_120C6;
    var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
    var_0.exitendcallback = ::_id_120C9;
    var_0.reentercallback = ::_id_120E7;
    var_0.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatcabpassengerrestrictions();
    var_0.exitextents["front"] = 105;
    var_0.exitextents["back"] = 105;
    var_0.exitextents["left"] = 44;
    var_0.exitextents["right"] = 44;
    var_0.exitextents["top"] = 90;
    var_0.exitextents["bottom"] = 0;
    var_1 = "front";
    var_0.exitoffsets[var_1] = ( 75, 0, 65 );
    var_0.exitdirections[var_1] = "front";
    var_1 = "back";
    var_0.exitoffsets[var_1] = ( -90, 0, 65 );
    var_0.exitdirections[var_1] = "back";
    var_2 = [ "driver", "front_right", "back_left", "back_right" ];
    var_3 = "driver";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "open_jeep_carpoc", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "back_right", "back", "front_right", "front" ];
    var_0.exitoffsets[var_3] = ( 17, 19, 65 );
    var_0.exitdirections[var_3] = "left";
    var_4.animtag = "tag_seat_0";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4._id_12023 = "ping_vehicle_driver";
    var_4.spawnpriority = 4;
    var_3 = "front_right";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "open_jeep_carpoc", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "back_left", "back", "driver", "front" ];
    var_0.exitoffsets[var_3] = ( 17, -19, 65 );
    var_0.exitdirections[var_3] = "right";
    var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getturretpassengerrestrictions();
    var_4._id_13E8A = getcompleteweaponname( "tur_gun_carpoc_mp_pass" );
    var_4._id_13E92 = "tur_gun_carpoc_mp_pass";
    var_4._id_12023 = "ping_vehicle_rider";
    var_4.spawnpriority = 3;
    var_3 = "back_left";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "open_jeep_carpoc", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "front_right", "back", "back_right", "front" ];
    var_0.exitoffsets[var_3] = ( -24, -19, 65 );
    var_0.exitdirections[var_3] = "right";
    var_4.viewclamps["top"] = 45;
    var_4.viewclamps["bottom"] = 25;
    var_4.viewclamps["left"] = 120;
    var_4.viewclamps["right"] = 120;
    var_4.animtag = "tag_seat_1";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.hidestowedweapon = 1;
    var_4._id_12023 = "ping_vehicle_rider";
    var_4.spawnpriority = 2;
    var_3 = "back_right";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "open_jeep_carpoc", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ var_3, "back_left", "back", "driver", "front" ];
    var_0.exitoffsets[var_3] = ( -40, 0, 65 );
    var_0.exitdirections[var_3] = "back";
    var_4.viewclamps["top"] = 45;
    var_4.viewclamps["bottom"] = 25;
    var_4.viewclamps["left"] = 120;
    var_4.viewclamps["right"] = 120;
    var_4.animtag = "tag_seat_3";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.hidestowedweapon = 1;
    var_4._id_12023 = "ping_vehicle_rider";
    var_4.spawnpriority = 1;
}

_id_120D6()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( "open_jeep_carpoc", 1 );
    scripts\cp_mp\vehicles\vehicle_interact::_id_1419D( "open_jeep_carpoc", "single", [ "driver", "front_right", "back_left", "back_right" ] );
}

_id_120D9()
{
    var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E( "open_jeep_carpoc", 1 );
    var_0.id = 25;
    var_0.seatids["driver"] = 0;
    var_0.seatids["front_right"] = 1;
    var_0.seatids["back_left"] = 2;
    var_0.seatids["back_right"] = 3;
    var_0._id_12DA2[0] = 0;
    var_0._id_12DA2[1] = 1;
    var_0._id_12DA3["driver"]["open_jeep_carpoc_mp"] = 0;
    var_0._id_12DA3["driver"]["tur_gun_carpoc_mp_pass"] = 1;
    var_0._id_12DA3["front_right"]["open_jeep_carpoc_mp"] = 0;
    var_0._id_12DA3["front_right"]["tur_gun_carpoc_mp_pass"] = 1;
    var_0._id_12DA3["back_left"]["open_jeep_carpoc_mp"] = 0;
    var_0._id_12DA3["back_left"]["tur_gun_carpoc_mp_pass"] = 1;
    var_0._id_12DA3["back_right"]["open_jeep_carpoc_mp"] = 0;
    var_0._id_12DA3["back_right"]["tur_gun_carpoc_mp_pass"] = 1;
}

_id_120D4()
{
    scripts\cp_mp\vehicles\vehicle_damage::_id_1416C( "open_jeep_carpoc", 2750 );
    var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle( "open_jeep_carpoc" );
    var_0.class = "medium_heavy";
    scripts\cp_mp\vehicles\vehicle_damage::_id_1413D( "open_jeep_carpoc" );
    scripts\cp_mp\vehicles\vehicle_damage::_id_14178( "open_jeep_carpoc", 9 );
    scripts\cp_mp\vehicles\vehicle_damage::_id_14176( "open_jeep_carpoc", ::_id_120E4 );
    scripts\cp_mp\vehicles\vehicle_damage::_id_14175( "open_jeep_carpoc", ::_id_120E3 );
    scripts\cp_mp\vehicles\vehicle_damage::_id_14171( "open_jeep_carpoc", ::_id_120C4 );
    scripts\cp_mp\vehicles\vehicle_damage::_id_1417B( "open_jeep_carpoc_mp", 5 );
}

_id_120D3()
{
    var_0 = _calloutmarkerping_predicted_log::_id_1410F( "open_jeep_carpoc", 1 );
    var_0.challengeevaluator = 1.33333;
    var_0.keycardlocs_chosen = 0.91666;
    var_0.is_using_stealth_debug = 350;
    var_0.is_valid_station_name = 525;
    var_0.is_two_hit_melee_weapon = 875;
    var_0.isakimbomeleeweapon = 10;
    var_0.isallowedweapon = 40;
    var_0.isakimbo = 80;
    var_0.isattachmentgrenadelauncher = 0;
    var_0.isattachmentselectfire = 0;
    var_0.isassaulting = 0;

    if ( getdvarint( "PNPLTTTNN", 0 ) )
        var_0.setup_techo_lmgs = ::_id_120F1;
}

_id_120D5()
{
    level._effect["open_jeep_carpoc_explode"] = loadfx( "vfx/iw8_mp/vehicle/vfx_jeep_mp_death_exp.vfx" );

    if ( getdvarint( "PNPLTTTNN", 0 ) )
        level._effect["open_jeep_carpoc_ramming_sparks"] = loadfx( "vfx/iw8_mp/vehicle/vfx_tromeo_mp_dmg_sparks.vfx" );
}

_id_120C2( var_0 )
{
    var_1 = "tag_gunner_turret2_rot";
    var_2 = ( 0, 0, 0 );
    var_3 = spawnturret( "misc_turret", var_0 gettagorigin( var_1 ), "tur_gun_carpoc_mp_pass", 0 );
    var_3 linkto( var_0, var_1, var_2, ( 0, 0, 0 ) );
    var_3 setmodel( "veh_s4_mil_ratrace_suv_turret_wz" );
    var_3 setmode( "sentry_offline" );
    var_3 setsentryowner( undefined );
    var_3 makeunusable();
    var_3 setdefaultdroppitch( 0 );
    var_3 setturretmodechangewait( 1 );
    var_3.angles = var_0.angles;
    var_3.vehicle = var_0;
    scripts\cp_mp\vehicles\vehicle::_id_14207( var_0, var_3, getcompleteweaponname( "tur_gun_carpoc_mp_pass" ) );
}

_id_120C1( var_0, var_1 )
{
    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0, 0, 0 );

    var_2 = getdvarint( "scr_open_jeep_carpoc_use_alt_vehicle_type", 0 );
    var_0.modelname = "veh_s4_mil_ratrace_suv_wz";
    var_0.targetname = "open_jeep_carpoc";
    var_0.vehicletype = "open_jeep_physics_carpoc_mp";

    if ( var_2 == 1 )
    {

    }
    else if ( var_2 == 2 )
    {

    }

    var_3 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle( var_0, var_1 );

    if ( !isdefined( var_3 ) )
        return undefined;

    scripts\cp_mp\vehicles\vehicle::_id_14138( var_3, "open_jeep_carpoc", var_0 );
    _id_120C2( var_3 );
    var_3.objweapon = getcompleteweaponname( "open_jeep_carpoc_mp" );
    var_4 = scripts\cp_mp\vehicles\vehicle_damage::_id_1414C( var_3, 1 );
    var_4.wind_trigger_toggle = "br_light_vehicle_damage";
    var_4._id_11BAE = "br_medium_vehicle_damage";
    _calloutmarkerping_predicted_timeout::_id_1412B( var_3 );
    scripts\cp_mp\vehicles\vehicle::_id_14139( var_3, var_0 );
    thread scripts\cp_mp\vehicles\vehicle::vehicle_watchflipped( var_3, undefined, scripts\cp_mp\vehicles\vehicle::vehicle_flippedendcallback );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "open_jeep_carpoc", "create" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "open_jeep_carpoc", "create" ) ]]( var_3 );

    return var_3;
}

_id_120CB( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_0 = spawnstruct();
        var_0.inflictor = self;
        var_0.objweapon = "open_jeep_carpoc_mp";
        var_0.meansofdeath = "MOD_EXPLOSIVE";
    }

    scripts\cp_mp\vehicles\vehicle_damage::_id_14162( var_0 );
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants( self, var_0 );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals( undefined, undefined, 1 );
    thread _id_120C5();

    if ( !istrue( level.suppressvehicleexplosion ) )
    {
        var_2 = self gettagorigin( "tag_origin" );
        var_3 = scripts\engine\utility::ter_op( isdefined( var_0.attacker ) && isent( var_0.attacker ), var_0.attacker, self );
        self radiusdamage( var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "open_jeep_carpoc_mp" );
        playfx( scripts\engine\utility::getfx( "open_jeep_carpoc_explode" ), var_2, anglestoforward( self.angles ), anglestoup( self.angles ) );
        playsoundatpos( var_2, "car_explode" );
        earthquake( 0.4, 800, var_2, 0.7 );
        playrumbleonposition( "grenade_rumble", var_2 );
        physicsexplosionsphere( var_2, 500, 200, 1 );
    }
}

_id_120C5()
{
    scripts\cp_mp\vehicles\vehicle::_id_14185( self );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "open_jeep_carpoc", "delete" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "open_jeep_carpoc", "delete" ) ]]( self );

    waitframe();
    scripts\cp_mp\vehicles\vehicle::_id_14186( self );
}

_id_120E4( var_0 )
{
    if ( scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_isselfdamage( self, var_0 ) )
        return 0;

    return 1;
}

_id_120E3( var_0 )
{
    if ( isdefined( var_0.damage ) && var_0.damage > 0 )
        self notify( "damage_taken", var_0 );

    return 1;
}

_id_120C4( var_0 )
{
    thread _id_120CB( var_0 );
    return 1;
}

_id_120C8( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_1 == "front_right" )
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_giveturret( var_3, "tur_gun_carpoc_mp_pass", var_4, 1 );
}

_id_120C6( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_4.success ) )
        thread _id_120C7( var_0, var_1, var_2, var_3, var_4 );
    else if ( !istrue( var_4.playerdisconnect ) && !istrue( var_4.playerdeath ) )
    {
        if ( var_1 == "front_right" )
            thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret( var_3, var_0, "tur_gun_carpoc_mp_pass", var_4, 1 );
    }
}

_id_120C7( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_1 == "driver" )
    {
        var_0 setotherent( var_3 );
        var_0 setentityowner( var_3 );
        var_3 controlslinkto( var_0 );
        var_5 = var_0 _meth_87E6();

        if ( var_5 )
        {
            var_3 setclientomnvar( "ui_veh_show_time", 1 );
            thread open_jeep_carpoc_monitor_speed_boost( var_0, var_3, var_1, var_4 );
            thread open_jeep_carpoc_speed_boost_cleanup_monitor( var_0, var_3 );
        }
    }
    else if ( var_1 == "front_right" )
    {
        var_6 = 2350;
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_disablefirefortime( var_3, var_6 );
        var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192( var_0, "tur_gun_carpoc_mp_pass" );
        var_7.owner = var_3;
        var_7 setotherent( var_3 );
        var_7 setentityowner( var_3 );
        var_7 setsentryowner( var_3 );
        var_3 disableturretdismount();
        var_3 controlturreton( var_7 );
    }

    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer( var_0, var_1, var_2 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter( var_0, var_2, var_1, var_3 );
}

_id_120C9( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_4.success ) )
        _id_120CA( var_0, var_1, var_2, var_3, var_4 );
}

_id_120CA( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_1 == "driver" )
    {
        var_0 notify( "open_jeep_carpoc_driver_exit" );
        var_0 setotherent( undefined );
        var_0 setentityowner( undefined );

        if ( !istrue( var_4.playerdisconnect ) )
            var_3 controlsunlink();
    }
    else if ( var_1 == "front_right" )
    {
        var_0 notify( "open_jeep_carpoc_gunner_exit" );
        var_5 = scripts\cp_mp\vehicles\vehicle::_id_14192( var_0, "tur_gun_carpoc_mp_pass" );
        var_5.owner = undefined;

        if ( !istrue( var_4.playerdisconnect ) )
        {
            var_3 enableturretdismount();
            var_3 controlturretoff( var_5 );
            thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_cleardisablefirefortime( var_3, var_4.playerdeath );

            if ( !istrue( var_4.playerdeath ) )
                thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret( var_3, var_0, "tur_gun_carpoc_mp_pass", var_4, 1 );
        }

        var_5 setotherent( undefined );
        var_5 setentityowner( undefined );
        var_5 setsentryowner( undefined );
    }

    if ( !istrue( var_4.playerdisconnect ) )
    {
        var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
        var_6 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit( var_3, var_2, var_4 );

        if ( !var_6 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "handleSuicideFromVehicles" ) )
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "handleSuicideFromVehicles" ) ]]( var_3 );
            else
                var_3 suicide();
        }
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit( var_0, var_1, var_2, var_3 );
}

_id_120E7( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_2 ) && var_2 == "front_right" )
        thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_taketurret( var_3, var_0, "tur_gun_carpoc_mp_pass", var_4, 1 );
}

_id_120DA()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "open_jeep_carpoc", 1 );
    var_0.maxinstancecount = 2;
    var_0.priority = 75;
    var_0.getspawnstructscallback = ::_id_120CF;

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "open_jeep_carpoc", "spawnCallback" ) )
        var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc( "open_jeep_carpoc", "spawnCallback" );

    var_0.clearancecheckradius = 105;
    var_0.clearancecheckheight = 90;
    var_0.clearancecheckminradius = 105;
}

_id_120CF()
{
    if ( isdefined( level._id_1218B ) )
        var_0 = level._id_1218B;
    else
        var_0 = scripts\engine\utility::getstructarray( "open_jeep_carpoc_spawn", "targetname" );

    if ( var_0.size > 0 )
    {
        var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag( var_0, 1 );

        if ( var_0.size > 1 )
            var_0 = scripts\engine\utility::array_randomize( var_0 );
    }

    return var_0;
}

activate_timed_laser_traps()
{

}

_id_120EE( var_0, var_1 )
{
    if ( !getdvarint( "scr_open_jeep_carpoc_update_upgrade_team", 1 ) )
        return;

    var_2 = _id_120E2( var_0 );
    var_3 = _id_120CD( var_0, var_2, var_1 );

    if ( var_3 == "neutral" )
        return;

    if ( !isdefined( var_0._id_13DF6 ) )
        var_0._id_13DF6 = var_3;

    if ( var_0._id_13DF6 == var_3 )
        return;

    var_0._id_13DF6 = var_3;
    var_4 = _id_120E5( var_0, var_1 );
    var_0 _id_120E6( var_0, var_4 );
}

_id_120E2( var_0 )
{
    var_1 = var_0.occupants["driver"];

    if ( isdefined( var_1 ) )
        return var_1.team;

    var_2 = var_0.occupants["front_right"];

    if ( isdefined( var_2 ) )
        return var_2.team;

    return "neutral";
}

_id_120CD( var_0, var_1, var_2 )
{
    if ( var_1 != "neutral" )
        return var_1;

    if ( isdefined( var_2 ) )
        return var_2.team;

    return var_0.team;
}

_id_120E5( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        return var_1;

    var_2 = var_0.occupants["driver"];

    if ( isdefined( var_2 ) )
        return var_2;

    var_3 = var_0.occupants["front_right"];

    if ( isdefined( var_3 ) )
        return var_3;

    return undefined;
}

_id_120E6( var_0, var_1 )
{
    if ( isdefined( var_0.radar ) )
        var_0.radar delete();
    else if ( istrue( var_0._id_129C5 ) )
        var_0 _meth_87AC();

    if ( istrue( var_0._id_129C5 ) )
        _id_120E9( var_0, var_1 );
}

_id_120E8( var_0, var_1 )
{
    var_0 endon( "death" );
    var_0.radar endon( "death" );
    var_2 = var_1.team;
    var_1 waittill( "disconnect" );
    var_3 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var_2, 0 );
    var_4 = undefined;

    if ( isdefined( var_3 ) && var_3.size > 0 )
        var_4 = var_3[0];

    level thread _id_120E6( var_0, var_4 );
}

_id_120E9( var_0, var_1 )
{
    var_2 = getdvarint( "scr_truck_mg_uav_type", 0 );

    if ( var_2 == 0 )
        var_0 _meth_87AB();
    else if ( isdefined( var_1 ) )
    {
        var_3 = spawn( "script_model", var_0.origin );
        var_3 setmodel( "tag_origin" );
        var_3 linkto( var_0 );
        var_3 makeportableradar( var_1 );
        var_0.radar = var_3;
        level thread _id_120E8( var_0, var_1 );
    }
}

_id_120F1( var_0, var_1 )
{
    var_2 = var_0.position[0];
    var_3 = var_0.ent[0];
    var_4 = var_0.velocity[0];

    if ( isdefined( var_2 ) && var_3 _meth_87DC() )
    {
        var_5 = var_4 * 0.05;
        var_6 = var_2 + var_5;
        playfx( scripts\engine\utility::getfx( "open_jeep_carpoc_ramming_sparks" ), var_6, anglestoforward( var_3.angles ), anglestoup( var_3.angles ) );
    }
}

open_jeep_carpoc_monitor_speed_boost( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    var_0 endon( "open_jeep_carpoc_driver_exit" );
    var_1 endon( "disconnect" );
    var_1 endon( "death" );
    var_4 = 0;

    if ( var_2 == "driver" )
    {
        for (;;)
        {
            var_5 = max( 0, var_0 _meth_87DF() );
            var_1 setclientomnvar( "ui_veh_time_percent", int( var_5 ) );
            var_6 = var_0 _meth_87E7();
            var_1 setclientomnvar( "ui_br_veh_speed_boost_in_cooldown", var_6 );
            var_7 = var_0 _meth_87E0();

            if ( var_7 )
            {
                if ( !var_4 )
                {
                    var_0 setscriptablepartstate( "speedBoost", "on" );
                    open_jeep_carpoc_handle_sound_start( var_0 );
                    var_1 setclientomnvar( "ui_deadsilence_overlay", 0 );
                }
            }
            else if ( var_4 )
            {
                var_0 setscriptablepartstate( "speedBoost", "off" );
                open_jeep_carpoc_handle_sound_stop( var_0 );
                var_1 setclientomnvar( "ui_deadsilence_overlay", 2 );
            }

            var_4 = var_7;
            waitframe();
        }
    }
}

open_jeep_carpoc_speed_boost_cleanup_monitor( var_0, var_1 )
{
    scripts\engine\utility::waittill_any_ents( var_0, "death", var_0, "open_jeep_carpoc_driver_exit", var_1, "disconnect", var_1, "death" );
    open_jeep_carpoc_speed_boost_vfx_cleanup( var_0, var_1 );
    var_0 stoploopsound();
    var_1 setclientomnvar( "ui_veh_show_time", 0 );
}

open_jeep_carpoc_speed_boost_vfx_cleanup( var_0, var_1 )
{
    var_0 setscriptablepartstate( "speedBoost", "off" );
    var_1 setclientomnvar( "ui_deadsilence_overlay", 2 );
}

open_jeep_carpoc_handle_sound_start( var_0 )
{
    var_0 playsoundonmovingent( "veh_carpoc_nitro_strt" );
    var_0 playloopsound( "veh_carpoc_nitro_lp" );
}

open_jeep_carpoc_handle_sound_stop( var_0 )
{
    var_0 playsoundonmovingent( "veh_carpoc_nitro_end" );
    var_0 stoploopsound();
}
