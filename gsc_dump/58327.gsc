// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_11D6A()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "motorcycle", "spawnCallback", ::_id_11D6E );
    _id_11D6B();
    _id_11D6C();
    scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback( "motorcycle", _calloutmarkerping_poolidisentity::_id_11D5D );
}

_id_11D6C()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "motorcycle", 1 );
    var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
}

_id_11D6B()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle( "motorcycle", 1 );
    var_0.frontextents = 45;
    var_0.backextents = 45;
    var_0.leftextents = 28;
    var_0.rightextents = 28;
    var_0.bottomextents = 15;
    var_0.distancetobottom = 30;
    var_0.loscheckoffset = ( 0, 0, 30 );
}

_id_11D6E( var_0, var_1 )
{
    var_2 = _calloutmarkerping_poolidisentity::_id_11D56( var_0, var_1 );

    if ( isdefined( var_2 ) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn() )
        var_2.ondeathrespawn = ::_id_11D6D;

    return var_2;
}

_id_11D6D()
{
    thread _id_11D6F();
}

_id_11D6F()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( self );
    var_1 = spawnstruct();
    scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata( var_0, var_1 );
    var_2 = spawnstruct();
    var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C( "motorcycle", var_1, var_2 );
}
