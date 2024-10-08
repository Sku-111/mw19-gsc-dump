// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_14114()
{
    var_0 = spawnstruct();
    level.vehicle.collision = var_0;
    var_0.vehicledata = [];
    _id_14115();
    _id_14108();

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "vehicle_collision", "init" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "vehicle_collision", "init" ) ]]();

    thread _id_1411A();
}

_id_1411A()
{
    level endon( "game_ended" );
    var_0 = _id_1410E();

    for (;;)
    {
        var_0.eventdata = [];
        var_0.eventid = 0;
        waitframe();
    }
}

_id_1411B( var_0 )
{
    level endon( "game_ended" );

    if ( !isdefined( _id_1410F( var_0.vehiclename, 0, 1 ) ) )
        return;

    var_0 notify( "vehicle_collision_updateInstance" );
    var_0 endon( "vehicle_collision_updateInstance" );
    var_0 vehphys_enablecollisioncallback( 1 );

    while ( isdefined( var_0 ) )
    {
        var_0 waittill( "collision", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 );
        _id_14117( var_0, var_8, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_9 );
    }
}

_id_1411C( var_0 )
{
    var_0 notify( "vehicle_collision_updateInstance" );
}

_id_1410E()
{
    return level.vehicle.collision;
}

_id_1410F( var_0, var_1, var_2 )
{
    var_3 = _id_1410E();
    var_4 = var_3.vehicledata[var_0];

    if ( !isdefined( var_4 ) )
    {
        if ( istrue( var_1 ) )
        {
            var_4 = spawnstruct();
            var_3.vehicledata[var_0] = var_4;
            var_4.ref = var_0;
            var_4._id_12B1E = undefined;
            var_4.setup_techo_lmgs = undefined;
            var_4.challengeevaluator = 1;
            var_4.keycardlocs_chosen = 1;
            var_4.is_using_stealth_debug = 0;
            var_4.is_valid_station_name = 0;
            var_4.is_two_hit_melee_weapon = 0;
            var_4.isakimbomeleeweapon = 5;
            var_4.isallowedweapon = 20;
            var_4.isakimbo = 40;
            var_4._id_133C5 = 0;
            var_4._id_133C6 = 0;
            var_4._id_133C4 = 0;
        }
        else if ( !istrue( var_2 ) )
        {

        }
    }

    return var_4;
}

_id_1410C( var_0, var_1 )
{
    var_2 = _id_1410E();
    var_3 = _id_1410F( var_0.vehiclename, 0, 1 );

    if ( !isdefined( var_3 ) )
        return;

    var_4 = var_0 getentitynumber();
    var_5 = "none";

    if ( isdefined( var_1 ) && var_1 != var_0 && ( !isdefined( var_1.classname ) || var_1.classname != "worldspawn" ) )
        var_5 = var_1 getentitynumber();

    if ( !isdefined( var_2.eventdata[var_4] ) )
        var_2.eventdata[var_4] = [];

    var_6 = isdefined( var_1 ) && var_1 scripts\cp_mp\vehicles\vehicle::isvehicle() && isdefined( _id_1410F( var_1.vehiclename, 0, 1 ) );
    var_7 = undefined;

    if ( isdefined( var_2.eventdata[var_4][var_5] ) )
    {
        if ( isstring( var_5 ) && var_5 == "none" )
        {

        }

        var_7 = var_2.eventdata[var_4][var_5];
    }
    else if ( var_6 )
    {
        if ( !isdefined( var_2.eventdata[var_5] ) )
            var_2.eventdata[var_5] = [];

        if ( isdefined( var_2.eventdata[var_5][var_4] ) )
            var_7 = var_2.eventdata[var_5][var_4];
    }

    if ( !isdefined( var_7 ) )
    {
        var_7 = spawnstruct();
        var_2.eventdata[var_4][var_5] = var_7;

        if ( var_6 )
            var_2.eventdata[var_5][var_4] = var_7;

        var_7.id = var_2.eventid;
        var_2.eventid++;
        var_7.time = gettime();
        var_7.ent = [];
        var_7.cop_car_initomnvars = [];
        var_7.body1 = [];
        var_7.player_has_primary_weapons_max_ammo = [];
        var_7.player_has_primary_weapons_max_stock_ammo = [];
        var_7.position = [];
        var_7.normal = [];
        var_7._id_11EBB = [];
        var_7._id_121E2 = [];
        var_7.angles = [];
        var_7.velocity = [];
    }

    return var_7;
}

