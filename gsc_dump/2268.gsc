// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

vehicle_init()
{
    if ( !isdefined( level.vehicle ) )
        level.vehicle = spawnstruct();

    level.vehicle.vehicledata = [];
    [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle", "init" ) ]]();
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_init();
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_init();
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_init();
    scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_init();
    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_init();
    scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_init();
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_init();
    _calloutmarkerping_predicted_timeout::_id_14125();
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_init();
    _calloutmarkerping_predicted_log::_id_14114();
    scripts\cp_mp\vehicles\apc_rus::apc_rus_init();
    scripts\cp_mp\vehicles\atv::atv_init();
    scripts\cp_mp\vehicles\cargo_truck::cargo_truck_init();
    _calloutmarkerping_isdropcrate::get_intel_location_vo();
    scripts\cp_mp\vehicles\cop_car::cop_car_init();
    scripts\cp_mp\vehicles\hoopty::hoopty_init();
    scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_init();
    scripts\cp_mp\vehicles\technical::technical_init();
    scripts\cp_mp\vehicles\light_tank::light_tank_init();
    scripts\cp_mp\vehicles\little_bird::little_bird_init();
    _calloutmarkerping_poolidisdanger::x1stash_removequestinstance();
    scripts\cp_mp\vehicles\tac_rover::tac_rover_init();
    scripts\cp_mp\vehicles\large_transport::large_transport_init();
    scripts\cp_mp\vehicles\pickup_truck::pickup_truck_init();
    scripts\cp_mp\vehicles\jeep::jeep_init();
    scripts\cp_mp\vehicles\med_transport::med_transport_init();
    scripts\cp_mp\vehicles\van::van_init();
    _calloutmarkerping_poolidisentity::_id_11D60();
    _calloutmarkerping_isvehicleoccupiedbyenemy::bot_gulag_think();
    _calloutmarkerping_handleluinotify_mappingdeletemarker::bomber_init();
    _calloutmarkerping_isenemy::get_priority_player();
    _calloutmarkerping_iskiosk::get_num_of_wire_to_cut();
    _calloutmarkerping_poolidisloot::_id_12102();
    _calloutmarkerping_predicted_isanypingactive::_id_120D2();
    _calloutmarkerping_isplunderextract::hvi_vehicle_rider_special_setup();
    _calloutmarkerping_onpingchallenge::startarmsracedef2obj();
}

isvehicle()
{
    return isdefined( self.vehiclename );
}

isvehicledestroyed()
{
    return istrue( self.isdestroyed );
}

vehiclecanfly()
{
    var_0 = vehicle_getleveldataforvehicle( self.vehiclename );

    if ( isdefined( var_0 ) )
        return istrue( var_0.canfly );

    return undefined;
}

vehicle_getleveldataforvehicle( var_0, var_1 )
{
    var_2 = level.vehicle.vehicledata[var_0];

    if ( !isdefined( var_2 ) )
    {
        if ( istrue( var_1 ) )
        {
            var_2 = spawnstruct();
            level.vehicle.vehicledata[var_0] = var_2;
            var_2._id_13FCA = undefined;
            var_2.destroycallback = undefined;
            var_2.canfly = undefined;
        }
    }

    return var_2;
}

_id_14138( var_0, var_1, var_2 )
{
    var_0.maxhealth = 2147483647;
    var_0.health = var_0.maxhealth;
    var_0.vehiclename = var_1;
    var_0 setnodeploy( 1 );
    var_0 makeunusable();

    if ( isdefined( var_2.owner ) )
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setoriginalowner( var_0, var_2.owner );

    if ( isdefined( var_2.team ) )
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( var_0, var_2.team );
    else
        scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam( var_0, "neutral" );

    var_0 scripts\cp_mp\emp_debuff::set_start_emp_callback( ::vehicle_empstartcallback );
    var_0 scripts\cp_mp\emp_debuff::set_clear_emp_callback( ::vehicle_empclearcallback );
    scripts\cp_mp\utility\weapon_utility::setlockedoncallback( var_0, ::vehicle_lockedoncallback );
    scripts\cp_mp\utility\weapon_utility::setlockedonremovedcallback( var_0, ::vehicle_lockedonremovedcallback );
    scripts\cp_mp\utility\weapon_utility::_id_13162( var_0, ::_id_1419A );
    scripts\cp_mp\utility\weapon_utility::_id_13163( var_0, ::_id_1419B );
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_registerinstance( var_0 );

    if ( !scripts\common\utility::iscp() || !istrue( var_2.disableusabilityatspawn ) )
        scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_registerinstance( var_0 );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle", "create" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle", "create" ) ]]( var_0, var_2 );

    thread _id_14226( var_0 );
}

