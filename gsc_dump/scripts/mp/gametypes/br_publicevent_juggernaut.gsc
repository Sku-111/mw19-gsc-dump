// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = spawnstruct();
    var_0.weight = getdvarfloat( "scr_br_pe_juggernaut_weight", 1.0 );
    var_0.attackerswaittime = ::attackerswaittime;
    var_0._id_140CF = ::_id_140CF;
    var_0._id_14382 = ::_id_14382;
    var_0.postinitfunc = ::postinitfunc;
    var_0._id_11B78 = getdvarint( "scr_br_pe_juggernaut_max_times", 1 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "juggernaut", "10   5   0   0           0   0   0   0" );
    var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter.gsc::getdvarpemetereventweights( "juggernaut" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 4, var_0 );
}

postinitfunc()
{
    game["dialog"]["public_events_juggernaut_start"] = "public_events_juggernaut_start";
    var_0 = getdvarint( "scr_br_pe_juggernaut_drop_on_death", 0 );
    scripts\mp\gametypes\br_jugg_common.gsc::strafe_internal( "drop_on_death", var_0, "public_event" );
}

_id_140CF()
{
    return level.disable_super_in_turret.name != "jugg";
}

_id_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var_0 = forest_combat();
    wait( var_0 );
}

attackerswaittime()
{
    var_0 = scripts\mp\gametypes\br_jugg_common.gsc::resetafkchecks( getdvarint( "scr_br_pe_juggernaut_dropNumTeamBased", 1 ) );
    level.vehicle_isneutraltoplayer = scripts\engine\utility::array_randomize( level.vehicle_isneutraltoplayer );
    var_1 = scripts\mp\gametypes\br_jugg_common.gsc::_id_1334B( var_0, 0 );
    scripts\mp\gametypes\br_public.gsc::brleaderdialog( "public_events_juggernaut_start" );
    level scripts\mp\gametypes\br_jugg_common.gsc::_id_1383F( var_1, "public_event" );
    _id_1436C();
}

_id_1436C()
{
    for (;;)
    {
        wait 1;
        var_0 = 0;

        foreach ( var_2 in level.focus_fire_attacker_timeout )
        {
            if ( var_2.cratetype == "battle_royale_juggernaut" )
            {
                var_0 = 1;
                break;
            }
        }

        if ( !var_0 )
            break;
    }
}

forest_combat()
{
    var_0 = getdvarfloat( "scr_br_pe_juggernaut_starttime_min", 795.0 );
    var_1 = getdvarfloat( "scr_br_pe_juggernaut_starttime_max", 1110.0 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}
