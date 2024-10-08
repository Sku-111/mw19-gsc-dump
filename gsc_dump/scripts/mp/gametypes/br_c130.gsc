// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\mp\flags::gameflaginit( "br_ready_to_jump", 0 );
    setdvarifuninitialized( "scr_br_c130_parachuteEnableDelay", 2.0 );
    level.br_ispointinboundsfunc = ::ispointinbounds;
}

spawnc130pathstruct( var_0, var_1 )
{
    var_2 = makepathparamsstruct( var_0, var_1 );
    var_3 = scripts\mp\gametypes\br_public.gsc::makepathstruct( var_2 );
    return var_3;
}

makepathparamsstruct( var_0, var_1 )
{
    var_2 = 160;
    var_3 = 200;

    if ( isdefined( var_0 ) )
        var_4 = var_0;
    else
        var_4 = ( 0, 0, 0 );

    if ( level.mapname == "mp_torez" )
    {
        var_2 = 165;
        var_3 = 195;
        var_4 = ( 3000, -2000, 0 );
    }

    var_5 = 6.28318;
    var_6 = randomfloatrange( 0, 360 );
    var_7 = randomfloatrange( var_2, var_3 );

    if ( isdefined( var_1 ) )
        var_8 = var_1;
    else
        var_8 = level.br_level.br_circleradii[0];

    var_9 = spawnstruct();
    var_9.r = var_8;
    var_9.randomangle = var_6;
    var_9.endangleoffset = var_7;
    var_9.centerpt = var_4;
    return var_9;
}

snappointtomapbounds2d( var_0 )
{
    var_1 = level.br_level.br_mapbounds;

    if ( var_0[0] < var_1[1][0] )
        var_0 = ( var_1[1][0], var_0[1], var_0[2] );
    else if ( var_0[0] > var_1[0][0] )
        var_0 = ( var_1[0][0], var_0[1], var_0[2] );

    if ( var_0[1] < var_1[1][1] )
        var_0 = ( var_0[0], var_1[1][1], var_0[2] );
    else if ( var_0[1] > var_1[0][1] )
        var_0 = ( var_0[0], var_1[0][1], var_0[2] );

    return var_0;
}

_id_1342E( var_0, var_1, var_2 )
{
    if ( !isdefined( level.outofboundstriggers ) || level.outofboundstriggers.size == 0 )
        return snappointtomapbounds2d( var_1 );

    if ( !isdefined( level._id_12165 ) )
        level._id_12165 = level.outofboundstriggers;

    var_3 = physics_createcontents( [ "physicscontents_playertrigger" ] );
    var_4 = scripts\engine\trace::ray_trace_ents( var_0, var_1, level._id_12165, var_3 );
    var_5 = 0;

    if ( var_4["fraction"] < 1.0 )
    {
        var_1 = var_4["position"];
        var_5 = 1;
    }

    if ( isdefined( level._id_12166 ) && level._id_12166.size > 0 && getdvarint( "scr_br_spawnOOBKillswitch", 0 ) == 0 )
    {
        var_6 = scripts\mp\gametypes\br_public.gsc::_id_12A18( var_0, var_1, level._id_12166 );

        if ( isdefined( var_6 ) )
        {
            var_7 = distance2dsquared( var_0, var_1 );
            var_8 = distance2dsquared( var_0, var_6 );

            if ( var_8 < var_7 )
            {
                var_1 = ( var_6[0], var_6[1], var_1[2] );
                var_5 = 1;
            }
        }
    }

    if ( var_5 && isdefined( var_2 ) )
    {
        var_9 = vectornormalize( var_0 - var_1 );
        var_1 = var_1 + var_9 * var_2;
    }

    return var_1;
}

respawns_on_failed_unload( var_0 )
{
    var_1 = getdvarfloat( "scr_br_c130MaxRadiusPerc", 0.7 );
    var_2 = ( level.br_level.br_mapsize[0] / 2 + level.br_level.br_mapsize[1] / 2 ) / 2;

    if ( isdefined( var_0 ) )
        var_2 = var_0;

    var_3 = var_1 * var_2;
    return var_3;
}

vehicle_collision_getdamagefactor( var_0 )
{
    if ( !isdefined( level.br_level ) )
        return 1;

    var_1 = level.br_level.br_mapcenter;
    var_2 = respawns_on_failed_unload();
    var_3 = distance2d( var_1, var_0 );
    return var_3 < var_2;
}

