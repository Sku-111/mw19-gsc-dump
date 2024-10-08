// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    setdvar( "scr_br_altprematchloadout", "classtable_brdbd_prematch" );
    scripts\mp\gametypes\br_gametypes.gsc::_id_12B11( "regenHealthAdd", ::_id_1264B );
    scripts\mp\gametypes\br_gametypes.gsc::_id_12B11( "postMainInit", ::_id_12803 );
    scripts\mp\gametypes\br_gametypes.gsc::_id_12B11( "playerNakedDropLoadout", ::_id_12604 );
    scripts\mp\gametypes\br_gametypes.gsc::_id_12B11( "playerAdditionalGulagDropLogic", ::playergulagdroploadout );

    if ( getdvarint( "scr_br_tdbd_hunter_enabled", 1 ) == 1 )
    {
        _keypadscriptableused_bunkeralt::init();
        _ispointinbadarea::init();
    }

    if ( getdvarint( "scr_br_resurgence_respawn_enable", 0 ) == 1 )
    {
        level thread scripts\mp\gametypes\br_gametype_rebirth.gsc::enabledskiplaststand();
        level thread scripts\mp\gametypes\br_gametype_rebirth.gsc::enable_traversals_for_bombers();
    }

    if ( getdvarint( "scr_br_dbd_vehicle_littlebird", 0 ) == 0 )
        scripts\mp\gametypes\br_gametypes.gsc::load_sequence_3_vfx( "littleBirdSpawns" );

    if ( getdvarint( "scr_br_dbd_vehicle_truck", 0 ) == 0 )
        scripts\mp\gametypes\br_gametypes.gsc::load_sequence_3_vfx( "truckSpawns" );

    if ( getdvarint( "scr_br_dbd_vehicle_jeep", 0 ) == 0 )
        scripts\mp\gametypes\br_gametypes.gsc::load_sequence_3_vfx( "jeepSpawns" );

    if ( getdvarint( "scr_br_dbd_vehicle_tacrover", 0 ) == 0 )
        scripts\mp\gametypes\br_gametypes.gsc::load_sequence_3_vfx( "tacRoverSpawns" );

    if ( getdvarint( "scr_br_dbd_vehicle_atv", 0 ) == 0 )
        scripts\mp\gametypes\br_gametypes.gsc::load_sequence_3_vfx( "atvSpawns" );

    if ( getdvarint( "scr_br_dbd_vehicle_motorcycle", 0 ) == 0 )
        scripts\mp\gametypes\br_gametypes.gsc::load_sequence_3_vfx( "motorcycleSpawns" );

    level._id_11C95 = ::_id_11C95;
    level.disable_super_in_turret.iscontender = getdvarfloat( "scr_br_dbd_healthregenrate", 1 );
    level.disable_super_in_turret.iscloseto = getdvarfloat( "scr_br_dbd_gasdamagesclar", 1.5 );
    level.disable_super_in_turret.iscrossbowbolt = getdvarfloat( "scr_br_dbd_stimregenscalar", 4 );
}

_id_12803()
{
    if ( getdvarint( "scr_dbd_fall_height_modifier_enable", 1 ) == 0 )
        return;

    setdvar( "NKTQRKRMTS", getdvarint( "scr_br_dbd_fallheightmin", 1120 ) );
    setdvar( "LKMOLLSKKO", getdvarint( "scr_br_dbd_fallheightmax", 1121 ) );
    setdvar( "OMLLLQKQSR", getdvarint( "scr_br_dbd_fallheightmin", 1120 ) );
    setdvar( "LTMMLKRKTR", getdvarint( "scr_br_dbd_fallheightmax", 1121 ) );
    level thread soundbank_load();
}

_id_1264B( var_0 )
{
    if ( istrue( self.adrenalinepoweractive ) )
        return float( level.disable_super_in_turret.iscontender * level.disable_super_in_turret.iscrossbowbolt );

    return float( level.disable_super_in_turret.iscontender );
}

_id_11C95( var_0 )
{
    return int( var_0 * level.disable_super_in_turret.iscloseto );
}

_id_12604()
{
    scripts\mp\gametypes\br.gsc::searchcircleorigin( 0, 1, 0 );
    scripts\mp\gametypes\br_pickups.gsc::br_forcegivecustompickupitem( self, "brloot_self_revive", 1 );
}

playergulagdroploadout()
{
    scripts\mp\gametypes\br_pickups.gsc::br_forcegivecustompickupitem( self, "brloot_self_revive", 1 );
    scripts\mp\gametypes\br_pickups.gsc::br_forcegivecustompickupitem( self, "brloot_armor_plate", 1, 2 );
    scripts\mp\gametypes\br_pickups.gsc::br_forcegivecustompickupitem( self, "brloot_ammo_12g", 1, 12 );
    scripts\mp\gametypes\br_pickups.gsc::br_forcegivecustompickupitem( self, "brloot_ammo_50cal", 1, 10 );
    scripts\mp\gametypes\br_pickups.gsc::br_forcegivecustompickupitem( self, "brloot_ammo_762", 1, 60 );
}

soundbank_load()
{
    wait 5.0;
    scripts\mp\utility\sound::besttime( "br_mode_titanium_trials" );
}
