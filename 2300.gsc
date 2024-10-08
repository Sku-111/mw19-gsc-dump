// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

debug_test_kill_kidnapper()
{
    var_0 = scripts\mp\equipment::getequipmentslotammo( "health" );

    if ( var_0 <= 0 )
        return;

    if ( self isparachuting() )
    {
        self notify( "br_try_armor_cancel" );
        return;
    }

    if ( isdefined( self.cam ) )
        self.cam--;

    var_1 = scripts\engine\utility::ter_op( scripts\mp\utility\perk::_hasperk( "specialty_br_stronger_armor" ), self.br_maxarmorhealth / 2, self.br_maxarmorhealth / 3 );

    if ( getdvarint( "scr_smartArmor_insertion", 0 ) == 1 )
    {
        var_2 = self.br_armorhealth;
        var_2 = int( var_2 + var_1 );
    }
    else
    {
        var_3 = self.br_armorhealth + 5;
        var_2 = clamp( var_3, 0, self.br_maxarmorhealth );
        var_2 = int( var_2 / var_1 ) * var_1 + var_1;
    }

    self.br_armorhealth = clamp( var_2, 0, self.br_maxarmorhealth );
    debug_state( self.br_armorhealth );
    scripts\mp\equipment::decrementequipmentslotammo( "health", 1 );
    scripts\cp\vehicles\vehicle_compass_cp::_id_120A8( "armor_plate" );
    scripts\mp\gametypes\br_public.gsc::runbrgametypefuncwrapper( "onArmorPlate" );

    if ( scripts\mp\utility\perk::_hasperk( "specialty_reduce_regen_delay_on_plate" ) )
        scripts\mp\perks\perkfunctions::_id_12AD0();

    self notify( "armor_plate_inserted" );
}

debug_swivelroom_start()
{
    var_0 = self.br_armorhealth + 5;
    var_1 = clamp( var_0, 0, self.br_maxarmorhealth );
    var_2 = max( 1, getdvarint( "scr_br_armor_heal_amount", 50 ) );
    var_1 = int( var_1 / var_2 ) * var_2;
    var_3 = clamp( var_1, 0, self.br_maxarmorhealth );

    if ( var_3 >= self.br_armorhealth )
        return;

    self.br_armorhealth = var_3;
    debug_state( self.br_armorhealth );
}

debug_state( var_0 )
{
    var_1 = var_0 * ( 150 / self.br_maxarmorhealth );
    self setclientomnvar( "ui_br_armor_amount", int( var_1 ) );
    scripts\mp\gametypes\br_public.gsc::updatebrscoreboardstat( "armorHealthRatio", int( var_1 ) );
}

demo_update_hint_logic( var_0, var_1 )
{
    self endon( "disconnect" );

    if ( var_1 == 0 )
        return;

    if ( istrue( self.tracking_max_health ) )
        return;

    if ( self isswitchingweapon() )
        return;

    if ( !delay_end_soldiers_spawns() )
        return;

    var_2 = getcompleteweaponname( "armor_plate_deploy_mp" );
    var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "", self );
    var_3.camera_character_preview_select = var_2;
    deletetmtylheadicon( 1 );
    thread denyascendmessagelaststand();
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon( var_2, var_3, ::delay_end_common_combat, undefined, undefined, undefined, undefined, 0 );
}

denyascendmessagelaststand()
{
    self endon( "br_armor_repair_end" );
    self endon( "disconnect" );
    debug_run_helicopter_boss();
    thread depletiondelay();
    self._id_138D4 = 0;
    scripts\engine\utility::_id_143A9( "death", "mantle_start", "last_stand_start", "special_weapon_fired", "br_try_armor_cancel", "br_armor_plate_done" );
    self._id_138D4 = 1;
    thread debug_trans_1_start();
}

depletiondelay()
{
    self endon( "disconnect" );
    self endon( "br_armor_repair_end" );

    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && self.currentweapon.basename != "armor_plate_deploy_mp" )
    {
        if ( self isonladder() )
            self notify( "br_try_armor_cancel" );

        waitframe();
    }

    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && self.currentweapon.basename == "armor_plate_deploy_mp" )
    {
        if ( self isonladder() )
            self notify( "br_try_armor_cancel" );

        waitframe();
    }

    self notify( "br_try_armor_cancel" );
}