_id_14117( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( !isdefined( var_1 ) || var_1 == var_0 || isdefined( var_1.classname ) && var_1.classname == "worldspawn" )
        var_1 = undefined;

    var_10 = _id_1410C( var_0, var_1 );

    if ( !isdefined( var_10 ) )
        return;

    level notify( "vehicle_collision_registerEvent_" + var_10.id );
    var_11 = undefined;

    foreach ( var_11, var_13 in var_10.ent )
    {
        if ( var_13 == var_0 )
            break;
    }

    if ( !isdefined( var_11 ) )
        var_11 = var_10.ent.size;

    var_10.ent[var_11] = var_0;
    var_10.cop_car_initomnvars[var_11] = var_2;
    var_10.body1[var_11] = var_3;
    var_10.player_has_primary_weapons_max_ammo[var_11] = var_4;
    var_10.player_has_primary_weapons_max_stock_ammo[var_11] = var_5;
    var_10.position[var_11] = var_6;
    var_10.normal[var_11] = var_7;
    var_10._id_11EBB[var_11] = var_8;
    var_10._id_121E2[var_11] = var_9;
    var_10.angles[var_11] = var_0.angles;

    if ( !scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle() )
        var_10.velocity[var_11] = var_0 vehicle_getvelocity();
    else
        var_10.velocity[var_11] = ( 0, 0, 0 );

    if ( var_10.ent.size == 1 )
        var_10.ent[1] = var_1;

    var_14 = _id_1410F( var_0.vehiclename );

    if ( isdefined( var_14._id_12B1E ) )
        [[ var_14._id_12B1E ]]( var_10, var_11 );

    thread _id_14118( var_10 );
}

_id_14118( var_0 )
{
    level endon( "game_ended" );
    level endon( "vehicle_collision_registerEvent_" + var_0.id );
    waittillframeend;
    thread _id_14110( var_0 );
}

_id_14110( var_0 )
{
    _id_14111( var_0 );

    foreach ( var_4, var_2 in var_0.ent )
    {
        if ( !isdefined( var_2.vehiclename ) )
            continue;

        var_3 = _id_1410F( var_2.vehiclename, 0, 1 );

        if ( !isdefined( var_3 ) )
            continue;

        if ( isdefined( var_3.setup_techo_lmgs ) )
            [[ var_3.setup_techo_lmgs ]]( var_0, var_4 );
    }
}

_id_14111( var_0 )
{
    var_1 = _id_1410E();

    if ( var_1._id_11E02 )
        return;

    if ( var_0.ent.size < 2 || var_0.velocity.size < 2 )
        return;

    var_2 = var_0.ent.size;
    var_0.armorbox_usedcallback = [];

    for ( var_3 = 0; var_3 < var_2; var_3++ )
        var_0.armorbox_usedcallback[var_3] = vectordot( var_0.velocity[var_3], var_0.normal[var_3] );

    var_0._id_12B4D = int( abs( var_0.armorbox_usedcallback[0] - var_0.armorbox_usedcallback[1] ) );

    for ( var_3 = 0; var_3 < var_2; var_3++ )
        var_0.armorbox_usedcallback[var_3] = int( abs( var_0.armorbox_usedcallback[var_3] ) );

    var_0.unset_relic_nuketimer = [];
    _id_1410D( var_0, 0, 1 );
    _id_1410D( var_0, 1, 0 );
    _id_1410A( var_0, 0, 1 );
    _id_1410A( var_0, 1, 0 );
    _id_1410B( var_0, 0, 1 );
    _id_1410B( var_0, 1, 0 );
    _id_14119( var_0, 0, 1 );
    _id_14119( var_0, 1, 0 );
}

