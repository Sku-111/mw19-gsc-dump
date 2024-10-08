// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_14216( var_0 )
{
    var_1 = spawnstruct();
    var_2 = scripts\engine\utility::getstruct( "launch_code_drop_button", "targetname" );
    var_1.origin = var_2.origin + ( 0, 0, 50000 );

    if ( isdefined( var_0 ) )
        var_2.origin = var_0;

    var_3 = scripts\mp\gametypes\br_gametype_truckwar.gsc::_id_14263( var_1 );

    if ( isdefined( var_3 ) )
        level thread scripts\mp\gametypes\br_gametype_truckwar.gsc::_id_13DE4( var_3, var_2.origin, var_3.angles, 1 );
}

_id_13570()
{
    level endon( "game_ended" );
    var_0 = 0;

    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
    {
        if ( getdvarint( "scr_ri_spawn_vehicles_in_prematch", 1 ) == 1 )
            var_0 = 1;
    }
    else
        var_0 = 1;

    if ( !var_0 )
        return;

    if ( getdvarint( "scr_ri_default_veh_spawns", 0 ) )
    {
        scripts\mp\gametypes\br_vehicles.gsc::spawninitialvehicles();
        return;
    }

    if ( !isdefined( level.start_reach_exhaust_waste._id_12E2C._id_141BE ) )
        return;

    foreach ( var_4, var_2 in level.start_reach_exhaust_waste._id_12E2C._id_141BE )
    {
        var_3 = spawnstruct();
        var_3.ref = var_2[0];
        var_3.origin = var_2[1];
        var_3.angles = var_2[2];
        var_3._id_13A22 = var_4;
        level thread _id_1421B( var_3 );
    }
}

_id_12B07( var_0 )
{
    level.start_reach_exhaust_waste.spawned_vehicles[var_0._id_1352E._id_13A22] = var_0;
}

lasttuttxt( var_0 )
{
    level.start_reach_exhaust_waste.spawned_vehicles[var_0._id_1352E._id_13A22] = undefined;
}

_id_1421B( var_0 )
{
    if ( var_0.ref == "aa_turret" )
    {
        if ( isdefined( level.arenaflag_setenabled ) )
        {
            var_1 = var_0 [[ level.arenaflag_setenabled ]]();

            if ( isdefined( var_1 ) )
            {
                var_1._id_1352E = var_0;
                var_2 = var_0.origin;
                var_2 = var_2 - anglestoforward( var_0.angles ) * 5;
                var_3 = easepower( "veh_s4_mil_lnd_turret_quad_aa_wz_clip_dyn", var_2, var_0.angles );
                var_3 setscriptablepartstate( "clip", "enabled" );
                var_1.clip = var_3;
            }
            else
            {

            }
        }
    }
    else
    {
        var_4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnvehicle( var_0.ref, var_0 );

        if ( isdefined( var_4 ) )
        {
            var_4._id_1352E = var_0;

            if ( scripts\mp\flags::gameflag( "prematch_done" ) )
            {
                _id_12B07( var_4 );
                var_4 thread vehicle_death_watcher();
                var_4 thread _id_141C5();
            }
        }
        else
        {

        }
    }
}

_id_1420B( var_0 )
{
    level endon( "game_ended" );
    wait 45.0;
    _id_1421B( var_0 );
}

_id_141C5()
{
    level endon( "game_ended" );
    self endon( "death" );
    self endon( "vehicle_pending_respawn" );
    var_0 = self.origin;
    var_1 = 1500.0;
    var_2 = getdvarfloat( "scr_ri_veh_neglect_duration", 30.0 );
    self._id_11E49 = undefined;
    self._id_11E4A = 0;
    self._id_1381C = undefined;
    self.mp_layover_patch = undefined;

    for (;;)
    {
        self.loot_nag = distance2d( var_0, self.origin );
        self._id_141FA = isdefined( self getvehicleowner() );

        if ( !self._id_11E4A && self.loot_nag > var_1 && !self._id_141FA )
        {
            self._id_1381C = gettime();
            self.mp_layover_patch = gettime() + var_2 * 1000;
            self._id_11E4A = 1;
        }
        else if ( self._id_11E4A && self._id_141FA )
        {
            self._id_11E4A = 0;
            self._id_1381C = undefined;
            self.mp_layover_patch = undefined;
            self._id_11E49 = undefined;
        }

        if ( isdefined( self._id_1381C ) && isdefined( self.mp_layover_patch ) )
        {
            var_3 = gettime();
            self._id_11E49 = ( self.mp_layover_patch - var_3 ) / 1000;
            var_4 = 0;

            if ( var_3 >= self.mp_layover_patch )
            {
                foreach ( var_6 in level.players )
                {
                    if ( distance( var_6.origin, self.origin ) < var_1 )
                    {
                        self.mp_layover_patch = var_3 + var_2 / 2 * 1000;
                        var_4 = 1;
                        break;
                    }
                }

                if ( !var_4 )
                {
                    var_8 = self.health * 0.95;
                    self dodamage( var_8, self.origin );
                    break;
                }
            }
        }

        wait 1.0;
    }
}

vehicle_death_watcher()
{
    level endon( "game_ended" );
    self endon( "end_death_watcher" );
    var_0 = self._id_1352E;
    self waittill( "death" );
    self notify( "vehicle_pending_respawn" );
    lasttuttxt( self );
    _id_1420B( var_0 );
}

_id_141B6()
{
    return self.vehiclename == "veh_a10fd" || self.vehiclename == "veh_bt";
}

_id_141B5()
{
    return self.vehiclename == "veh_a10fd";
}

_id_12D35()
{
    level endon( "match_start_reset_aa_turrets" );
    level endon( "game_ended" );

    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
        return;

    var_0 = ( 0, 0, 60 );
    var_1 = self.origin + var_0;
    var_1 = var_1 - anglestoforward( self.angles ) * 28;
    self.useownerobj = scripts\mp\gameobjects::createhintobject( var_1, "HINT_BUTTON", undefined, &"BR_RUMBLE_INVASION/REPAIR_TURRET", -1, "duration_none", undefined, 100, 60, 60, 60 );

    for (;;)
    {
        self.useownerobj waittill( "trigger", var_2 );

        if ( isdefined( var_2 ) && var_2.plundercount >= 5 )
            break;

        playsoundatpos( self.useownerobj.origin, "ui_select_purchase_deny" );
    }

    self.useownerobj delete();
    var_2 scripts\mp\gametypes\br_plunder.gsc::_id_1261E( 5 );
    playsoundatpos( self.origin, "ui_select_purchase_confirm" );
    var_2 thread scripts\mp\hud_message::showsplash( "aa_turret_repaired" );
    var_2 thread scripts\mp\rank::giverankxp( "ri_turret_repaired", 25, var_2 getcurrentprimaryweapon() );
    var_2 thread scripts\mp\rank::scoreeventpopup( "ri_turret_repaired" );
    var_3 = spawnstruct();
    var_3.origin = self.origin;
    var_3.angles = self.angles;

    if ( isdefined( level.arenaknivesout ) )
        level.arenaknivesout = scripts\engine\utility::array_remove( level.arenaknivesout, self );

    if ( isdefined( level.arenaflag_setenabled ) )
        var_3 [[ level.arenaflag_setenabled ]]();

    self delete();
}
