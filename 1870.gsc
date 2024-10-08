// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

haslightarmor( var_0 )
{
    return getlightarmorvalue( var_0 ) > 0;
}

getlightarmorvalue( var_0 )
{
    if ( isdefined( var_0.lightarmorhp ) )
        return var_0.lightarmorhp;

    return 0;
}

setlightarmorvalue( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    if ( lightarmor_lightarmor_disabled( var_0 ) )
    {
        var_1 = 0;
        var_2 = 1;
    }

    var_4 = getlightarmorvalue( var_0 );

    if ( !var_2 && var_4 > var_1 )
        var_1 = var_4;

    if ( var_4 <= 0 && var_1 > 0 )
    {
        lightarmor_set( var_0, var_1, var_3 );
        return;
    }

    if ( var_4 > 0 && var_1 <= 0 )
    {
        lightarmor_unset( var_0 );
        return;
    }

    var_0.lightarmorhp = var_1;

    if ( isplayer( var_0 ) && var_4 <= var_1 && var_1 > 0 && var_3 == 1 )
        thread lightarmor_setfx( var_0 );

    if ( isplayer( var_0 ) )
        lightarmor_updatehud( var_0 );
}

init()
{
    level._effect["lightArmor_persistent"] = loadfx( "vfx/core/mp/core/vfx_uplink_carrier.vfx" );
}

lightarmor_set( var_0, var_1, var_2 )
{
    var_0 notify( "lightArmor_set" );
    var_0.lightarmorhp = var_1;
    lightarmor_updatehud( var_0 );
    thread lightarmor_monitordeath( var_0 );

    if ( isplayer( var_0 ) && var_2 == 1 )
        thread lightarmor_setfx( var_0 );
}

lightarmor_unset( var_0 )
{
    var_0 notify( "lightArmor_unset" );
    var_0.lightarmorhp = undefined;
    lightarmor_updatehud( var_0 );

    if ( isplayer( var_0 ) )
    {

    }

    var_0 notify( "remove_light_armor" );
}

lightarmor_modifydamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_11 = 0;
    var_12 = 0;
    var_13 = var_0.lightarmorhp;

    if ( !isdefined( var_10 ) )
        var_10 = 1;

    if ( !var_11 )
    {
        if ( var_4 == "MOD_FALLING" )
            var_11 = 1;
    }

    if ( !var_11 )
    {
        if ( isexplosivedamagemod( var_4 ) )
        {
            if ( isdefined( var_9 ) && isdefined( var_9.stuckenemyentity ) && var_9.stuckenemyentity == var_0 )
                var_11 = 1;
        }
    }

    if ( !var_11 )
    {
        if ( scripts\mp\utility\weapon::issuperdamagesource( var_5 ) )
            var_11 = 1;
    }

    if ( !var_11 )
    {
        var_12 = min( var_2 + var_3, var_0.lightarmorhp );
        var_13 = var_13 - ( var_2 + var_3 );

        if ( !var_10 )
            var_0.lightarmorhp = var_0.lightarmorhp - ( var_2 + var_3 );

        var_2 = 0;
        var_3 = 0;

        if ( var_13 <= 0 )
        {
            var_2 = abs( var_13 );
            var_3 = 0;

            if ( !var_10 )
                lightarmor_unset( var_0 );
        }
    }

    if ( !var_10 )
        lightarmor_updatehud( self );

    if ( var_12 > 0 && var_2 == 0 )
        var_2 = 1;

    return [ var_12, var_2, var_3 ];
}

lightarmor_lightarmor_disabled( var_0 )
{
    if ( var_0 scripts\mp\heavyarmor::hasheavyarmor() )
        return 1;

    return 0;
}

lightarmor_monitordeath( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "lightArmor_set" );
    var_0 endon( "lightArmor_unset" );
    var_0 waittill( "death" );
    thread lightarmor_unset( var_0 );
}

lightarmor_updatehud( var_0 )
{
    if ( !isplayer( var_0 ) )
        return;
}

lightarmor_setfx( var_0 )
{

}