_id_1410A( var_0, var_1, var_2, var_3 )
{
    if ( var_0.stack_patch_thread_root[var_1] )
        return;

    if ( !isdefined( var_0.is_trials_level ) )
        var_0.is_trials_level = [];

    var_4 = _id_1410E();
    var_5 = var_0.ent[var_1].vehiclename;
    var_6 = var_0.ent[var_2].vehiclename;
    var_7 = _id_1410F( var_5, 0, 1 );
    var_8 = _id_1410F( var_6, 0, 1 );
    var_9 = istrue( var_0.unset_relic_nuketimer[var_1] );
    var_10 = istrue( var_0.unset_relic_nuketimer[var_2] );
    var_11 = var_0.armorbox_usedcallback[var_1];
    var_12 = var_0.armorbox_usedcallback[var_2];
    var_13 = undefined;

    if ( var_9 && var_4.spawn_para_and_heli_logic && var_4.spawn_new_ents >= 0 )
        var_13 = var_4.spawn_new_ents;
    else if ( var_10 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_1 >= 0 )
        var_13 = var_4.spawn_module_lmg_1;
    else
    {
        var_13 = var_8.challengeevaluator;

        if ( isdefined( var_4.challengeevaluator[var_5] ) && isdefined( var_4.challengeevaluator[var_5][var_6] ) )
            var_13 = var_4.challengeevaluator[var_5][var_6];
    }

    var_14 = undefined;

    if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_c >= 0 )
        var_14 = var_4.spawn_module_p3_form_c;
    else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_soldiers_01 >= 0 )
        var_14 = var_4.spawn_overwatch_soldiers_01;
    else
    {
        var_14 = var_7.keycardlocs_chosen;

        if ( isdefined( var_4.keycardlocs_chosen[var_5] ) && isdefined( var_4.keycardlocs_chosen[var_5][var_6] ) )
            var_14 = var_4.keycardlocs_chosen[var_5][var_6];
    }

    var_15 = var_0.ent[var_1];
    var_16 = var_0.ent[var_2];

    if ( isdefined( var_16._id_11E06 ) )
        var_13 = var_13 * var_16._id_11E06;

    if ( isdefined( var_15._id_11E07 ) )
        var_14 = var_14 * var_15._id_11E07;

    var_0.is_trials_level[var_1] = var_12 / ( var_11 + var_12 ) * var_0._id_12B4D * var_13 * var_14;
}

