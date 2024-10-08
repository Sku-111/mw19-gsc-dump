// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

script_print_fx()
{
    if ( !isdefined( self.script_fxid ) || !isdefined( self.script_fxcommand ) || !isdefined( self.script_delay ) )
    {
        self delete();
        return;
    }

    if ( isdefined( self.target ) )
        var_0 = getent( self.target ).origin;
    else
        var_0 = "undefined";

    if ( self.script_fxcommand == "OneShotfx" )
    {

    }

    if ( self.script_fxcommand == "loopfx" )
    {

    }

    if ( self.script_fxcommand == "loopsound" )
        return;
}

grenadeexplosionfx( var_0 )
{
    playfx( level._effect["mechanical explosion"], var_0 );
    earthquake( 0.15, 0.5, var_0, 250 );
}

soundfx( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_origin", ( 0, 0, 0 ) );
    var_3.origin = var_1;
    var_3 playloopsound( var_0 );

    if ( isdefined( var_2 ) )
        var_3 thread soundfxdelete( var_2 );
}

soundfxdelete( var_0 )
{
    level waittill( var_0 );
    self delete();
}

func_glass_handler()
{
    var_0 = [];
    var_1 = [];
    var_2 = getentarray( "vfx_custom_glass", "targetname" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.script_noteworthy ) )
        {
            var_5 = getglass( var_4.script_noteworthy );

            if ( isdefined( var_5 ) )
            {
                var_1[var_5] = var_4;
                var_0[var_0.size] = var_5;
            }
        }
    }

    var_7 = var_0.size;
    var_8 = var_0.size;
    var_9 = 5;
    var_10 = 0;

    while ( var_7 != 0 )
    {
        var_11 = var_10 + var_9 - 1;

        if ( var_11 > var_8 )
            var_11 = var_8;

        if ( var_10 == var_8 )
            var_10 = 0;

        while ( var_10 < var_11 )
        {
            var_12 = var_0[var_10];
            var_4 = var_1[var_12];

            if ( isdefined( var_4 ) )
            {
                if ( isglassdestroyed( var_12 ) )
                {
                    var_4 delete();
                    var_7--;
                    var_1[var_12] = undefined;
                }
            }

            var_10++;
        }

        wait 0.05;
    }
}

blenddelete( var_0 )
{
    self waittill( "death" );
    var_0 delete();
}
