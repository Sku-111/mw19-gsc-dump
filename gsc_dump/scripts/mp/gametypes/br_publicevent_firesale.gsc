// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = spawnstruct();
    var_0._id_140CF = ::_id_140CF;
    var_0.weight = getdvarfloat( "scr_br_pe_firesale_weight", 1.0 );
    var_0.attackerswaittime = ::attackerswaittime;
    var_0._id_14382 = ::_id_14382;
    var_0.postinitfunc = ::postinitfunc;
    var_0._id_11B78 = getdvarint( "scr_br_pe_firesale_max_times", 1 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "firesale", "0    5   10  10          10  10  10  10" );
    var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter.gsc::getdvarpemetereventweights( "firesale" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 2, var_0 );
}

postinitfunc()
{
    game["dialog"]["public_events_firesale_start"] = "public_events_fire_sale_start";
    game["dialog"]["public_events_firesale_end"] = "public_events_fire_sale_end";
}

_id_140CF()
{
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex <= 1 )
        return 1;

    var_0 = scripts\mp\gametypes\br_armory_kiosk.gsc::resetarenaomnvardata();
    return var_0 >= 1;
}

_id_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var_0 = forest_combat();
    wait( var_0 );
}

relic_squadlink_add_visionset()
{
    var_0 = getdvarfloat( "scr_br_pe_firesale_duration", 90.0 );
    var_1 = isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex != -1;
    var_2 = getdvarint( "scr_br_pe_firesale_bound_under_circleduration", 1 ) == 1;

    if ( var_2 && var_1 )
        var_0 = min( var_0, scripts\mp\gametypes\br_circle.gsc::inithelirepository() );

    var_3 = getdvarint( "scr_br_pe_firesale_override_with_circleduration", 0 ) == 1;

    if ( var_3 && var_1 )
        var_0 = scripts\mp\gametypes\br_circle.gsc::inithelirepository();

    var_4 = getdvarint( "scr_br_pe_firesale_minDuration", 15.0 );
    var_0 = max( var_0, var_4 );
    return var_0;
}

attackerswaittime()
{
    level endon( "game_ended" );
    level notify( "public_event_firesale_start" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_pe_firesale_start" );
    scripts\mp\gametypes\br_public.gsc::brleaderdialog( "public_events_firesale_start" );
    setomnvar( "ui_publicevent_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", 1 );
    var_0 = relic_squadlink_add_visionset();
    var_1 = gettime() + var_0 * 1000;
    setomnvar( "ui_publicevent_timer", var_1 );
    var_2 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_2 hide();
    var_3 = 5;

    if ( var_0 > var_3 )
        wait( var_0 - var_3 );
    else
        var_3 = int( var_0 );

    for ( var_4 = 0; var_4 < var_3; var_4++ )
    {
        var_2 playsound( "ui_mp_fire_sale_timer" );
        wait 1.0;
    }

    scripts\mp\gametypes\br_publicevents.gsc::neurotoxin_mask_monitor( 2 );
    level notify( "public_event_firesale_end" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_pe_firesale_end" );
    scripts\mp\gametypes\br_public.gsc::brleaderdialog( "public_events_firesale_end" );
    setomnvar( "ui_publicevent_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
    var_2 delete();
}

forest_combat()
{
    var_0 = getdvarfloat( "scr_br_pe_firesale_starttime_min", 795.0 );
    var_1 = getdvarfloat( "scr_br_pe_firesale_starttime_max", 1110.0 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}