spawnc130pathstructnew( var_0, var_1 )
{
    var_2 = level.br_level.br_mapcenter;

    if ( isdefined( var_0 ) )
        var_2 = var_0;

    var_3 = respawns_on_failed_unload( var_1 );
    var_4 = randomfloat( 360 );

    if ( scripts\mp\gametypes\br_public.gsc::tutorial_playsound() )
    {
        if ( isdefined( level.stop_rpg_guys ) )
            var_4 = level.stop_rpg_guys;
        else
            var_4 = 75;
    }

    var_5 = anglestoforward( ( 0, var_4, 0 ) );
    var_5 = var_5 * ( var_3 * randomfloatrange( -1, 1 ) );
    var_5 = var_5 + ( 0, 0, relic_ammo_drain_take_ammo() );

    if ( !scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee( "randomizeCircleCenter" ) )
        var_2 = var_2 + var_5;

    if ( !scripts\mp\gametypes\br_public.gsc::tutorial_playsound() && !scripts\mp\gametypes\br_public.gsc::uniquelootcallbacks() )
        var_2 = getdvarvector( "scr_br_c130PathCenter", var_2 );

    if ( isdefined( level.delay_show_backpack ) )
        var_2 = level.delay_show_backpack;

    if ( scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee_params( "planeConstrainedFromMapCenter" ) )
        var_2 = hostdamagepercentmedium( var_2 );

    var_6 = ( 0, randomfloatrange( 0, 360 ), 0 );

    if ( scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee( "randomizeCircleCenter" ) )
    {
        var_7 = level.br_level.br_mapcenter + var_5;
        var_8 = var_2 - var_7;

        if ( scripts\engine\utility::cointoss() && getdvarint( "scr_br_circlePlaneDirFlipDisabled", 0 ) == 0 )
            var_8 = var_8 * -1.0;

        var_9 = vectortoyaw( var_8 );
        var_6 = ( 0, var_9, 0 );
    }

    if ( scripts\mp\gametypes\br_public.gsc::tutorial_playsound() )
        var_6 = ( 0, 75, 0 );
    else
    {
        var_10 = getdvarfloat( "scr_br_c130PathAngle", -1 );

        if ( var_10 < 0 )
            var_10 = var_6[1];

        var_6 = ( 0, var_10, 0 );
    }

    var_11 = level.br_level.br_circleradii[0];

    if ( isdefined( var_1 ) )
        var_11 = var_1;

    var_12 = var_11 * 2;

    if ( scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee_params( "planeUseCircleRadius" ) )
        var_12 = var_11;

    var_13 = _id_1361A( var_2, var_6, var_12 );
    var_14 = scripts\cp_mp\parachute::getc130height();
    var_13.startpt = ( var_13.startpt[0], var_13.startpt[1], var_14 );
    var_13.endpt = ( var_13.endpt[0], var_13.endpt[1], var_14 );
    return var_13;
}

hostdamagepercentmedium( var_0 )
{
    var_1 = physics_createcontents( [ "physicscontents_playertrigger" ] );
    var_2 = scripts\engine\trace::ray_trace_ents( level.br_level.br_mapcenter, var_0, level._id_12165, var_1 );

    if ( var_2["fraction"] < 1.0 )
    {
        var_3 = var_0[2];
        var_0 = var_2["position"] - level.br_level.br_mapcenter;
        var_4 = var_2["fraction"] - 0.01;
        var_0 = ( var_0[0] * var_4, var_0[1] * var_4, var_3 );
    }

    return var_0;
}