_id_1410B( var_0, var_1, var_2 )
{
    if ( var_0.stack_patch_thread_root[var_1] )
        return;

    var_3 = var_0.is_trials_level[var_1];

    if ( !isdefined( var_0.isairlockdoor ) )
    {
        var_0.isairlockdoor = [];
        var_0._id_133C1 = [];
    }

    if ( var_3 > 0 )
    {
        var_4 = _id_1410E();
        var_5 = var_0.ent[var_1].vehiclename;
        var_6 = var_0.ent[var_2].vehiclename;
        var_7 = _id_1410F( var_5, 0, 1 );
        var_8 = _id_1410F( var_6, 0, 1 );
        var_9 = istrue( var_0.unset_relic_nuketimer[var_1] );
        var_10 = istrue( var_0.unset_relic_nuketimer[var_2] );
        var_11 = undefined;

        if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_2 >= 0 )
            var_11 = var_4.spawn_module_lmg_2;
        else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_obit_model >= 0 )
            var_11 = var_4.spawn_obit_model;
        else
        {
            var_11 = var_7.is_two_hit_melee_weapon;

            if ( isdefined( var_4.is_two_hit_melee_weapon[var_6] ) && isdefined( var_4.is_two_hit_melee_weapon[var_6][var_5] ) )
                var_11 = var_4.is_two_hit_melee_weapon[var_6][var_5];
        }

        if ( var_11 > 0 && var_3 >= var_11 )
        {
            var_0.isairlockdoor[var_1] = 0;

            if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_5 >= 0 )
                var_0.isairlockdoor[var_1] = var_4.spawn_module_lmg_5;
            else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_origin >= 0 )
                var_0.isairlockdoor[var_1] = var_4.spawn_origin;
            else
            {
                var_0.isairlockdoor[var_1] = var_7.isakimbo;

                if ( isdefined( var_4.isakimbo[var_6] ) && isdefined( var_4.isakimbo[var_6][var_5] ) )
                    var_0.isairlockdoor[var_1] = var_4.isakimbo[var_6][var_5];
            }

            if ( var_0.isairlockdoor[var_1] > 0 )
            {
                if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_soldiers1 >= 0 )
                    var_0._id_133C1[var_1] = var_4.spawn_module_soldiers1 > 0;
                else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_paratrooper_ac130 >= 0 )
                    var_0._id_133C1[var_1] = var_4.spawn_paratrooper_ac130 > 0;
                else
                {
                    var_0._id_133C1[var_1] = var_7._id_133C4;

                    if ( isdefined( var_4._id_133C4[var_6] ) && isdefined( var_4._id_133C4[var_6][var_5] ) )
                        var_0._id_133C1[var_1] = var_4._id_133C4[var_6][var_5];
                }

                return;
            }
        }

        var_11 = undefined;

        if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_4 >= 0 )
            var_11 = var_4.spawn_module_lmg_4;
        else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_objective >= 0 )
            var_11 = var_4.spawn_objective;
        else
        {
            var_11 = var_7.is_valid_station_name;

            if ( isdefined( var_4.is_valid_station_name[var_6] ) && isdefined( var_4.is_valid_station_name[var_6][var_5] ) )
                var_11 = var_4.is_valid_station_name[var_6][var_5];
        }

        if ( var_11 > 0 && var_3 >= var_11 )
        {
            var_0.isairlockdoor[var_1] = 0;

            if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_b >= 0 )
                var_0.isairlockdoor[var_1] = var_4.spawn_module_p3_form_b;
            else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_final_tank >= 0 )
                var_0.isairlockdoor[var_1] = var_4.spawn_overwatch_final_tank;
            else
            {
                var_0.isairlockdoor[var_1] = var_7.isallowedweapon;

                if ( isdefined( var_4.isallowedweapon[var_6] ) && isdefined( var_4.isallowedweapon[var_6][var_5] ) )
                    var_12 = var_4.isallowedweapon[var_6][var_5];
            }

            if ( var_0.isairlockdoor[var_1] > 0 )
            {
                if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_new_digits >= 0 )
                    var_0._id_133C1[var_1] = var_4.spawn_new_digits > 0;
                else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_pavelow_boss >= 0 )
                    var_0._id_133C1[var_1] = var_4.spawn_pavelow_boss > 0;
                else
                {
                    var_0._id_133C1[var_1] = var_7._id_133C6;

                    if ( isdefined( var_4._id_133C6[var_6] ) && isdefined( var_4._id_133C6[var_6][var_5] ) )
                        var_0._id_133C1[var_1] = var_4._id_133C6[var_6][var_5];
                }

                return;
            }
        }

        var_11 = undefined;

        if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_lmg_3 >= 0 )
            var_11 = var_4.spawn_module_lmg_3;
        else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_obit_struct >= 0 )
            var_11 = var_4.spawn_obit_struct;
        else
        {
            var_11 = var_7.is_using_stealth_debug;

            if ( isdefined( var_4.is_using_stealth_debug[var_6] ) && isdefined( var_4.is_using_stealth_debug[var_6][var_5] ) )
                var_11 = var_4.is_using_stealth_debug[var_6][var_5];

            if ( var_11 > 0 && var_3 >= var_11 )
            {
                var_0.isairlockdoor[var_1] = 0;

                if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_p3_form_a >= 0 )
                    var_0.isairlockdoor[var_1] = var_4.spawn_module_p3_form_a;
                else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_overwatch_extra_atvs >= 0 )
                    var_0.isairlockdoor[var_1] = var_4.spawn_overwatch_extra_atvs;
                else
                {
                    var_0.isairlockdoor[var_1] = var_7.isakimbomeleeweapon;

                    if ( isdefined( var_4.isakimbomeleeweapon[var_6] ) && isdefined( var_4.isakimbomeleeweapon[var_6][var_5] ) )
                        var_13 = var_4.isakimbomeleeweapon[var_6][var_5];
                }

                if ( var_0.isairlockdoor[var_1] > 0 )
                {
                    if ( var_9 && var_4.spawn_module_p3_form_d && var_4.spawn_module_trickle >= 0 )
                        var_0._id_133C1[var_1] = var_4.spawn_module_trickle > 0;
                    else if ( var_10 && var_4.spawn_para_and_heli_logic && var_4.spawn_parking_guys >= 0 )
                        var_0._id_133C1[var_1] = var_4.spawn_parking_guys > 0;
                    else
                    {
                        var_0._id_133C1[var_1] = var_7._id_133C5;

                        if ( isdefined( var_4._id_133C5[var_6] ) && isdefined( var_4._id_133C5[var_6][var_5] ) )
                            var_0._id_133C5[var_1] = var_4._id_133C5[var_6][var_5];
                    }

                    return;
                }
            }
        }
    }

    var_0.isairlockdoor[var_1] = 0;
    var_0._id_133C1[var_1] = 0;
}

