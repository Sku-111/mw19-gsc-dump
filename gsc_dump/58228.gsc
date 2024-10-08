// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_124F5()
{
    var_0 = self getmovingplatformparent();

    if ( isdefined( var_0 ) )
    {
        if ( tugofwar_tank( var_0 ) )
            return 1;
    }

    return 0;
}

tugofwar_tank( var_0 )
{
    if ( isdefined( level._id_145F1 ) )
    {
        foreach ( var_2 in level._id_145F1._id_13C8D )
        {
            if ( var_2 == var_0 )
                return 1;
            else if ( isdefined( var_2.wz_tease ) && var_2.wz_tease == var_0 )
                return 1;
        }
    }
    else if ( isdefined( level._id_13CD3 ) && isdefined( level._id_13CD3.helis_assault2_check_size ) && isdefined( level._id_13CD3._id_11C70 ) )
    {
        if ( var_0 == level._id_13CD3._id_11C70 )
            return 1;

        foreach ( var_2 in level._id_13CD3.helis_assault2_check_size )
        {
            if ( var_2 == var_0 )
                return 1;
        }
    }

    return 0;
}

tryspawnweapons( var_0 )
{
    if ( isdefined( level._id_1394C ) )
    {
        foreach ( var_2 in level._id_1394C )
        {
            if ( isdefined( var_2 ) )
            {
                if ( var_2 == var_0 )
                    return 1;
                else if ( isdefined( var_2.get_depletion_delay ) && var_2.get_depletion_delay == var_0 )
                    return 1;
            }
        }
    }

    return 0;
}

trophy_tryreflectsnapshot( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isdefined( level._id_145F1 ) )
    {
        foreach ( var_2 in level._id_145F1._id_13C8D )
        {
            if ( var_2 == var_0 )
                return 1;
        }
    }

    return 0;
}

manageworldspawnedbolts( var_0 )
{
    if ( isdefined( level._id_145F1 ) )
    {
        if ( isdefined( var_0 ) && isdefined( var_0.tablet ) && istrue( var_0.tablet._id_11FF8 ) )
            level._id_145F1 notify( "train_dom_contract_complete", var_0 );
    }
}

c130airdrop_deleteatlifetime( var_0, var_1 )
{
    var_2 = 0;

    if ( var_0 > 5 )
        var_2 = 5;

    var_3 = 10;

    if ( isdefined( var_1 ) )
        var_3 = var_1;

    for ( var_4 = var_2; var_4 < var_0; var_4 = var_4 + var_3 )
    {
        if ( c130airdrop_createpathstruct( var_4 ) )
            return 1;
    }

    return 0;
}

c130airdrop_createpathstruct( var_0 )
{
    for ( var_1 = 0; var_1 < level._id_145F1.animents.size; var_1++ )
    {
        var_2 = level.scr_anim["br_cargo_train_anim"][level._id_145F1.animents[var_1].bullet][0];

        if ( !isdefined( var_2 ) )
            return;

        var_3 = getanimlength( var_2 );
        var_4 = level._id_145F1.animents[var_1] getanimtime( var_2 );
        var_5 = var_4 * var_3;

        if ( var_5 + var_0 > var_3 )
        {
            var_6 = var_5 + var_0 - var_3;
            var_7 = var_3 / var_6;
            var_8 = getanglesforanimtime( ( -9661, -9119, -299.007 ), ( 0, 0, 0 ), var_2, var_7 );
        }
        else
        {
            var_9 = var_5 + var_0;
            var_10 = var_9 / var_3;
            var_8 = getanglesforanimtime( ( -9661, -9119, -299.007 ), ( 0, 0, 0 ), var_2, var_10 );
        }

        if ( !isdefined( var_8 ) || !isvector( var_8 ) )
            return 0;

        if ( _id_127DA( var_8 ) )
            return 1;
    }

    return 0;
}