_id_1361A( var_0, var_1, var_2 )
{
    var_3 = anglestoforward( var_1 );

    if ( !isdefined( var_2 ) )
    {
        var_2 = level.br_level.br_circleradii[0] * 2;

        if ( scripts\mp\gametypes\br_public.gsc::tutorial_playsound() )
            var_2 = level.br_level.br_circleradii[2] * 2;
    }

    var_4 = var_0 - var_3 * var_2;
    var_5 = var_0 + var_3 * var_2;

    if ( !scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee( "planeSnapToOOB" ) )
    {
        var_4 = _id_1342E( var_0, var_4 );
        var_5 = _id_1342E( var_0, var_5 );
    }

    var_6 = var_4;
    var_7 = var_5;

    if ( scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee( "planeSnapToOOB" ) )
    {
        if ( !add_to_spotlight_array( var_4 ) )
            var_6 = _id_1342E( var_0, var_4 );

        if ( !add_to_spotlight_array( var_5 ) )
            var_7 = _id_1342E( var_0, var_5 );
    }

    var_3 = vectornormalize( var_5 - var_4 );
    var_8 = scripts\mp\utility\game::round_vehicle_logic();
    var_9 = 10;

    if ( var_8 == "mini" || var_8 == "zxp" && getdvarint( "scr_br_alt_mode_rebirth_skip_initial_circle", 0 ) || getdvarint( "scr_br_alt_mode_escape_skip_initial_circle", 0 ) || var_8 == "reveal" || isdefined( level.disable_heli_lights ) && level.disable_heli_lights._id_14291 == 3 )
    {
        if ( scripts\cp_mp\utility\game_utility::turretdisabled() )
            var_9 = 5;
        else
            var_9 = 2;
    }

    if ( var_8 == "rebirth" || var_8 == "rebirth_reverse" || var_8 == "treasure_hunt" || var_8 == "mendota" || var_8 == "olaride" || var_8 == "rebirth_dbd" )
    {
        if ( scripts\cp_mp\utility\game_utility::turretdisabled() || scripts\cp_mp\utility\game_utility::validateprojectileent() )
            var_9 = 8;
        else
            var_9 = 7;
    }

    var_4 = var_4 - var_3 * getc130speed() * var_9;
    var_5 = var_5 + var_3 * 100000;

    if ( scripts\mp\gametypes\br_public.gsc::tutorial_playsound() )
        var_4 = var_4 - var_3 * getc130speed() * 20;

    var_10 = spawnstruct();
    var_10.startpt = var_4;
    var_10.endpt = var_5;
    var_10._id_1386E = var_6;
    var_10.neurotoxin_damage_monitor = var_7;
    var_10.angle = var_1;
    var_10.pathdir = var_3;
    var_10.centerpt = var_0;
    return var_10;
}

getc130speed()
{
    if ( isdefined( level.br_level ) && isdefined( level.br_level.c130_speedoverride ) )
        return level.br_level.c130_speedoverride;

    return 3044;
}

relic_ammo_drain_take_ammo()
{
    return 8000;
}

setc130heightoverrides( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        level.br_level.c130_heightoverride = var_0;

    if ( isdefined( var_1 ) )
        level.br_level.c130_sealeveloverride = var_1;

    setomnvar( "ui_br_altimeter_c130_height", scripts\cp_mp\parachute::getc130height() );
    setomnvar( "ui_br_altimeter_sea_height", scripts\cp_mp\parachute::getc130sealevel() );
}

updatec130pathomnvars( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.startpt ) || !isdefined( var_0.endpt ) || !isdefined( var_0.angle ) )
        return;

    if ( scripts\mp\gametypes\br_gametypes.gsc::unset_relic_aggressive_melee( "c130PlaneLine" ) )
        return;

    setomnvar( "ui_br_c130_path_start_x", int( var_0._id_1386E[0] ) );
    setomnvar( "ui_br_c130_path_start_y", int( var_0._id_1386E[1] ) );
    setomnvar( "ui_br_c130_path_end_x", int( var_0.neurotoxin_damage_monitor[0] ) );
    setomnvar( "ui_br_c130_path_end_y", int( var_0.neurotoxin_damage_monitor[1] ) );
}

createtestc130path( var_0, var_1 )
{
    self notify( "debug130Line" );

    if ( isdefined( level.br_level.br_mapcenter ) && isdefined( level.br_level.br_mapsize ) )
    {
        var_2 = spawnc130pathstructnew( var_0, var_1 );
        level thread scripts\mp\gametypes\br_analytics.gsc::determinewinnertype( var_2.centerpt, var_2.angle[1], var_2._id_1386E, var_2.neurotoxin_damage_monitor );
    }
    else
        var_2 = spawnc130pathstruct( var_0, var_1 );

    updatec130pathomnvars( var_2 );
    return var_2;
}

spawnc130( var_0, var_1, var_2 )
{
    var_3 = distance( var_0.startpt, var_0.endpt );
    var_4 = var_3 / getc130speed();
    var_5 = 1;
    level.br_ac130 = gunship_spawn( var_0.startpt, var_0.endpt, var_4, var_5, var_1, var_2 );
    level.br_ac130._id_12205 = var_0;
    return var_4;
}

