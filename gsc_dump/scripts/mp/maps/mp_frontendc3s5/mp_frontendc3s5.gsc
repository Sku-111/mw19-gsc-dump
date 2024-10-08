// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    scripts\mp\maps\mp_frontendc3s5\mp_frontendc3s5_precache.gsc::main();
    scripts\mp\maps\mp_frontendc3s5\gen\mp_frontendc3s5_art.gsc::main();
    level.playersleftloop = 1;
    game["attackers"] = "allies";
    game["defenders"] = "axis";
    scripts\cp_mp\frontendutils::_id_131E2();
    scripts\cp_mp\frontendutils::create_camera_position_list();
    scripts\cp_mp\frontendutils::setup_initial_entities();
    level.transition_interrupted = 0;
    var_0 = 0.1;
    scripts\engine\utility::delaythread( var_0, scripts\cp_mp\frontendutils::playersetiszombie );
    level thread init_fx();
    level.callbackplayerconnect = ::callback_frontendplayerconnect;
    level thread _id_11DB7();
}

_id_11DB7()
{
    var_0 = getent( "mp_lobby_floor_01", "targetname" );
    var_1 = getent( "mp_lobby_floor_02", "targetname" );
    var_2 = getent( "frontend_rfl_probe_01", "targetname" );
    var_3 = getent( "frontend_rfl_probe_02", "targetname" );
    var_2 linkto( var_0 );
    var_3 linkto( var_1 );
}

init_fx()
{
    level._effect["lava"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_br3_frontend_magmaflow_smk.vfx" );
    level._effect["steam"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_steampressure.vfx" );
    level._effect["dust"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_dust.vfx" );
    level._effect["vfx_br3_frontend_grid_smk"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_br3_frontend_grid_smk.vfx" );
    level._effect["vfx_frontend_amb_mplobby_ch3_s5"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_ch3_s5.vfx" );
    level._effect["vfx_frontend_amb_mplobby_dust"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_dust.vfx" );
    level._effect["vfx_br3_dust_motes_fast_med"] = loadfx( "vfx/iw8_br/island/gen_amb/vfx_br3_dust_motes_fast_med.vfx" );
    level._effect["vfx_br3_dust_motes_sml"] = loadfx( "vfx/iw8_br/island/gen_amb/vfx_br3_dust_motes_sml.vfx" );
    level._effect["vfx_frontend_amb_mplobby_steampressure"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_frontend_amb_mplobby_steampressure.vfx" );
    level._effect["vfx_br3_frontend_magmaflow_smk"] = loadfx( "vfx/iw8/level/frontend/ch3_s5/vfx_br3_frontend_magmaflow_smk.vfx" );
}

callback_frontendplayerconnect()
{
    thread onplayerconnectrunonce();
    thread scripts\cp_mp\frontendutils::frontend_camera_watcher( ::gas_trap_cloud_structs );
    thread scripts\cp_mp\frontendutils::epictauntlistener();
    thread scripts\cp_mp\frontendutils::luinotifylistener();
}

onplayerconnectrunonce()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    level.playerviewowner = self;

    if ( isdefined( level.playerconnectedevents ) )
        return;

    level.playerconnectedevents = 1;
    scripts\engine\utility::init_struct_class();
    scripts\cp_mp\frontendutils::playersetisbecomingzombie();
    scripts\cp_mp\frontendutils::playersetispropgameextrainfo();
    thread scripts\cp_mp\frontendutils::_id_13205();
    scripts\cp_mp\frontendutils::initialize_transition_array();
    self enablephysicaldepthoffieldscripting();
    wait 0.5;
    scripts\mp\maps\mp_frontendc3s5\mp_frontendc3s5_fx.gsc::main();
    scripts\mp\maps\mp_frontendc3s5\mp_frontendc3s5_lighting.gsc::main();
}

target_check_grenade()
{
    if ( isdefined( level._id_13970 ) )
        return;

    level._id_13970 = 1;
    var_0 = getentarray( "sun_frontend_seasonal_target", "targetname" );

    if ( isdefined( var_0 ) && var_0.size > 0 )
        level._id_1396F = var_0[0];
}

gas_trap_cloud_structs( var_0 )
{
    target_check_grenade();
    scripts\cp_mp\frontendutils::camera_section_change( var_0 );
    var_1 = istrue( level._id_13370 );
    var_2 = var_1 && getdvarint( "frontend_seasonal_sun", 0 ) != 0 && isdefined( level._id_1396F );

    if ( var_2 )
    {
        var_3 = "seasonal_nonwalking";

        if ( isdefined( var_0 ) && isdefined( var_0.name ) )
        {
            switch ( var_0.name )
            {
                case "squad_lobby_detail":
                case "squad_lobby":
                    var_3 = "seasonal_walking";
            }
        }

        level._id_1396F setscriptablepartstate( "sun", var_3 );
    }
}