_id_14139( var_0, var_1 )
{
    var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 1 );
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance( var_0, var_1.owner, var_1.team );
    scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_spawnevent( var_0, var_1.spawntype );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle", "createLate" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle", "createLate" ) ]]( var_0, var_1 );
}

_id_14185( var_0 )
{
    if ( isdefined( var_0 ) && istrue( var_0.isdestroyed ) )
        return;

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( level._id_1425A ) && isdefined( var_0._id_12970 ) )
        thread [[ level._id_1425A ]]( var_0, var_0._id_12970 );

    var_0 notify( "death" );
    var_0.isdestroyed = 1;

    if ( isdefined( var_0.ondeathrespawn ) )
        var_0 thread [[ var_0.ondeathrespawn ]]();

    var_0 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
    var_0 setnonstick( 1 );
    scripts\cp_mp\utility\weapon_utility::clearlockedon( var_0 );
    var_0 scripts\cp_mp\emp_debuff::clear_emp( 1 );
    _calloutmarkerping_predicted_timeout::_id_14123( var_0 );
    scripts\cp_mp\vehicles\vehicle_damage::_id_14141( var_0 );
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_deregisterinstance( var_0 );
    scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance( var_0 );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle", "deleteNextFrame" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle", "deleteNextFrame" ) ]]( var_0 );
}

_id_14186( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_deregisterinstance( var_0 );
    scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_deregisterinstance( var_0.vehiclename, var_0 getentitynumber() );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle", "deleteNextFrameLate" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle", "deleteNextFrameLate" ) ]]( var_0 );

    var_1 = _id_14193( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
            var_3 delete();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle( var_0 );
}

_id_14197( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle", "hide" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle", "hide" ) ]]( var_0 );

    var_1 = _id_14193( var_0 );

    if ( isdefined( var_1 ) )
    {
        foreach ( var_3 in var_1 )
            var_3 hide();
    }

    var_0 hide();
}

_id_14226( var_0 )
{
    level endon( "game_ended" );
    var_1 = vehicle_getleveldataforvehicle( var_0.vehiclename );
    thread _calloutmarkerping_predicted_log::_id_1411B( var_0 );

    while ( isdefined( var_0 ) )
    {
        var_2 = spawnstruct();
        scripts\cp_mp\utility\vehicle_omnvar_utility::_id_14282( var_0 );
        _id_14103( var_0 );

        if ( isdefined( var_1._id_13FCA ) )
            var_0 [[ var_1._id_13FCA ]]( var_2 );

        var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_1424B();
        waitframe();
    }
}

_id_14105( var_0 )
{
    if ( isdefined( var_0._id_1426C ) )
    {
        if ( var_0._id_1426C != "" )
        {
            var_1 = var_0 vehicle_getvelocity();
            var_2 = anglestoforward( var_0.angles );

            if ( vectordot( var_1, var_2 ) >= 0 )
            {
                if ( var_0 getscriptableparthasstate( "trail", var_0._id_1426C ) )
                    var_0 setscriptablepartstate( "trail", var_0._id_1426C );
            }
            else if ( var_0 getscriptableparthasstate( "trail", var_0._id_1426C + "_idle" ) )
                var_0 setscriptablepartstate( "trail", var_0._id_1426C + "_idle" );
        }
    }
}