spawnplayertoc130()
{
    if ( isdefined( level.infil_vignette_anim_type ) && level.infil_vignette_anim_type == "script_model" )
        self unlink();

    scripts\mp\gametypes\br_infils.gsc::neurotoxin_damage_loop();
    thread playerputinc130( level.br_ac130 );
    self.elevator_manager = 1;

    if ( istrue( self.tutorial_usingparachute ) && getdvar( "scr_br_gametype", "" ) != "dmz" && getdvar( "scr_br_gametype", "" ) != "rat_race" && getdvar( "scr_br_gametype", "" ) != "risk" && getdvar( "scr_br_gametype", "" ) != "bodycount" && getdvar( "scr_br_gametype", "" ) != "gold_war" && getdvar( "scr_br_gametype", "" ) != "olaride" )
        level scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "deploy_squad_leader", self, 1, 0 );
}

playerputinc130( var_0 )
{
    self.angles = var_0.angles;
    self allowcrouch( 0 );
    self allowprone( 0 );
    thread listenjump( var_0, 0 );
    thread listenkick( var_0, 0 );
    self.br_infil_type = "c130";
    thread scripts\mp\gametypes\br_public.gsc::orbitcam( var_0 );
    self setclientomnvar( "ui_hide_nameplate_strings", 1 );
}

gunship_spawn( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_3 ) )
        var_3 = 1;

    var_6 = spawn( "script_model", var_0 );
    var_6 setmodel( "veh8_mil_air_acharlie130_magma_animated" );
    var_6 setcandamage( 0 );
    var_6.maxhealth = 100000;
    var_6.health = var_6.maxhealth;
    var_6.cleanme = 1;
    var_6.startpt = var_0;
    var_6.dir = vectornormalize( var_1 - var_0 );
    var_6.angles = vectortoangles( var_6.dir );
    var_7 = "veh8_mil_air_acharlie130_magma_rigid";

    if ( isdefined( level.debugforcesre1 ) )
        var_7 = level.debugforcesre1;

    var_6.innards = spawn( "script_model", var_0 );
    var_6.innards setmodel( var_7 );
    var_6.innards.cleanme = 1;
    var_6.innards linkto( var_6, "", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_6.playeroffsets = [ ( 32, 30, -500 ), ( -32, 30, -500 ), ( 0, 30, -500 ), ( 16, 30, -500 ), ( -16, 30, -500 ) ];
    var_6.currentplayeroffset = 0;

    if ( isdefined( var_5 ) )
        var_6 [[ var_5 ]]();

    if ( var_3 )
        var_6 thread kickwhenoutofbounds( "c130" );

    if ( isdefined( var_4 ) )
        var_6 thread [[ var_4 ]]( var_1, var_2 );
    else
        var_6 thread gunship_handlemovement( var_1, var_2 );

    return var_6;
}

gunship_handlemovement( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    self hide();

    if ( isdefined( self.innards ) )
        self.innards hide();

    self waittill( "start_moving" );
    self show();

    if ( isdefined( self.innards ) )
        self.innards show();

    self moveto( var_0, var_1 );
    thread killaftertime( var_1, "c130" );
    thread scripts\mp\gametypes\br_public.gsc::gunship_spawnvfx();
    self playloopsound( "br_ac130_lp" );
}

add_to_spotlight_array( var_0 )
{
    var_1 = 0;
    var_2 = 1;
    return ispointinbounds( var_0, var_1, var_2 );
}

ispointinbounds( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = scripts\mp\utility\game_utility_mp::track_get_reward_time( var_0, var_2 );

    if ( !var_3 )
        return 0;

    var_4 = scripts\mp\gametypes\br_public.gsc::uniquelootcallbacks() || scripts\mp\gametypes\br_public.gsc::tutorial_playsound();

    if ( var_4 && isdefined( level.br_ac130 ) )
        return var_3;

    var_5 = ispointincustomoutofbounds( var_0 );

    if ( var_5 )
        return 0;

    if ( vehicle_collision_getdamagefactor( var_0 ) )
        return 1;

    var_6 = scripts\mp\outofbounds::ispointinoutofbounds( var_0 );

    if ( var_6 )
        return 0;

    if ( istrue( var_1 ) )
    {
        if ( scripts\mp\outofbounds::useshouldsucceedcallback( var_0 ) )
            return 0;
    }

    return 1;
}

ispointincustomoutofbounds( var_0 )
{
    if ( !isdefined( level.customoutofboundstriggers ) )
        return 0;

    foreach ( var_2 in level.customoutofboundstriggers )
    {
        if ( isdefined( var_2 ) && ispointinvolume( var_0, var_2 ) )
            return 1;
    }

    return 0;
}

