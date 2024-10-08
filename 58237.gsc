// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_11D60()
{
    var_0 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle( "motorcycle", 1 );
    var_0.destroycallback = ::_id_11D5D;
    _id_11D67();
    _id_11D65();
    _id_11D68();
    _id_11D63();
    _id_11D62();
    _id_11D64();
    _id_11D61();

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "motorcycle", "init" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "motorcycle", "init" ) ]]();

    _id_11D69();
    _id_11D66();
}

_id_11D66()
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "motorcycle", "initLate" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "motorcycle", "initLate" ) ]]();
}

_id_11D67()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle( "motorcycle", 1 );
    var_0.enterendcallback = ::_id_11D59;
    var_0.exitstartcallback = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exitstartcallback;
    var_0.exitendcallback = ::_id_11D5B;
    var_0.exitextents["front"] = 45;
    var_0.exitextents["back"] = 45;
    var_0.exitextents["left"] = 28;
    var_0.exitextents["right"] = 28;
    var_0.exitextents["top"] = 45;
    var_0.exitextents["bottom"] = 0;
    var_0.exittopcastoffset = 40;
    var_0.onprematchstarted2 = getdvarint( "scr_motorcycleUseExitFallback", 1 );
    var_1 = "left";
    var_0.exitoffsets[var_1] = ( -5, 0, 55 );
    var_0.exitdirections[var_1] = "left";
    var_1 = "right";
    var_0.exitoffsets[var_1] = ( -5, 0, 55 );
    var_0.exitdirections[var_1] = "right";
    var_1 = "front";
    var_0.exitoffsets[var_1] = ( 29, 0, 55 );
    var_0.exitdirections[var_1] = "front";
    var_1 = "back";
    var_0.exitoffsets[var_1] = ( -35, 0, 45 );
    var_0.exitdirections[var_1] = "back";
    var_2 = [ "driver", "rear" ];
    var_3 = "driver";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "motorcycle", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ "left", "right", "back", "front" ];
    var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getdriverrestrictions();
    var_4.animtag = "tag_seat_0";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4.spawnpriority = 10;
    var_4._id_12023 = "ping_vehicle_driver";
    var_3 = "rear";
    var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat( "motorcycle", var_3, 1 );
    var_4.seatswitcharray = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_generateseatswitcharray( var_3, var_2 );
    var_4.exitids = [ "back", "right", "left", "front" ];
    var_4.viewclamps["top"] = 180;
    var_4.viewclamps["bottom"] = 180;
    var_4.viewclamps["left"] = 120;
    var_4.viewclamps["right"] = 120;
    var_4.restrictions = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getcombatpassengerrestrictions();
    var_4.animtag = "tag_seat_1";
    var_4.exittag = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animtagtoexittag( var_4.animtag );
    var_4._id_12023 = "ping_vehicle_rider";
    var_4._id_13345 = 1;
}

_id_11D65()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_getleveldataforvehicle( "motorcycle", 1 );
    scripts\cp_mp\vehicles\vehicle_interact::_id_1419D( "motorcycle", "single", [ "driver", "rear" ] );
}

_id_11D68()
{
    var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427E( "motorcycle", 1 );
    var_0.id = 18;
    var_0.seatids["driver"] = 0;
    var_0.seatids["rear"] = 1;
}

_id_11D63()
{
    scripts\cp_mp\vehicles\vehicle_damage::_id_1416C( "motorcycle", 500 );
    var_0 = scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_getleveldataforvehicle( "motorcycle" );
    var_0.class = "super_light";
    scripts\cp_mp\vehicles\vehicle_damage::_id_1413D( "motorcycle" );
    scripts\cp_mp\vehicles\vehicle_damage::_id_14178( "motorcycle", 4 );

    if ( level.gametype == "br" )
        scripts\cp_mp\vehicles\vehicle_damage::_id_14179( "motorcycle", 6, "semtex_aalpha12_mp" );

    scripts\cp_mp\vehicles\vehicle_damage::_id_14171( "motorcycle", ::_id_11D57 );
}

_id_11D62()
{
    var_0 = _calloutmarkerping_predicted_log::_id_1410F( "motorcycle", 1 );
    var_0.challengeevaluator = 1;
    var_0.keycardlocs_chosen = 1;
    var_0.is_using_stealth_debug = 350;
    var_0.is_valid_station_name = 525;
    var_0.is_two_hit_melee_weapon = 875;
    var_0.isakimbomeleeweapon = 12.5;
    var_0.isallowedweapon = 50;
    var_0.isakimbo = 100;
    var_0.isattachmentgrenadelauncher = 0;
    var_0.isattachmentselectfire = 0;
    var_0.isassaulting = 1;
    var_1 = _calloutmarkerping_predicted_log::_id_1410E();
    var_1.keycardlocs_chosen["motorcycle"] = [];
    var_1.keycardlocs_chosen["motorcycle"]["cargo_truck"] = 2;
}

_id_11D64()
{
    level._effect["motorcycle_explode"] = loadfx( "vfx/iw8/veh/scriptables/vfx_veh_explosion_motorcycle.vfx" );
}

#using_animtree("mp_vehicles_always_loaded");

_id_11D61()
{
    level.scr_anim["motorcycle"]["pickup_right"] = %sdr_mp_veh_motorcycle_pickup_right;
    level.scr_anim["motorcycle"]["pickup_left"] = %sdr_mp_veh_motorcycle_pickup_left;
}

