// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init_vehicles()
{
    scripts\engine\utility::create_func_ref( "fastrope_anim", ::fastrope_anim );
    scripts\engine\utility::create_func_ref( "vehicle_door_anim", ::matchdata_logweaponstat );
    scripts\common\vehicle::init_vehicles();
}

fastrope_anim( var_0, var_1, var_2 )
{
    var_0 dontinterpolate();
    var_0 scriptmodelclearanim();
    var_0 scriptmodelplayanimdeltamotionfrompos( getanimname( var_1 ), var_0.origin, var_0.angles, var_2 );
}

matchdata_logweaponstat( var_0, var_1 )
{
    if ( isdefined( var_0 ) )
        var_0 vehicleplayanim( var_1, 0 );
}

_id_1422B()
{
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_apc", ::_id_1310B );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_asierra", ::_id_1310C );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_blima", ::_id_1310D );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_decho_civ", ::_id_1310F );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_decho_police", ::_id_13110 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_decho_rebel", ::_id_13111 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_mkilo", ::_id_13112 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_mkilo23_ai_infil", ::_id_13113 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_skilo", ::_id_13116 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_techo", ::_id_13117 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_tromeo", ::_id_13118 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_umike", ::_id_13119 );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_vindia", ::_id_1311A );
    scripts\engine\utility::create_func_ref( "set_vehicle_anims_ralfa", ::_id_13115 );
    scripts\engine\utility::create_func_ref( "use_turret", ::_id_1405E );
}

#using_animtree("mp_vehicles_always_loaded");

_id_1310B( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_apc_org_unload_door_l;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[2].vehicle_getoutanim = %vh_apc_org_unload_door_r;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[4].vehicle_getoutanim = %vh_apc_org_unload_door_back;
    var_0[4].vehicle_getoutanim_clear = 0;
    return var_0;
}

_id_1310C( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_asierra_driver_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_asierra_driver_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_asierra_driver_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[1].vehicle_getoutanim = %vh_asierra_pass_exit_patrol;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim_combat = %vh_asierra_pass_exit_combat_idle;
    var_0[1].vehicle_getoutanim_combat_clear = 0;
    var_0[1].vehicle_getoutanim_combat_run = %vh_asierra_pass_exit_combat_run;
    var_0[1].vehicle_getoutanim_combat_run_clear = 0;
    var_0[7].vehicle_getoutanim = %vh_asierra_bed_exit_patrol;
    var_0[7].vehicle_getoutanim_clear = 0;
    var_0[7].vehicle_getoutanim_combat = %vh_asierra_bed_exit_combat_idle;
    var_0[7].vehicle_getoutanim_combat_clear = 0;
    var_0[7].vehicle_getoutanim_combat_run = %vh_asierra_bed_exit_combat_idle;
    var_0[7].vehicle_getoutanim_combat_run_clear = 0;
    return var_0;
}

_id_1310D( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        var_0[var_1].vehicle_getoutanim = %vh_blima_rappel_heli_drop;

    return var_0;
}

_id_13112( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_mkilo_driver_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_mkilo_driver_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_mkilo_driver_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[1].vehicle_getoutanim = %vh_mkilo_pass_exit_patrol;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim_combat = %vh_mkilo_pass_exit_combat_idle;
    var_0[1].vehicle_getoutanim_combat_clear = 0;
    var_0[1].vehicle_getoutanim_combat_run = %vh_mkilo_pass_exit_combat_run;
    var_0[1].vehicle_getoutanim_combat_run_clear = 0;
    return var_0;
}