_id_123AF()
{
    var_0 = anglestoforward( self.angles );

    for (;;)
    {
        var_1 = vectornormalize( self._id_12205._id_1386E - self.origin );
        var_2 = vectordot( var_0, var_1 ) < 0;

        if ( var_2 )
            break;

        waitframe();
    }
}

kickwhenoutofbounds( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );

    if ( !scripts\cp_mp\utility\game_utility::isrealismenabled() )
        setomnvarforallclients( "ui_hide_minimap", 1 );

    waitframe();
    _id_123AF();
    var_1 = relic_ammo_drain_take_ammo();

    while ( !add_to_spotlight_array( ( self.origin[0], self.origin[1], var_1 ) ) )
        waitframe();

    if ( !scripts\cp_mp\utility\game_utility::isrealismenabled() )
        setomnvarforallclients( "ui_hide_minimap", 0 );

    var_2 = getdvarint( "scr_br_project_kick_for_gas", 1 );

    if ( var_2 )
    {
        for (;;)
        {
            var_3 = scripts\mp\gametypes\br_circle.gsc::getdangercircleorigin();
            var_4 = scripts\mp\gametypes\br_circle.gsc::getdangercircleradius();

            if ( var_4 > 0 )
            {
                var_5 = var_4 * var_4;

                if ( distance2dsquared( self.origin, var_3 ) <= var_5 )
                    break;
            }
            else
                break;

            waitframe();
        }
    }

    level.delay_music_reinforcements = 1;
    level.c130inbounds = 1;
    level notify( "br_c130_in_bounds" );

    for (;;)
    {
        var_6 = anglestoforward( self.angles );
        var_7 = vectornormalize( self._id_12205.centerpt - self.origin );
        var_8 = vectordot( var_6, var_7 ) < 0;

        if ( var_8 )
            break;

        waitframe();
    }

    var_9 = getdvarint( "scr_br_project_kick", 3500 );

    for (;;)
    {
        var_6 = anglestoforward( self.angles );
        var_10 = self.origin + var_6 * var_9;
        var_10 = ( var_10[0], var_10[1], var_1 );

        if ( !add_to_spotlight_array( var_10 ) )
        {
            level.debugnextpropindex = 1;

            foreach ( var_12 in level.players )
            {
                if ( isdefined( var_12 ) && isdefined( var_12.br_infil_type ) && var_12.br_infil_type == var_0 && !isdefined( var_12.jumptype ) )
                {
                    var_12.jumptype = "outOfBounds";
                    var_12 notify( "halo_kick_c130" );
                }
            }

            break;
        }

        if ( var_2 )
        {
            var_3 = scripts\mp\gametypes\br_circle.gsc::getdangercircleorigin();
            var_4 = scripts\mp\gametypes\br_circle.gsc::getdangercircleradius();

            if ( var_4 > 0 )
            {
                var_5 = var_4 * var_4;

                if ( distance2dsquared( var_10, var_3 ) > var_5 )
                {
                    level.debugnextpropindex = 1;

                    foreach ( var_12 in level.players )
                    {
                        if ( isdefined( var_12 ) && isdefined( var_12.br_infil_type ) && var_12.br_infil_type == var_0 && !isdefined( var_12.jumptype ) )
                        {
                            var_12.jumptype = "outOfBounds";
                            var_12 notify( "halo_kick_c130" );
                        }
                    }

                    break;
                }
            }
        }

        waitframe();
    }

    level.c130inbounds = undefined;
    level notify( "br_c130_left_bounds" );
    level.infilstruct.playersinc130 = 0;
    setomnvar( "ui_br_players_left_in_plane", level.infilstruct.playersinc130 );
}

killaftertime( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "death" );
    wait( var_0 );

    if ( isdefined( self.players ) )
    {
        foreach ( var_3 in self.players )
        {
            if ( isdefined( var_3 ) && isdefined( var_3.br_infil_type ) && var_3.br_infil_type == var_1 && !isdefined( var_3.jumptype ) )
            {
                var_3.jumptype = "outOfBounds";
                var_3 notify( "halo_kick_c130" );
            }
        }
    }
    else
    {
        foreach ( var_3 in level.players )
        {
            if ( isdefined( var_3 ) && isdefined( var_3.br_infil_type ) && var_3.br_infil_type == var_1 && !isdefined( var_3.jumptype ) )
            {
                var_3.jumptype = "outOfBounds";
                var_3 notify( "halo_kick_c130" );
            }
        }
    }

    self stoploopsound();
    scripts\mp\gametypes\br_infils.gsc::stop_hotjoining( self );
    wait 0.1;

    if ( isdefined( self.animstruct ) )
    {
        var_7 = 1;

        while ( var_7 )
        {
            var_7 = 0;

            foreach ( var_3 in level.players )
            {
                if ( isdefined( var_3.br_infil_type ) )
                {
                    var_7 = 1;
                    break;
                }
            }

            if ( var_7 )
                wait 0.5;
        }

        scripts\mp\gametypes\br_infils.gsc::handleheadshotkillrewardbullets( self.animstruct );
    }
    else
    {
        if ( isdefined( self.innards ) )
            self.innards delete();

        self delete();
    }
}

