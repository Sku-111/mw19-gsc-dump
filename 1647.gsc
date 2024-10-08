// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    setdvarifuninitialized( "debug_screens", 0 );
    waitframe();
    level.screens = spawnstruct();
    level.screens.screens = scripts\engine\utility::getstructarray( "screens_system", "script_noteworthy" );

    if ( !isdefined( level.screens.screens ) || level.screens.screens.size <= 0 )
        return;

    level.screens.screens_flagged = [];
    level thread screens_debug_counter();

    foreach ( var_1 in level.screens.screens )
    {
        var_1.state = "off";
        var_1 group_by_flag();
        var_1 thread watch_scriptable();
    }

    if ( isdefined( level.screens_think_func ) )
        scripts\engine\utility::array_thread( level.screens.screens, level.screens_think_func );
    else
        scripts\engine\utility::array_thread( level.screens.screens, ::screens_think );
}

group_by_flag()
{
    if ( isdefined( self.script_flag ) )
    {
        if ( !isdefined( level.screens.screens_flagged[self.script_flag] ) )
        {
            level.screens.screens_flagged[self.script_flag] = [];
            level thread screens_wait_for_flag( self.script_flag );
        }

        level.screens.screens_flagged[self.script_flag] = scripts\engine\utility::array_add( level.screens.screens_flagged[self.script_flag], self );
        level.screens.screens = scripts\engine\utility::array_remove( level.screens.screens, self );
    }
}

screens_think()
{
    if ( istrue( level.screens_off_test ) )
        return;

    self endon( "death" );
    screens_create();
    var_0 = get_state();

    if ( isdefined( var_0 ) )
        do_state( var_0 );
    else
        screens_fixed();
}

do_state( var_0 )
{
    self endon( "death" );

    if ( issubstr( var_0, "screen" ) )
    {
        childthread screens_fixed( var_0 );
        return;
    }

    switch ( var_0 )
    {
        case "fixed":
            if ( debug() )
            {

            }

            childthread screens_fixed();
            break;
        case "flip":
            if ( debug() )
            {

            }

            childthread screens_flip();
            break;
        case "fliprnd":
            if ( debug() )
            {

            }

            childthread screens_fliprnd();
            break;
        case "static":
            if ( debug() )
            {

            }

            childthread screens_static();
            break;
        case "red":
            if ( debug() )
            {

            }

            childthread screens_red();
            break;
        case "bink":
            if ( debug() )
            {

            }

            childthread screens_bink();
            break;
        case "alertflip":
            if ( debug() )
            {

            }

            childthread screens_alertflip();
            break;
    }
}

screens_create()
{
    self.screen_model = spawn( "script_model", self.origin );
    self.screen_model.angles = self.angles;
    self.screen_model setmodel( self.script_modelname );
    self.screen_model hideallparts();
    get_screens();
}

screens_damage_think()
{
    self.screen_model setcandamage( 1 );
    self.screen_model waittill( "damage" );
    self notify( "stop_screens" );
    self.screen_model delete();
}

screens_delete()
{
    self.state = "off";
    self notify( "stop_screens" );

    if ( isdefined( self.screen_model ) )
        self.screen_model delete();

    delete_screens();
}

screens_fixed( var_0 )
{
    if ( !isdefined( self.screens_fixed ) && !isdefined( var_0 ) )
        return;

    self endon( "stop_screens" );
    self endon( "stop_screens_fixed" );

    if ( isdefined( var_0 ) )
        var_1 = var_0;
    else
        var_1 = "screen_fixed" + ( randomint( self.screens_fixed.size ) + 1 );

    if ( debug() )
    {
        var_2 = var_1;

        if ( isdefined( var_0 ) )
            var_2 = "override " + var_2;
    }

    self.state = "on";
    self.screen_model hideallparts();
    self.screen_model showpart( var_1 );

    if ( isdefined( self.screens_widget ) && !isdefined( var_0 ) )
    {
        if ( randomint( 3 ) == 0 )
        {
            var_1 = "screen_widget" + ( randomint( self.screens_widget.size ) + 1 );
            self.screen_model showpart( var_1 );
        }
    }
}

screens_static()
{
    if ( !isdefined( self.screens_static ) )
        return;

    self endon( "stop_screens" );
    self endon( "stop_screens_static" );
    var_0 = "screen_static" + ( randomint( self.screens_static.size ) + 1 );

    if ( debug() )
    {

    }

    self.state = "on";
    self.screen_model hideallparts();
    self.screen_model showpart( var_0 );
}

screens_flip()
{
    if ( !isdefined( self.screens_flip ) )
        return;

    self endon( "stop_screens" );
    self endon( "stop_screens_flip" );
    var_0 = randomint( self.screens_flip.size ) + 1;

    for (;;)
    {
        for ( var_1 = var_0; var_1 < self.screens_flip.size + 1; var_1++ )
        {
            var_2 = 3;
            var_3 = "screen_flip" + var_1;

            if ( debug() )
            {

            }

            self.state = "on";
            self.screen_model hideallparts();
            self.screen_model showpart( var_3 );
            wait( var_2 );
        }

        var_0 = 1;
    }
}