_id_13113( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_mkilo_driver_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_mkilo_driver_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_mkilo_driver_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[1].vehicle_getoutanim = %vh_mkilo_pass_exit_patrol;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim_combat = %vh_mkilo_pass_exit_combat_idle;
    var_0[1].vehicle_getoutanim_combat_clear = 0;
    var_0[1].vehicle_getoutanim_combat_run = %vh_mkilo_pass_exit_combat_run;
    var_0[1].vehicle_getoutanim_combat_run_clear = 0;
    var_0[2].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[3].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[3].vehicle_getoutanim_clear = 0;
    var_0[4].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[4].vehicle_getoutanim_clear = 0;
    var_0[5].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[5].vehicle_getoutanim_clear = 0;
    var_0[6].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[6].vehicle_getoutanim_clear = 0;
    var_0[7].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[7].vehicle_getoutanim_clear = 0;
    var_0[8].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[8].vehicle_getoutanim_clear = 0;
    var_0[9].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[9].vehicle_getoutanim_clear = 0;
    var_0[10].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[10].vehicle_getoutanim_clear = 0;
    var_0[11].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[11].vehicle_getoutanim_clear = 0;
    var_0[12].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[12].vehicle_getoutanim_clear = 0;
    var_0[13].vehicle_getoutanim = %vh_mp_mkilo23_backgate_exit;
    var_0[13].vehicle_getoutanim_clear = 0;
    return var_0;
}

_id_13116( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_skilo_driver_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_skilo_driver_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_skilo_driver_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[1].vehicle_getoutanim = %vh_skilo_passenger_exit_patrol;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim_combat = %vh_skilo_passenger_exit_combat_idle;
    var_0[1].vehicle_getoutanim_combat_clear = 0;
    var_0[1].vehicle_getoutanim_combat_run = %vh_skilo_passenger_exit_combat_run;
    var_0[1].vehicle_getoutanim_combat_run_clear = 0;
    var_0[2].vehicle_getoutanim = %vh_skilo_pass3_exit_patrol;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[2].vehicle_getoutanim_combat = %vh_skilo_pass3_exit_combat_idle;
    var_0[2].vehicle_getoutanim_combat_clear = 0;
    var_0[2].vehicle_getoutanim_combat_run = %vh_skilo_pass3_exit_combat_run;
    var_0[2].vehicle_getoutanim_combat_run_clear = 0;
    return var_0;
}

_id_13117( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_techo_driver_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_techo_driver_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_techo_driver_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[1].vehicle_getoutanim = %vh_techo_pass_exit_patrol;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim_combat = %vh_techo_pass_exit_combat_idle;
    var_0[1].vehicle_getoutanim_combat_clear = 0;
    var_0[1].vehicle_getoutanim_combat_run = %vh_techo_pass_exit_combat_run;
    var_0[1].vehicle_getoutanim_combat_run_clear = 0;
    var_0[2].vehicle_getoutanim = %vh_techo_cab2_exit_patrol;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[2].vehicle_getoutanim_combat = %vh_techo_cab2_exit_combat_idle;
    var_0[2].vehicle_getoutanim_combat_clear = 0;
    var_0[2].vehicle_getoutanim_combat_run = %vh_techo_cab2_exit_combat_run;
    var_0[2].vehicle_getoutanim_combat_run_clear = 0;
    var_0[3].vehicle_getoutanim = %vh_techo_cab1_exit_patrol;
    var_0[3].vehicle_getoutanim_clear = 0;
    var_0[3].vehicle_getoutanim_combat = %vh_techo_cab1_exit_combat_idle;
    var_0[3].vehicle_getoutanim_combat_clear = 0;
    var_0[3].vehicle_getoutanim_combat_run = %vh_techo_cab1_exit_combat_run;
    var_0[3].vehicle_getoutanim_combat_run_clear = 0;
    var_0[0].vehicle_getinanim = %reb_com_veh8_techo_fl_door_close;
    var_0[0].vehicle_getinanim_clear = 0;
    var_0[1].vehicle_getinanim = %reb_com_veh8_techo_fr_door_close;
    var_0[1].vehicle_getinanim_clear = 0;
    var_0[2].vehicle_getinanim = %reb_com_veh8_techo_bl_door_close;
    var_0[2].vehicle_getinanim_clear = 0;
    var_0[3].vehicle_getinanim = %reb_com_veh8_techo_br_door_close;
    var_0[3].vehicle_getinanim_clear = 0;
    return var_0;
}

