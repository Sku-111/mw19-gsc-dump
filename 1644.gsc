// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

start_notetrack_wait( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 notify( "stop_sequencing_notetracks" );
    thread notetrack_wait( var_0, var_1, self, var_2, var_3, var_4 );
}

notetrack_wait( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_0 endon( "stop_sequencing_notetracks" );
    var_0 endon( "death" );

    if ( isdefined( var_2 ) )
        var_6 = var_2;
    else
        var_6 = self;

    var_7 = undefined;

    if ( isdefined( var_4 ) )
        var_7 = var_4;
    else
        var_7 = var_0.animname;

    var_8 = spawnstruct();
    var_8.dialog = [];
    var_9 = [];

    if ( isdefined( var_7 ) && isdefined( level.scr_notetrack[var_7] ) && isdefined( var_3 ) )
    {
        if ( isdefined( level.scr_notetrack[var_7][var_3] ) )
            var_9[var_3] = level.scr_notetrack[var_7][var_3];

        if ( isdefined( level.scr_notetrack[var_7]["any"] ) )
            var_9["any"] = level.scr_notetrack[var_7]["any"];
    }

    foreach ( var_18, var_11 in var_9 )
    {
        foreach ( var_13 in level.scr_notetrack[var_7][var_18] )
        {
            foreach ( var_15 in var_13 )
            {
                if ( isdefined( var_15["dialog"] ) )
                    var_8.dialog[var_15["dialog"]] = 1;
            }
        }
    }

    var_19 = 0;
    var_20 = 0;

    for (;;)
    {
        var_8.dialoguenotetrack = 0;
        var_21 = undefined;

        if ( !var_19 && isdefined( var_7 ) && isdefined( var_3 ) )
        {
            var_19 = 1;
            var_22 = undefined;
            var_20 = isdefined( level.scr_notetrack[var_7] ) && isdefined( level.scr_notetrack[var_7][var_3] ) && isdefined( level.scr_notetrack[var_7][var_3]["start"] );

            if ( !var_20 )
                continue;

            var_23 = [ "start" ];
        }
        else
            var_0 waittill( var_1, var_23 );

        if ( !isarray( var_23 ) )
            var_23 = [ var_23 ];

        var_0 printnotetracks( var_23 );
        validatenotetracks( var_1, var_23, var_5 );
        var_24 = undefined;

        foreach ( var_26 in var_23 )
        {
            notetrack_handler( var_0, var_3, var_26, var_7, var_9, var_6, var_8 );

            if ( var_26 == "end" )
                var_24 = 1;
        }

        if ( isdefined( var_24 ) )
            break;
    }
}

notetrack_handler( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_2 == "end" )
        return 1;

    foreach ( var_12, var_8 in var_4 )
    {
        if ( isdefined( level.scr_notetrack[var_3][var_12][var_2] ) )
        {
            foreach ( var_10 in level.scr_notetrack[var_3][var_12][var_2] )
                [[ anim.callbacks["AnimHandleNotetrack"] ]]( var_10, var_0, var_6, var_5 );
        }
    }

    if ( isdefined( anim.callbacks["EntityHandleNotetrack"] ) )
        [[ anim.callbacks["EntityHandleNotetrack"] ]]( var_0, var_2 );
}