_id_14119( var_0, var_1, var_2 )
{
    if ( var_0.stack_patch_thread_root[var_1] )
        return;

    if ( var_0.isairlockdoor[var_1] <= 0 )
        return;

    var_3 = var_0.ent[var_1];
    var_4 = var_0.ent[var_2];

    if ( getdvarint( "PNPLTTTNN", 0 ) && var_3 _meth_87DC() )
        return;

    var_5 = var_3.maxhealth * var_0.isairlockdoor[var_1] / 100;
    var_6 = var_0.ent[var_1].health;

    if ( var_0._id_133C1[var_1] )
        var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143( 1 );

    if ( isdefined( var_3 ) && isdefined( var_4 ) )
        var_3 dodamage( var_5, var_0.position[var_1], undefined, var_4, "MOD_CRUSH", var_4.objweapon );

    if ( isdefined( var_3 ) )
    {
        if ( var_0._id_133C1[var_1] )
            var_3 scripts\cp_mp\vehicles\vehicle_damage::_id_14143( 0 );

        if ( var_3.health < var_6 )
            thread _id_14113( var_3, var_4, 1.5 );
    }
}

_id_14113( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0._id_14100 ) )
        var_0._id_14100 = [];

    var_3 = var_1 getentitynumber();
    var_0._id_14100[var_3] = var_1;
    wait( var_2 );

    if ( isdefined( var_0 ) && isdefined( var_0._id_14100 ) )
    {
        var_0._id_14100[var_3] = undefined;

        if ( var_0._id_14100.size == 0 )
            var_0._id_14100 = undefined;
    }
}

_id_1410D( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0.stack_patch_thread_root ) )
        var_0.stack_patch_thread_root = [];

    if ( var_0._id_12B4D < 100 )
    {
        var_0.stack_patch_thread_root[var_1] = 1;
        return;
    }

    var_3 = var_0.ent[var_1];

    if ( isdefined( var_3._id_14100 ) && isdefined( var_0.ent[var_2] ) && isdefined( var_3._id_14100[var_0.ent[var_2] getentitynumber()] ) )
    {
        var_0.stack_patch_thread_root[var_1] = 1;
        return;
    }

    var_0.stack_patch_thread_root[var_1] = 0;
}

_id_14108()
{
    _id_14109();
}

