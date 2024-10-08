// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

initialize_radio()
{
    level.tacopsradio = [];
    level thread radiowatchplayerjoin();
}

radiowatchplayerjoin()
{
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_0 );
        level.tacopsradio[var_0 scripts\mp\utility\player::getuniqueid()] = spawn( "script_model", ( 0, 0, 0 ) );
    }
}

queue_dialogue( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_2 ) )
        level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()] function_stack_clear();

    var_4 = 0;

    if ( !isdefined( var_3 ) )
        var_4 = level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()] thread function_stack( ::play_mp_sound, var_0, var_1 );
    else
        var_4 = level.tacopsradio[var_1 scripts\mp\utility\player::getuniqueid()] thread function_stack_timeout( var_3, ::play_mp_sound, var_0, var_1 );

    return var_4;
}

queue_dialogue_for_team( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_2 ) )
    {
        foreach ( var_5 in scripts\mp\utility\teams::getteamdata( var_1, "players" ) )
            level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()] function_stack_clear();
    }

    var_7 = 0;

    foreach ( var_5 in scripts\mp\utility\teams::getteamdata( var_1, "players" ) )
    {
        if ( !isdefined( var_3 ) )
        {
            var_7 = level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()] thread function_stack( ::play_mp_sound, var_0, var_5 );
            continue;
        }

        var_7 = level.tacopsradio[var_5 scripts\mp\utility\player::getuniqueid()] thread function_stack_timeout( var_3, ::play_mp_sound, var_0, var_5 );
    }

    return var_7;
}

play_mp_sound( var_0, var_1, var_2 )
{
    var_1 playlocalsound( var_0, var_2 );
    var_3 = lookupsoundlength( var_0 );
    wait( 0.5 + var_3 / 1000.0 );

    if ( isdefined( var_2 ) )
        self notify( var_2 );
}

function_stack( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = spawnstruct();
    var_6 thread function_stack_proc( self, var_0, var_1, var_2, var_3, var_4, var_5 );
    return function_stack_wait_finish( var_6 );
}

function_stack_timeout( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = spawnstruct();
    var_7 thread function_stack_proc( self, var_1, var_2, var_3, var_4, var_5, var_6 );

    if ( isdefined( var_7.function_stack_func_begun ) || var_7 scripts\engine\utility::_id_143B9( var_0, "function_stack_func_begun" ) != "timeout" )
        return function_stack_wait_finish( var_7 );
    else
    {
        var_7 notify( "death" );
        return 0;
    }
}

function_stack_clear()
{
    if ( !isdefined( self.function_stack ) )
        return;

    var_0 = [];

    if ( isdefined( self.function_stack[0] ) && isdefined( self.function_stack[0].function_stack_func_begun ) )
        var_0[0] = self.function_stack[0];

    self.function_stack = undefined;
    self notify( "clear_function_stack" );
    waittillframeend;

    if ( !var_0.size )
        return;

    if ( !var_0[0].function_stack_func_begun )
        return;

    self.function_stack = var_0;
}

function_stack_wait( var_0 )
{
    self endon( "death" );
    var_0 scripts\engine\utility::waittill_either( "function_done", "death" );
}

function_stack_wait_finish( var_0 )
{
    function_stack_wait( var_0 );

    if ( !isdefined( self ) )
        return 0;

    if ( !issentient( self ) )
        return 1;

    if ( isalive( self ) )
        return 1;

    return 0;
}

function_stack_proc( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    self endon( "death" );

    if ( !isdefined( var_0.function_stack ) )
        var_0.function_stack = [];

    var_0.function_stack[var_0.function_stack.size] = self;
    thread function_stack_self_death( var_0 );
    function_stack_caller_waits_for_turn( var_0 );

    if ( isdefined( var_0 ) && isdefined( var_0.function_stack ) )
    {
        self.function_stack_func_begun = 1;
        self notify( "function_stack_func_begun" );

        if ( isdefined( var_6 ) )
            var_0 [[ var_1 ]]( var_2, var_3, var_4, var_5, var_6 );
        else if ( isdefined( var_5 ) )
            var_0 [[ var_1 ]]( var_2, var_3, var_4, var_5 );
        else if ( isdefined( var_4 ) )
            var_0 [[ var_1 ]]( var_2, var_3, var_4 );
        else if ( isdefined( var_3 ) )
            var_0 [[ var_1 ]]( var_2, var_3 );
        else if ( isdefined( var_2 ) )
            var_0 [[ var_1 ]]( var_2 );
        else
            var_0 [[ var_1 ]]();

        if ( isdefined( var_0 ) && isdefined( var_0.function_stack ) )
        {
            var_0.function_stack = scripts\engine\utility::array_remove( var_0.function_stack, self );
            var_0 notify( "level_function_stack_ready" );
        }
    }

    if ( isdefined( self ) )
    {
        self.function_stack_func_begun = 0;
        self notify( "function_done" );
    }
}

function_stack_self_death( var_0 )
{
    self endon( "function_done" );
    self waittill( "death" );

    if ( isdefined( var_0 ) )
    {
        var_0.function_stack = scripts\engine\utility::array_remove( var_0.function_stack, self );
        var_0 notify( "level_function_stack_ready" );
    }
}

function_stack_caller_waits_for_turn( var_0 )
{
    var_0 endon( "death" );
    self endon( "death" );
    var_0 endon( "clear_function_stack" );

    while ( var_0.function_stack[0] != self )
        var_0 waittill( "level_function_stack_ready" );
}

bcs_scripted_dialogue_start()
{
    anim.scripteddialoguestarttime = gettime();
}