_id_11D56( var_0, var_1 )
{
    if ( !isdefined( var_0.angles ) )
        var_0.angles = ( 0, 0, 0 );

    var_0.modelname = "veh_t9_mil_lnd_motorcycle_wz";
    var_0.targetname = "motorcycle";
    var_0.vehicletype = "motorcycle_physics_mp";
    var_2 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle( var_0, var_1 );
    var_2.vehicletype = "motorcycle_physics_mp";

    if ( !isdefined( var_2 ) )
        return undefined;

    if ( getdvarint( "scr_motorcycleUseExitFallback", 1 ) )
        var_2.play_incoming_rpg_vo = 1;

    scripts\cp_mp\vehicles\vehicle::_id_14138( var_2, "motorcycle", var_0 );
    var_2.objweapon = getcompleteweaponname( "motorcycle_mp" );
    _calloutmarkerping_predicted_timeout::_id_1412B( var_2 );
    scripts\cp_mp\vehicles\vehicle::_id_14139( var_2, var_0 );
    var_2 thread _id_11D72();

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "motorcycle", "create" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "motorcycle", "create" ) ]]( var_2 );

    return var_2;
}

_id_11D72()
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( !self getscriptablehaspart( "stability" ) )
        return;

    for (;;)
    {
        self waittill( "collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 );
        var_8 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self );

        if ( var_8.size == 0 )
            self setscriptablepartstate( "stability", "unstable", 1 );
    }
}

_id_11D5D( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
    {
        var_0 = spawnstruct();
        var_0.inflictor = self;
        var_0.objweapon = "motorcycle_mp";
        var_0.meansofdeath = "MOD_EXPLOSIVE";
    }

    scripts\cp_mp\vehicles\vehicle_damage::_id_14162( var_0 );
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_killoccupants( self, var_0 );
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_clearvisuals( undefined, undefined, 1 );
    thread _id_11D58();

    if ( !istrue( level.suppressvehicleexplosion ) )
    {
        var_2 = self gettagorigin( "tag_origin" );
        var_3 = scripts\engine\utility::ter_op( isdefined( var_0.attacker ) && isent( var_0.attacker ), var_0.attacker, self );
        self radiusdamage( var_2, 256, 140, 70, var_3, "MOD_EXPLOSIVE", "motorcycle_mp" );
        playfx( scripts\engine\utility::getfx( "motorcycle_explode" ), var_2, anglestoforward( self.angles ), anglestoup( self.angles ) );
        playsoundatpos( var_2, "car_explode" );
        earthquake( 0.4, 800, var_2, 0.7 );
        playrumbleonposition( "grenade_rumble", var_2 );
        physicsexplosionsphere( var_2, 500, 200, 1 );
    }
}

_id_11D58()
{
    scripts\cp_mp\vehicles\vehicle::_id_14185( self );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "motorcycle", "delete" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "motorcycle", "delete" ) ]]( self );

    waitframe();
    scripts\cp_mp\vehicles\vehicle::_id_14186( self );
}

_id_11D57( var_0 )
{
    thread _id_11D5D( var_0 );
    return 1;
}

_id_11D4E( var_0 )
{
    self endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( var_0 ) && var_0 > 0.0 )
        wait( var_0 );

    self _meth_87C6();
}

_id_11D59( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_4.success ) )
        _id_11D5A( var_0, var_1, var_2, var_3, var_4 );
}

_id_11D5A( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_1 == "driver" )
    {
        var_0 setotherent( var_3 );
        var_0 setentityowner( var_3 );
        var_3 controlslinkto( var_0 );

        if ( getdvarint( "LTTOPOMRKP", 0 ) == 1 )
        {
            if ( !isdefined( var_2 ) )
            {
                var_5 = undefined;

                if ( var_0.angles[2] < -20.0 )
                    var_5 = level.scr_anim["motorcycle"]["pickup_left"];
                else if ( var_0.angles[2] > 20.0 )
                    var_5 = level.scr_anim["motorcycle"]["pickup_right"];

                if ( isdefined( var_5 ) )
                {
                    var_0 vehicleplayanim( var_5 );
                    var_0 thread _id_11D4E( getanimlength( var_5 ) );
                }
            }
        }
    }

    var_3 thread scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_animateplayer( var_0, var_1, var_2 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatenter( var_0, var_2, var_1, var_3 );
}

_id_11D5B( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_4.success ) )
        _id_11D5C( var_0, var_1, var_2, var_3, var_4 );
}

_id_11D5C( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_1 == "driver" )
    {
        var_0 setotherent( undefined );
        var_0 setentityowner( undefined );
        var_0 _meth_87C6();

        if ( !istrue( var_4.playerdisconnect ) )
            var_3 controlsunlink();
    }

    if ( !istrue( var_4.playerdisconnect ) )
    {
        var_3 scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_stopanimatingplayer();
        var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_moveplayertoexit( var_3, var_2, var_4 );

        if ( !var_5 )
        {
            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_occupancy", "handleSuicideFromVehicles" ) )
                [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_occupancy", "handleSuicideFromVehicles" ) ]]( var_3 );
            else
                var_3 suicide();
        }
    }

    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsonseatexit( var_0, var_1, var_2, var_3 );
}

_id_11D69()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "motorcycle", 1 );
    var_0.maxinstancecount = 4;
    var_0.priority = 75;
    var_0.getspawnstructscallback = ::_id_11D5E;
    var_0.spawncallback = scripts\cp_mp\utility\script_utility::getsharedfunc( "motorcycle", "spawnCallback" );
    var_0.clearancecheckradius = 55;
    var_0.clearancecheckheight = 45;
    var_0.clearancecheckminradius = 55;
}

_id_11D5E()
{
    var_0 = scripts\engine\utility::getstructarray( "motorcycle_spawn", "targetname" );

    if ( var_0.size > 0 )
    {
        var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_removespawnstructswithflag( var_0, 1 );

        if ( var_0.size > 1 )
            var_0 = scripts\engine\utility::array_randomize( var_0 );
    }

    return var_0;
}