_id_14109()
{
    var_0 = _id_1410E();
    var_0._id_11E02 = getdvarint( "scr_vehColDisableMulti", 0 ) > 0;
    var_0._id_11E01 = getdvarint( "scr_vehColDebugMulti", 0 ) > 0;
    var_0.spawn_module_p3_form_d = getdvarint( "scr_vehColHost", 0 ) > 0;
    var_0.spawn_module_lmg_1 = getdvarfloat( "scr_vehColHost_attackFactorMod", -1 );
    var_0.spawn_module_p3_form_c = getdvarfloat( "scr_vehColHost_defenseFactorMod", -1 );
    var_0.spawn_module_lmg_3 = getdvarint( "scr_vehColHost_damageFactorLow", -1 );
    var_0.spawn_module_lmg_4 = getdvarint( "scr_vehColHost_damageFactorMedium", -1 );
    var_0.spawn_module_lmg_2 = getdvarint( "scr_vehColHost_damageFactorHigh", -1 );
    var_0.spawn_module_p3_form_a = getdvarint( "scr_vehColHost_damagePercentLow", -1 );
    var_0.spawn_module_p3_form_b = getdvarint( "scr_vehColHost_damagePercentMedium", -1 );
    var_0.spawn_module_lmg_5 = getdvarint( "scr_vehColHost_damagePercentHigh", -1 );
    var_0.spawn_module_trickle = getdvarint( "scr_vehColHost_skipBurnDownLow", -1 );
    var_0.spawn_new_digits = getdvarint( "scr_vehColHost_skipBurnDownMedium", -1 );
    var_0.spawn_module_soldiers1 = getdvarint( "scr_vehColHost_skipBurnDownHigh", -1 );
    var_0.spawn_para_and_heli_logic = getdvarint( "scr_vehColHostVictim", 0 ) > 0;
    var_0.spawn_new_ents = getdvarfloat( "scr_vehColHostVictim_attackFactorMod", -1 );
    var_0.spawn_overwatch_soldiers_01 = getdvarfloat( "scr_vehColHostVictim_defenseFactorMod", -1 );
    var_0.spawn_obit_struct = getdvarint( "scr_vehColHostVictim_damageFactorLow", -1 );
    var_0.spawn_objective = getdvarint( "scr_vehColHostVictim_damageFactorMedium", -1 );
    var_0.spawn_obit_model = getdvarint( "scr_vehColHostVictim_damageFactorHigh", -1 );
    var_0.spawn_overwatch_extra_atvs = getdvarint( "scr_vehColHostVictim_damagePercentLow", -1 );
    var_0.spawn_overwatch_final_tank = getdvarint( "scr_vehColHostVictim_damagePercentMedium", -1 );
    var_0.spawn_origin = getdvarint( "scr_vehColHostVictim_damagePercentHigh", -1 );
    var_0.spawn_parking_guys = getdvarint( "scr_vehColHostVictim_skipBurnDownLow", -1 );
    var_0.spawn_pavelow_boss = getdvarint( "scr_vehColHostVictim_skipBurnDownMedium", -1 );
    var_0.spawn_paratrooper_ac130 = getdvarint( "scr_vehColHostVictim_skipBurnDownHigh", -1 );
}

_id_14115()
{
    var_0 = _id_1410E();
    var_1 = spawnstruct();
    var_0.challengeevaluator = [];
    var_0.keycardlocs_chosen = [];
    var_0.is_using_stealth_debug = [];
    var_0.is_valid_station_name = [];
    var_0.is_two_hit_melee_weapon = [];
    var_0.isakimbomeleeweapon = [];
    var_0.isallowedweapon = [];
    var_0.isakimbo = [];
    var_0._id_133C5 = [];
    var_0._id_133C6 = [];
    var_0._id_133C4 = [];
    var_2 = [];
    var_3 = [];
    var_3["attackFactorMod"] = [];
    var_3["defenseFactorMod"] = [];
    var_3["damageFactorLow"] = [];
    var_3["damageFactorMedium"] = [];
    var_3["damageFactorHigh"] = [];
    var_3["damagePercentLow"] = [];
    var_3["damagePercentMedium"] = [];
    var_3["damagePercentHigh"] = [];
    var_3["skipBurnDownLow"] = [];
    var_3["skipBurnDownMedium"] = [];
    var_3["skipBurnDownHigh"] = [];
    var_4 = tablelookupgetnumcols( "mp_cp/vehicleCollisionTable.csv" );

    for ( var_5 = 1; var_5 < var_4; var_5++ )
    {
        var_6 = tablelookupbyrow( "mp_cp/vehicleCollisionTable.csv", 0, var_5 );

        if ( isdefined( var_6 ) && var_6 != "" )
        {
            if ( getsubstr( var_6, 0, 1 ) != "*" )
                var_2[var_6] = var_5;
        }
    }

    var_7 = undefined;
    var_8 = 0;
    var_9 = tablelookupgetnumrows( "mp_cp/vehicleCollisionTable.csv" );

    for ( var_8 = 0; var_8 < var_9; var_8++ )
    {
        var_10 = tablelookupbyrow( "mp_cp/vehicleCollisionTable.csv", var_8, 1 );

        if ( isdefined( var_10 ) && var_10 != "" )
        {
            if ( getsubstr( var_10, 0, 1 ) == "*" )
            {
                var_7 = getsubstr( var_10, 1, var_10.size );
                continue;
            }

            if ( isdefined( var_3[var_7] ) )
                var_3[var_7][var_10] = var_8;
        }
    }

    foreach ( var_7, var_12 in var_3 )
    {
        foreach ( var_10, var_14 in var_12 )
        {
            foreach ( var_6, var_16 in var_2 )
            {
                var_17 = tablelookup( "mp_cp/vehicleCollisionTable.csv", 0, var_14, var_16 );

                if ( isdefined( var_17 ) && var_17 != "" )
                    _id_14116( var_17, var_10, var_7, var_6 );
            }
        }
    }
}