_id_14103( var_0 )
{
    if ( !var_0 scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle() && !istrue( var_0 vehiclecanfly() ) && !var_0 vehicle_isonground() )
    {
        var_1 = var_0 vehicle_getvelocity();

        if ( var_1[2] >= 75 && length2dsquared( var_1 ) <= 100 )
        {
            if ( !isdefined( var_0._id_12289 ) )
                var_0._id_12289 = gettime();

            if ( gettime() - var_0._id_12289 >= 650 )
            {
                var_2 = ( 128, 128, 128 );
                var_3 = var_0.origin - var_2;
                var_4 = var_0.origin + var_2;
                var_5 = physics_aabbbroadphasequery( var_3, var_4, physics_createcontents( [ "physicscontents_vehicle" ] ), var_0 );

                foreach ( var_7 in var_5 )
                {
                    if ( isdefined( var_7 ) && var_7 scripts\cp_mp\killstreaks\helper_drone::unset_relic_noks() && !istrue( var_7.isdestroyed ) )
                    {
                        var_7 thread scripts\cp_mp\killstreaks\helper_drone::helperdroneexplode( 0 );
                        var_0._id_12289 = undefined;
                    }
                }

                return;
            }

            return;
        }

        var_0._id_12289 = undefined;
        return;
    }
    else
        var_0._id_12289 = undefined;
}

_id_14207( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1.objweapon ) )
        var_1.objweapon = var_2;

    if ( !isdefined( var_0.turrets ) )
        var_0.turrets = [];

    var_5 = undefined;

    if ( isdefined( var_4 ) )
        var_5 = var_4;
    else if ( isstring( var_2 ) )
        var_5 = var_2;
    else
        var_5 = var_2.basename;

    var_0.turrets[var_5] = var_1;
    var_6 = var_0.childoutlineents;

    if ( !isdefined( var_6 ) )
        var_6 = [ var_0 ];

    if ( !scripts\engine\utility::array_contains( var_6, var_1 ) )
        var_6 = scripts\engine\utility::array_add( var_6, var_1 );

    var_0.childoutlineents = var_6;

    if ( istrue( var_3 ) )
        thread _id_14221( var_0, var_1 );
}

_id_14188( var_0, var_1 )
{
    if ( !isdefined( var_0.turrets ) )
        return;

    var_2 = undefined;

    if ( isstring( var_1 ) )
        var_2 = var_1;
    else
        var_2 = var_1.basename;

    var_3 = var_0.turrets[var_2];
    var_0.turrets[var_2] = undefined;

    if ( isdefined( var_3 ) )
    {
        var_4 = var_0.childoutlineents;

        if ( isdefined( var_4 ) )
        {
            var_4 = scripts\engine\utility::array_remove( var_4, var_3 );
            var_0.childoutlineents = var_4;
        }

        var_3 notify( "vehicle_trackTurretProjectile" );
    }
}

_id_14192( var_0, var_1 )
{
    if ( !isdefined( var_0.turrets ) )
        return undefined;

    var_2 = undefined;

    if ( isstring( var_1 ) )
        var_2 = var_1;
    else
        var_2 = var_1.basename;

    return var_0.turrets[var_2];
}

_id_14191( var_0, var_1 )
{
    if ( !isdefined( var_0.turrets ) )
        return undefined;

    return var_0.turrets[var_1];
}

_id_14193( var_0 )
{
    var_1 = [];

    if ( isdefined( var_0.turrets ) )
        var_1 = var_0.turrets;

    return var_1;
}

_id_14221( var_0, var_1 )
{
    var_1 endon( "death" );
    var_1 notify( "vehicle_trackTurretProjectile" );
    var_1 endon( "vehicle_trackTurretProjectile" );

    for (;;)
    {
        var_1 waittill( "missile_fire", var_2 );

        if ( isdefined( var_2 ) )
            var_2.vehicle = var_0;
    }
}

_id_141B9( var_0, var_1 )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE( var_0 ) )
        return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E2( var_0, var_1 );
    else if ( level.teambased )
    {
        var_2 = var_0.team;

        if ( !isdefined( var_2 ) || var_2 == "neutral" )
        {
            if ( isdefined( var_0.owner ) )
                var_0.team = var_0.owner.team;
        }

        if ( !isdefined( var_2 ) )
            return 0;

        return var_0.team == var_1.team;
    }
    else
        return isdefined( var_0.owner ) && var_0.owner == var_1;
}