_id_1310E( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_decho_driver_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_decho_driver_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_decho_driver_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[1].vehicle_getoutanim = %vh_decho_pass_exit_patrol;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim_combat = %vh_decho_pass_exit_combat_idle;
    var_0[1].vehicle_getoutanim_combat_clear = 0;
    var_0[1].vehicle_getoutanim_combat_run = %vh_decho_pass_exit_combat_run;
    var_0[1].vehicle_getoutanim_combat_run_clear = 0;
    return var_0;
}

_id_1310F( var_0 )
{
    _id_1310E( var_0 );
    var_0[2].vehicle_getoutanim = %vh_decho_civ_pass3_exit_patrol;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[2].vehicle_getoutanim_combat = %vh_decho_civ_pass3_exit_combat_idle;
    var_0[2].vehicle_getoutanim_combat_clear = 0;
    var_0[2].vehicle_getoutanim_combat_run = %vh_decho_civ_pass3_exit_combat_run;
    var_0[2].vehicle_getoutanim_combat_run_clear = 0;
    var_0[3].vehicle_getoutanim = %vh_decho_civ_pass4_exit_patrol;
    var_0[3].vehicle_getoutanim_clear = 0;
    var_0[3].vehicle_getoutanim_combat = %vh_decho_civ_pass4_exit_combat_idle;
    var_0[3].vehicle_getoutanim_combat_clear = 0;
    var_0[3].vehicle_getoutanim_combat_run = %vh_decho_civ_pass4_exit_combat_run;
    var_0[3].vehicle_getoutanim_combat_run_clear = 0;
    return var_0;
}

_id_13110( var_0 )
{
    _id_1310E( var_0 );
    var_0[2].vehicle_getoutanim = %vh_decho_police_trunk_exit_patrol;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[2].vehicle_getoutanim_combat = %vh_decho_police_trunk_exit_combat_idle;
    var_0[2].vehicle_getoutanim_combat_clear = 0;
    var_0[2].vehicle_getoutanim_combat_run = %vh_decho_police_trunk_exit_combat_run;
    var_0[2].vehicle_getoutanim_combat_run_clear = 0;
    var_0[3].vehicle_getoutanim = %vh_decho_trunk_exit_patrol;
    var_0[3].vehicle_getoutanim_clear = 0;
    var_0[3].vehicle_getoutanim_combat = %vh_decho_trunk_exit_combat_idle;
    var_0[3].vehicle_getoutanim_combat_clear = 0;
    var_0[3].vehicle_getoutanim_combat_run = %vh_decho_trunk_exit_combat_run;
    var_0[3].vehicle_getoutanim_combat_run_clear = 0;
    return var_0;
}

_id_13111( var_0 )
{
    _id_1310E( var_0 );
    var_0[2].vehicle_getoutanim = %vh_decho_cab1_exit_patrol;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[2].vehicle_getoutanim_combat = %vh_decho_cab1_exit_combat_idle;
    var_0[2].vehicle_getoutanim_combat_clear = 0;
    var_0[2].vehicle_getoutanim_combat_run = %vh_decho_cab1_exit_combat_run;
    var_0[2].vehicle_getoutanim_combat_run_clear = 0;
    var_0[3].vehicle_getoutanim = %vh_decho_cab2_exit_patrol;
    var_0[3].vehicle_getoutanim_clear = 0;
    var_0[3].vehicle_getoutanim_combat = %vh_decho_cab2_exit_combat_idle;
    var_0[3].vehicle_getoutanim_combat_clear = 0;
    var_0[3].vehicle_getoutanim_combat_run = %vh_decho_cab2_exit_combat_run;
    var_0[3].vehicle_getoutanim_combat_run_clear = 0;
    var_0[4].vehicle_getoutanim = %vh_decho_trunk_exit_patrol;
    var_0[4].vehicle_getoutanim_clear = 0;
    var_0[4].vehicle_getoutanim_combat = %vh_decho_trunk_exit_combat_idle;
    var_0[4].vehicle_getoutanim_combat_clear = 0;
    var_0[4].vehicle_getoutanim_combat_run = %vh_decho_trunk_exit_combat_run;
    var_0[4].vehicle_getoutanim_combat_run_clear = 0;
    return var_0;
}

