// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

get_mine_ignore_list()
{
    var_0 = [ self ];

    if ( isdefined( level.dynamicladders ) )
    {
        foreach ( var_2 in level.dynamicladders )
            var_0[var_0.size] = var_2.ents[0];
    }

    var_4 = self getlinkedchildren( 1 );

    if ( !isdefined( var_4 ) )
        var_4 = [];

    var_4[var_4.size] = self getlinkedparent();

    foreach ( var_6 in var_4 )
    {
        if ( isdefined( var_6 ) && var_6.classname == "grenade" )
            var_0[var_0.size] = var_6;
    }

    return var_0;
}

get_sticky_grenade_destination( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 endon( "death" );

    if ( !isdefined( var_5 ) )
        var_5 = spawnstruct();

    if ( !isdefined( var_5.contents ) )
        var_5.contents = get_grenade_cast_contents();

    if ( !isdefined( var_5.divisions ) )
        var_5.divisions = 5;

    if ( !isdefined( var_5.amortize ) )
        var_5.amortize = 1;

    if ( !isdefined( var_5.ignorelist ) )
        var_5.ignorelist = [ var_0, var_0.owner ];

    if ( !isdefined( var_5.ignorclutter ) )
        var_5.ignoreclutter = 1;

    if ( !isdefined( var_4 ) )
        var_4 = 10;

    if ( !isdefined( var_5.maxtime ) )
        var_5.maxtime = var_4 - var_4 * var_0.tickpercent;

    var_6 = var_5.maxtime / var_5.divisions;
    var_7[0] = 0;
    var_8[0] = var_0.origin;
    var_9 = var_5.divisions;
    var_10 = anglestoforward( var_1 );
    var_11 = ( 0, 0, 1 );
    var_12 = var_10 * var_2 + var_11 * var_3;
    var_13 = var_11 * vectordot( var_11, var_12 );
    var_14 = var_12 - var_13;

    for ( var_15 = 1; var_15 < var_5.divisions; var_15++ )
    {
        var_16 = var_7[var_15 - 1];
        var_17 = var_8[var_15 - 1];
        var_18 = var_15 * var_6;
        var_19 = var_14 * var_18;
        var_20 = var_13 * var_18 + ( 0, 0, -400 ) * var_18 * var_18;
        var_21 = var_8[0] + var_19 + var_20;
        var_7[var_15] = var_18;
        var_8[var_15] = var_21;
        var_22 = physics_raycast( var_17, var_21, var_5.contents, var_5.ignorelist, 1, "physicsquery_closest", var_5.ignoreclutter );

        if ( isdefined( var_22 ) && var_22.size > 0 )
        {
            var_5.destination = var_22[0]["position"];
            var_5.destinationnormal = var_22[0]["normal"];
            var_5.destinationentity = var_22[0]["entity"];
            var_5.destinationhit = 1;
            var_23 = var_21 - var_17;
            var_24 = length( var_23 );
            var_25 = var_23 / var_24;
            var_26 = var_17 - var_5.destination;
            var_27 = vectordot( var_25, var_26 );
            var_28 = clamp( var_27 / var_24, 0, 1 );
            var_5.destinationtime = var_16 + var_6 * var_28;
            break;
        }
        else if ( var_15 == var_5.divisions - 1 )
        {
            var_5.destination = var_21;
            break;
        }

        if ( var_5.amortize )
            waitframe();
    }

    return var_5;
}

get_grenade_cast_contents( var_0 )
{
    var_1 = undefined;

    if ( istrue( var_0 ) )
        var_1 = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_player" ] );
    else
        var_1 = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky" ] );

    return var_1;
}

