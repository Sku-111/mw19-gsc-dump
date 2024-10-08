// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

min_x()
{
    level endon( "game_ended" );
    min_z();
    level thread min_y();
}

min_z()
{
    level.min_x = getent( "crane_arm", "targetname" );
    level.min_x.collision = getent( "crane_collision", "targetname" );
    level.min_x.spawn_maint_wave_2 = getent( "crane_hook", "targetname" );
    level.min_x._id_123B7 = getent( "crane_platform", "targetname" );
    level.min_x.collision linkto( level.min_x );
    level.min_x.trigger = getent( "crane_trigger", "targetname" );
    level.min_x.trigger makeusable();
    level.min_x.trigger show();
    level.min_x.trigger sethintdisplayfov( 360 );
    level.min_x.trigger setusefov( 360 );
    level.min_x.trigger sethintdisplayrange( 100 );
    level.min_x.trigger setuserange( 100 );
    var_0 = getent( level.min_x.spawn_maint_wave_2.target, "targetname" );
    var_1 = getent( var_0.target, "targetname" );
    level.min_x._id_11E30 = var_0;
    level.min_x.pelletweaponvictimids = var_1;
    level.min_x._id_11E30 linkto( level.min_x );
    level.min_x.pelletweaponvictimids linkto( level.min_x );
}

min_y()
{
    level endon( "game_ended" );
    level.min_x endon( "death" );
    level.min_x endon( "deleted" );
    level.min_x.trigger endon( "deaht" );

    for (;;)
    {
        if ( isdefined( level.min_x.trigger ) )
        {
            level.min_x.trigger.in_use = undefined;
            level.min_x.trigger makeusable();
            level.min_x.trigger sethintstring( &"MP/BR_INTERACTABLES_CRANE_PROMPT" );
            level.min_x.trigger waittill( "trigger", var_0 );
            level.min_x.trigger.in_use = 1;
            level.min_x.trigger makeunusable();
            level.min_x.trigger sethintstring( "" );
            var_0 playlocalsound( "ammo_crate_use" );
        }

        wait 5;
        level.min_x._id_123B7 movez( 1808, 5, 1, 1 );
        wait 7;
        level.min_x._id_123B7 linkto( level.min_x.spawn_maint_wave_2 );
        level.min_x.spawn_maint_wave_2 moveto( level.min_x.pelletweaponvictimids.origin, 5, 1, 1 );
        wait 7;
        level.min_x.spawn_maint_wave_2 linkto( level.min_x );
        level.min_x rotateyaw( 135, 10, 1, 1 );
        wait 12;

        if ( isdefined( level.min_x.trigger ) )
        {
            level.min_x.trigger.in_use = undefined;
            level.min_x.trigger makeusable();
            level.min_x.trigger sethintstring( &"MP/BR_INTERACTABLES_CRANE_PROMPT" );
            level.min_x.trigger waittill( "trigger", var_0 );
            level.min_x.trigger.in_use = 1;
            level.min_x.trigger makeunusable();
            level.min_x.trigger sethintstring( "" );
            var_0 playlocalsound( "ammo_crate_use" );
        }

        wait 5;
        level.min_x rotateyaw( -135, 10, 1, 1 );
        wait 12;
        level.min_x.spawn_maint_wave_2 unlink();
        level.min_x.spawn_maint_wave_2 moveto( level.min_x._id_11E30.origin, 5, 1, 1 );
        wait 7;
        level.min_x._id_123B7 unlink();
        level.min_x._id_123B7 movez( -1808, 5, 1, 1 );
        wait 7;
    }
}