_id_141B7( var_0, var_1 )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE( var_0 ) )
        return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E0( var_0, var_1 );
    else if ( level.teambased )
    {
        var_2 = var_0.team;

        if ( !isdefined( var_2 ) || var_2 == "neutral" )
        {
            if ( isdefined( var_0.owner ) )
                var_0.team = var_0.owner.team;
        }

        if ( !isdefined( var_2 ) )
            return 0;

        return var_0.team == var_1.team;
    }
    else
        return isdefined( var_0.owner ) && var_0.owner != var_1;
}

_id_141BB( var_0, var_1 )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE( var_0 ) )
        return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E4( var_0, var_1 );
    else if ( level.teambased )
        return ( !isdefined( var_0.team ) || var_0.team == "neutral" ) && !isdefined( var_0.owner );
    else
        return !isdefined( var_0.owner );
}

_id_141BA( var_0, var_1 )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE( var_0 ) )
        return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E3( var_0, var_1 );
    else
    {
        if ( level.teambased )
            return isdefined( var_0.team ) && var_0.team == var_1;

        return undefined;
    }
}

_id_141B8( var_0, var_1 )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE( var_0 ) )
        return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E1( var_0, var_1 );
    else
    {
        if ( level.teambased )
            return isdefined( var_0.team ) && var_0.team != var_1;

        return undefined;
    }
}

_id_141BC( var_0, var_1 )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE( var_0 ) )
        return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141E5( var_0, var_1 );
    else
    {
        if ( level.teambased )
            return !isdefined( var_0.team ) || var_0.team == "neutral";

        return undefined;
    }
}

_id_14190( var_0 )
{
    if ( scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DE( var_0 ) )
        return scripts\cp_mp\vehicles\vehicle_occupancy::_id_141D7( var_0 );
    else
    {
        if ( isdefined( var_0.team ) && var_0.team != "neutral" )
            return var_0.team;

        return undefined;
    }
}

_id_1418B( var_0, var_1 )
{
    if ( _id_1420D( var_0, var_1 ) )
    {
        var_2 = istrue( var_1.inlaststand );
        var_3 = var_1.health;

        if ( isdefined( var_0.objweapon ) )
            level._id_12185 = "MOD_EXPLOSIVE";

        var_1 dodamage( 1000, var_0.origin, var_0.owner, var_0, "MOD_CRUSH", var_0.objweapon );
        level._id_12185 = undefined;

        if ( !isalive( var_1 ) )
            return 1;

        if ( !var_2 && istrue( var_1.inlaststand ) )
            return 1;

        if ( var_3 > var_1.health )
            return 1;
    }

    return 0;
}

_id_1420D( var_0, var_1 )
{
    if ( level.teambased )
    {
        if ( level.friendlyfire == 0 )
        {
            if ( isdefined( var_0.owner ) )
            {
                if ( var_0.owner != var_1 )
                {
                    if ( var_0.owner.team == var_1.team )
                        return 0;
                }
            }
            else if ( isdefined( var_0.team ) && var_0.team != "neutral" )
            {
                if ( var_0.team == var_1.team )
                    return 0;
            }
        }
    }

    return 1;
}

_id_14203( var_0, var_1 )
{
    var_1 endon( "disconnect" );
    var_1 notify( "vehicle_preventPlayerCollisionDamageForTimeAfterExit" );
    var_1 endon( "vehicle_preventPlayerCollisionDamageForTimeAfterExit" );
    var_1.vehiclecollisionignorearray = [];
    var_1.vehiclecollisionignorearray["inflictor"] = var_0;
    var_1.vehiclecollisionignorearray["objWeapon"] = var_0.objweapon;
    var_1.vehiclecollisionignorearray["meansOfDeath"] = "MOD_CRUSH";
    _id_14204( var_1 );
    thread _id_14106( var_1 );
}

_id_14204( var_0 )
{
    var_0 endon( "death" );
    wait 2;
}

_id_14106( var_0 )
{
    var_0 notify( "vehicle_preventPlayerCollisionDamageForTimeAfterExit" );
    var_0.vehiclecollisionignorearray = undefined;
}