screens_fliprnd()
{
    if ( !isdefined( self.screens_fliprnd ) )
        return;

    self endon( "stop_screens" );
    self endon( "stop_screens_fliprnd" );
    var_0 = randomint( self.screens_fliprnd.size ) + 1;

    for (;;)
    {
        for ( var_1 = var_0; var_1 < self.screens_fliprnd.size + 1; var_1++ )
        {
            var_2 = randomfloatrange( 1.5, 4 );
            var_3 = "screen_fliprnd" + var_1;

            if ( debug() )
            {

            }

            self.state = "on";
            self.screen_model hideallparts();
            self.screen_model showpart( var_3 );
            wait( var_2 );
        }

        var_0 = 1;
    }
}

screens_bink()
{
    if ( !isdefined( self.screens_bink ) )
        return;

    self endon( "stop_screens" );
    self endon( "stop_screens_bink" );
    var_0 = "screen_bink" + ( randomint( self.screens_bink.size ) + 1 );

    if ( debug() )
    {

    }

    self.state = "on";
    self.screen_model hideallparts();
    self.screen_model showpart( var_0 );
}

screens_red()
{
    if ( !isdefined( self.screens_red ) )
        return;

    self endon( "stop_screens" );
    self endon( "stop_screens_red" );
    self.reversed = 0;
    var_0 = randomint( self.screens_red.size ) + 1;

    for (;;)
    {
        for ( var_1 = 1; var_1 < self.screens_red.size + 1; var_1++ )
        {
            var_2 = randomfloatrange( 0.25, 0.5 );

            if ( randomint( 6 ) == 0 && !self.reversed )
            {
                self.reversed = 1;

                if ( var_1 <= 2 )
                    var_1 = var_1 + self.screens_red.size;

                var_1 = var_1 - 2;
                var_2 = 0.1;
            }
            else
                self.reversed = 0;

            var_3 = "screen_red" + var_1;

            if ( debug() )
            {

            }

            self.state = "on";
            self.screen_model hideallparts();
            self.screen_model showpart( var_3 );
            wait( var_2 );
        }

        var_0 = 1;
    }
}

screens_alertflip()
{
    if ( !isdefined( self.screens_alertflip ) )
        return;

    self endon( "stop_screens" );
    self endon( "stop_screens_alertflip" );
    self.screen_model hideallparts();

    for (;;)
    {
        var_0 = randomfloatrange( 0.5, 1 );

        if ( debug() )
        {

        }

        self.state = "on";
        self.screen_model hidepart( "screen_alertflip1" );
        self.screen_model showpart( "screen_alertflip2" );
        wait( var_0 );
        self.screen_model showpart( "screen_alertflip1" );
        self.screen_model hidepart( "screen_alertflip2" );
        wait( var_0 );
    }
}

get_screens()
{
    var_0 = getnumparts( self.screen_model.model );

    for ( var_1 = 0; var_1 < var_0; var_1++ )
    {
        var_2 = getpartname( self.screen_model.model, var_1 );

        if ( issubstr( var_2, "screen_" ) )
        {
            if ( issubstr( var_2, "screen_red" ) )
            {
                if ( !isdefined( self.screens_red ) )
                    self.screens_red = [];

                self.screens_red = scripts\engine\utility::array_add( self.screens_red, var_2 );
                continue;
            }

            if ( issubstr( var_2, "screen_fixed" ) )
            {
                if ( !isdefined( self.screens_fixed ) )
                    self.screens_fixed = [];

                self.screens_fixed = scripts\engine\utility::array_add( self.screens_fixed, var_2 );
                continue;
            }

            if ( issubstr( var_2, "screen_static" ) )
            {
                if ( !isdefined( self.screens_static ) )
                    self.screens_static = [];

                self.screens_static = scripts\engine\utility::array_add( self.screens_static, var_2 );
                continue;
            }

            if ( issubstr( var_2, "screen_fliprnd" ) )
            {
                if ( !isdefined( self.screens_fliprnd ) )
                    self.screens_fliprnd = [];

                self.screens_fliprnd = scripts\engine\utility::array_add( self.screens_fliprnd, var_2 );
                continue;
            }

            if ( issubstr( var_2, "screen_flip" ) )
            {
                if ( !isdefined( self.screens_flip ) )
                    self.screens_flip = [];

                self.screens_flip = scripts\engine\utility::array_add( self.screens_flip, var_2 );
                continue;
            }

            if ( issubstr( var_2, "screen_bink" ) )
            {
                if ( !isdefined( self.screens_bink ) )
                    self.screens_bink = [];

                self.screens_bink = scripts\engine\utility::array_add( self.screens_bink, var_2 );
                continue;
            }

            if ( issubstr( var_2, "screen_alertflip" ) )
            {
                if ( !isdefined( self.screens_alertflip ) )
                    self.screens_alertflip = [];

                self.screens_alertflip = scripts\engine\utility::array_add( self.screens_alertflip, var_2 );
                continue;
            }

            if ( issubstr( var_2, "screen_widget" ) )
            {
                if ( !isdefined( self.screens_widget ) )
                    self.screens_widget = [];

                self.screens_widget = scripts\engine\utility::array_add( self.screens_widget, var_2 );
            }
        }
    }
}

