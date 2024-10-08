// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_12A27()
{
    level._id_12A34 = [];
    level._id_12A34["rcxd_rad"] = spawnstruct();
    level._id_12A34["rcxd_rad"].timeout = getdvarfloat( "scr_br_rcxd_rad_timeout", 45.0 );
    level._id_12A34["rcxd_rad"].maxhealth = 75;
    level._id_12A34["rcxd_rad"].hitstokill = 3;
    level._id_12A34["rcxd_rad"].speed = 140;
    level._id_12A34["rcxd_rad"].accel = 20;
    level._id_12A34["rcxd_rad"].halfsize = 27;
    level._id_12A34["rcxd_rad"].spawndist = 30;
    level._id_12A34["rcxd_rad"].streakname = "rcxd_rad";
    level._id_12A34["rcxd_rad"].vehicleinfo = "veh_rcxd_rad_mp";
    level._id_12A34["rcxd_rad"].modelbase = "lm_veh_t9_drone_rcxd";
    level._id_12A34["rcxd_rad"].teamsplash = "used_rcxd_rad";
    level._id_12A34["rcxd_rad"].destroyedsplash = "callout_destroyed_rcxd_rad";
    level._id_12A34["rcxd_rad"].initbunker = 0.5;
    level._id_12A34["rcxd_rad"].sound_explode = "recon_drone_explode";
    level._id_12A34["rcxd_rad"].vodestroyed = "ball_drone_backup_destroy";
    level._id_12A34["rcxd_rad"].votimedout = "ball_drone_backup_timeout";
    level._id_12A34["rcxd_rad"].scorepopup = "destroyed_rcxd_rad";
    level._id_12A34["rcxd_rad"].playfxcallback = scripts\cp_mp\killstreaks\helper_drone::helperdronefx;
    level._id_12A34["rcxd_rad"].primarymode = "MANUAL";
    level._id_12A34["rcxd_rad"].primarymodestring = &"KILLSTREAKS_HINTS/RCD_MANUAL";
    level._id_12A34["rcxd_rad"].primarymodefunc = scripts\cp_mp\killstreaks\helper_drone::setreconmodesettings;
    level._id_12A34["rcxd_rad"].premoddamagefunc = undefined;
    level._id_12A34["rcxd_rad"].postmoddamagefunc = scripts\cp_mp\killstreaks\helper_drone::helperdrone_modifydamageresponse;
    level._id_12A34["rcxd_rad"].deployweaponname = "ks_remote_rcxd_mp";
    level._id_12A34["rcxd_rad"]._id_11B06 = 1;
    level._id_12A34["rcxd_rad"]._id_11B07 = 1;
    level._id_12A34["rcxd_rad"]._id_11B17 = 73984;
    level._id_12A34["rcxd_rad"]._id_11B18 = 73984;
    level._id_12A34["rcxd_rad"].deathfunc = ::_id_12A22;
    level._id_12A34["rcxd_rad"].leaderinteractionthink = 1;
    level._id_12A34["rcxd_rad"].diewithowner = 1;
    level._id_12A34["rcxd_rad"].stringcannotplace = &"KILLSTREAKS_HINT_CANNOT_CALL_IN";
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "rcxd_rad", ::_id_13E2E, undefined, ::_id_13E11 );
    initmines();
    var_0 = getarraykeys( level._id_12A34 );

    foreach ( var_2 in var_0 )
    {
        var_3 = level._id_12A34[var_2].hitstokill;

        if ( isdefined( var_3 ) )
        {
            scripts\mp\vehicles\damage::set_vehicle_hit_damage_data( var_2, var_3 );
            scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle( "emp_grenade_mp", var_3, var_2 );
        }
    }

    scripts\cp_mp\vehicles\vehicle_damage::_id_14171( "rcxd_rad", ::_id_12A22 );
    game["dialog"]["rcxd_enemy"] = "rcxd_enemy";
    game["dialog"]["rcxd_friendly_use"] = "rcxd_friendly_use";
    level._effect["rcxdExplosion"] = loadfx( "vfx/iw8_br/equipment/vfx_rcxd_exp_main" );
}