_id_14201( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1.vehiclecollisionignorearray ) )
        return 0;

    if ( !isdefined( var_0 ) )
        return 0;

    if ( var_0 != var_1.vehiclecollisionignorearray["inflictor"] )
        return 0;

    if ( !isdefined( var_3 ) )
        return 0;

    if ( !scripts\common\utility::iscp() )
    {
        if ( var_3 != var_1.vehiclecollisionignorearray["objWeapon"] )
            return 0;
    }

    if ( var_2 != var_1.vehiclecollisionignorearray["meansOfDeath"] )
        return 0;

    return 1;
}

_id_14104( var_0 )
{
    if ( !isdefined( var_0.meansofdeath ) || var_0.meansofdeath != "MOD_CRUSH" )
        return 0;

    if ( !isdefined( var_0.inflictor ) || !var_0.inflictor isvehicle() )
        return 0;

    return 1;
}

vehicle_playerkilledbycollision( var_0 )
{
    if ( !_id_14104( var_0 ) )
        return;

    if ( var_0.inflictor.vehiclename == "little_bird" || var_0.inflictor.vehiclename == "little_bird_mg" || var_0.inflictor.vehiclename == "loot_chopper" || var_0.inflictor.vehiclename == "magma_plunder_chopper" )
        thread _id_14200( var_0.victim );
    else
        playsoundatpos( var_0.victim.origin, "vehicle_body_hit" );
}

_id_14200( var_0 )
{
    var_1 = 35;
    var_0.nocorpse = 1;
    playsoundatpos( var_0.origin, "vehicle_body_hit" );
    var_2 = scripts\cp_mp\utility\player_utility::relic_nuketimer_timer();

    if ( var_2.size < var_1 )
    {
        var_3 = spawn( "script_model", var_0 gettagorigin( "j_mainroot" ) );
        var_3.angles = var_0.angles;
        var_3 setmodel( "player_death_fx" );
        var_3 setscriptablepartstate( "effects", "gib", 0 );

        foreach ( var_5 in var_2 )
            var_3 hidefromplayer( var_5 );

        wait 0.5;
        var_3 delete();
    }
}

vehicle_watchflipped( var_0, var_1, var_2, var_3 )
{
    var_0 endon( "death" );
    level endon( "game_ended" );

    if ( isdefined( var_3 ) )
        var_0 endon( var_3 );

    var_4 = 0;
    var_5 = undefined;
    var_6 = undefined;

    for (;;)
    {
        var_7 = 0;
        var_8 = anglestoup( var_0.angles )[2];

        if ( var_8 <= 0.0872 )
        {
            var_7 = 1;
            var_5 = undefined;
        }
        else if ( var_8 <= 0.5736 )
        {
            if ( !isdefined( var_5 ) )
                var_5 = gettime() + 3000;

            if ( gettime() > var_5 )
            {
                var_7 = 1;
                var_5 = undefined;
            }
        }
        else
        {
            if ( var_4 )
            {
                scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6( var_0, 1 );
                scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse( var_0, 1 );
                var_4 = 0;
            }

            var_7 = 0;
            var_5 = undefined;
        }

        if ( var_7 )
        {
            if ( isdefined( var_1 ) )
                thread [[ var_1 ]]( var_0 );

            if ( !var_4 )
            {
                scripts\cp_mp\vehicles\vehicle_occupancy::_id_141C6( var_0, 0 );
                scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_allowvehicleuse( var_0, 0 );
                var_4 = 1;
            }

            scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_ejectalloccupants( var_0 );
            var_9 = 0;
            var_6 = gettime() + 3000;

            for (;;)
            {
                if ( vectordot( anglestoup( var_0.angles ), ( 0, 0, 1 ) ) > 0.0872 )
                    break;

                if ( gettime() >= var_6 )
                {
                    var_9 = 1;
                    break;
                }

                waitframe();
            }

            var_6 = undefined;

            if ( isdefined( var_2 ) )
                thread [[ var_2 ]]( var_0, var_9 );
        }

        waitframe();
    }
}

vehicle_flippedendcallback( var_0, var_1 )
{
    if ( var_1 )
    {
        var_2 = vehicle_getleveldataforvehicle( var_0.vehiclename );

        if ( isdefined( var_2.destroycallback ) )
            var_0 [[ var_2.destroycallback ]]();
    }
}