anim_handle_notetrack( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( var_0["function"] ) )
        self thread [[ var_0["function"] ]]( var_1 );

    if ( isdefined( var_0["notify"] ) )
        level notify( var_0["notify"] );

    if ( isdefined( var_0["attach model"] ) )
    {
        if ( isdefined( var_0["selftag"] ) )
            var_1 attach( var_0["attach model"], var_0["selftag"] );
        else
            var_3 attach( var_0["attach model"], var_0["tag"] );

        return;
    }

    if ( isdefined( var_0["detach model"] ) )
    {
        if ( isdefined( var_0["selftag"] ) )
            var_1 detach( var_0["detach model"], var_0["selftag"] );
        else
            var_3 detach( var_0["detach model"], var_0["tag"] );
    }

    if ( !var_2.dialoguenotetrack )
    {
        if ( isdefined( var_0["dialog"] ) && isdefined( var_2.dialog[var_0["dialog"]] ) )
        {
            var_1 scripts\anim\face.gsc::sayspecificdialogue( var_0["dialog"] );
            var_2.dialog[var_0["dialog"]] = undefined;
            var_2.dialoguenotetrack = 1;
        }
    }

    if ( isdefined( var_0["create model"] ) )
        anim_addmodel( var_1, var_0 );
    else if ( isdefined( var_0["delete model"] ) )
        anim_removemodel( var_1, var_0 );

    if ( isdefined( var_0["selftag"] ) )
    {
        if ( isdefined( var_0["effect"] ) )
            level thread notetrack_effect( var_1, var_0 );

        if ( isdefined( var_0["stop_effect"] ) )
            stopfxontag( level._effect[var_0["stop_effect"]], var_1, var_0["selftag"] );

        if ( isdefined( var_0["swap_part_to_efx"] ) )
        {
            playfxontag( level._effect[var_0["swap_part_to_efx"]], var_1, var_0["selftag"] );
            var_1 hidepart( var_0["selftag"] );
        }

        if ( isdefined( var_0["trace_part_for_efx"] ) )
        {
            var_4 = undefined;
            var_5 = scripts\engine\utility::getfx( var_0["trace_part_for_efx"] );

            if ( isdefined( var_0["trace_part_for_efx_water"] ) )
                var_4 = scripts\engine\utility::getfx( var_0["trace_part_for_efx_water"] );

            var_6 = 0;

            if ( isdefined( var_0["trace_part_for_efx_delete_depth"] ) )
                var_6 = var_0["trace_part_for_efx_delete_depth"];

            var_1 thread trace_part_for_efx( var_0["selftag"], var_5, var_4, var_6 );
        }

        if ( isdefined( var_0["trace_part_for_efx_canceling"] ) )
            var_1 thread trace_part_for_efx_cancel( var_0["selftag"] );
    }

    if ( isdefined( var_0["tag"] ) && isdefined( var_0["effect"] ) )
        playfxontag( level._effect[var_0["effect"]], var_3, var_0["tag"] );

    if ( isdefined( var_0["selftag"] ) && isdefined( var_0["effect_looped"] ) )
        playfxontag( level._effect[var_0["effect_looped"]], var_1, var_0["selftag"] );
}

anim_addmodel( var_0, var_1 )
{
    if ( !isdefined( var_0.scriptmodel ) )
        var_0.scriptmodel = [];

    var_2 = var_0.scriptmodel.size;
    var_0.scriptmodel[var_2] = spawn( "script_model", ( 0, 0, 0 ) );
    var_0.scriptmodel[var_2] setmodel( var_1["create model"] );
    var_0.scriptmodel[var_2].origin = var_0 gettagorigin( var_1["selftag"] );
    var_0.scriptmodel[var_2].angles = var_0 gettagangles( var_1["selftag"] );
}

anim_removemodel( var_0, var_1 )
{
    for ( var_2 = 0; var_2 < var_0.scriptmodel.size; var_2++ )
    {
        if ( isdefined( var_1["explosion"] ) )
        {
            var_3 = anglestoforward( var_0.scriptmodel[var_2].angles );
            var_3 = var_3 * 120;
            var_3 = var_3 + var_0.scriptmodel[var_2].origin;
            playfx( level._effect[var_1["explosion"]], var_0.scriptmodel[var_2].origin );
            radiusdamage( var_0.scriptmodel[var_2].origin, 350, 700, 50 );
        }

        var_0.scriptmodel[var_2] delete();
    }
}

notetrack_effect( var_0, var_1 )
{
    var_2 = isdefined( var_1["moreThanThreeHack"] );

    if ( var_2 )
        scripts\engine\utility::lock( "moreThanThreeHack" );

    playfxontag( level._effect[var_1["effect"]], var_0, var_1["selftag"] );

    if ( var_2 )
        scripts\engine\utility::unlock( "moreThanThreeHack" );
}

trace_part_for_efx_cancel( var_0 )
{
    self notify( "cancel_trace_for_part_" + var_0 );
}

trace_part_for_efx( var_0, var_1, var_2, var_3 )
{
    var_4 = "trace_part_for_efx";
    self endon( "cancel_trace_for_part_" + var_0 );
    var_5 = self gettagorigin( var_0 );
    var_6 = 0;
    var_7 = spawnstruct();
    var_7.last_pos = self gettagorigin( var_0 );
    var_7.hit_surface = 0;
    var_7.part = var_0;
    var_7.hit_water = 0;
    var_7.effect = var_1;
    var_7.stationary = 0;
    var_7.last_motion_time = gettime();

    while ( isdefined( self ) && !var_7.hit_surface )
    {
        scripts\engine\utility::lock( var_4 );
        test_trace_tag( var_7 );
        scripts\engine\utility::unlock_wait( var_4 );

        if ( var_7.stationary == 1 && gettime() - var_7.last_motion_time > 3000 )
            return;
    }

    if ( !isdefined( self ) )
        return;

    if ( isdefined( var_2 ) && var_7.hit_water )
        var_1 = var_2;

    playfx( var_1, var_7.last_pos );

    if ( var_3 == 0 )
        self hidepart( var_0 );
    else
        thread hidepartatdepth( var_7.last_pos[2] - var_3, var_0 );
}