initmines()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle( "rcxd_rad", 1 );
    var_0.frontextents = 15;
    var_0.backextents = 15;
    var_0.leftextents = 15;
    var_0.rightextents = 15;
    var_0.bottomextents = 3;
    var_0.distancetobottom = 3;
}

_id_13E2E( var_0 )
{
    var_1 = self;
    var_2 = var_1 _id_13E2F( var_0 );

    if ( !var_2 )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/CANNOT_BE_USED" );
    }

    return var_2;
}

_id_13E11()
{
    var_0 = self;
    var_1 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "rcxd_rad", var_0 );
    var_1._id_133CE = 1;
    var_2 = var_0 _id_13E2F( var_1 );

    if ( !var_2 )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "KILLSTREAKS/CANNOT_BE_USED" );
    }

    return var_2;
}

_id_13E2F( var_0 )
{
    var_1 = self;

    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( var_0 ) )
            return 0;
    }

    if ( !scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle() )
        return 0;

    if ( !self isonground() && !self isonladder() || _calloutmarkerping_handleluinotify_enemyrepinged::updateleaders() )
        return 0;

    if ( isdefined( level.getflagradarowner ) )
    {
        if ( ![[ level.getflagradarowner ]]( var_1 ) )
            return 0;
    }

    if ( var_1 scripts\cp_mp\utility\player_utility::isinvehicle( 1 ) )
        return 0;

    var_2 = var_0.streakname;
    var_3 = level._id_12A34[var_2].deployweaponname;
    var_4 = var_1 scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy( var_0, ::_id_14588, undefined, undefined, ::deployweapontaken, var_3, 0, ::_id_14405 );
    var_1 scripts\common\utility::allow_usability( 0 );
    var_1 thread scripts\cp_mp\utility\killstreak_utility::tabletdofset( 0, 1, 1 );

    if ( !istrue( var_4 ) )
    {
        var_1 _id_12A2A( var_0 );
        scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
        var_0 notify( "killstreak_finished_with_deploy_weapon" );
        return 0;
    }

    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( var_0 ) )
        {
            var_1 _id_12A2A( var_0 );
            scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
            var_0 notify( "killstreak_finished_with_deploy_weapon" );
            return 0;
        }
    }

    var_1 scripts\cp_mp\utility\player_utility::_freezecontrols( 1 );
    var_5 = 0.4;
    var_6 = var_1 scripts\engine\utility::_id_143BA( var_5, "death", "weapon_switch_started" );

    if ( !isdefined( var_6 ) || var_6 != "timeout" )
    {
        var_1 _id_12A20( var_0 );
        var_1 scripts\cp_mp\utility\player_utility::_freezecontrols( 0 );
        return 0;
    }

    var_1 scripts\cp_mp\utility\player_utility::_freezecontrols( 0 );
    var_7 = undefined;

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "sound", "playKillstreakDeployDialog" ) )
    {
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "sound", "playKillstreakDeployDialog" ) ]]( var_1, var_0.streakname );
        var_7 = 2.0;
    }

    var_1 thread scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "use_" + var_0.streakname, 1, var_7 );
    var_8 = level._id_12A34[var_2].teamsplash;
    var_6 = _id_13870( var_0 );

    if ( !istrue( var_6 ) )
    {
        var_1 _id_12A20( var_0 );
        return 0;
    }

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "teamPlayerCardSplash" ) )
        level thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "teamPlayerCardSplash" ) ]]( var_8, var_1 );

    return 1;
}

_id_14405( var_0 )
{
    scripts\cp_mp\killstreaks\killstreakdeploy::waituntilfinishedwithdeployweapon( var_0 );
    waitframe();
}

_id_14588( var_0 )
{
    return 1;
}

deployweapontaken( var_0 )
{
    self notify( "finished_deploy_weapon" );
}