_id_14116( var_0, var_1, var_2, var_3 )
{
    var_4 = _id_1410E();

    if ( var_2 == "attackFactorMod" )
    {
        var_5 = float( var_0 );

        if ( !isdefined( var_4.challengeevaluator[var_1] ) )
            var_4.challengeevaluator[var_1] = [];

        var_4.challengeevaluator[var_1][var_3] = var_5;
    }
    else if ( var_2 == "defenseFactorMod" )
    {
        var_5 = float( var_0 );

        if ( !isdefined( var_4.keycardlocs_chosen[var_1] ) )
            var_4.keycardlocs_chosen[var_1] = [];

        var_4.keycardlocs_chosen[var_1][var_3] = var_5;
    }
    else if ( var_2 == "damageFactorLow" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4.is_using_stealth_debug[var_1] ) )
            var_4.is_using_stealth_debug[var_1] = [];

        var_4.is_using_stealth_debug[var_1][var_3] = var_5;
    }
    else if ( var_2 == "damageFactorMedium" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4.is_valid_station_name[var_1] ) )
            var_4.is_valid_station_name[var_1] = [];

        var_4.is_valid_station_name[var_1][var_3] = var_5;
    }
    else if ( var_2 == "damageFactorHigh" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4.is_two_hit_melee_weapon[var_1] ) )
            var_4.is_two_hit_melee_weapon[var_1] = [];

        var_4.is_two_hit_melee_weapon[var_1][var_3] = var_5;
    }
    else if ( var_2 == "damagePercentLow" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4.isakimbomeleeweapon[var_1] ) )
            var_4.isakimbomeleeweapon[var_1] = [];

        var_4.isakimbomeleeweapon[var_1][var_3] = var_5;
    }
    else if ( var_2 == "damagePercentMedium" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4.isallowedweapon[var_1] ) )
            var_4.isallowedweapon[var_1] = [];

        var_4.isallowedweapon[var_1][var_3] = var_5;
    }
    else if ( var_2 == "damagePercentHigh" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4.isakimbo[var_1] ) )
            var_4.isakimbo[var_1] = [];

        var_4.isakimbo[var_1][var_3] = var_5;
    }
    else if ( var_2 == "skipBurnDownLow" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4._id_133C5[var_1] ) )
            var_4._id_133C5[var_1] = [];

        var_4._id_133C5[var_1][var_3] = var_5 > 0;
    }
    else if ( var_2 == "skipBurnDownMedium" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4._id_133C6[var_1] ) )
            var_4._id_133C6[var_1] = [];

        var_4._id_133C6[var_1][var_3] = var_5 > 0;
    }
    else if ( var_2 == "skipBurnDownHigh" )
    {
        var_5 = int( var_0 );

        if ( !isdefined( var_4._id_133C4[var_1] ) )
            var_4._id_133C4[var_1] = [];

        var_4._id_133C4[var_1][var_3] = var_5 > 0;
    }
}