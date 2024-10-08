// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

assignclientmatchdataid()
{
    if ( getdvarint( "scr_ri_boost_enable", 1 ) == 1 )
    {
        var_0 = "incursion_boost";
        var_1 = accesscardsspawned_red::preinfilstreamfunc();
        var_2 = getdvarint( "scr_ri_boost_duration", 30 );

        if ( !isdefined( var_1 ) || var_1 != var_0 )
        {
            thread apc_rus_postmoddamagecallback();
            thread ammobox_updateheadicononjointeam();
            thread _watch_incursion_timer( var_2 );
            thread _watch_incursion_boost_deactivate();
        }

        var_3 = getdvarfloat( "scr_ri_boost_scale", 1.5 );
        var_4 = "actionhero_mp";
        var_5 = "zombiedefault";
        var_6 = 1;
        thread accesscardsspawned_red::_id_1380C( var_0, var_2, var_3, var_4, var_5, var_6 );
    }
}

isdragonsbreath()
{
    var_0 = accesscardsspawned_red::preinfilstreamfunc();

    if ( isdefined( var_0 ) && var_0 == "incursion_boost" )
        accesscardsspawned_red::_id_138C8();
}

apc_rus_postmoddamagecallback()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "start_speed_boost_incursion_boost" );
    self setclientomnvar( "ui_privateevent_timer_type", 4 );
    self notify( "force_regeneration" );
}

_watch_incursion_timer( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "stop_speed_boost_incursion_boost" );

    for (;;)
    {
        var_1 = gettime() + var_0 * 1000;
        self setclientomnvar( "ui_privateevent_timer", var_1 );
        self waittill( "speed_boost_incursion_boost_timer_reset", var_0 );
    }
}

_watch_incursion_boost_deactivate()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self waittill( "stop_speed_boost_incursion_boost" );
    self setclientomnvar( "ui_privateevent_timer_type", 0 );
}

ammobox_updateheadicononjointeam()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "stop_speed_boost_incursion_boost" );
    scripts\engine\utility::waittill_all_in_array( [ "begin_firing", "start_speed_boost_incursion_boost" ] );
    isdragonsbreath();
}