_id_12E28()
{
    var_0 = self;
    var_0 endon( "death_or_disconnect" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );
    var_1 = getcompleteweaponname( "ks_remote_rcxd_mp" );

    if ( var_0 hasweapon( var_1 ) )
        var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon( var_1 );
}

_id_13870( var_0 )
{
    var_1 = self;
    level endon( "game_ended" );
    var_2 = spawnstruct();
    var_2.origin = var_1.origin + ( 100, 0, 0 );
    var_2.angles = var_1.angles;
    var_2.modelname = "lm_veh_t9_drone_rcxd";
    var_2.vehicletype = "veh_rcxd_mp";
    var_2.targetname = "veh_rcxd";
    var_2.cannotbesuspended = 1;
    var_3 = spawnstruct();
    var_4 = var_1 _id_12A25( 100 );

    if ( !isdefined( var_4 ) )
    {
        var_1 _id_12A20( var_0 );
        return 0;
    }

    var_2.origin = var_4;
    var_5 = scripts\cp_mp\vehicles\vehicle_tracking::_spawnvehicle( var_2, var_3 );

    if ( !isdefined( var_5 ) )
    {
        var_1 _id_12A20( var_0 );
        return 0;
    }

    var_1.restoreangles = var_1 getplayerangles();
    var_5 setotherent( var_1 );
    var_5 setentityowner( var_1 );
    var_1 controlslinkto( var_5 );
    var_1 setclientomnvar( "ui_rcd_controls", 9 );
    var_5 scripts\cp_mp\utility\killstreak_utility::_id_11DC0( var_1 );
    var_5.owner = var_1;
    var_5.team = var_1.team;
    var_5.vehiclename = var_0.streakname;
    var_6 = level._id_12A34[var_0.streakname];
    var_5.streakinfo = var_0;
    var_5.owner.streakinfo = var_0;
    var_5.maxhealth = var_6.maxhealth;
    var_5.health = var_6.maxhealth;

    if ( isdefined( var_6.damagemonitorfunc ) )
        var_5 thread [[ var_6.damagemonitorfunc ]]();

    var_5 thread _id_12A33();
    var_5 thread _id_12A30();
    var_5 thread _id_12A2F();
    var_5 thread _id_12A32();
    var_5 thread _id_12A23();
    var_5 thread _id_12A2C( var_6 );
    var_5 thread _id_12A2E();
    var_5 thread _id_12A2B();
    var_5 thread _id_12A28( var_6 );

    if ( scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag( "prematch_fade_done" ) )
        thread _id_12E28();

    var_5 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 1 );
    scripts\mp\outofbounds::registerentforoob( var_5, "killstreak" );
    var_5 _id_12A29( "rcxd_enemy", 0, 1 );
    var_5 _id_12A29( "rcxd_friendly_use", 1, 0 );
    var_5 setscriptablepartstate( "flash_light", "enabled", 0 );
    return 1;
}

_id_12A25( var_0 )
{
    var_1 = undefined;
    var_2 = self.origin;
    var_3 = self.angles;
    var_4 = anglestoforward( var_3 );
    var_5 = anglestoright( var_3 );
    var_6 = [ var_2 + var_0 * var_4, var_2 - var_0 * var_4, var_2 + var_0 * var_5, var_2 - var_0 * var_5, var_2 + 0.707 * var_0 * ( var_4 + var_5 ), var_2 + 0.707 * var_0 * ( var_4 - var_5 ), var_2 + 0.707 * var_0 * ( var_5 - var_4 ), var_2 + 0.707 * var_0 * ( -1 * var_4 - var_5 ) ];

    foreach ( var_8 in var_6 )
    {
        var_1 = _id_12A1D( var_2, var_8 );

        if ( isdefined( var_1 ) )
            break;
    }

    return var_1;
}

