// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

get_last_stand_id()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "cargo_truck_mg", "spawnCallback", ::get_length_from_table );
    cargo_truck_mp_initmines();
    cargo_truck_mp_initspawning();
    scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback( "cargo_truck_mg", _calloutmarkerping_isdropcrate::get_gunshot_alias );
}

cargo_truck_mp_initspawning()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "cargo_truck_mg", 1 );
    var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

cargo_truck_mp_initmines()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle( "cargo_truck_mg", 1 );
    var_0.frontextents = 165;
    var_0.backextents = 168;
    var_0.leftextents = 57;
    var_0.rightextents = 57;
    var_0.bottomextents = 35;
    var_0.distancetobottom = 50;
    var_0.loscheckoffset = ( 0, 0, 70 );
}

get_length_from_table( var_0, var_1 )
{
    var_2 = _calloutmarkerping_isdropcrate::get_friendly_convoy_vehicle( var_0, var_1 );

    if ( isdefined( var_2 ) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn() )
        var_2.ondeathrespawn = ::get_least_used_node_close_to_pos;

    return var_2;
}

get_least_used_node_close_to_pos()
{
    thread cargo_truck_mp_waitandspawn();
}

cargo_truck_mp_waitandspawn()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( self );
    var_1 = spawnstruct();
    scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata( var_0, var_1 );
    var_2 = spawnstruct();
    var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C( "cargo_truck_mg", var_1, var_2 );
}
