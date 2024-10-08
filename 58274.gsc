// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level._effect["vfx_2x_points_screen_fx"] = loadfx( "vfx/iw8_br/gameplay/rumble/vfx_rum_2x_scrnfx" );
    level._effect["vfx_2x_points_victim_explosion"] = loadfx( "vfx/iw8_br/gameplay/rumble/vfx_rum_victim_2x_explosion" );
    level._effect["vfx_2x_points_hand_glow"] = loadfx( "vfx/iw8_br/gameplay/rumble/vfx_rum_2x_hands_trail" );
    game["dialog"]["powerup_double_points"] = "power_up_double_points";
    var_0 = spawnstruct();
    var_0._id_138FD = "double_points";
    var_0.parachute_get_path = getdvarfloat( "scr_brPowerups_double_points_buff_duration", 45 );
    var_0.asm_playfacialanim_mp = ::asm_playfacialanim_mp;
    var_0._id_12A35 = ::_id_12A35;
    var_0.isdeathshieldskippingenabled = ::isdeathshieldskippingenabled;
    _keypadscriptableused_bunkeralt::_id_12AF4( var_0 );
}

asm_playfacialanim_mp()
{
    self._id_1265D = 0;
    self._id_11E08 = 2;
    self.player._id_12827 = 1;
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "powerup_double_points", self.player );
    thread _id_135B7();
    self.player playlocalsound( "mp_powerup_activate_2x_plr" );
    _keypadscriptableused_bunkeralt::_id_12425( self.player, "br_rumble_powerup_double_points_activated" );
}

isdeathshieldskippingenabled()
{
    self notify( "singleton_deactivate_func" );
    self endon( "singleton_deactivate_func" );
    self.player._id_12827 = 0;
    thread lb_impulse_dmg_threshold_low();

    if ( isalive( self.player ) )
        self.player playlocalsound( "mp_powerup_deactivate_2x_plr" );
}

_id_12A35()
{
    open_starting_safehouse_door( self._id_12E2D.parachute_get_path );
    self.player playlocalsound( "mp_powerup_reactivate_2x_plr" );
}

_id_11FF1( var_0 )
{
    if ( isdefined( var_0.attacker ) && istrue( var_0.attacker._id_12827 ) )
    {
        playfx( scripts\engine\utility::getfx( "vfx_2x_points_victim_explosion" ), var_0.victim.origin );
        var_1 = easepower( "brloot_rumble_powerup_sfx", var_0.victim.origin );
        var_1 setscriptablepartstate( "sfx", "2x_victim_death_3D" );
        var_0.attacker playlocalsound( "mp_powerup_victim_death_2x_plr" );
        var_2 = var_0.attacker _keypadscriptableused_bunkeralt::_id_1249C( "double_points" );
        var_3 = 50;
    }
}

open_starting_safehouse_door( var_0 )
{
    self.mp_layover_patch = gettime() + var_0 * 1000;
    self.player thread _keypadscriptableused_bunkeralt::_id_13F7E( undefined, 1, 2 );
}

_id_135B7()
{
    playfxontag( scripts\engine\utility::getfx( "vfx_2x_points_hand_glow" ), self.player, "j_wrist_le" );
    playfxontag( scripts\engine\utility::getfx( "vfx_2x_points_hand_glow" ), self.player, "j_wrist_ri" );
    waitframe();
    stopfxontagforclients( scripts\engine\utility::getfx( "vfx_2x_points_hand_glow" ), self.player, "j_wrist_le", self.player );
    waitframe();
    stopfxontagforclients( scripts\engine\utility::getfx( "vfx_2x_points_hand_glow" ), self.player, "j_wrist_ri", self.player );
}

lb_impulse_dmg_threshold_low()
{
    stopfxontag( scripts\engine\utility::getfx( "vfx_2x_points_hand_glow" ), self.player, "j_wrist_le" );
    waitframe();
    stopfxontag( scripts\engine\utility::getfx( "vfx_2x_points_hand_glow" ), self.player, "j_wrist_ri" );
}

isplatepouch()
{
    scripts\mp\gametypes\br_dev.gsc::_id_12B21( ::isplacementplayerobstructed );
    level thread isplayerbrsquadleader();
}

isplayerbrsquadleader()
{
    level endon( "game_ended" );

    while ( !isdefined( level.player ) )
        waitframe();
}

isplacementplayerobstructed( var_0, var_1 )
{
    var_2 = "";

    switch ( var_0 )
    {
        case "rmbl_give_double_points_powerup":
            level.player _keypadscriptableused_bunkeralt::_id_1393A( "double_points" );
            break;
        case "rmbl_spawn_double_points_powerup":
            var_3 = level.player.origin + anglestoforward( level.player.angles ) * 300 + ( 0, 0, 25 );
            easepower( "brloot_rumble_powerup_double_points", var_3 );
            break;
        case "rmbl_give_teammate_double_points_powerup":
            var_4 = scripts\mp\utility\teams::getteamdata( level.player.team, "players" );
            var_4 = scripts\engine\utility::array_remove( var_4, level.player );
            var_4[randomintrange( 0, var_4.size )] _keypadscriptableused_bunkeralt::_id_1393A( "double_points" );
            break;
    }
}