listenkick( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_c130" );
    self endon( "br_jump" );
    self waittill( "halo_kick_c130", var_2 );

    if ( !isdefined( var_2 ) )
        var_2 = ( 0, var_0.angles[1] + 180, 0 );

    self.display_hint_for_player_single = 1;
    thread leaveplane( var_0, var_1, var_2, 0 );
}

listenjump( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "cancel_c130" );
    self endon( "br_jump" );
    var_2 = undefined;
    self.redeployenabled = 0;
    var_3 = getdvarint( "scr_br_squadLeaderForceJump", 0 );
    var_0 _id_123AF();

    for (;;)
    {
        var_4 = scripts\engine\utility::waittill_either( "halo_jump_c130", "halo_jump_solo_c130" );

        if ( !isdefined( var_4 ) )
            var_4 = "halo_jump_c130";

        var_5 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( self.team, self.squadindex );

        if ( !var_3 )
        {
            var_2 = var_0 scripts\mp\gametypes\br_public.gsc::calctrailpoint();

            if ( add_to_spotlight_array( var_2 ) )
            {
                self.jumptype = "solo";
                self notify( "halo_kick_c130" );
                scripts\engine\utility::thread_on_notify( "infil_jump_done", scripts\mp\gametypes\br_public.gsc::updatebrscoreboardstat, "jumpMasterState", 0 );
                break;
            }
            else
                self iprintlnbold( &"MP_BR_INGAME/NOT_PLAYABLE" );

            continue;
        }

        var_6 = scripts\mp\gametypes\br_public.gsc::updatedragonsbreath() || isdefined( self.pers["squadMemberIndex"] ) && self.pers["squadMemberIndex"] == 0;

        if ( !var_6 && var_5.size > 1 )
        {
            if ( var_4 == "halo_jump_solo_c130" )
            {
                var_2 = var_0 scripts\mp\gametypes\br_public.gsc::calctrailpoint();

                if ( add_to_spotlight_array( var_2 ) )
                {
                    self.jumptype = "solo";
                    self notify( "halo_kick_c130" );
                    scripts\engine\utility::thread_on_notify( "infil_jump_done", scripts\mp\gametypes\br_public.gsc::updatebrscoreboardstat, "jumpMasterState", 0 );
                    break;
                }
                else
                    self iprintlnbold( &"MP_BR_INGAME/NOT_PLAYABLE" );
            }

            continue;
        }

        var_2 = var_0 scripts\mp\gametypes\br_public.gsc::calctrailpoint();

        if ( add_to_spotlight_array( var_2 ) )
        {
            if ( var_6 )
            {
                self.jumptype = "leader";
                var_7 = isdefined( level.squaddata );

                if ( var_7 )
                {
                    var_8 = level.squaddata[self.team][self.squadindex];
                    var_5 = var_8.players;
                }

                foreach ( var_10 in var_5 )
                {
                    if ( var_10 != self && isdefined( var_10.br_infil_type ) && !isdefined( var_10.jumptype ) )
                    {
                        var_10.jumptype = "follower";
                        var_10 notify( "halo_kick_c130", self getplayerangles() );
                    }

                    var_10 playlocalsound( "tmp_br_infil_ac130_jumpmaster_go" );
                }

                if ( var_4 != "halo_jump_solo_c130" && getdvarint( "scr_br_holdteamtojumpmaster", 0 ) )
                    thread holdteammatestosquadleader( var_5 );
                else
                {
                    foreach ( var_10 in var_5 )
                    {
                        if ( isdefined( var_10.br_infil_type ) )
                            setteammateomnvarsforplayer( var_10, var_5, 0 );
                    }
                }
            }

            break;
        }
        else
            self iprintlnbold( &"MP_BR_INGAME/NOT_PLAYABLE" );

        var_2 = var_0 scripts\mp\gametypes\br_public.gsc::calctrailpoint();
        waitframe();
    }

    thread leaveplane( var_0, var_1, self getplayerangles(), 0 );
}