vehicle_deletecollmapvehicles()
{
    level notify( "vehicle_deleteCollmapVehicles" );
    level endon( "vehicle_deleteCollmapVehicles" );
    wait 1;
    var_0 = getentarray( "delete_me", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        for ( var_1 = var_0.size - 1; var_1 >= 0; var_1-- )
            var_0[var_1] delete();
    }
}

vehicle_lockedoncallback()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "missileLocking", var_0, self.vehiclename );
}

vehicle_lockedonremovedcallback()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "missileLocking", var_0, self.vehiclename );
}

_id_1419A()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning( "missileIncoming", var_0, self.vehiclename );
}

_id_1419B()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants( self, 0 );
    scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning( "missileIncoming", var_0, self.vehiclename );
}

vehicle_empstartcallback( var_0 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "emp", "onVehicleEMPed" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "emp", "onVehicleEMPed" ) ]]( var_0 );

    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 0 );
}

vehicle_empclearcallback( var_0 )
{
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement( self, 1 );
}

_id_1418F( var_0 )
{
    var_1 = undefined;

    switch ( var_0 )
    {
        case "apc_russian":
            var_1 = scripts\cp_mp\vehicles\apc_rus::apc_rus_explode;
            break;
        case "atv":
            var_1 = scripts\cp_mp\vehicles\atv::atv_explode;
            break;
        case "cargo_truck":
            var_1 = scripts\cp_mp\vehicles\cargo_truck::cargo_truck_explode;
            break;
        case "cargo_truck_mg":
            var_1 = _calloutmarkerping_isdropcrate::get_gunshot_alias;
            break;
        case "cop_car":
            var_1 = scripts\cp_mp\vehicles\cop_car::cop_car_explode;
            break;
        case "hoopty":
            var_1 = scripts\cp_mp\vehicles\hoopty::hoopty_explode;
            break;
        case "hoopty_truck":
            var_1 = scripts\cp_mp\vehicles\hoopty_truck::hoopty_truck_explode;
            break;
        case "jeep":
            var_1 = scripts\cp_mp\vehicles\jeep::jeep_explode;
            break;
        case "large_transport":
            var_1 = scripts\cp_mp\vehicles\large_transport::large_transport_explode;
            break;
        case "light_tank":
            var_1 = scripts\cp_mp\vehicles\light_tank::light_tank_explode;
            break;
        case "little_bird":
            var_1 = scripts\cp_mp\vehicles\little_bird::little_bird_explode;
            break;
        case "little_bird_mg":
            var_1 = _calloutmarkerping_poolidisdanger::x1spyplane;
            break;
        case "medium_transport":
            var_1 = scripts\cp_mp\vehicles\med_transport::med_transport_explode;
            break;
        case "pickup_truck":
            var_1 = scripts\cp_mp\vehicles\pickup_truck::pickup_truck_explode;
            break;
        case "tac_rover":
            var_1 = scripts\cp_mp\vehicles\tac_rover::tac_rover_explode;
            break;
        case "technical":
            var_1 = scripts\cp_mp\vehicles\technical::technical_explode;
            break;
        case "van":
            var_1 = scripts\cp_mp\vehicles\van::van_explode;
            break;
        case "motorcycle":
            var_1 = _calloutmarkerping_poolidisentity::_id_11D5D;
            break;
        case "veh_a10fd":
            var_1 = _calloutmarkerping_isvehicleoccupiedbyenemy::bot_get_stored_custom_classes;
            break;
        case "veh_bt":
            var_1 = _calloutmarkerping_handleluinotify_mappingdeletemarker::create_script_wait_for_flags;
            break;
        case "veh_indigo":
            var_1 = _calloutmarkerping_onpingchallenge::start_trap_room_combat;
            break;
        case "open_jeep":
            var_1 = _calloutmarkerping_poolidisloot::_id_12100;
            break;
        case "open_jeep_carpoc":
            var_1 = _calloutmarkerping_predicted_isanypingactive::_id_120CB;
            break;
        case "cargo_truck_susp":
            var_1 = _calloutmarkerping_isenemy::get_power_ref_from_weapon;
            break;
        case "convoy_truck":
            var_1 = _calloutmarkerping_isplunderextract::hvi_patrol_exit;
            break;
    }

    return var_1;
}