plant( var_0, var_1 )
{
    self endon( "death_or_disconnect" );
    var_0 endon( "death" );
    var_0.releasegrenadeorigin = var_0.origin;
    var_0.releaseownerorigin = self.origin;
    var_0.releaseownereye = self geteye();
    var_0.releaseownerangles = self getgunangles();

    if ( !isdefined( var_1.plantmaxtime ) )
        var_1.plantmaxtime = 0.5;

    if ( !isdefined( var_1.plantmaxroll ) )
        var_1.plantmaxroll = 0;

    if ( !isdefined( var_1.plantmindistbeloweye ) )
        var_1.plantmindistbeloweye = 12;

    if ( !isdefined( var_1.plantmaxdistbelowownerfeet ) )
        var_1.plantmaxdistbelowownerfeet = 20;

    if ( !isdefined( var_1.plantmindisteyetofeet ) )
        var_1.plantmindisteyetofeet = 45;

    if ( !isdefined( var_1.plantnormalcos ) )
        var_1.plantnormalcos = 0.342;

    if ( !isdefined( var_1.plantoffsetz ) )
        var_1.plantoffsetz = 1;

    plant_watch_stuck( var_0, var_1 );
    var_2 = 0;
    var_3 = var_1.notifyorigin;
    var_4 = var_1.notifynormal;
    var_5 = var_1.notifyentity;
    var_6 = var_1.notifyhit;
    var_7 = undefined;

    if ( !istrue( var_6 ) )
    {
        var_3 = var_1.calcorigin;
        var_4 = var_1.calcnormal;
        var_5 = var_1.calcentity;
        var_6 = var_1.calchit;

        if ( istrue( var_6 ) && isdefined( var_5 ) && var_5 getnonstick() )
            var_6 = undefined;

        var_8 = get_grenade_cast_contents( 0 );
        var_9 = [ var_0 ];
        var_10 = self geteye() - ( 0, 0, 30 );
        var_11 = var_10 + anglestoforward( self getplayerangles( 1 ) ) * 20;
        var_12 = physics_raycast( var_10, var_11, var_8, var_9, 0, "physicsquery_closest", 1 );

        if ( isdefined( var_12 ) && var_12.size > 0 )
            var_6 = 0;
    }
    else
        var_7 = plant_clamp_angles( var_0.angles, var_1 );

    if ( istrue( var_6 ) )
    {
        if ( isdefined( var_4 ) && vectordot( var_4, ( 0, 0, 1 ) ) < var_1.plantnormalcos )
            var_2 = 1;
        else
        {
            var_13 = vectordot( var_0.releaseownerorigin - var_3, ( 0, 0, 1 ) );

            if ( var_13 > 0 )
            {
                if ( var_13 > var_1.plantmaxdistbelowownerfeet )
                    var_2 = 1;
            }
            else
            {
                var_14 = vectordot( var_0.releaseownereye - var_0.releaseownerorigin, ( 0, 0, 1 ) );

                if ( var_14 > var_1.plantmindisteyetofeet )
                {
                    var_15 = vectordot( var_0.releaseownereye - var_3, ( 0, 0, 1 ) );

                    if ( var_15 >= 0 )
                    {
                        if ( var_15 < var_1.plantmindistbeloweye )
                            var_2 = 1;
                    }
                    else
                        var_2 = 1;
                }
            }
        }
    }
    else
        var_2 = 1;

    if ( var_2 )
    {
        var_8 = var_1.castcontents;

        if ( !isdefined( var_8 ) )
            var_8 = get_grenade_cast_contents();

        var_9 = [ var_0 ];
        var_10 = var_0.releaseownerorigin + ( 0, 0, 1 );
        var_11 = var_10 + ( 0, 0, -1 * var_1.plantmaxdistbelowownerfeet );
        var_12 = physics_raycast( var_10, var_11, var_8, var_9, 1, "physicsquery_closest", 1 );

        if ( isdefined( var_12 ) && var_12.size > 0 )
        {
            var_3 = var_12[0]["position"];
            var_4 = var_12[0]["normal"];

            if ( isdefined( var_4 ) && vectordot( var_4, ( 0, 0, 1 ) ) < var_1.plantnormalcos )
                return 0;

            var_16 = var_0.releaseownerangles * ( 0, 1, 0 );

            if ( isdefined( var_4 ) )
            {
                var_7 = scripts\mp\utility\script::vectortoanglessafe( anglestoforward( var_16 ), var_4 );
                var_7 = plant_clamp_angles( var_7, var_1 );
            }
            else
                var_7 = var_16;

            var_3 = var_3 + anglestoup( var_7 ) * var_1.plantoffsetz;
            var_5 = var_12[0]["entity"];
            var_0 dontinterpolate();
            var_0.origin = var_3;
            var_0.angles = var_7;
        }
        else
            return 0;
    }
    else
    {
        if ( !isdefined( var_7 ) )
        {
            var_16 = var_0.releaseownerangles * ( 0, 1, 0 );

            if ( isdefined( var_4 ) )
            {
                var_7 = scripts\mp\utility\script::vectortoanglessafe( anglestoforward( var_16 ), var_4 );
                var_7 = plant_clamp_angles( var_7, var_1 );
            }
            else
                var_7 = var_16;
        }

        var_3 = var_3 + anglestoup( var_7 ) * var_1.plantoffsetz;
        var_0 dontinterpolate();
        var_0.origin = var_3;
        var_0.angles = var_7;
    }

    if ( isdefined( var_5 ) )
        var_0 linkto( var_5 );

    return 1;
}

plant_watch_stuck( var_0, var_1 )
{
    childthread plant_watch_stuck_notify( var_0, var_1 );
    childthread plant_watch_stuck_calculate( var_0, var_1 );
    childthread plant_watch_stuck_timeout( var_0, var_1 );
    var_1 waittill( "start_race" );
    waittillframeend;
    var_1 notify( "end_race" );
    return var_1;
}

plant_watch_stuck_notify( var_0, var_1 )
{
    var_1 endon( "end_race" );
    var_0 waittill( "missile_stuck", var_2 );
    var_1.notifyorigin = var_0.origin;
    var_1.notifyangles = var_0.angles;
    var_1.notifyentity = var_2;
    var_1.notifyhit = 1;
    var_1 notify( "start_race" );
}

plant_watch_stuck_calculate( var_0, var_1 )
{
    var_1 endon( "end_race" );
    var_1 = get_sticky_grenade_destination( var_0, var_0.releaseownerangles, var_1.throwspeedforward, var_1.throwspeedup, var_1.castmaxtime, var_1 );
    var_1.calcorigin = var_1.destination;
    var_1.calcnormal = var_1.destinationnormal;
    var_1.calcentity = var_1.destinationentity;
    var_1.calchit = var_1.destinationhit;
    var_1 notify( "start_race" );
}

plant_watch_stuck_timeout( var_0, var_1 )
{
    var_1 endon( "end_race" );
    wait( var_1.plantmaxtime );
    var_1 notify( "start_race" );
}

plant_clamp_angles( var_0, var_1 )
{
    var_2 = 0;
    var_3 = var_0[1];
    var_4 = scripts\engine\utility::ter_op( var_1.plantmaxroll != 0, var_0[2], 0 );

    if ( var_4 != 0 )
    {
        if ( var_4 > 0 )
            var_4 = clamp( var_0[2], 0, var_1.plantmaxroll );
        else
            var_4 = clamp( var_0[2], -1 * var_1.plantmaxroll, 0 );
    }

    return ( var_2, var_3, var_4 );
}

_id_14444()
{
    var_0 = self.origin;

    for (;;)
    {
        self waittill( "touching_platform", var_1 );

        if ( isdefined( var_1 ) && self istouching( var_1 ) && self.origin[2] - var_0[2] > 12 )
        {
            self notify( "collision_with_platform" );
            return;
        }
    }
}