_id_12A1D( var_0, var_1 )
{
    var_2 = undefined;
    var_3 = ( 0, 0, 45 );
    var_4 = scripts\engine\trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    var_5 = var_0 + var_3;
    var_6 = var_1 + var_3;
    var_7 = 40;
    var_8 = scripts\engine\trace::ray_trace_passed( var_5, var_6, self, var_4 );

    if ( !istrue( var_8 ) )
        return var_2;

    var_9 = scripts\engine\trace::ray_trace( var_6, var_6 - ( 0, 0, 500 ), self, var_4 );

    if ( isdefined( var_9["position"] ) && var_9["hittype"] != "hittype_none" )
    {
        var_10 = var_9["position"] + var_3;
        var_11 = scripts\engine\trace::sphere_trace_passed( var_10, var_10, var_7, self, var_4 );
        var_12 = undefined;

        if ( level.teambased )
            var_12 = self.team;

        if ( istrue( var_11 ) && !scripts\mp\outofbounds::ispointinoutofbounds( var_9["position"], var_12 ) )
            var_2 = var_9["position"];
    }

    var_13 = var_2;
    var_14 = 14.75;

    if ( isdefined( var_2 ) )
    {
        var_15 = 1;
        var_16 = [ ( var_14, var_14, 0 ), ( -1 * var_14, var_14, 0 ), ( var_14, -1 * var_14, 0 ), ( -1 * var_14, -1 * var_14, 0 ) ];

        foreach ( var_18 in var_16 )
        {
            var_19 = var_13 + var_18;
            var_9 = scripts\engine\trace::ray_trace( var_13, var_19, self, var_4 );

            if ( isdefined( var_9["position"] ) && var_9["hittype"] != "hittype_none" )
            {
                var_20 = scripts\mp\outofbounds::ispointinoutofbounds( var_9["position"], self.team );

                if ( !istrue( var_20 ) )
                    return undefined;

                break;
            }
        }
    }

    return var_13;
}

_id_12A20( var_0 )
{
    var_1 = self;
    var_1 _id_12A2A( var_0 );
    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    var_0 notify( "killstreak_finished_with_deploy_weapon" );

    if ( !var_1 scripts\common\utility::is_usability_allowed() )
        var_1 scripts\common\utility::allow_usability( 1 );
}

_id_12A28( var_0 )
{
    var_1 = self;
    var_1.owner endon( "disconnect" );
    var_1 endon( "death" );
    var_1 endon( "leaving" );
    var_1 endon( "explode" );
    var_1 endon( "switch_modes" );
    var_1 vehphys_enablecollisioncallback( 1 );
    var_2 = var_1.streakinfo;

    for (;;)
    {
        var_1 waittill( "collision", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( !isdefined( var_10 ) )
            continue;

        var_12 = undefined;

        if ( var_10 scripts\cp_mp\vehicles\vehicle::isvehicle() )
            var_12 = var_10;
        else if ( var_10 scripts\cp_mp\utility\player_utility::isinvehicle() )
            var_12 = var_10.vehicle;
        else if ( istrue( var_10.velstartid ) )
            var_12 = var_10;

        if ( !isdefined( var_12 ) )
            continue;

        var_13 = istrue( scripts\cp_mp\utility\player_utility::playersareenemies( var_1.owner, var_12.owner ) );

        if ( istrue( var_0.leaderplunderstring ) )
        {
            if ( var_13 || !isdefined( var_12.owner ) )
                var_1 thread _id_12A24( var_2 );
            else
                var_1 dodamage( var_1.maxhealth, var_12.origin, undefined, undefined, "MOD_CRUSH" );

            continue;
        }

        var_14 = undefined;
        var_15 = undefined;

        if ( var_13 )
        {
            var_16 = var_12.owner scripts\cp_mp\utility\player_utility::getvehicle();

            if ( isdefined( var_16 ) && var_16 == var_12 )
            {
                var_14 = var_12.owner;
                var_15 = var_12;
            }
        }

        var_17 = var_1.maxhealth * var_0.initbunker;
        var_1 dodamage( var_17, var_12.origin, var_14, var_15, "MOD_CRUSH" );
    }
}

_id_12A33()
{
    var_0 = self;
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "explode" );
    var_0.owner endon( "disconnect" );
    var_0 endon( "owner_gone" );
    var_1 = level._id_12A34[var_0.vehiclename];
    var_0.timeout = var_1.timeout;

    if ( !isdefined( var_0.timeout ) )
        return;

    var_3 = var_0.streakinfo;

    if ( var_0.timeout > 0 )
    {
        var_0.owner setclientomnvar( "ui_killstreak_countdown", gettime() + int( var_0.timeout * 1000 ) );
        wait( var_0.timeout );
    }

    var_0 scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( var_1.votimedout, 1 );
    var_0 thread _id_12A21( var_3 );
}