c130airdrop_createpath()
{
    if ( isdefined( level._id_145F1 ) && isdefined( level._id_145F1._id_13C8D ) )
    {
        foreach ( var_1 in level._id_145F1._id_13C8D )
        {
            if ( _id_127DA( var_1.origin ) )
                return 1;
        }
    }

    return 0;
}

_id_127DA( var_0, var_1 )
{
    if ( istrue( level.br_circle_disabled ) )
        return 0;

    var_2 = ai_pushes_terminal();
    var_3 = ai_raising_alarm();

    if ( istrue( var_1 ) && istrue( level.group_unset_jugg_standstill ) )
    {
        var_2 = ai_stop_shooting_watch();
        var_3 = ai_truck_rider_think();
    }

    if ( !try_play_tv_station_intro_sequence( var_0, var_2, var_3 ) )
        return 1;

    return 0;
}

try_play_tv_station_intro_sequence( var_0, var_1, var_2 )
{
    if ( squared( var_0[0] - var_1[0] ) + squared( var_0[1] - var_1[1] ) <= squared( var_2 ) )
        return 1;

    return 0;
}

ai_stop_shooting_watch()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
        return ( level.br_circle.safecircleent.origin[0], level.br_circle.safecircleent.origin[1], 0 );
    else
        return ( 0, 0, 0 );
}

ai_truck_rider_think()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.safecircleent ) )
        return level.br_circle.safecircleent.origin[2];
    else
        return 0;
}

ai_pushes_terminal()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
        return ( level.br_circle.dangercircleent.origin[0], level.br_circle.dangercircleent.origin[1], 0 );
    else
        return ( 0, 0, 0 );
}

ai_raising_alarm()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) )
        return level.br_circle.dangercircleent.origin[2];
    else
        return 0;
}

updatelocationbesttime( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    var_9 = init_timer( var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
    return updateleadmarkers( var_0, var_9 );
}

updateleadmarkers( var_0, var_1 )
{
    var_2 = var_1._id_14724;
    var_3 = var_0.origin - var_2;
    var_4 = vectordot( var_3, var_1._id_12AC3 );

    if ( var_4 > var_1.halflength )
        return 0;

    if ( var_4 < var_1.halflength * -1 )
        return 0;

    var_5 = vectordot( var_3, var_1._id_12AC4 );

    if ( var_5 > var_1.halfwidth )
        return 0;

    if ( var_5 < var_1.halfwidth * -1 )
        return 0;

    var_6 = vectordot( var_3, var_1._id_12AC5 );

    if ( var_6 > var_1.setplayerbeingrevivedextrainfo )
        return 0;

    if ( var_6 < var_1.setplayerbeingrevivedextrainfo * -1 )
        return 0;

    return 1;
}

init_timer( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = spawnstruct();
    var_8._id_12AC3 = anglestoforward( var_0.angles );
    var_8._id_12AC4 = anglestoright( var_0.angles );
    var_8._id_12AC5 = anglestoup( var_0.angles );
    var_9 = var_0 gettagorigin( var_1 );
    var_8._id_14724 = var_9 + var_8._id_12AC3 * var_2 + var_8._id_12AC4 * var_3 + var_8._id_12AC5 * var_4;
    var_10 = [];
    var_8.halflength = var_5 / 2;
    var_8.halfwidth = var_6 / 2;
    var_8.setplayerbeingrevivedextrainfo = var_7 / 2;
    return var_8;
}

_id_124D8( var_0, var_1 )
{
    return updatelocationbesttime( var_1, var_0, "tag_origin", 0, 0, 88, 760, 112, 124 );
}

updateleaders()
{
    var_0 = 0;

    if ( level.gametype == "br" )
    {
        if ( isdefined( level._id_1394C ) )
        {
            foreach ( var_2 in level._id_1394C )
            {
                if ( !isdefined( var_2 ) )
                    continue;

                if ( _id_124D8( var_2, self ) )
                {
                    var_0 = 1;
                    break;
                }
            }
        }
    }

    return var_0;
}
