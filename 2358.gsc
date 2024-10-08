// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{

}

getmapselectweapon()
{
    return "ks_remote_map_mp";
}

getselectmappoint( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_3 = 0;

    if ( scripts\mp\utility\killstreak::isnavmeshkillstreak( var_0.streakname ) )
        var_3 = 1;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    scripts\common\utility::allow_offhand_weapons( 0 );
    thread watchmapselectexit( var_0 );
    thread _id_144E5();
    thread watchownertimeoutdeath();
    var_4 = undefined;
    scripts\cp_mp\utility\killstreak_utility::starttabletscreen( var_0.streakname, 0.05 );
    var_4 = gathermappointinfo( var_1, var_2 );
    scripts\cp_mp\utility\killstreak_utility::stoptabletscreen( 0.75 );
    return var_4;
}

gathermappointinfo( var_0, var_1 )
{
    var_2 = 1;

    if ( var_0 <= 1 )
    {
        self setclientomnvar( "ui_map_select_uses", -1 );
        var_2 = 0;
    }

    self.mapselectpickcounter = 0;
    self.previousmapselectioninfo = undefined;
    var_3 = [];
    thread watchmapselectweapon();

    if ( istrue( var_2 ) )
    {
        self setclientomnvar( "ui_map_select_uses", var_0 );
        self setclientomnvar( "ui_map_select_count", var_0 );
    }

    while ( self.mapselectpickcounter < var_0 )
    {
        var_4 = waittill_confirm_or_cancel( "confirm_location", "cancel_location" );

        if ( !isdefined( var_4 ) || var_4.string == "cancel_location" )
        {
            var_3 = undefined;
            break;
        }

        var_5 = var_4.location + ( 0, 0, 10000 );
        var_6 = var_4.location - ( 0, 0, 10000 );
        var_7 = scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_getgameinstancesforall();
        var_8 = level.activekillstreaks;
        var_9 = scripts\engine\utility::array_combine( var_7, var_8 );
        var_10 = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 0, 0, 0, 0 );
        var_11 = scripts\engine\trace::ray_trace( var_5, var_6, var_9, var_10, 0, 1 );
        var_4.location = var_11["position"];
        var_3[var_3.size] = var_4;
        self.mapselectpickcounter++;

        if ( istrue( var_2 ) )
            self setclientomnvar( "ui_map_select_uses", var_0 - self.mapselectpickcounter );
    }

    self setclientomnvar( "ui_map_select_count", -1 );
    self notify( "map_select_exit" );

    if ( isdefined( var_3 ) )
        self.pers["startedMapSelect"] = 0;

    return var_3;
}

watchmapselectweapon()
{
    self endon( "map_select_exit" );

    for (;;)
    {
        var_0 = self getcurrentweapon();

        if ( var_0.basename != "ks_remote_map_mp" )
        {
            self notify( "cancel_location" );
            break;
        }

        waitframe();
    }
}

watchmapselectexit( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self waittill( "map_select_exit" );
    stopmapselectsequence( var_0 );
}

_id_144E5()
{
    self endon( "disconnect" );
    self endon( "map_select_exit" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( scripts\cp_mp\emp_debuff::is_empd() )
        {
            self notify( "cancel_location" );
            break;
        }

        waitframe();
    }
}

watchownertimeoutdeath()
{
    self endon( "disconnect" );
    self endon( "map_select_exit" );
    level endon( "game_ended" );
    self setclientomnvar( "ui_location_selection_countdown", gettime() + 30000 );
    scripts\engine\utility::_id_143B9( 30, "death" );
    self notify( "cancel_location" );
}

startmapselectsequence( var_0, var_1, var_2, var_3 )
{
    if ( !self.pers["startedMapSelect"] )
    {
        triggeroneoffradarsweep( self );
        self.pers["startedMapSelect"] = 1;
    }

    if ( !isdefined( var_0 ) )
        var_0 = 0;

    if ( !isdefined( var_1 ) )
        var_1 = 0;

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    self beginlocationselection( var_0, var_1, var_2, 1, var_3 );
}

stopmapselectsequence( var_0 )
{
    self.mapselectpickcounter = undefined;
    self.mapselectdircounter = undefined;
    self.previousmapselectioninfo = undefined;

    if ( scripts\mp\utility\player::isreallyalive( self ) )
    {
        scripts\common\utility::allow_offhand_weapons( 1 );
        var_0 notify( "killstreak_finished_with_deploy_weapon" );
    }
    else
        self.pers["startedMapSelect"] = 0;

    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 0.25 );

    if ( isdefined( self ) )
        self endlocationselection();
}

waittill_confirm_or_cancel( var_0, var_1, var_2 )
{
    if ( ( !isdefined( var_0 ) || var_0 != "death" ) && ( !isdefined( var_1 ) || var_1 != "death" ) )
        self endon( "death" );

    var_3 = spawnstruct();

    if ( isdefined( var_0 ) )
        childthread waittill_return( var_0, var_3 );

    if ( isdefined( var_1 ) )
        childthread waittill_return( var_1, var_3 );

    if ( isdefined( var_2 ) )
        childthread waittill_return( var_2, var_3 );

    var_3 waittill( "returned", var_4, var_5, var_6 );
    var_3 notify( "die" );
    var_7 = spawnstruct();
    var_7.location = var_4;
    var_7.angles = var_5;
    var_7.string = var_6;
    return var_7;
}

waittill_return( var_0, var_1 )
{
    if ( var_0 != "death" )
        self endon( "death" );

    var_1 endon( "die" );
    self waittill( var_0, var_2, var_3 );
    var_1 notify( "returned", var_2, var_3, var_0 );
}