_id_12A21( var_0 )
{
    var_1 = 1;
    var_2 = self;

    if ( !isdefined( var_0 ) )
        var_0 = var_2.streakinfo;

    if ( !istrue( var_2.lbravo_spawner_safehouse1 ) )
    {
        var_2 thread _id_12A1E();
        var_2.lbravo_spawner_safehouse1 = 1;
    }

    var_2 vehphys_enablecollisioncallback( 0 );

    if ( !isdefined( var_0 ) )
        var_0 = var_2.streakinfo;

    if ( isdefined( var_2.owner ) )
    {
        if ( !isdefined( var_0 ) )
            var_0 = var_2.owner.streakinfo;

        var_2.owner.streakinfo = undefined;
    }

    if ( !isdefined( var_2 ) || istrue( var_2.isdestroyed ) )
    {
        if ( isdefined( var_0 ) )
            var_0 notify( "killstreak_finished_with_deploy_weapon" );

        return;
    }

    var_2.isdestroyed = 1;
    var_2.health = 0;
    var_2 scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setcandamage( 0 );
    var_2 playsound( "mp_killstreak_disappear" );

    if ( level.gametype != "br" && isdefined( var_2.owner ) && scripts\cp_mp\utility\script_utility::issharedfuncdefined( "br", "superSlotCleanUp" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "br", "superSlotCleanUp" ) ]]( var_2.owner );

    var_0 notify( "killstreak_finished_with_deploy_weapon" );
    var_2.owner setclientomnvar( "ui_rcd_controls", 0 );
    var_2.owner cameraunlink( var_2 );
    var_2 unlink();
    var_2.owner controlsunlink();
    scripts\cp_mp\utility\killstreak_utility::_id_11DC1( var_2.owner );
    var_2 setscriptablepartstate( "flash_light", "default", 0 );
    var_2.owner scripts\cp_mp\utility\killstreak_utility::_id_12AA7( var_0 );
    var_2.owner unlink();
    var_2.owner setplayerangles( ( var_2.owner.restoreangles[0], var_2.owner.restoreangles[1], 0 ) );
    var_2.owner.restoreangles = undefined;
    var_2.owner scripts\common\utility::allow_usability( 1 );
    var_2 notify( "explode" );
    scripts\mp\outofbounds::clearoob( self, 1 );
    var_2 setscriptablepartstate( "flash_light", "default", 0 );
    var_3 = level._id_12A34[var_0.streakname].deployweaponname;
    var_4 = getcompleteweaponname( var_3 );

    if ( var_2.owner hasweapon( var_4 ) )
        var_2.owner scripts\cp_mp\utility\inventory_utility::getridofweapon( var_4 );

    var_2 thread _id_12A1F();
    var_2.owner setclientomnvar( "ui_remote_control_sequence", -1 );
}

_id_12A1F()
{
    waitframe();
    scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle( self );
}

_id_12A2A( var_0 )
{
    var_1 = self;
    var_1 endon( "death_or_disconnect" );
    var_1 notify( "rcxdWeaponTaken" );
    var_1 endon( "rcxdWeaponTaken" );
    wait 1.5;
    var_2 = level._id_12A34[var_0.streakname].deployweaponname;
    var_3 = getcompleteweaponname( var_2 );
    var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon( var_3 );
    var_4 = var_1 scripts\cp_mp\utility\inventory_utility::getcurrentprimaryweaponsminusalt();
    var_5 = var_1 scripts\mp\utility\inventory::getlastweapon();

    if ( !var_1 hasweapon( var_5 ) )
        var_5 = var_1 scripts\mp\utility\inventory::getfirstprimaryweapon();

    var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweapon( var_5 );
    var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon( var_3 );

    if ( var_1 hasweapon( var_3 ) )
        var_1 scripts\cp_mp\utility\inventory_utility::getridofweapon( var_3 );

    if ( !var_1 scripts\common\utility::is_usability_allowed() )
        var_1 scripts\common\utility::allow_usability( 1 );
}

