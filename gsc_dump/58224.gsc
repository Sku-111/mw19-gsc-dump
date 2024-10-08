// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

friendlyfire_allowed()
{
    var_0 = spawnstruct();
    var_0._id_1393D = [];
    return var_0;
}

friendlystatusdirty( var_0, var_1 )
{
    var_3 = spawnstruct();
    var_3.target = var_1;
    var_3.friendly_hvi_vehicle_extra_riders_intro_scene = var_0;
    self._id_1393D = scripts\engine\utility::array_removeundefined( self._id_1393D );
    self._id_1393D[self._id_1393D.size] = var_3;
}

front_struct( var_0, var_1 )
{
    var_2 = 0;

    foreach ( var_5, var_4 in self._id_1393D )
    {
        if ( var_4.friendly_hvi_vehicle_extra_riders_intro_scene == var_0 )
        {
            if ( var_4.target == var_1 )
            {
                self._id_1393D[var_5] = undefined;
                return;
            }
        }
    }
}

from( var_0, var_1, var_2, var_3 )
{
    foreach ( var_6, var_5 in self._id_1393D )
    {
        if ( !isdefined( var_5.target ) )
            self._id_1393D[var_6] = undefined;
    }

    var_7 = self._id_1393D;

    if ( isdefined( var_3 ) )
    {
        foreach ( var_5 in var_7 )
            var_5.target [[ var_5.friendly_hvi_vehicle_extra_riders_intro_scene ]]( var_0, var_1, var_2, var_3 );
    }
    else if ( isdefined( var_2 ) )
    {
        foreach ( var_5 in var_7 )
            var_5.target [[ var_5.friendly_hvi_vehicle_extra_riders_intro_scene ]]( var_0, var_1, var_2 );
    }
    else if ( isdefined( var_1 ) )
    {
        foreach ( var_5 in var_7 )
            var_5.target [[ var_5.friendly_hvi_vehicle_extra_riders_intro_scene ]]( var_0, var_1 );
    }
    else if ( isdefined( var_0 ) )
    {
        foreach ( var_5 in var_7 )
            var_5.target [[ var_5.friendly_hvi_vehicle_extra_riders_intro_scene ]]( var_0 );
    }
    else
    {
        foreach ( var_5 in var_7 )
            var_5.target [[ var_5.friendly_hvi_vehicle_extra_riders_intro_scene ]]();
    }
}