leaveplane( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "cancel_c130" );
    setdvarifuninitialized( "scr_br_infil_hudoutline", 1 );
    self notify( "br_jump" );
    self allowcrouch( 1 );
    self allowprone( 1 );
    self.plotarmor = undefined;
    scripts\mp\utility\game::_id_131A3( self, 0 );
    scripts\mp\gametypes\br_public.gsc::updatebrscoreboardstat( "isInInfilPlane", 0 );

    if ( isdefined( level.infilstruct ) && isdefined( level.infilstruct.playersinc130 ) && level.infilstruct.playersinc130 > 0 )
        level.infilstruct.playersinc130--;

    self notifyonplayercommandremove( "halo_jump_c130", "+gostand" );
    self notifyonplayercommandremove( "halo_jump_solo_c130", "+gostand" );
    self notifyonplayercommandremove( "abandon_fireteam_leader", "+frag" );
    self notifyonplayercommandremove( "br_pass_squad_leader", "+usereload" );
    self notifyonplayercommandremove( "br_pass_squad_leader", "+activate" );
    self waittill( "infil_jump_done" );

    if ( isdefined( self.br_infil_type ) )
        thread stop_players_inside_death_or_disconnect_monitor( var_0 );

    self cameradefault();
    self.br_infil_type = undefined;
    thread parachute( var_0, var_1, var_2, var_3 );
    thread scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "onLeaveAC130" );

    if ( scripts\mp\utility\game::round_vehicle_logic() == "truckwar" )
    {
        scripts\mp\gametypes\br_gametype_truckwar.gsc::getspawnpoint( 1 );
        self setorigin( self._id_12AB3.origin, 1 );
        self setplayerangles( self._id_12AB3.angles );
    }
}

holdteammatestosquadleader( var_0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    thread _id_144D3( var_0 );
    var_1 = self;
    wait 0.2;
    var_2 = [ ( -250, 0, 0 ), ( -150, -150, 0 ), ( -150, 150, 0 ) ];
    var_3 = 0;

    foreach ( var_5 in var_0 )
    {
        if ( !isdefined( var_5 ) || !isalive( var_5 ) )
            continue;

        if ( var_5 != var_1 )
        {
            if ( isdefined( var_5.jumptype ) && var_5.jumptype != "solo" )
            {
                var_5 thread pushplayertoplayeroffset( var_1, var_2[var_3] );
                var_3++;
                continue;
            }

            setteammateomnvarsforplayer( var_5, var_0, 0 );
        }
    }

    var_7 = 2700;
    var_8 = 999999999;

    while ( !self usebuttonpressed() && var_8 > var_7 )
    {
        var_9 = scripts\common\utility::groundpos( var_1.origin );
        var_8 = var_1.origin[2] - var_9[2];

        if ( var_1 isparachuting() )
            break;

        waitframe();
    }

    foreach ( var_11 in var_0 )
    {
        if ( !isdefined( var_11 ) || !isalive( var_11 ) )
            continue;

        if ( var_11 != self && istrue( var_11.beingpushed ) )
        {
            var_11 notify( "stop_push" );
            var_11.beingpushed = undefined;
        }

        setteammateomnvarsforplayer( var_11, var_0, 0 );
    }

    self notify( "hold_teammates_complete" );
}

_id_144D3( var_0 )
{
    level endon( "game_ended" );
    self endon( "hold_teammates_complete" );
    scripts\engine\utility::_id_143A5( "death", "disconnect" );

    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( var_2 ) )
            continue;

        if ( var_2 != self && istrue( var_2.beingpushed ) )
        {
            var_2 notify( "stop_push" );
            var_2.beingpushed = undefined;
        }

        setteammateomnvarsforplayer( var_2, var_0, 0 );
    }
}

setteammateomnvarsforplayer( var_0, var_1, var_2 )
{
    var_3 = scripts\engine\utility::ter_op( var_0 scripts\mp\gametypes\br_public.gsc::updatedragonsbreath(), 2, var_2 );
    var_0 scripts\mp\gametypes\br_public.gsc::updatebrscoreboardstat( "jumpMasterState", var_3 );
}

_id_12611()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "stop_push" );
    self waittill( "skydive_deployparachute" );
    var_0 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    setteammateomnvarsforplayer( self, var_0, 0 );
}

