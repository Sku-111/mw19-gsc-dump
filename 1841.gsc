// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.equipment = spawnstruct();
    inititems();
    loadtable();
    timeoflastexecute();
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( ::equiponplayerspawned );
}

inititems()
{
    level.equipment.callbacks = [];
    var_0 = level.equipment;
    scripts\mp\equipment_interact::equipmentinteract_init();

    if ( !istrue( game["isLaunchChunk"] ) )
    {
        scripts\mp\perks\headgear::init();
        scripts\mp\equipment\tactical_cover::tac_cover_init();
        scripts\mp\equipment\trophy_system::trophy_init();
        scripts\mp\equipment\decoy_grenade::decoy_init();
        _donewithcorpse::vehicle_compass_setteamfriendlyto();
        scripts\mp\equipment\slinger.gsc::slinger_init();
        scripts\mp\equipment\at_mine::at_mine_init();
        scripts\mp\equipment\tac_insert::tacinsert_init();
    }

    scripts\mp\equipment\claymore::claymore_init();
    scripts\mp\equipment\molotov::molotov_init();
    _debug_rooftop_raid_exfil::emp_init();
    scripts\mp\equipment\weapon_drop::weapondrop_init();
    scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
    scripts\mp\equipment\numbers_grenade.gsc::init();
    var_0.callbacks["equip_helmet"]["onGive"] = scripts\mp\perks\headgear::runheadgear;
    var_0.callbacks["equip_helmet"]["onTake"] = scripts\mp\perks\headgear::removeheadgear;
    var_0.callbacks["equip_adrenaline"]["onFired"] = scripts\mp\equipment\adrenaline::onequipmentfired;
    var_0.callbacks["equip_adrenaline"]["onTake"] = scripts\mp\equipment\adrenaline::onequipmenttaken;
    var_0.callbacks["equip_c4"]["onGive"] = scripts\mp\equipment\c4::c4_set;
    var_0.callbacks["equip_trophy"]["onGive"] = scripts\mp\equipment\trophy_system::trophy_set;
    var_0.callbacks["equip_trophy"]["onTake"] = scripts\mp\equipment\trophy_system::trophy_unset;
    var_0.callbacks["equip_decon_station"]["onTake"] = _debug_rooftop_heli_start::jugg_go_to_node_callback;
    var_0.callbacks["equip_decon_station"]["onGive"] = _debug_rooftop_heli_start::jugg_getminigunweapon;
    var_0.callbacks["equip_throwing_knife"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
    var_0.callbacks["equip_throwing_knife"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
    var_0.callbacks["equip_throwing_knife_fire"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
    var_0.callbacks["equip_throwing_knife_fire"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
    var_0.callbacks["equip_throwing_knife_electric"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
    var_0.callbacks["equip_throwing_knife_electric"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
    var_0.callbacks["equip_throwing_knife_drill"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
    var_0.callbacks["equip_throwing_knife_drill"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
    var_0.callbacks["equip_molotov"]["onGive"] = scripts\mp\equipment\molotov::molotov_on_give;
    var_0.callbacks["equip_molotov"]["onTake"] = scripts\mp\equipment\molotov::molotov_on_take;
    var_0.callbacks["equip_tac_cover"]["onGive"] = scripts\mp\equipment\tactical_cover::tac_cover_on_give;
    var_0.callbacks["equip_tac_cover"]["onTake"] = scripts\mp\equipment\tactical_cover::tac_cover_on_take;
    var_0.callbacks["equip_tac_cover"]["onFired"] = scripts\mp\equipment\tactical_cover::tac_cover_on_fired;
    var_0.callbacks["equip_tac_insert"]["onGive"] = scripts\mp\equipment\tac_insert::tacinsert_set;
    var_0.callbacks["equip_tac_insert"]["onTake"] = scripts\mp\equipment\tac_insert::tacinsert_unset;
    var_0.callbacks["equip_binoculars"]["onGive"] = _debug_rooftop_activesat::closeobjectiveiconid;
    var_0.callbacks["equip_binoculars"]["onTake"] = _debug_rooftop_activesat::codeloc;
    var_0.callbacks["equip_gas_grenade"]["onPlayerDamaged"] = scripts\mp\equipment\gas_grenade::gas_onplayerdamaged;
    var_0.callbacks["equip_flash"]["onPlayerDamaged"] = scripts\mp\equipment\flash_grenade::onplayerdamaged;
    var_0.callbacks["equip_concussion"]["onPlayerDamaged"] = scripts\mp\equipment\concussion_grenade::onplayerdamaged;
    var_0.callbacks["equip_thermite"]["onPlayerDamaged"] = scripts\mp\equipment\thermite::thermite_onplayerdamaged;
    var_0.callbacks["equip_molotov"]["onPlayerDamaged"] = scripts\mp\equipment\molotov::molotov_on_player_damaged;
    var_0.callbacks["equip_numbers_grenade"]["onPlayerDamaged"] = scripts\mp\equipment\numbers_grenade.gsc::on_player_damaged;
    var_0.callbacks["equip_at_mine"]["onOwnerChanged"] = scripts\mp\equipment\at_mine::at_mine_onownerchanged;
    var_0.callbacks["equip_claymore"]["onOwnerChanged"] = scripts\mp\equipment\claymore::claymore_onownerchanged;
    var_0.callbacks["equip_c4"]["onOwnerChanged"] = scripts\mp\equipment\c4::c4_onownerchanged;
    var_0.callbacks["equip_jammer"]["onOwnerChanged"] = _donewithcorpse::vehicle_compass_updateallvisibilityforplayer;
    var_0.callbacks["equip_at_mine"]["onDestroyedByTrophy"] = scripts\mp\equipment\at_mine::at_mine_delete;
    var_0.callbacks["equip_claymore"]["onDestroyedByTrophy"] = scripts\mp\equipment\claymore::claymore_delete;
    var_0.callbacks["equip_trophy"]["onDestroyedByTrophy"] = scripts\mp\equipment\trophy_system::trophy_delete;
    var_0.callbacks["equip_c4"]["onDestroyedByTrophy"] = scripts\mp\equipment\c4::c4_delete;
    var_0.callbacks["equip_snapshot_grenade"]["onDestroyedByTrophy"] = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_delete;
    thread watchlethaldelay();
    scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback( ::onownerdisconnect );
}

getcallback( var_0, var_1 )
{
    if ( !isdefined( level.equipment.callbacks[var_0] ) )
        return undefined;

    return level.equipment.callbacks[var_0][var_1];
}

loadtable()
{
    level.equipment.table = [];
    var_0 = 1;

    for (;;)
    {
        var_1 = tablelookupbyrow( "mp/equipment.csv", var_0, 1 );

        if ( !isdefined( var_1 ) || var_1 == "" )
            break;

        var_2 = tolower( var_1 );
        var_3 = spawnstruct();
        var_3.ref = var_2;
        var_4 = tablelookupbyrow( "mp/equipment.csv", var_0, 6 );

        if ( var_4 != "none" )
        {
            var_5 = tablelookupbyrow( "mp/equipment.csv", var_0, 19 );
            var_6 = undefined;

            if ( var_5 != "" )
            {
                var_7 = getcompleteweaponname( var_4 );

                if ( !nullweapon( var_7 ) )
                    var_6 = [ var_5 ];
            }

            var_3.objweapon = getcompleteweaponname( var_4, var_6 );
        }

        var_3.id = var_0;
        var_3.image = tablelookupbyrow( "mp/equipment.csv", var_0, 4 );
        var_3.defaultslot = scripts\engine\utility::ter_op( tablelookupbyrow( "mp/equipment.csv", var_0, 7 ) == "2", "secondary", "primary" );
        var_3.scavengerammo = int( tablelookupbyrow( "mp/equipment.csv", var_0, 10 ) );
        var_3.ispassive = tolower( tablelookupbyrow( "mp/equipment.csv", var_0, 11 ) ) == "true";
        var_3.usecellspawns = tablelookupbyrow( "mp/equipment.csv", var_0, 8 ) != "-1";
        var_8 = tablelookupbyrow( "mp/equipment.csv", var_0, 12 );

        if ( var_8 == "none" )
        {

        }
        else if ( var_8 == "" )
        {
            if ( var_4 != "none" )
                var_3.damageweaponnames = [ var_4 ];
        }
        else
        {
            var_9 = [];

            if ( var_4 != "none" )
                var_9[var_9.size] = var_4;

            var_10 = strtok( var_8, " " );

            foreach ( var_12 in var_10 )
                var_9[var_9.size] = var_12;

            var_3.damageweaponnames = var_9;
        }

        level.equipment.table[var_2] = var_3;
        var_0++;
    }
}

getequipmenttableinfo( var_0 )
{
    return level.equipment.table[var_0];
}

giveequipment( var_0, var_1 )
{
    if ( !isdefined( self.equipment ) )
        self.equipment = [];

    if ( var_0 == "none" )
        return;

    var_2 = getequipmenttableinfo( var_0 );

    if ( !isdefined( var_2 ) )
        scripts\mp\utility\script::laststand_dogtags( "Attempting to give unknown equipment - " + var_0 + " - in slot - " + var_1 );
    else
    {
        if ( var_1 == "super" )
        {
            var_3 = level.br_pickups.br_superreference[level.br_pickups.br_equipnametoscriptable[var_0]];
            var_2.id = scripts\mp\supers::getsuperid( var_3 );
        }

        takeequipment( var_1 );

        if ( isdefined( var_2.objweapon ) )
        {
            self giveweapon( var_2.objweapon );

            if ( is_equipment_slot_allowed( var_1 ) && !var_2.ispassive )
            {
                if ( var_1 == "primary" )
                    self assignweaponoffhandprimary( var_2.objweapon );
                else if ( var_1 == "secondary" )
                    self assignweaponoffhandsecondary( var_2.objweapon );
                else if ( var_1 == "super" )
                    self assignweaponoffhandspecial( var_2.objweapon );
            }
        }

        sethudslot( var_1, var_2.id );
        self.equipment[var_1] = var_0;
        var_4 = getcallback( var_0, "onGive" );

        if ( isdefined( var_4 ) )
            self thread [[ var_4 ]]( var_0, var_1 );

        updateuiammocount( var_1 );
        var_5 = var_0 == "equip_throwing_knife" || var_0 == "equip_throwing_knife_fire" || var_0 == "equip_throwing_knife_electric" || var_0 == "equip_throwing_knife_drill";

        if ( scripts\mp\utility\game::getgametype() == "arena" && var_5 )
            return;

        thread watchlethaldelayplayer( var_0, var_1 );
    }
}

takeequipment( var_0 )
{
    var_1 = getcurrentequipment( var_0 );

    if ( !isdefined( var_1 ) )
        return;

    var_2 = getequipmenttableinfo( var_1 );

    if ( isdefined( var_2.objweapon ) )
    {
        if ( self hasweapon( var_2.objweapon ) )
        {
            scripts\cp_mp\utility\inventory_utility::_takeweapon( var_2.objweapon );

            if ( var_0 == "primary" )
                self clearoffhandprimary();
            else if ( var_0 == "secondary" )
                self clearoffhandsecondary();
        }
    }

    sethudslot( var_0, 0 );
    self.equipment[var_0] = undefined;
    var_3 = getcallback( var_1, "onTake" );

    if ( isdefined( var_3 ) )
        self thread [[ var_3 ]]( var_1, var_0 );

    updateuiammocount( var_0 );
    self notify( "equipment_taken_" + var_1 );
}

equiponplayerdamaged( var_0 )
{
    var_1 = var_0.objweapon.basename;

    foreach ( var_10, var_3 in level.equipment.table )
    {
        var_4 = getcallback( var_10, "onPlayerDamaged" );

        if ( isdefined( var_4 ) && isdefined( var_3.damageweaponnames ) )
        {
            foreach ( var_6 in var_3.damageweaponnames )
            {
                if ( var_6 == var_1 )
                {
                    var_7 = gettime();
                    var_8 = [[ var_4 ]]( var_0 );
                    return var_8;
                }
            }
        }
    }
}

ondestroyedbytrophy()
{
    if ( isdefined( self.equipmentref ) )
    {
        var_0 = getcallback( self.equipmentref, "onDestroyedByTrophy" );

        if ( isdefined( var_0 ) )
        {
            self thread [[ var_0 ]]();
            return 1;
        }
        else if ( scripts\mp\weapons::isplantedequipment( self ) )
        {
            thread scripts\mp\weapons::deleteexplosive();
            return 1;
        }
    }

    return 0;
}

disableslotinternal( var_0 )
{
    if ( var_0 == "primary" )
        self clearoffhandprimary();
    else if ( var_0 == "secondary" )
        self clearoffhandsecondary();
    else if ( var_0 == "super" )
        self clearoffhandspecial();
}

enableslotinternal( var_0 )
{
    var_1 = getcurrentequipment( var_0 );

    if ( !isdefined( var_1 ) )
        return;

    var_2 = getequipmenttableinfo( var_1 );

    if ( isdefined( var_2.objweapon ) && !var_2.ispassive && self hasweapon( var_2.objweapon ) )
    {
        if ( var_0 == "primary" )
            self assignweaponoffhandprimary( var_2.objweapon );
        else if ( var_0 == "secondary" )
            self assignweaponoffhandsecondary( var_2.objweapon );
        else if ( var_0 == "super" )
            self assignweaponoffhandspecial( var_2.objweapon );
    }
}

allow_equipment( var_0, var_1 )
{
    allow_equipment_slot( "primary", var_0, var_1 );
    allow_equipment_slot( "secondary", var_0, var_1 );
}

allow_equipment_slot( var_0, var_1, var_2 )
{
    var_3 = scripts\common\input_allow::allow_input_internal( "equipment_" + var_0, var_1, var_2 );

    if ( !isdefined( var_3 ) )
        return;

    if ( var_1 )
        enableslotinternal( var_0 );
    else
        disableslotinternal( var_0 );
}

is_equipment_slot_allowed( var_0 )
{
    return scripts\common\input_allow::is_input_allowed_internal( "equipment_" + var_0 );
}

sethudslot( var_0, var_1 )
{
    if ( var_0 != "super" )
        self setclientomnvar( "ui_equipment_id_" + var_0, var_1 );
    else
        self setclientomnvar( "ui_perk_package_super1", var_1 );
}

getcurrentequipment( var_0 )
{
    if ( !isdefined( self.equipment ) )
        return undefined;

    return self.equipment[var_0];
}

clearallequipment()
{
    if ( !isdefined( self.equipment ) )
        return;

    foreach ( var_2, var_1 in self.equipment )
        takeequipment( var_2 );
}

getequipmentmaxammo( var_0 )
{
    var_1 = getequipmenttableinfo( var_0 );

    if ( !isdefined( var_1 ) )
        return undefined;

    if ( !isdefined( var_1.objweapon ) )
        return 0;

    if ( level.gametype != "br" )
    {
        var_2 = scripts\mp\utility\perk::_hasperk( "specialty_extraoffhandammo" );
        var_3 = weaponmaxammo( var_1.objweapon, var_2 );

        switch ( var_0 )
        {
            case "equip_hb_sensor":
            case "equip_binoculars":
            case "equip_tac_cover":
                break;
            default:
                var_3--;
                break;
        }

        var_4 = findequipmentslot( var_0 );

        if ( isdefined( var_4 ) && scripts\mp\utility\perk::_hasperk( "specialty_extra_deadly" ) && var_4 == "primary" )
            var_3++;
    }
    else
    {
        var_5 = level.br_pickups.br_equipnametoscriptable[var_1.ref];
        var_3 = level.br_pickups.maxcounts[var_5];

        if ( !isdefined( var_3 ) )
            var_3 = 0;

        if ( var_0 == "equip_armorplate" )
        {
            if ( scripts\mp\utility\perk::_hasperk( "specialty_br_stronger_armor" ) )
                var_3 = getdvarint( "scr_br_perk_stronger_armor", 5 );

            if ( scripts\mp\gametypes\br_public.gsc::should_use_velo_forward() )
                var_3 = var_3 + getdvarint( "scr_br_platePouchCount", 3 );
        }
    }

    return var_3;
}

getequipmentstartammo( var_0 )
{
    var_1 = getequipmenttableinfo( var_0 );

    if ( !isdefined( var_1 ) )
        return undefined;

    if ( !isdefined( var_1.objweapon ) )
        return 0;

    var_2 = scripts\mp\utility\perk::_hasperk( "specialty_extraoffhandammo" );
    return weaponstartammo( var_1.objweapon, var_2 );
}

getequipmentammo( var_0 )
{
    var_1 = getequipmenttableinfo( var_0 );

    if ( !isdefined( var_1 ) )
        return undefined;

    if ( !isdefined( var_1.objweapon ) )
        return 0;

    return self getammocount( var_1.objweapon );
}

setequipmentammo( var_0, var_1 )
{
    var_2 = getequipmenttableinfo( var_0 );

    if ( !isdefined( var_2.objweapon ) )
        return;

    self setweaponammoclip( var_2.objweapon, var_1 );
    updateuiammocount( findequipmentslot( var_0 ) );
}

incrementequipmentammo( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = getequipmentammo( var_0 );
    var_3 = int( min( var_2 + var_1, getequipmentmaxammo( var_0 ) ) );
    setequipmentammo( var_0, var_3 );
}

decrementequipmentammo( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_2 = getequipmentammo( var_0 );
    var_1 = int( min( var_1, var_2 ) );

    if ( var_1 > 0 )
    {
        var_3 = int( min( var_2 - var_1, getequipmentmaxammo( var_0 ) ) );
        setequipmentammo( var_0, var_3 );
    }
}

incrementequipmentslotammo( var_0, var_1 )
{
    var_2 = getcurrentequipment( var_0 );

    if ( !isdefined( var_2 ) )
        return undefined;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_3 = getequipmentammo( var_2 );
    var_4 = int( min( var_3 + var_1, getequipmentmaxammo( var_2 ) ) );
    setequipmentammo( var_2, var_4 );
}

decrementequipmentslotammo( var_0, var_1 )
{
    var_2 = getcurrentequipment( var_0 );

    if ( !isdefined( var_2 ) )
        return undefined;

    if ( !isdefined( var_1 ) )
        var_1 = 1;

    var_3 = getequipmentammo( var_2 );
    var_4 = int( min( var_3 - var_1, getequipmentmaxammo( var_2 ) ) );
    setequipmentammo( var_2, var_4 );
}

getequipmentslotammo( var_0 )
{
    var_1 = getcurrentequipment( var_0 );

    if ( !isdefined( var_1 ) )
        return undefined;

    return getequipmentammo( var_1 );
}

setequipmentslotammo( var_0, var_1 )
{
    var_2 = getcurrentequipment( var_0 );

    if ( !isdefined( var_2 ) )
        return undefined;

    return setequipmentammo( var_2, var_1 );
}

mapequipmentweaponforref( var_0 )
{
    switch ( var_0.basename )
    {
        case "claymore_radial_mp":
            return getcompleteweaponname( "claymore_mp" );
        case "at_mine_ap_mp":
            return getcompleteweaponname( "at_mine_mp" );
        case "thermite_av_mp":
        case "thermite_ap_mp":
            return getcompleteweaponname( "thermite_mp" );
    }

    return var_0;
}

getequipmentreffromweapon( var_0 )
{
    var_0 = mapequipmentweaponforref( var_0 );

    foreach ( var_2 in level.equipment.table )
    {
        if ( isdefined( var_2.objweapon ) && var_0 == var_2.objweapon )
            return var_2.ref;
    }

    return undefined;
}

getweaponfromequipmentref( var_0 )
{
    foreach ( var_2 in level.equipment.table )
    {
        if ( isdefined( var_2.ref ) && var_0 == var_2.ref )
            return var_2.objweapon;
    }

    return undefined;
}

hasequipment( var_0 )
{
    if ( !isdefined( self.equipment ) )
        return 0;

    foreach ( var_2 in self.equipment )
    {
        if ( var_2 == var_0 )
            return 1;
    }

    return 0;
}

findequipmentslot( var_0 )
{
    if ( !isdefined( self.equipment ) )
        return undefined;

    foreach ( var_3, var_2 in self.equipment )
    {
        if ( var_2 == var_0 )
            return var_3;
    }
}

isequipmentlethal( var_0 )
{
    return isequipmentprimary( var_0 );
}

isequipmentprimary( var_0 )
{
    if ( isdefined( level.equipment.table[var_0] ) )
        return level.equipment.table[var_0].defaultslot == "primary";
    else
        return 0;
}

isequipmenttactical( var_0 )
{
    return isequipmentsecondary( var_0 );
}

isequipmentsecondary( var_0 )
{
    if ( isdefined( level.equipment.table[var_0] ) )
        return level.equipment.table[var_0].defaultslot == "secondary";
    else
        return 0;
}

unset_force_aitype_suicidebomber( var_0 )
{
    if ( isdefined( level.equipment.table[var_0] ) )
        return istrue( level.equipment.table[var_0].usecellspawns );
    else
        return 0;
}

updateuiammocount( var_0 )
{
    if ( !isdefined( self.equipment ) )
        return;

    var_1 = 0;
    var_2 = getcurrentequipment( var_0 );

    if ( isdefined( var_2 ) )
        var_1 = getequipmentslotammo( var_0 );

    if ( var_0 == "primary" )
    {
        self setclientomnvar( "ui_power_num_charges", var_1 );
        self trajectoryupdateoriginandangles( "primary", var_1 );
    }
    else if ( var_0 == "secondary" )
    {
        self setclientomnvar( "ui_power_secondary_num_charges", var_1 );
        self trajectoryupdateoriginandangles( "secondary", var_1 );
    }
    else if ( var_0 == "health" )
    {
        self setclientomnvar( "ui_equipment_id_health_numCharges", var_1 );

        if ( scripts\mp\utility\game::unset_relic_grounded() )
            scripts\mp\gametypes\br_public.gsc::updatebrextradata( "armorPlateCount", var_1 );
    }
}

equiponplayerspawned()
{
    thread watchoffhandfired();
}

resetequipment()
{
    self.equipment = [];
}

executeoffhandfired( var_0 )
{
    foreach ( var_6, var_2 in self.equipment )
    {
        var_3 = getequipmenttableinfo( var_2 );

        if ( isdefined( var_3.objweapon ) && var_0 == var_3.objweapon )
        {
            if ( scripts\mp\utility\game::getgametype() == "br" )
                scripts\mp\gametypes\br_analytics.gsc::branalytics_equipmentuse( self, var_0 );

            var_4 = getequipmentreffromweapon( var_0 );
            scripts\mp\damage::hide_name_fx_from_players( var_4 );
            var_5 = getcallback( var_2, "onFired" );

            if ( isdefined( var_5 ) )
                self thread [[ var_5 ]]( var_2, var_6, var_0 );

            updateuiammocount( var_6 );
            break;
        }
    }
}

watchoffhandfired()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );

    for (;;)
    {
        self waittill( "offhand_fired", var_0 );
        executeoffhandfired( var_0 );
    }
}

givescavengerammo()
{
    foreach ( var_3, var_1 in self.equipment )
    {
        var_2 = getequipmenttableinfo( var_1 );

        if ( var_2.scavengerammo > 0 )
            incrementequipmentammo( var_1, var_2.scavengerammo );
    }
}

getdefaultslot( var_0 )
{
    var_1 = getequipmenttableinfo( var_0 );

    if ( !isdefined( var_1 ) )
        return undefined;

    return var_1.defaultslot;
}

watchlethaldelay()
{
    level endon( "lethal_delay_end" );
    level endon( "round_end" );
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var_0 = initstandardloadout();

    if ( var_0 )
        level.lethaldelaystarttime = gettime();
    else
        level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();

    if ( level.lethaldelay == 0 )
    {
        level.lethaldelayendtime = level.lethaldelaystarttime;
        level notify( "lethal_delay_end" );
    }

    level.lethaldelayendtime = level.lethaldelaystarttime + level.lethaldelay * 1000;
    level notify( "lethal_delay_start" );

    for (;;)
    {
        var_1 = undefined;

        if ( var_0 )
            var_1 = gettime();
        else
            var_1 = scripts\mp\utility\game::gettimepassed();

        if ( var_1 >= level.lethaldelayendtime )
            break;

        waitframe();
    }

    level notify( "lethal_delay_end" );
}

watchlethaldelayplayer( var_0, var_1 )
{
    self endon( "death_or_disconnect" );
    level endon( "round_end" );
    level endon( "game_ended" );

    if ( lethaldelaypassed() )
        return;

    self notify( "watchLethalDelayPlayer_" + var_1 );
    self endon( "watchLethalDelayPlayer_" + var_1 );
    self endon( "equipment_taken_" + var_0 );

    if ( !isdefined( self.weapon_xp_iw8_sh_charlie725 ) || !istrue( self.weapon_xp_iw8_sh_charlie725[var_1] ) )
    {
        if ( !isdefined( self.weapon_xp_iw8_sh_charlie725 ) )
            self.weapon_xp_iw8_sh_charlie725 = [];

        self.weapon_xp_iw8_sh_charlie725[var_1] = 1;
        allow_equipment_slot( var_1, 0 );
    }

    watchlethaldelayfeedbackplayer( self, var_1 );

    if ( isdefined( self.weapon_xp_iw8_sh_charlie725 ) && istrue( self.weapon_xp_iw8_sh_charlie725[var_1] ) )
    {
        self.weapon_xp_iw8_sh_charlie725[var_1] = undefined;

        if ( self.weapon_xp_iw8_sh_charlie725.size == 0 )
            self.weapon_xp_iw8_sh_charlie725 = undefined;

        allow_equipment_slot( var_1, 1 );
    }
}

watchlethaldelayfeedbackplayer( var_0, var_1 )
{
    level endon( "lethal_delay_end" );

    if ( !istrue( scripts\mp\flags::gameflag( "prematch_done" ) ) )
        level waittill( "lethal_delay_start" );

    var_2 = "+frag";

    if ( var_1 != "primary" )
        var_2 = "+smoke";

    if ( !isai( var_0 ) )
        var_0 notifyonplayercommand( "lethal_attempt_" + var_1, var_2 );

    var_3 = initstandardloadout();

    for (;;)
    {
        self waittill( "lethal_attempt_" + var_1 );
        var_4 = undefined;

        if ( var_3 )
            var_4 = gettime();
        else
            var_4 = scripts\mp\utility\game::gettimepassed();

        var_5 = ( level.lethaldelayendtime - var_4 ) / 1000;
        var_5 = int( max( 0, ceil( var_5 ) ) );
        var_0 scripts\mp\hud_message::showerrormessage( "MP/LETHALS_UNAVAILABLE_FOR_N", var_5 );
    }
}

cancellethaldelay()
{
    level.lethaldelay = 0;

    if ( initstandardloadout() )
        level.lethaldelaystarttime = gettime();
    else
        level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();

    level.lethaldelayendtime = level.lethaldelaystarttime;
    level notify( "lethal_delay_end" );
}

lethaldelaypassed()
{
    if ( isdefined( level.lethaldelay ) && level.lethaldelay == 0 )
        return 1;

    if ( isdefined( level.lethaldelayendtime ) )
    {
        var_0 = undefined;

        if ( initstandardloadout() )
            var_0 = gettime();
        else
            var_0 = scripts\mp\utility\game::gettimepassed();

        return var_0 > level.lethaldelayendtime;
    }

    return 0;
}

initstandardloadout()
{
    var_0 = scripts\mp\utility\game::getgametype();

    if ( var_0 == "hq" || var_0 == "grnd" || var_0 == "koth" )
        return 1;

    return 0;
}

onownerdisconnect( var_0 )
{
    var_1 = var_0 scripts\mp\weapons::getallequip();

    foreach ( var_3 in var_1 )
        var_3 notify( "owner_disconnect" );
}

hackequipment( var_0 )
{
    self.ishacked = 1;
    var_0 scripts\mp\gamelogic::sethasdonecombat( var_0, 1 );
    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_1203D( self.equipmentref );
    changeowner( var_0 );

    if ( level.teambased )
        self filteroutplayermarks( var_0.team );
    else
        self filteroutplayermarks( var_0 );

    var_0 scripts\mp\killstreaks\killstreaks::givescoreforhack();
}

changeowner( var_0 )
{
    var_1 = self.owner;
    self setentityowner( var_0 );
    self.owner = var_0;
    self.team = var_0.team;
    self setotherent( var_0 );
    var_1 scripts\mp\weapons::removeequip( self );
    self.owner scripts\mp\weapons::updateplantedarray( self );
    var_2 = getcallback( self.equipmentref, "onOwnerChanged" );
    self notify( "ownerChanged" );

    if ( isdefined( var_2 ) )
        self [[ var_2 ]]( var_1 );
}

scriptablescleanupbatchsize( var_0, var_1, var_2 )
{
    foreach ( var_4 in var_0 )
    {
        if ( istrue( var_4.gulag ) )
            continue;

        var_4._id_12FB1 = var_4 getcurrentequipment( var_1 );
        var_4._id_12FB0 = getequipmentslotammo( var_1 );
        var_4 takeequipment( var_1 );
        var_4 giveequipment( var_2, var_1 );
    }
}

_id_13A30( var_0, var_1, var_2, var_3 )
{
    foreach ( var_5 in var_0 )
    {
        if ( istrue( var_5.gulag ) )
            continue;

        var_6 = var_5 getcurrentequipment( var_1 );

        if ( !istrue( var_3 ) && isdefined( var_6 ) && var_2 != var_6 )
            continue;

        var_5 takeequipment( var_1 );
        var_7 = var_5._id_12FB1;
        var_8 = var_5._id_12FB0;

        if ( isdefined( var_7 ) )
        {
            var_5 giveequipment( var_7, var_1 );
            var_5._id_12FB1 = undefined;

            if ( isdefined( var_8 ) )
            {
                var_5 setequipmentammo( var_7, var_8 );
                var_5._id_12FB0 = undefined;
            }
        }
    }
}

debughackequipment()
{
    for (;;)
    {
        if ( getdvarint( "scr_debugHackEquipment" ) != 0 )
        {
            var_0 = level.players[0];
            var_1 = undefined;

            for ( var_2 = 1; var_2 < level.players.size; var_2++ )
            {
                if ( var_0 scripts\mp\utility\player::isenemy( level.players[var_2] ) )
                {
                    var_1 = level.players[var_2];
                    break;
                }
            }

            if ( !isdefined( var_1 ) )
            {
                iprintlnbold( "Need a player on the other team to scr_debugHackEquipment" );
                continue;
            }

            var_3 = var_0 scripts\mp\weapons::getallequip();
            var_4 = undefined;

            if ( var_3.size > 0 )
                var_4 = var_3[0];

            if ( !isdefined( var_4 ) )
            {
                iprintlnbold( "First player must have at least one piece of equipment to scr_debugHackEquipment" );
                continue;
            }

            var_4 hackequipment( var_1 );
        }

        waitframe();
    }
}

debugemp()
{
    for (;;)
    {
        if ( getdvarint( "scr_testEMPGrenade" ) != 0 )
        {
            if ( level.players.size < 2 )
            {
                iprintlnbold( "Need at least two players to scr_testEMPGrenade" );
                continue;
            }

            var_0 = level.players[1];
            var_0 scripts\mp\utility\weapon::_launchgrenade( "emp_grenade_mp", ( 0, 0, 0 ), ( 0, 0, 0 ), 0.05, 0 );
        }

        waitframe();
    }
}

debugempdrone()
{
    for (;;)
    {
        if ( getdvarint( "scr_testEMPDrone" ) != 0 )
        {
            if ( level.players.size < 2 )
            {
                iprintlnbold( "Need at least two players to scr_testEMPDrone" );
                continue;
            }

            var_0 = level.players[0];
            var_1 = level.players[1];
            var_2 = spawnstruct();
            var_2.streakname = "emp_drone";
            var_2.owner = var_1;
            var_2.id = scripts\cp_mp\utility\killstreak_utility::getuniquekillstreakid( var_1 );
            var_2.lifeid = 0;
            var_3 = var_0.origin;
            var_4 = var_1 scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_createdrone( var_2, var_3 );
        }

        waitframe();
    }
}

debugdestroyempdrones()
{
    for (;;)
    {
        if ( getdvarint( "scr_testEMPDroneDestroy" ) != 0 )
        {
            foreach ( var_1 in level.activekillstreaks )
            {
                if ( isdefined( var_1.streakinfo ) && var_1.streakinfo.streakname == "emp_drone" )
                    var_1 scripts\cp_mp\killstreaks\emp_drone::empdrone_destroy();
            }
        }

        waitframe();
    }
}

timeoflastexecute()
{
    level.weapon_xp_iw8_pi_papa320 = [];
    var_0 = 0;

    foreach ( var_2 in level.equipment.table )
    {
        if ( !var_2.usecellspawns )
            continue;

        if ( var_2.id <= 0 )
            continue;

        if ( var_2.defaultslot == "secondary" )
            continue;

        level.weapon_xp_iw8_pi_papa320[var_2.ref] = 1 << var_0;
        var_0++;
    }
}