_id_12A22( var_0 )
{
    var_1 = self;
    var_1 thread _id_12A21();
    return 0;
}

_id_12A30()
{
    var_0 = self;
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "explode" );
    var_0 childthread _id_12A31( "disconnect" );
    var_0 childthread _id_12A31( "joined_team" );
    var_0 childthread _id_12A31( "joined_spectators" );
    var_0 childthread _id_12A31( "last_stand_start" );
}

_id_12A31( var_0 )
{
    var_1 = self;
    var_2 = var_1.streakinfo;
    var_1.owner waittill( var_0 );
    var_1 notify( "owner_gone" );
    var_1 thread _id_12A21( var_2 );
}

_id_12A2F()
{
    var_0 = self;
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "leaving" );
    var_0 endon( "explode" );
    var_1 = var_0.streakinfo;

    for (;;)
    {
        var_0.owner waittill( "death" );
        var_2 = level._id_12A34[var_0.vehiclename];

        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "getGametypeNumLives" ) )
        {
            if ( istrue( var_2.diewithowner ) || [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGametypeNumLives" ) ]]() && var_0.owner.pers["deaths"] == [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getGametypeNumLives" ) ]]() )
                var_0 thread _id_12A21( var_1 );
        }
    }
}

_id_12A32()
{
    var_0 = self;
    var_0 endon( "death" );
    var_0 endon( "explode" );
    var_0.owner endon( "disconnect" );
    var_0 endon( "owner_gone" );
    var_1 = var_0.streakinfo;
    level scripts\engine\utility::_id_143A7( "round_end_finished", "game_ended", "prematch_cleanup", "ending_sequence" );
    var_0 thread _id_12A21( var_1 );
}

_id_12A23()
{
    var_0 = self;
    var_0 endon( "death" );
    var_0 endon( "explode" );
    var_1 = var_0.streakinfo;
    level scripts\engine\utility::_id_143A5( "bro_shot_start", "game_ended" );
    var_0 thread _id_12A21( var_1 );
}

_id_12A2C( var_0 )
{
    var_1 = self;

    if ( !istrue( var_0.leaderinteractionthink ) )
        return;

    var_1.owner notifyonplayercommand( "detonate_rcxd", "+usereload" );
    var_1.owner notifyonplayercommand( "detonate_rcxd", "+activate" );
    var_1 _id_12A2D();

    if ( isdefined( var_1.owner ) )
    {
        var_1.owner notifyonplayercommandremove( "detonate_rcxd", "+usereload" );
        var_1.owner notifyonplayercommandremove( "detonate_rcxd", "+activate" );
    }
}

_id_12A2D()
{
    var_0 = self;
    var_0.owner endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "explode" );
    var_0 endon( "switch_modes" );
    var_1 = var_0.streakinfo;
    var_0.owner waittill( "detonate_rcxd" );
    var_0 thread _id_12A24( var_1 );
}

_id_12A2E()
{
    var_0 = self;
    var_0.owner endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "explode" );
    var_0 endon( "switch_modes" );
    var_0.owner notifyonplayercommand( "jump_rcxd", "+gostand" );

    for (;;)
    {
        if ( !var_0 _meth_87B5() )
        {
            var_0.owner waittill( "jump_rcxd" );
            waitframe();

            if ( var_0 _meth_87B5() )
            {
                var_0 setscriptablepartstate( "jump", "enabled", 0 );
                waitframe();
                var_0 setscriptablepartstate( "jump", "default", 0 );
            }
        }

        waitframe();
    }
}