pushplayertoplayeroffset( var_0, var_1 )
{
    level endon( "game_ended" );
    self.beingpushed = 1;
    var_2 = self;
    var_2 endon( "death_or_disconnect" );
    var_2 endon( "stop_push" );
    var_2 thread _id_12611();
    var_3 = length( var_1 );

    while ( !var_2 isonground() && !var_2 usebuttonpressed() && isdefined( var_0 ) && !var_2 isparachuting() )
    {
        var_4 = var_0 getplayerangles();
        var_5 = rotatepointaroundvector( ( 0, 0, 1 ), var_1, var_4[1] );
        var_6 = var_0.origin + var_5 - var_2.origin;
        var_7 = length( var_6 );

        if ( var_7 > var_3 )
        {
            var_8 = var_2 getvelocity();
            var_2 setvelocity( var_6 + var_8 * 0.9 );
        }

        waitframe();
    }

    var_2 notify( "stop_push" );
    var_2.beingpushed = undefined;
    var_9 = scripts\mp\utility\teams::getteamdata( var_2.team, "players" );
    setteammateomnvarsforplayer( var_2, var_9, 0 );
}

parachute( var_0, var_1, var_2, var_3 )
{
    self setclientomnvar( "ui_br_infiled", 1 );
    self setclientomnvar( "ui_hide_nameplate_strings", 0 );
    self unlink();

    if ( isdefined( self.br_orbitcam ) )
        self.br_orbitcam delete();

    waitframe();
    self playershow( 1 );

    if ( isdefined( var_2 ) )
        self setplayerangles( var_2 );

    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        self.delay_give_tactical_grenade = undefined;
        scripts\mp\gametypes\br_analytics.gsc::branalytics_deploytriggered( self );
    }

    var_4 = ( 0, 0, 0 );

    if ( var_3 )
        var_4 = anglestoforward( var_0.angles ) * getc130speed();

    self.ignorefalldamagetime = gettime() + 5000;
    self skydive_setdeploymentstatus( 0 );
    var_5 = getdvarfloat( "scr_br_c130_parachuteEnableDelay", 2.0 );
    thread scripts\cp_mp\parachute::startfreefall( var_5, var_1, undefined, var_4 );
}

stop_players_inside_death_or_disconnect_monitor( var_0 )
{
    self endon( "disconnect" );
    var_1 = self;

    if ( isdefined( var_0 ) )
        var_0 playsoundtoplayer( "br_ac130_flyby", var_1 );

    if ( scripts\mp\utility\game::round_vehicle_logic() != "truckwar" && scripts\mp\utility\game::round_vehicle_logic() != "reveal" && scripts\mp\utility\game::round_vehicle_logic() != "brdov" )
    {
        var_1 setsoundsubmix( "mp_br_infil_music", 0.0 );
        var_2 = scripts\mp\music_and_dialog::risk_flagspawnshiftingcenter( "br_infil_jump" );
        var_1 setplayermusicstate( var_2 );
        var_1.stickers = 1;
    }

    wait 1.0;
    var_1 clearclienttriggeraudiozone( 3.0 );

    if ( scripts\mp\utility\game::round_vehicle_logic() == "reveal" || scripts\mp\utility\game::round_vehicle_logic() == "brdov" )
    {
        wait 3.0;
        var_1 clearsoundsubmix( "mp_br_infil_music", 15.0 );
        var_1 clearsoundsubmix( "mp_br_event_dovp1_infil", 12.0 );
    }
    else
    {
        wait 5.0;
        var_1 clearsoundsubmix( "mp_br_infil_music", 15.0 );
    }
}

setplayervarinrespawnc130( var_0 )
{
    if ( isdefined( self.inrespawnc130 ) && self.inrespawnc130 == var_0 )
        return;

    self.inrespawnc130 = var_0;
    level notify( "update_circle_hide" );
}

waittoplayinfildialog()
{
    level endon( "game_ended" );
    level.br_ac130 endon( "death" );
    level.br_ac130 _id_123AF();

    for (;;)
    {
        var_0 = level.br_ac130 scripts\mp\gametypes\br_public.gsc::calctrailpoint();

        if ( add_to_spotlight_array( var_0 ) )
        {
            foreach ( var_2 in level.players )
            {
                if ( isplayer( var_2 ) )
                    var_2 playlocalsound( "scr_br_infil_ac130_klaxon" );
            }

            wait 1.0;
            scripts\mp\flags::gameflagset( "br_ready_to_jump" );
            scripts\mp\gametypes\br_analytics.gsc::branalytics_deployallowed();
            level notify( "stop_suspense_music" );
            level thread scripts\mp\music_and_dialog::suspensemusic();
            return;
        }

        waitframe();
    }
}