_id_13118( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_tromeo_front_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_tromeo_front_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_tromeo_front_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[2].vehicle_getoutanim = %reb_com_veh8_techo_br_door_open;
    var_0[2].vehicle_getoutanim_clear = 0;
    var_0[3].vehicle_getoutanim = %reb_com_veh8_techo_bl_door_open;
    var_0[3].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getinanim = %reb_com_veh8_techo_fl_door_close;
    var_0[0].vehicle_getinanim_clear = 0;
    var_0[1].vehicle_getinanim = %reb_com_veh8_techo_fr_door_close;
    var_0[1].vehicle_getinanim_clear = 0;
    var_0[2].vehicle_getinanim = %reb_com_veh8_techo_br_door_close;
    var_0[2].vehicle_getinanim_clear = 0;
    var_0[3].vehicle_getinanim = %reb_com_veh8_techo_bl_door_close;
    var_0[3].vehicle_getinanim_clear = 0;
    return var_0;
}

_id_13119( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_umike_driver_exit_patrol;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getoutanim_combat = %vh_umike_driver_exit_combat_idle;
    var_0[0].vehicle_getoutanim_combat_clear = 0;
    var_0[0].vehicle_getoutanim_combat_run = %vh_umike_driver_exit_combat_run;
    var_0[0].vehicle_getoutanim_combat_run_clear = 0;
    var_0[1].vehicle_getoutanim = %vh_umike_passenger_exit_patrol;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim_combat = %vh_umike_passenger_exit_combat_idle;
    var_0[1].vehicle_getoutanim_combat_clear = 0;
    var_0[1].vehicle_getoutanim_combat_run = %vh_umike_passenger_exit_combat_run;
    var_0[1].vehicle_getoutanim_combat_run_clear = 0;
    var_0[2].vehicle_getoutanim = %vh_umike_bed_exit_combat_idle;
    var_0[2].vehicle_getoutanim_clear = 0;
    return var_0;
}

_id_1311A( var_0 )
{
    var_0[0].vehicle_getoutanim = %vh_vindia_back_door_exit_combat_idle;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[4].vehicle_getoutanim = %vh_vindia_left_door_exit_combat_idle;
    var_0[4].vehicle_getoutanim_clear = 0;
    var_0[5].vehicle_getoutanim = %vh_vindia_right_door_exit_combat_idle;
    var_0[5].vehicle_getoutanim_clear = 0;
    return var_0;
}

_id_13114( var_0 )
{
    var_0[0].vehicle_getoutanim = %reb_com_veh8_decho_fl_door_open;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim = %reb_com_veh8_decho_fr_door_open;
    var_0[1].vehicle_getoutanim_clear = 0;
    return var_0;
}

_id_13115( var_0 )
{
    var_0[0].vehicle_getoutanim = %reb_com_veh8_techo_fl_door_open;
    var_0[0].vehicle_getoutanim_clear = 0;
    var_0[1].vehicle_getoutanim = %reb_com_veh8_techo_fr_door_open;
    var_0[1].vehicle_getoutanim_clear = 0;
    var_0[0].vehicle_getinanim = %reb_com_veh8_techo_fl_door_close;
    var_0[0].vehicle_getinanim_clear = 0;
    var_0[1].vehicle_getinanim = %reb_com_veh8_techo_fr_door_close;
    var_0[1].vehicle_getinanim_clear = 0;
    return var_0;
}

_id_1405E( var_0, var_1 )
{
    scripts\asm\asm_bb::bb_requestturret( var_0 );
    scripts\asm\asm_bb::bb_requestturretpose( var_1 );
    var_3 = var_0 gettagorigin( "tag_gunner" );
    var_4 = var_0 gettagangles( "tag_gunner" );

    if ( self islinked() )
        self unlink();

    self forceteleport( var_3, var_4 );
    self linktoblendtotag( var_0, "tag_gunner", 0 );
}