hidepartatdepth( var_0, var_1 )
{
    self endon( "entitydeleted" );

    while ( self gettagorigin( var_1 )[2] > var_0 )
        wait 0.05;

    self hidepart( var_1 );
}

test_trace_tag( var_0 )
{
    var_1 = undefined;

    if ( !isdefined( self ) )
        return;

    var_0.current_pos = self gettagorigin( var_0.part );

    if ( var_0.current_pos != var_0.last_pos )
    {
        var_0.last_motion_time = gettime();
        var_0.stationary = 0;

        if ( !scripts\engine\trace::_bullet_trace_passed( var_0.last_pos, var_0.current_pos, 0, self ) )
        {
            var_2 = scripts\engine\trace::_bullet_trace( var_0.last_pos, var_0.current_pos, 0, self );

            if ( var_2["fraction"] < 1.0 )
            {
                var_0.last_pos = var_2["position"];
                var_0.hit_water = var_2["surfacetype"] == "water";
                var_0.hit_surface = 1;
                return;
            }
            else
            {

            }
        }
    }
    else
        var_0.stationary = 1;

    var_0.last_pos = var_0.current_pos;
}

_add_z( var_0, var_1 )
{
    return ( var_0[0], var_0[1], var_0[2] + var_1 );
}

validatenotetracks( var_0, var_1, var_2 )
{

}

printnotetracks( var_0 )
{

}

animsound_start_tracker( var_0, var_1 )
{
    add_to_animsound();
    var_2 = spawnstruct();
    var_2.anime = var_0;
    var_2.notetrack = "#" + var_0;
    var_2.animname = var_1;
    var_2.end_time = gettime() + 60000;

    if ( animsound_exists( var_0, var_2.notetrack ) )
        return;

    add_animsound( var_2 );
}

animsound_start_tracker_loop( var_0, var_1, var_2 )
{
    add_to_animsound();
    var_0 = var_1 + var_0;
    var_3 = spawnstruct();
    var_3.anime = var_0;
    var_3.notetrack = "#" + var_0;
    var_3.animname = var_2;
    var_3.end_time = gettime() + 60000;

    if ( animsound_exists( var_0, var_3.notetrack ) )
        return;

    add_animsound( var_3 );
}

animsound_tracker( var_0, var_1, var_2 )
{
    var_1 = tolower( var_1 );
    add_to_animsound();

    if ( var_1 == "end" )
        return;

    if ( animsound_exists( var_0, var_1 ) )
        return;

    var_3 = spawnstruct();
    var_3.anime = var_0;
    var_3.notetrack = var_1;
    var_3.animname = var_2;
    var_3.end_time = gettime() + 60000;
    add_animsound( var_3 );
}

animsound_exists( var_0, var_1 )
{
    var_1 = tolower( var_1 );
    var_2 = getarraykeys( self.animsounds );

    for ( var_3 = 0; var_3 < var_2.size; var_3++ )
    {
        var_4 = var_2[var_3];

        if ( self.animsounds[var_4].anime != var_0 )
            continue;

        if ( self.animsounds[var_4].notetrack != var_1 )
            continue;

        self.animsounds[var_4].end_time = gettime() + 60000;
        return 1;
    }

    return 0;
}

add_animsound( var_0 )
{
    for ( var_1 = 0; var_1 < level.animsound_hudlimit; var_1++ )
    {
        if ( isdefined( self.animsounds[var_1] ) )
            continue;

        self.animsounds[var_1] = var_0;
        return;
    }

    var_2 = getarraykeys( self.animsounds );
    var_3 = var_2[0];
    var_4 = self.animsounds[var_3].end_time;

    for ( var_1 = 1; var_1 < var_2.size; var_1++ )
    {
        var_5 = var_2[var_1];

        if ( self.animsounds[var_5].end_time < var_4 )
        {
            var_4 = self.animsounds[var_5].end_time;
            var_3 = var_5;
        }
    }

    self.animsounds[var_3] = var_0;
}

add_to_animsound()
{
    if ( !isdefined( self.animsounds ) )
        self.animsounds = [];

    var_0 = 0;

    for ( var_1 = 0; var_1 < level.animsounds.size; var_1++ )
    {
        if ( self == level.animsounds[var_1] )
        {
            var_0 = 1;
            break;
        }
    }

    if ( !var_0 )
        level.animsounds[level.animsounds.size] = self;
}