deletetmtylheadicon( var_0 )
{
    scripts\common\utility::allow_melee( !var_0 );
    scripts\common\utility::allow_killstreaks( !var_0 );
    scripts\common\utility::allow_crate_use( !var_0 );
    scripts\mp\equipment::allow_equipment( !var_0 );
    scripts\common\utility::allow_offhand_weapons( !var_0 );
    scripts\common\utility::brjugg_onplayerkilled( !var_0 );
    self.tracking_max_health = var_0;
}

delay_end_common_combat( var_0 )
{
    self endon( "disconnect" );
    self endon( "br_armor_repair_end" );

    if ( !delay_end_soldiers_spawns() || istrue( self._id_138D4 ) )
        return;

    var_1 = gettime();
    var_2 = var_1 + 1860.0;
    var_3 = 2000.0;
    var_4 = 1860.0;

    for ( var_5 = 0; var_1 < var_2; var_1 = gettime() )
    {
        if ( !isdefined( var_0.camera_character_preview_select ) || var_0.camera_character_preview_select != self getcurrentweapon() )
            return;

        waitframe();
    }

    debug_test_kill_kidnapper();
    var_6 = ( var_3 - var_4 ) / 1000;
    wait( var_6 );

    while ( deletepropsifatmax() )
    {
        var_7 = self.equipment["health"];
        var_8 = scripts\mp\equipment::getequipmentslotammo( "health" );

        if ( isdefined( var_7 ) && isdefined( var_8 ) && var_8 > 0 && self.br_armorhealth < self.br_maxarmorhealth )
        {
            var_9 = gettime() + 1250.0;

            while ( gettime() < var_9 )
            {
                if ( !isdefined( var_0.camera_character_preview_select ) || var_0.camera_character_preview_select != self getcurrentweapon() )
                    return;

                waitframe();
            }

            debug_test_kill_kidnapper();
            var_10 = 0.25;
            wait( var_10 );
            continue;
        }

        break;
    }

    self notify( "br_armor_plate_done" );
}

delay_end_soldiers_spawns()
{
    if ( isdefined( self.vehicle ) )
    {
        var_0 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat( self.vehicle, self );

        if ( var_0 == "driver" )
            return 0;
    }

    var_1 = self isskydiving() || self isonladder();
    var_2 = istrue( self._id_12D1E ) || istrue( self.isjuggernaut );
    var_2 = var_2 | ( scripts\mp\supers::issuperinuse() && ( self.super.staticdata.ref != "super_deadsilence" && self.super.staticdata.ref != "super_serum_gadget" ) );

    if ( var_1 || var_2 )
        return 0;

    if ( self.br_armorhealth == self.br_maxarmorhealth )
    {
        scripts\mp\hud_message::showerrormessage( level.br_pickups.delete_furthest_respawn_enemy );
        return 0;
    }

    return 1;
}

deletepropsifatmax()
{
    var_0 = scripts\engine\utility::is_player_gamepad_enabled() && self allowspectateallteams();
    var_1 = isdefined( self.cam ) && self.cam > 0;
    return var_0 || var_1;
}

debug_run_helicopter_boss()
{
    self notifyonplayercommand( "br_try_armor_cancel", "+weapnext" );
    self notifyonplayercommand( "br_try_armor_cancel", "+weapprev" );
    self notifyonplayercommand( "br_try_armor_cancel", "+attack" );
    self notifyonplayercommand( "br_try_armor_cancel", "+smoke" );
    self notifyonplayercommand( "br_try_armor_cancel", "+frag" );
    self notifyonplayercommand( "br_try_armor_cancel", "+melee_zoom" );
}

delete_wire_blocker_on_trigger()
{
    self notifyonplayercommandremove( "br_try_armor_cancel", "+weapnext" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+weapprev" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+attack" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+smoke" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+frag" );
    self notifyonplayercommandremove( "br_try_armor_cancel", "+melee_zoom" );
}

debug_trans_1_start()
{
    self endon( "disconnect" );
    self notify( "br_armor_repair_end" );
    delete_wire_blocker_on_trigger();

    while ( isdefined( self.currentweapon ) && isdefined( self.currentweapon.basename ) && self.currentweapon.basename == "armor_plate_deploy_mp" )
        waitframe();

    waitframe();

    if ( istrue( self.cam ) )
        self.cam = 0;

    deletetmtylheadicon( 0 );
}