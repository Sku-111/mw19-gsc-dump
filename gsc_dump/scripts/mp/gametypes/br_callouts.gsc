// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.calloutglobals.calloutzones = getentarray( "location_volume", "targetname" );
    level.calloutglobals._id_11E29 = [];

    if ( !tableexists( level.calloutglobals.callouttable ) )
        return;

    var_0 = level.mapcorners[0].origin[0];
    var_1 = level.mapcorners[1].origin[0];
    var_2 = var_1 - var_0;
    var_3 = level.mapcorners[0].origin[1];
    var_4 = level.mapcorners[1].origin[1];
    var_5 = var_4 - var_3;
    var_6 = 0;

    for (;;)
    {
        var_7 = tablelookupbyrow( level.calloutglobals.callouttable, var_6, 5 );

        if ( !isdefined( var_7 ) || var_7 == "" )
            break;

        if ( var_7 != "1" )
        {

        }
        else
        {
            var_8 = tablelookupbyrow( level.calloutglobals.callouttable, var_6, 6 );
            var_8 = float( var_8 );
            var_8 = var_8 * var_2 + var_0;
            var_9 = tablelookupbyrow( level.calloutglobals.callouttable, var_6, 7 );
            var_9 = float( var_9 );
            var_9 = var_9 * var_5 + var_3;
            var_10 = tablelookupbyrow( level.calloutglobals.callouttable, var_6, 8 );
            var_10 = float( var_10 );
            var_11 = tablelookupbyrow( level.calloutglobals.callouttable, var_6, 1 );
            var_12 = spawnstruct();
            var_12.origin = ( var_8, var_9, 0 );
            var_12.radius = var_10;
            level.calloutglobals._id_11E29[var_11] = var_12;
        }

        var_6++;
    }
}

removeminigunrestrictions( var_0 )
{
    var_1 = "";

    foreach ( var_4, var_3 in level.calloutglobals._id_11E29 )
    {
        if ( distance2dsquared( var_0, var_3.origin ) <= var_3.radius * var_3.radius )
        {
            var_1 = var_4;
            break;
        }
    }

    return var_1;
}

removematchingents_bymodel( var_0 )
{
    var_1 = "none";
    var_2 = -1;
    var_3 = 144000000;

    if ( !isdefined( var_0.calloutarea ) || var_0.calloutarea == var_1 )
        return var_2;

    var_4 = var_0.origin;
    var_5 = 0;
    var_6 = var_2;
    var_7 = var_3;

    foreach ( var_11, var_9 in level.calloutglobals._id_11E29 )
    {
        var_10 = distance2dsquared( var_4, var_9.origin );

        if ( var_10 <= var_7 )
        {
            var_7 = var_10;
            var_6 = var_5;
        }

        var_5++;
    }

    return var_6;
}