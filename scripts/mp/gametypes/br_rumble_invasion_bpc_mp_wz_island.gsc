// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

initstructs()
{
    var_0 = ::_id_13933;
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 19661.2, 27606.6, 3937.12 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 19669.1, 38688.5, 1631.17 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 33343.7, 32240.2, 2935.71 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 27319, 39542, 2379.3 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 21092, 24714.8, 4508.01 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 28015.1, 19155.4, 2340.87 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 38648.1, 15971.6, 1946 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 29921.5, 15223.7, 1359.59 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 40029.8, 10033.1, 362.307 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 36438.2, 7536.39, 200.625 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 34979.3, 3428.87, 931.984 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 26331.4, 3291.42, 2048.84 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -2117.66, -18559.4, 2105.88 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 2994.03, -10818.7, 1928.96 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 11687.1, -9883.24, 2016.94 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 17306.7, -10333, 2343.36 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 23881.4, -18410.6, 3823.69 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 26294.3, -18295.6, 3783.68 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 4234.65, -20609.3, 2447.91 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 20059.5, -6437.28, 3953.87 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 9505.2, -14566.3, 1978.03 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( 1926.83, 28392.9, 2008.02 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -4145.42, 26557.9, 1343.12 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -10426.5, 25736, 2000.04 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -9948.43, 21111.2, 2004.12 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -5936.79, 20553.4, 1684.13 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -2116.68, 9111.3, 3779.1 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -9662.79, 7088.19, 1045.12 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -9914.37, 12785.7, 1992.21 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -6502.85, 16971.5, 1680.06 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -4303.66, 12956.9, 3020.36 ), undefined, undefined );
    [[ var_0 ]]( "brRumbleInv_bonus_point_crate_drops", ( -6250.98, -3486.26, 1414.2 ), undefined, undefined );
}

_id_13933( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.targetname = var_0;
    var_4.origin = var_1;
    var_4.angles = var_2;
    var_4.script_parameters = var_3;

    if ( isdefined( var_4.targetname ) )
    {
        if ( !isdefined( level.struct_class_names["targetname"][var_4.targetname] ) )
            level.struct_class_names["targetname"][var_4.targetname] = [];

        var_5 = level.struct_class_names["targetname"][var_4.targetname].size;
        level.struct_class_names["targetname"][var_4.targetname][var_5] = var_4;
    }
}