delete_screens()
{
    if ( isdefined( self.screens_red ) )
        self.screens_red = [];

    if ( isdefined( self.screens_fixed ) )
        self.screens_fixed = [];

    if ( isdefined( self.screens_static ) )
        self.screens_static = [];

    if ( isdefined( self.screens_flip ) )
        self.screens_flip = [];

    if ( isdefined( self.screens_fliprnd ) )
        self.screens_fliprnd = [];

    if ( isdefined( self.screens_bink ) )
        self.screens_bink = [];

    if ( isdefined( self.screens_alertflip ) )
        self.screens_alertflip = [];

    if ( isdefined( self.screens_widget ) )
        self.screens_widget = [];
}

get_state()
{
    if ( isdefined( self.script_parameters ) )
    {
        var_0 = strtok( self.script_parameters, " " );

        foreach ( var_2 in var_0 )
        {
            if ( issubstr( var_2, "screen" ) )
                return var_2;
        }

        foreach ( var_2 in var_0 )
        {
            if ( issubstr( var_2, "state" ) )
            {
                switch ( var_2 )
                {
                    case "state_fixed":
                        return "fixed";
                    case "state_flip":
                        return "flip";
                    case "state_fliprnd":
                        return "fliprnd";
                    case "state_static":
                        return "static";
                    case "state_red":
                        return "red";
                    case "state_bink":
                        return "bink";
                    case "state_alertflip":
                        return "alertflip";
                    default:
                }
            }
        }
    }

    return undefined;
}

watch_scriptable()
{
    if ( !isdefined( self.target ) )
        return;

    var_0 = getscriptablearray( self.target, "targetname" );

    if ( isdefined( var_0[0] ) )
    {
        if ( debug() )
        {

        }

        var_0[0] waittill( "death" );
        screens_delete();
        var_1 = getarraykeys( level.screens.screens_flagged );

        foreach ( var_3 in var_1 )
        {
            foreach ( var_5 in level.screens.screens_flagged[var_3] )
            {
                if ( self == var_5 )
                {
                    level.screens.screens_flagged[var_3] = scripts\engine\utility::array_remove( level.screens.screens_flagged[var_3], self );
                    return;
                }
            }
        }
    }
}

debug()
{
    if ( getdvarint( "debug_screens" ) > 0 )
        return 1;

    return 0;
}

set_screens_to_red()
{

}

screens_debug_counter()
{
    if ( !debug() )
        return;

    for (;;)
    {
        var_0 = 0;
        var_1 = 0;
        var_2 = getarraykeys( level.screens.screens_flagged );

        foreach ( var_4 in var_2 )
        {
            var_1 = var_1 + level.screens.screens_flagged[var_4].size;

            foreach ( var_6 in level.screens.screens_flagged[var_4] )
            {
                if ( isdefined( var_6.state ) && var_6.state == "on" )
                    var_0 = var_0 + 1;
            }
        }

        foreach ( var_6 in level.screens.screens )
        {
            if ( isdefined( var_6.state ) && var_6.state == "on" )
                var_0 = var_0 + 1;
        }

        var_11 = level.screens.screens.size + var_1;
        waitframe();
    }
}

screens_wait_for_flag( var_0 )
{
    if ( !scripts\engine\utility::flag_exist( var_0 ) )
        scripts\engine\utility::flag_init( var_0 );

    for (;;)
    {
        scripts\engine\utility::flag_wait( var_0 );

        if ( debug() )
            iprintln( level.screens.screens_flagged[var_0].size + " flagged screens activated: " + var_0 );

        if ( !istrue( level.screens_off_test ) )
        {
            if ( isdefined( level.screens_think_func ) )
                scripts\engine\utility::array_thread( level.screens.screens_flagged[var_0], level.screens_think_func );
            else
                scripts\engine\utility::array_thread( level.screens.screens_flagged[var_0], ::screens_think );
        }

        scripts\engine\utility::flag_waitopen( var_0 );

        if ( debug() )
            iprintln( level.screens.screens_flagged[var_0].size + " flagged screens deactivated: " + var_0 );

        if ( !istrue( level.screens_off_test ) )
            scripts\engine\utility::array_thread( level.screens.screens_flagged[var_0], ::screens_delete );
    }
}