_id_12A2B()
{
    var_0 = self;
    var_0.owner endon( "disconnect" );
    var_0 endon( "death" );
    var_0 endon( "explode" );
    var_0 endon( "switch_modes" );

    for (;;)
    {
        if ( var_0 _meth_87B4() )
        {
            var_0 setscriptablepartstate( "booster_start", "enabled", 0 );
            var_0 setscriptablepartstate( "booster", "enabled", 0 );
            wait 0.2;
            var_0 setscriptablepartstate( "booster_start", "default", 0 );

            while ( var_0 _meth_87B4() )
                waitframe();

            var_0 setscriptablepartstate( "booster", "default", 0 );
        }

        waitframe();
    }
}

_id_12A24( var_0 )
{
    var_1 = self;
    var_1 thread _id_12A1E();
    var_1.lbravo_spawner_safehouse1 = 1;
    var_1 thread _id_12A21( var_0 );
}

_id_12A1E()
{
    var_0 = self;
    var_1 = var_0.origin;
    var_2 = var_0.owner;
    var_3 = spawn( "trigger_radius", var_1, 0, 256, 512 );
    var_0 radiusdamage( var_0.origin, 300, 60, 25, var_2, "MOD_EXPLOSIVE" );
    var_3 endon( "death" );
    var_3.owner = var_2;
    var_3.team = var_2.team;
    var_3.playersintrigger = [];
    var_3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerenter();
    var_3 thread scripts\mp\equipment\gas_grenade::gas_watchtriggerexit();
    var_3 thread watchgastrigger( var_0.owner, "rcxd_mp_br" );
    var_4 = var_0.origin + ( 0, 0, -10 );
    var_5 = physicstrace( var_0.origin, var_4 );
    var_6 = var_5 == var_4;
    var_7 = "detonateGround";

    if ( var_6 )
        var_7 = "detonateAir";

    physicsexplosionsphere( var_0.origin, 200, 100, 3 );
    scripts\cp_mp\utility\shellshock_utility::shellshock_artilleryearthquake( var_0.origin );
    playfx( scripts\engine\utility::getfx( "rcxdExplosion" ), var_0.origin );
    var_2 playsoundtoplayer( "rcxd_tablet_post_exp_static", var_2 );
    wait 20.0;
    var_3 thread scripts\mp\equipment\gas_grenade::gas_destroytrigger();
}

watchgastrigger( var_0, var_1 )
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger", var_2 );

        if ( !isplayer( var_2 ) )
            continue;

        if ( level.teambased && var_2.team == var_0.team && var_2 != var_0 )
            continue;

        if ( istrue( var_2.gettinggassed ) )
            continue;

        thread applygasdamageovertime( var_0, var_2 );
    }
}

applygasdamageovertime( var_0, var_1 )
{
    var_1 endon( "disconnect" );
    var_1.gettinggassed = 1;

    while ( var_1 istouching( self ) )
    {
        var_1 dodamage( 9, self.origin, var_0, self, "MOD_EXPLOSIVE" );
        var_2 = scripts\engine\utility::_id_143B9( 1, "death" );

        if ( var_2 == "death" )
            break;
    }

    if ( istrue( var_1.gettinggassed ) )
        var_1.gettinggassed = undefined;
}

_id_12A29( var_0, var_1, var_2 )
{
    var_3 = self;

    if ( !isdefined( var_0 ) )
        return;

    var_4 = var_3 _id_12A26( var_1, var_2, 7500 );
    scripts\mp\gametypes\br_public.gsc::brleaderdialog( var_0, 1, var_4 );
}

_id_12A26( var_0, var_1, var_2 )
{
    var_3 = self;
    var_4 = [];
    var_5 = var_3.owner.team;
    var_6 = level.teamdata[var_5]["players"];
    var_4 = scripts\common\utility::playersnear( var_3.owner.origin, var_2 );

    if ( istrue( var_0 ) )
        var_4 = scripts\engine\utility::array_intersection( var_6, var_4 );

    if ( istrue( var_1 ) )
        var_4 = scripts\engine\utility::array_difference( var_4, var_6 );

    return var_4;
}
