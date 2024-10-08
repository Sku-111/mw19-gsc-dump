// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

mortar_launcher_init()
{
    load_fx();
    var_0 = getentarray( "player_mortar", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        setupmortarmodelanimscripts();
        setupmortarplayeranimscripts();
    }
    else
        return;

    foreach ( var_2 in var_0 )
    {
        if ( istrue( level.ismp ) )
        {
            if ( !isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) || isdefined( scripts\cp_mp\utility\game_utility::getlocaleid() ) && isdefined( var_2.script_noteworthy ) && var_2.script_noteworthy != level.localeid )
            {
                var_2 delete();
                continue;
            }
        }

        var_2 thread mortar_test( var_2 );
    }
}

load_fx()
{
    level._effect["vfx_flare_launch"] = loadfx( "vfx/iw8/level/embassy/vfx_mortar_fire.vfx" );
    level._effect["vfx_mortar_trail"] = loadfx( "vfx/iw8/level/highway/vfx_mortar_trail.vfx" );
    level._effect["vfx_mortar_explosion"] = loadfx( "vfx/iw8/weap/_explo/mortar/vfx_mortar_explosion_bm.vfx" );
}

#using_animtree("script_model");

setupmortarplayeranimscripts()
{
    level.scr_animtree["player_mortar"] = #animtree;
    level.scr_anim["player_mortar"]["player_mortar_fire"] = %emb_vm_mortar_player;
    level.scr_animname["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
    level.scr_eventanim["player_mortar"]["player_mortar_fire"] = "player_mortar_fire";
    level.scr_viewmodelanim["player_mortar"]["player_mortar_fire"] = "emb_vm_mortar_player";
}

setupmortarmodelanimscripts()
{
    level.scr_animtree["mortar"] = #animtree;
    level.scr_model["mortar"] = "misc_wm_mortar";
    level.scr_anim["mortar"]["player_mortar_fire"] = %emb_vm_mortar_mortar;
    level.scr_animname["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
    level.scr_viewmodelanim["mortar"]["player_mortar_fire"] = "emb_vm_mortar_mortar";
}

create_player_rig( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_0.animname = var_1;
    var_0 predictstreampos( var_0.origin );
    var_4 = spawn( "script_arms", var_0.origin, 0, 0, var_0 );
    var_4.player = var_0;
    var_0.player_rig = var_4;
    var_0.player_rig hide();
    var_0.player_rig.animname = var_1;
    var_0.player_rig useanimtree( #animtree );
}

put_player_into_rig( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_6 scripts\common\utility::allow_ads( 0 );
    var_6 scripts\common\utility::allow_prone( 0 );
    var_6 scripts\common\utility::allow_crouch( 0 );
    var_6 scripts\common\utility::allow_weapon_switch( 0 );

    if ( var_1 > 0.0 )
    {
        var_6 playerlinktoblend( var_0, "tag_player", var_1, 0, 0 );
        wait( var_1 );
    }

    var_6 playerlinktodelta( var_0, "tag_player", 1, var_2, var_3, var_4, var_5, 1 );
}

take_player_out_of_rig( var_0 )
{
    var_0 scripts\common\utility::allow_weapon( 1, "mortar" );
    var_0 scripts\common\utility::allow_ads( 1 );
    var_0 scripts\common\utility::allow_prone( 1 );
    var_0 scripts\common\utility::allow_crouch( 1 );
    var_0 scripts\common\utility::allow_weapon_switch( 1 );
    var_0 unlink();
    var_0.player_rig delete();
}

mortar_launch_player_effect( var_0, var_1 )
{
    if ( !istrue( level.ismp ) )
        var_1 playsound( "weap_mortar_load" );

    wait 2.2;
    var_0 playrumbleonentity( "damage_bullet" );
    earthquake( 0.24, 1, var_1.origin, 256 );
    var_1 hidepart( var_1.shell, "misc_wm_mortar" );
}

movemortar( var_0, var_1, var_2, var_3, var_4 )
{
    setdvarifuninitialized( "scr_mortar_gravity", "0 " );

    if ( getdvarint( "scr_mortar_gravity" ) )
    {
        var_0.origin = var_1;
        var_5 = getdvarint( "NPOQPMP" );
        var_6 = distance( var_1, var_2 );
        var_7 = var_2 - var_1;
        var_8 = 0.5 * var_5 * squared( var_3 ) * -1;
        var_9 = ( var_7[0] / var_3, var_7[1] / var_3, ( var_7[2] - var_8 ) / var_3 );
        var_0 movegravity( var_9, var_3 );
        var_10 = gettime() + var_3 * 1000;

        while ( gettime() < var_10 )
        {
            var_0 anglemortar();
            waitframe();
        }
    }
    else
    {
        var_11 = 1200;

        if ( isdefined( var_4 ) )
            var_11 = var_4;

        var_12 = 1 / ( var_3 / 0.05 );
        var_13 = 0;

        while ( var_13 < 1 )
        {
            var_0.origin = scripts\engine\math::get_point_on_parabola( var_1, var_2, var_11, var_13 );
            var_0 anglemortar();
            var_13 = var_13 + var_12;
            wait 0.05;
        }

        var_0.origin = var_2;
    }
}

anglemortar()
{
    if ( !isdefined( self.prevorigin ) )
    {
        self.prevorigin = self.origin;
        self.roll = 0;
        return;
    }

    self.angles = vectortoangles( self.origin - self.prevorigin );
    self.prevorigin = self.origin;
}

mortar_test( var_0 )
{
    if ( !istrue( level.ismp ) )
        var_0.interact = mortarlauncher_createhintobject( var_0.origin + ( 0, 0, 40 ), "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/ROOF_DEFEND", undefined, undefined, "show", 50, 160, 32, 120 );
    else
        var_0.interact = mortarlauncher_createhintobject( var_0.origin + ( 0, 0, 40 ), "HINT_BUTTON", undefined, &"MP_INGAME_ONLY/USE_MORTAR", undefined, undefined, "show", 256, 160, 128, 160 );

    var_0.flash = "j_shaft_top";
    var_0.shell = "j_mortar_shell";
    var_0 hidepart( var_0.shell, "misc_wm_mortar" );
    var_0.animname = "mortar";
    var_0 useanimtree( #animtree );
    var_0.og_angles = var_0.angles;

    for (;;)
    {
        var_0.interact makeusable();
        var_0.interact waittill( "trigger", var_1 );
        var_1 scripts\common\utility::allow_usability( 0 );
        var_0.interact makeunusable();
        player_launch_mortar( var_1, var_0 );
        wait 5;
        var_0 rotateto( var_0.og_angles, 0.1 );
        wait 1;
    }
}

player_launch_mortar( var_0, var_1 )
{
    self endon( "death_or_disconnect" );
    var_0 setorigin( var_1.origin );
    var_0 setplayerangles( var_1.angles );
    var_0 create_player_rig( var_0, "player_mortar" );
    var_0.player_rig.angles = var_1.angles;
    put_player_into_rig( var_0.player_rig, 0.5, 0, 0, 0, 0, var_0 );
    var_0 scripts\common\utility::allow_weapon( 0, "mortar" );
    var_2 = var_0 mortar_targetting( var_1 );

    if ( isdefined( var_2 ) )
    {
        var_0 playerlinktodelta( var_0.player_rig, "tag_player", 1, 0, 0, 0, 0, 1 );
        var_3 = vectortoangles( var_2 - var_1.origin );
        var_1.angles = ( 0, var_3[1], 0 );
        var_1 showpart( var_1.shell, "misc_wm_mortar" );
        var_0.player_rig show();
        var_1 scripts\engine\utility::delaythread( 2.25, ::launch_mortar, var_2, var_0 );
        thread mortar_launch_player_effect( var_0, var_1 );
        var_1 thread scripts\common\anim::anim_single( [ var_1, var_0.player_rig ], "player_mortar_fire" );
        var_0.player_rig waittillmatch( "single anim", "end" );
        var_1 notify( "mortar_fired" );
    }

    var_0 scripts\common\utility::allow_usability( 1 );
    var_1 hidepart( var_1.shell, "misc_wm_mortar" );
    take_player_out_of_rig( var_0 );

    if ( isdefined( var_1.previs_model ) )
        var_1.previs_model delete();
}

mortar_targetting( var_0 )
{
    self endon( "death_or_disconnect" );
    thread mortar_ondeathcleanup( var_0 );
    var_1 = undefined;
    self playerlinktodelta( self.player_rig, "tag_player", 0, 45, 45, 60, 60, 1 );

    if ( isdefined( var_0.previs_model ) )
        var_0.previs_model setscriptablepartstate( "target", "active" );

    for (;;)
    {
        if ( self stancebuttonpressed() || self attackbuttonpressed() )
        {
            if ( self attackbuttonpressed() )
            {
                while ( self attackbuttonpressed() )
                    wait 0.05;

                return var_1;
            }

            while ( self stancebuttonpressed() )
                wait 0.05;

            return undefined;
        }

        var_2 = scripts\engine\trace::ray_trace( self geteye() + ( 0, 0, 128 ), self geteye() + anglestoforward( self getplayerangles() ) * 16000 );
        var_1 = getgroundposition( var_2["position"], 8, 0, 1500 );
        var_3 = vectortoangles( var_1 - var_0.origin );
        var_0.angles = ( 0, var_3[1], 0 );

        if ( !isdefined( var_0.previs_model ) )
        {
            var_0.previs_model = spawn( "script_model", var_1 );
            var_0.previs_model setmodel( "mortar_target" );
            var_0.previs_model.angles = ( -90, 0, 0 );
            var_0.previs_model setscriptablepartstate( "target", "active" );

            foreach ( var_5 in level.players )
                var_0.previs_model hidefromplayer( var_5 );

            var_0.previs_model showtoplayer( self );
        }

        var_0.previs_model moveto( var_1 + ( 0, 0, 10 ), 0.1 );
        wait 0.05;
    }
}

mortar_ondeathcleanup( var_0 )
{
    var_0 endon( "mortar_fired" );
    self waittill( "death_or_disconnect" );

    if ( isdefined( var_0.previs_model ) )
        var_0.previs_model delete();
}

launch_mortar( var_0, var_1 )
{
    var_2 = self gettagorigin( "j_shaft_top" );
    var_3 = getgroundposition( self.origin + anglestoforward( self.angles ) * 8000, 8, 1000 );

    if ( isdefined( var_0 ) )
        var_3 = var_0;

    var_4 = scripts\engine\utility::spawn_tag_origin( self gettagorigin( "j_shaft_top" ), ( 0, 0, 0 ) );
    var_4 setmodel( "equipment_mortar_shell_improvised_01_mp" );
    playfx( scripts\engine\utility::getfx( "vfx_flare_launch" ), self.origin + ( 0, 0, 3 ) + anglestoforward( self.angles ) * 8, anglestoforward( self.angles ) );

    if ( !istrue( level.ismp ) )
        playsoundatpos( self gettagorigin( "j_shaft_top" ), "weap_mortar_flare_launch" );
    else
        playsoundatpos( self gettagorigin( "j_shaft_top" ), "weap_mortar_flare_launch" );

    var_4 show();
    var_5 = 5;
    thread movemortar( var_4, var_2, var_3, var_5, 1200 );
    wait 0.1;
    playfxontag( scripts\engine\utility::getfx( "vfx_mortar_trail" ), var_4, "tag_origin" );

    if ( !istrue( level.ismp ) )
        var_4 playloopsound( "weap_mortar_fly_lp" );
    else
        var_4 playloopsound( "weap_mortar_fly_lp" );

    wait( var_5 - 1.7 );

    if ( !istrue( level.ismp ) )
        var_4 playsound( "weap_mortar_incoming" );

    wait 1.7;
    stopfxontag( scripts\engine\utility::getfx( "vfx_mortar_trail" ), var_4, "tag_origin" );
    var_4 stoploopsound();
    playfx( scripts\engine\utility::getfx( "vfx_mortar_explosion" ), var_3 );
    earthquake( 0.25, 3, var_3, 2048 );

    if ( !istrue( level.ismp ) )
        playrumbleonposition( "cp_chopper_rumble", var_3 );
    else
    {
        playrumbleonposition( "grenade_rumble", var_3 );
        playsoundatpos( var_3, "weap_mortar_expl_trans" );
    }

    magicgrenademanual( "mortar_mp", var_3 + ( 0, 0, 5 ), ( 0, 0, 0 ), 0.05 );

    if ( !istrue( level.ismp ) )
        radiusdamage( var_3 + ( 0, 0, 5 ), 512, 250, 250, var_1, "MOD_EXPLOSIVE", "c4_mp_p" );
    else
        radiusdamage( var_3 + ( 0, 0, 5 ), 512, 1000, 250, var_1, "MOD_EXPLOSIVE", "c4_mp_p" );

    var_4 delete();
}

kill_mortar_target()
{
    self.previs_model setscriptablepartstate( "target", "neutral" );
}

mortarlauncher_createhintobject( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 )
{
    var_12 = undefined;

    if ( isdefined( var_11 ) )
        var_12 = var_11;
    else
        var_12 = spawn( "script_model", var_0 );

    var_12 makeusable();

    if ( isdefined( var_11 ) && isdefined( var_0 ) )
        var_12 sethinttag( var_0 );

    if ( isdefined( var_1 ) )
        var_12 setcursorhint( var_1 );
    else
        var_12 setcursorhint( "HINT_NOICON" );

    if ( isdefined( var_2 ) )
        var_12 sethinticon( var_2 );

    if ( isdefined( var_3 ) )
        var_12 sethintstring( var_3 );

    if ( isdefined( var_4 ) )
        var_12 setusepriority( var_4 );
    else
        var_12 setusepriority( 0 );

    if ( isdefined( var_5 ) )
        var_12 setuseholdduration( var_5 );
    else
        var_12 setuseholdduration( "duration_short" );

    if ( isdefined( var_6 ) )
        var_12 sethintonobstruction( var_6 );
    else
        var_12 sethintonobstruction( "hide" );

    if ( isdefined( var_7 ) )
        var_12 sethintdisplayrange( var_7 );
    else
        var_12 sethintdisplayrange( 200 );

    if ( isdefined( var_8 ) )
        var_12 sethintdisplayfov( var_8 );
    else
        var_12 sethintdisplayfov( 160 );

    if ( isdefined( var_9 ) )
        var_12 setuserange( var_9 );
    else
        var_12 setuserange( 50 );

    if ( isdefined( var_10 ) )
        var_12 setusefov( var_10 );
    else
        var_12 setusefov( 120 );

    if ( !isdefined( var_11 ) )
        return var_12;
}