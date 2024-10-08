// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level thread _id_13C04();
    waittillframeend;
    level thread _id_13C0A();
    level thread _id_13C01();
    level thread _id_13C03();
    level thread _id_13C0F();
}

_id_13C0A()
{
    level.hostage_callout_saveme_time = ::_id_13468;
    var_0 = getent( "soa_tower_elevator", "targetname" );
    var_1 = var_0 scripts\engine\utility::get_linked_ents();
    var_0.choosegulagloadouttable = 0;

    foreach ( var_3 in var_1 )
    {
        var_3 linkto( var_0 );
        var_3.targetname = "soa_tower_elevator_clip";
    }

    level._id_142FC = getent( "soa_tower_elevator_volume", "targetname" );
    level._id_142FC enablelinkto();
    level._id_142FC linkto( var_0 );
    level.getflagradarowner = ::trophy_watchtimeoutorgameended;
    level.getfirespoutlaunchvectors = ::trophy_watchtimeoutorgameended;
    var_5 = getent( "soa_tower_elevator_car_door_left", "targetname" );
    var_5 wp_loop();
    var_5._id_140B4 = var_5.origin;
    var_5._id_140B9 = scripts\engine\utility::getstruct( "soa_tower_elevator_car_door_left_open", "targetname" ).origin;
    var_6 = getent( "soa_tower_elevator_car_door_right", "targetname" );
    var_6 wp_loop();
    var_6._id_140B4 = var_6.origin;
    var_6._id_140B9 = scripts\engine\utility::getstruct( "soa_tower_elevator_car_door_right_open", "targetname" ).origin;
    var_7 = getent( "soa_tower_elevator_floor_3_door_left", "targetname" );
    var_7 wp_loop();
    var_7._id_140B4 = var_7.origin;
    var_7._id_140B9 = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_3_door_left_open", "targetname" ).origin;
    var_8 = getent( "soa_tower_elevator_floor_3_door_right", "targetname" );
    var_8 wp_loop();
    var_8._id_140B4 = var_8.origin;
    var_8._id_140B9 = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_3_door_right_open", "targetname" ).origin;
    var_9 = getent( "soa_tower_elevator_floor_30_door_left", "targetname" );
    var_9 wp_loop();
    var_9._id_140B4 = var_9.origin;
    var_9._id_140B9 = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_30_door_left_open", "targetname" ).origin;
    var_10 = getent( "soa_tower_elevator_floor_30_door_right", "targetname" );
    var_10 wp_loop();
    var_10._id_140B4 = var_10.origin;
    var_10._id_140B9 = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_30_door_right_open", "targetname" ).origin;
    var_11 = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_3", "targetname" ).origin;
    var_12 = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_30", "targetname" ).origin;
    var_13 = ( ( var_7._id_140B4[0] + var_8._id_140B4[0] ) / 2, ( var_7._id_140B4[1] + var_8._id_140B4[1] ) / 2, ( var_7._id_140B4[2] + var_8._id_140B4[2] ) / 2 );
    var_14 = ( ( var_9._id_140B4[0] + var_10._id_140B4[0] ) / 2, ( var_9._id_140B4[1] + var_10._id_140B4[1] ) / 2, ( var_9._id_140B4[2] + var_10._id_140B4[2] ) / 2 );
    var_15 = spawn( "script_model", ( 0, 0, 0 ) );
    var_15 setmodel( "tag_origin" );
    var_16 = ( -17.756, 185.622, 3761.61 );
    var_17 = ( 90, 270, 90 );
    var_18 = ( 41, 184, 3625 );
    var_19 = ( 0, 0, 0 );
    var_20 = distance2d( var_16, var_18 );
    var_21 = var_16[2] - var_18[2];
    var_22 = vectortoangles( ( var_16[0], var_16[1], 0 ) - ( var_18[0], var_18[1], 0 ) )[1];
    var_23 = var_17 - var_19;
    var_24 = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_30", "targetname" ).angles[1] + var_22;
    var_15.origin = var_11 + anglestoforward( ( 0, var_24, 0 ) ) * var_20;
    var_15.origin = var_15.origin + ( 0, 0, var_21 );
    var_15.angles = scripts\engine\utility::getstruct( "soa_tower_elevator_floor_3", "targetname" ).angles + var_23;
    var_15 linkto( var_0 );
    level._effect["vfx_elev_light_01"] = loadfx( "vfx/iw8_br2/gen_amb/vfx_elev_light_01.vfx" );
    wait 10;

    foreach ( var_26 in level.players )
        playfxontagforclients( scripts\engine\utility::getfx( "vfx_elev_light_01" ), var_15, "tag_origin", var_26 );

    var_0 thread _id_13C09();
    waitframe();

    for (;;)
    {
        var_0 thread _id_13C07();
        var_0 moveto( var_12, 15, 3, 3 );
        var_5 moveto( ( var_5._id_140B4[0], var_5._id_140B4[1], var_12[2] ), 15, 3, 3 );
        var_6 moveto( ( var_6._id_140B4[0], var_6._id_140B4[1], var_12[2] ), 15, 3, 3 );
        wait 12;
        wait 3;
        var_0 thread _id_13C08();
        wait 1;
        var_5 moveto( ( var_5._id_140B9[0], var_5._id_140B9[1], var_0.origin[2] ), 3, 1, 1 );
        var_6 moveto( ( var_6._id_140B9[0], var_6._id_140B9[1], var_0.origin[2] ), 3, 1, 1 );
        var_9 moveto( var_9._id_140B9, 3, 1, 1 );
        var_10 moveto( var_10._id_140B9, 3, 1, 1 );
        thread _id_13C06( var_14 );
        wait 3;
        wait 8;
        var_5 moveto( ( var_5._id_140B4[0], var_5._id_140B4[1], var_0.origin[2] ), 3, 1, 1 );
        var_6 moveto( ( var_6._id_140B4[0], var_6._id_140B4[1], var_0.origin[2] ), 3, 1, 1 );
        var_9 moveto( var_9._id_140B4, 3, 1, 1 );
        var_10 moveto( var_10._id_140B4, 3, 1, 1 );
        thread _id_13C05( var_14 );
        wait 3;
        wait 1;
        var_0 thread _id_13C07();
        var_0 moveto( var_11, 15, 3, 3 );
        var_5 moveto( ( var_5._id_140B4[0], var_5._id_140B4[1], var_11[2] ), 15, 3, 3 );
        var_6 moveto( ( var_6._id_140B4[0], var_6._id_140B4[1], var_11[2] ), 15, 3, 3 );
        wait 12;
        wait 3;
        var_0 thread _id_13C08();
        wait 1;
        var_5 moveto( ( var_5._id_140B9[0], var_5._id_140B9[1], var_0.origin[2] ), 3, 1, 1 );
        var_6 moveto( ( var_6._id_140B9[0], var_6._id_140B9[1], var_0.origin[2] ), 3, 1, 1 );
        var_7 moveto( var_7._id_140B9, 3, 1, 1 );
        var_8 moveto( var_8._id_140B9, 3, 1, 1 );
        thread _id_13C06( var_13 );
        wait 3;
        wait 8;
        var_5 moveto( ( var_5._id_140B4[0], var_5._id_140B4[1], var_0.origin[2] ), 3, 1, 1 );
        var_6 moveto( ( var_6._id_140B4[0], var_6._id_140B4[1], var_0.origin[2] ), 3, 1, 1 );
        var_7 moveto( var_7._id_140B4, 3, 1, 1 );
        var_8 moveto( var_8._id_140B4, 3, 1, 1 );
        thread _id_13C05( var_13 );
        wait 3;
        wait 1;
    }
}

_id_13C09()
{
    var_0 = scripts\engine\utility::getstruct( "soa_tower_elevator_bounds_southwest", "targetname" );
    var_1 = scripts\engine\utility::getstruct( "soa_tower_elevator_bounds_northeast", "targetname" );
    self._id_14684 = var_0.origin[2] - self.origin[2];
    self._id_14686 = var_1.origin[2] - self.origin[2];
    self._id_14686 = self._id_14686 - 10;
    var_2 = ( var_0.origin + var_1.origin ) / 2;
    var_3 = var_0.angles[1];
    var_4 = distance2d( var_0.origin, var_1.origin );
    var_5 = vectortoangles( var_1.origin - var_0.origin )[1];
    var_6 = var_5 - var_3;
    var_1.origin = var_0.origin + var_4 * anglestoforward( ( 0, var_6, 0 ) );

    for (;;)
    {
        var_7 = scripts\mp\utility\player::getplayersinradius( ( var_2[0], var_2[1], self.origin[2] ), 150 );

        foreach ( var_9 in var_7 )
        {
            var_10 = distance2d( var_0.origin, var_9.origin );
            var_11 = vectortoangles( var_9.origin - var_0.origin )[1];
            var_12 = var_11 - var_3;
            var_13 = var_0.origin + var_10 * anglestoforward( ( 0, var_12, 0 ) );

            if ( var_0.origin[0] < var_13[0] && var_13[0] < var_1.origin[0] && var_0.origin[1] < var_13[1] && var_13[1] < var_1.origin[1] && self.origin[2] + self._id_14684 < var_9.origin[2] && var_9.origin[2] < self.origin[2] + self._id_14686 && isalive( var_9 ) )
            {
                var_9 setclienttriggeraudiozone( "dwntwn_soa_elevator_int", 0.5 );
                continue;
            }

            var_9 clearclienttriggeraudiozone( 0.5 );
        }

        waitframe();
    }
}

_id_13C07()
{
    self playsoundonmovingent( "scn_soa_elevator_in_use_start" );
    self playloopsound( "scn_soa_elevator_in_use_lp" );
    self.choosegulagloadouttable = 1;
}

_id_13C08()
{
    self playsoundonmovingent( "scn_soa_elevator_in_use_stop" );
    self stoploopsound();
    self.choosegulagloadouttable = 0;
}

_id_13C06( var_0 )
{
    playsoundatpos( var_0, "scn_soa_elevator_open" );
}

_id_13C05( var_0 )
{
    playsoundatpos( var_0, "scn_soa_elevator_close" );
}

trophy_watchtimeoutorgameended( var_0 )
{
    return !var_0 istouching( level._id_142FC );
}

triggeraddobjectivetext( var_0 )
{
    if ( isdefined( var_0 ) && isdefined( var_0.targetname ) && var_0.targetname == "soa_tower_elevator_clip" )
        return 1;

    return 0;
}

_id_13468( var_0, var_1, var_2 )
{
    if ( distancesquared( var_0.origin, getent( "soa_tower_elevator", "targetname" ).origin + ( 0, 0, 75 ) ) < squared( 200 ) )
    {
        var_0 kill();
        return 1;
    }
    else
        return 0;
}

_id_13C01()
{
    _id_13C02( "ascender", "on_floor1" );
    _id_13C02( "ascender", "on_floorP1" );
    _id_13C02( "ascender", "on_floor30" );
    _id_13C02( "ascender", "on_floor1" );
    _id_13C02( "ascender_solo", "on_floor33" );
    _id_13C02( "ascender_solo", "on_floor1" );
    _id_13C02( "ascender_solo", "on_floor30" );
    _id_13C02( "ascender_solo", "on_floor2" );
    _id_13C02( "ascender_solo", "on_floor30" );
    _id_13C02( "ascender_solo", "on_floor3" );
    _id_13C02( "ascender_solo", "on_roof" );
    _id_13C02( "ascender_solo", "on_floor32" );
    _id_13C02( "ascender_solo", "on_floor33" );
    _id_13C02( "ascender_solo", "on_floor30" );
}

_id_13C02( var_0, var_1 )
{
    var_2 = getentitylessscriptablearrayinradius( var_1, "script_noteworthy" );

    foreach ( var_4 in var_2 )
    {
        if ( var_4 getscriptablehaspart( var_0 ) && var_4 getscriptableparthasstate( var_0, var_1 ) )
            var_4 setscriptablepartstate( var_0, var_1 );
    }
}

_id_13C04()
{
    var_0 = [];
    var_0[0] = ( 20820, -14380, 3766 );
    var_0[1] = ( 20509, -14258, 3755 );
    var_0[2] = ( 20282, -14245, 3740 );

    foreach ( var_2 in var_0 )
    {
        var_3 = 500;
        scripts\mp\gametypes\br_bunker_utility.gsc::little_bird_mg_playercontrolmg( var_2, var_3 );
    }
}

_id_13C03()
{
    var_0 = ( 20644, -14275, 3700 );
    var_1 = 375;
    var_2 = canceljoins( undefined, undefined, var_0, var_1 );

    if ( isdefined( var_2 ) )
    {
        foreach ( var_4 in var_2 )
        {
            if ( var_4.origin[2] < 3650 || var_4.origin[2] > 3800 )
                continue;

            if ( var_4.type == "br_loot_cache" || var_4.type == "br_loot_cache_lege" )
                var_4 setscriptablepartstate( "body", "open" );
        }
    }
}

activatemusictrigger()
{

}

_id_13C0F()
{
    level._id_12E2E = spawnstruct();
    level._id_12E2E.parachuteoverheadwarningtimeoutms = getdvarfloat( "scr_soa_event_vault_door_rotate_duration", 15.0 );
    level._id_12E2E.spotlight_turret_info = getdvarint( "scr_soa_event_vault_specialist_drops_max", 2 );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level thread _id_13C10();
    level thread _id_13C11();
}

_id_13C10()
{
    var_0 = ( -196, 836, 3890 );

    if ( level.mapname == "mp_don4" )
        var_0 = ( 20270, -14587, 3731 );

    var_1 = scripts\mp\gameobjects::createhintobject( var_0, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_DOOR", undefined, undefined, undefined, 350, 360, 200, 120 );
    var_1 thread _id_13C0D();
}

_id_13C0D()
{
    level endon( "game_ended" );
    self endon( "death" );
    var_0 = getent( "e_vault_door", "targetname" );

    for (;;)
    {
        self waittill( "trigger", var_1 );

        if ( var_1 scripts\mp\gametypes\br_public.gsc::should_damage_pavelow_boss() )
        {
            if ( soundexists( "br_keypad_confirm" ) )
                playsoundatpos( self.origin, "br_keypad_confirm" );

            var_0 thread _id_13C0E( var_1 );
            self delete();
        }
        else if ( soundexists( "br_keypad_deny" ) )
            playsoundatpos( self.origin, "br_keypad_deny" );

        wait 0.25;
    }
}

_id_13C0E( var_0 )
{
    level endon( "game_ended" );
    self endon( "death" );
    var_1 = incrementpersistentstat( level.players, self.origin, 10000 );

    foreach ( var_3 in var_1 )
        var_3 scripts\mp\hud_message::showsplash( "br_soa_tower_event_vault_opening", undefined, var_0 );

    var_5 = ( -161, 752, 3972 );
    var_6 = ( -353, 873, 3970 );
    var_7 = ( -354, 644, 3970 );

    if ( level.mapname == "mp_don4" )
    {
        var_5 = ( 20330, -14534, 3816 );
        var_6 = ( 20218, -14734, 3816 );
        var_7 = ( 20440, -14734, 3816 );
    }

    playsoundatpos( var_5, "mx_soa_ode_to_joy" );
    playsoundatpos( var_6, "evt_soa_ode_to_joy_alarm_01" );
    playsoundatpos( var_7, "evt_soa_ode_to_joy_alarm_02" );
    self rotateyaw( -90, level._id_12E2E.parachuteoverheadwarningtimeoutms, 0.25, 0.25 );
    playsoundatpos( self.origin, "evt_door_vault_open_start" );
    wait 0.5;
    self playloopsound( "evt_soa_door_vault_lp" );
    wait( level._id_12E2E.parachuteoverheadwarningtimeoutms - 0.5 );
    playsoundatpos( self.origin, "evt_door_vault_open_stop" );
    self stoploopsound();
}

_id_13C11()
{
    var_0 = ( -73, 449, 3895 );
    var_1 = ( -73, 337, 3895 );
    var_2 = ( -73, 233, 3895 );
    var_3 = ( 0, 180, 0 );

    if ( level.mapname == "mp_don4" )
    {
        var_0 = ( 20675.3, -14460, 3726 );
        var_1 = ( 20746.3, -14460, 3726 );
        var_2 = ( 20882.5, -14460, 3726 );
        var_3 = ( 0, 90, 0 );
    }

    var_4 = spawnstruct();
    var_4.origin = var_0;
    var_4.angles = var_3;
    var_4.itemsdropped = 0;
    var_4._id_13904 = "soa_tower_vault_lockbox_right";
    var_5 = scripts\mp\gameobjects::createhintobject( var_4.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_1" );
    var_5 thread _id_13C12( "helipad", var_4 );
    var_6 = spawnstruct();
    var_6.origin = var_1;
    var_6.angles = var_3;
    var_6.itemsdropped = 0;
    var_6._id_13904 = "soa_tower_vault_lockbox_middle";
    var_7 = scripts\mp\gameobjects::createhintobject( var_6.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_2" );
    var_7 thread _id_13C12( "security", var_6 );
    var_8 = spawnstruct();
    var_8.origin = var_2;
    var_8.angles = var_3;
    var_8.itemsdropped = 0;
    var_8._id_13904 = "soa_tower_vault_lockbox_left";
    var_9 = scripts\mp\gameobjects::createhintobject( var_8.origin, "HINT_BUTTON", undefined, &"BR_SOA_EVENT/VAULT_KEYREADER_3" );
    var_9 thread _id_13C12( "arms_deal", var_8 );
}

_id_13C12( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        self waittill( "trigger", var_2 );
        var_3 = 0;

        switch ( var_0 )
        {
            case "helipad":
                var_3 = var_2 scripts\mp\gametypes\br_public.gsc::should_damage_pavelow_boss( "brloot_access_card_gold_vault_lockbox_1" );
                break;
            case "security":
                var_3 = var_2 scripts\mp\gametypes\br_public.gsc::should_damage_pavelow_boss( "brloot_access_card_gold_vault_lockbox_2" );
                break;
            case "arms_deal":
                var_3 = var_2 scripts\mp\gametypes\br_public.gsc::should_damage_pavelow_boss( "brloot_access_card_gold_vault_lockbox_3" );
                break;
        }

        if ( var_3 )
        {
            if ( soundexists( "br_keypad_confirm" ) )
                playsoundatpos( self.origin, "br_keypad_confirm" );

            var_4 = getent( var_1._id_13904, "targetname" );
            playsoundatpos( var_4.origin, "evt_door_lockbox_open" );
            var_4 rotateyaw( 80, 1.5, 0.5, 0.5 );
            wait 1.32;
            var_1 thread _id_13C14( var_0, var_2 );
            var_2 scripts\mp\gametypes\br_pickups.gsc::_id_12BFC();
            self delete();
        }
        else if ( soundexists( "br_pickup_deny" ) )
            var_2 playlocalsound( "br_pickup_deny" );

        wait 0.25;
    }
}

_id_13C14( var_0, var_1 )
{
    var_2 = scripts\mp\utility\teams::getteamdata( var_1.team, "teamCount" );
    var_3 = _id_13C13( var_0, var_2 );
    scripts\mp\gametypes\br_lootcache.gsc::_id_11A42( var_3, 0 );

    if ( var_0 == "arms_deal" )
    {
        var_4 = ( 15, 0, 0 );

        if ( level.mapname == "mp_don4" )
            var_4 = ( 0, 15, 0 );

        var_5 = scripts\mp\gametypes\br_quest_util.gsc::_id_135DF( "blueprintextract", scripts\engine\utility::drop_to_ground( self.origin + var_4, 0, -200, ( 0, 0, 1 ) ) + ( 0, 0, 25 ), 0 );
        var_6 = scripts\mp\gametypes\br_quest_util.gsc::risk_flagspawndebugobjicons();
        var_5 scripts\mp\gametypes\br_blueprint_extract_spawn.gsc::controlslinked( var_6 );
        scripts\mp\gametypes\br_pickups.gsc::_id_12B3A( var_5 );
    }
}

_id_13C13( var_0, var_1 )
{
    var_2 = [];

    switch ( var_0 )
    {
        case "helipad":
            var_2[0] = "brloot_super_stoppingpower";

            if ( scripts\mp\utility\game::round_vehicle_logic() == "bodycount" )
            {
                var_2[1] = "brloot_bodycount_extra_life";
                var_2[2] = "brloot_bodycount_dogtag";
                var_2[3] = "brloot_bodycount_dogtag";
                var_2[4] = "brloot_bodycount_dogtag";
            }
            else
            {
                var_2[1] = "brloot_plunder_cash_epic_1";
                var_2[2] = "brloot_plunder_cash_epic_1";
                var_2[3] = "brloot_plunder_cash_epic_1";
                var_3 = min( level._id_12E2E.spotlight_turret_info, var_1 );

                for ( var_4 = 0; var_4 < var_3; var_4++ )
                    var_2[var_2.size] = "brloot_specialist_bonus";
            }

            break;
        case "security":
            var_2[0] = "brloot_super_armorbox";

            if ( scripts\mp\utility\game::round_vehicle_logic() == "bodycount" )
            {
                var_2[1] = "brloot_bodycount_dogtag";
                var_2[2] = "brloot_bodycount_dogtag";
                var_2[3] = "brloot_bodycount_dogtag";
                var_2[4] = "brloot_offhand_advancedsupplydrop";
            }
            else
            {
                var_2[1] = "brloot_plunder_cash_epic_1";
                var_2[2] = "brloot_plunder_cash_epic_1";
                var_2[3] = "brloot_plunder_cash_epic_1";
                var_2[4] = "brloot_killstreak_auav";
            }

            break;
        case "arms_deal":
            var_2[0] = "brloot_super_deadsilence";

            if ( scripts\mp\utility\game::round_vehicle_logic() == "bodycount" )
            {
                var_2[1] = "brloot_bodycount_dogtag";
                var_2[2] = "brloot_bodycount_dogtag";
                var_2[3] = "brloot_bodycount_dogtag";
            }
            else
            {
                var_2[1] = "brloot_plunder_cash_epic_1";
                var_2[2] = "brloot_plunder_cash_epic_1";
                var_2[3] = "brloot_plunder_cash_epic_1";
            }

            break;
    }

    return var_2;
}

_id_13C15( var_0, var_1, var_2 )
{
    var_3 = scripts\engine\utility::drop_to_ground( var_1, 0 ) + var_2;

    switch ( var_0 )
    {
        case "helipad":
            var_4 = easepower( "brloot_access_card_gold_vault_lockbox_1", var_3 );
            scripts\mp\gametypes\br_pickups.gsc::_id_12B3A( var_4 );
            break;
        case "security":
            var_4 = easepower( "brloot_access_card_gold_vault_lockbox_2", var_3 );
            scripts\mp\gametypes\br_pickups.gsc::_id_12B3A( var_4 );
            break;
        case "arms_deal":
            var_4 = easepower( "brloot_access_card_gold_vault_lockbox_3", var_3 );
            scripts\mp\gametypes\br_pickups.gsc::_id_12B3A( var_4 );
            break;
    }
}

wp_loop()
{
    var_0 = scripts\engine\utility::get_linked_ents();

    foreach ( var_2 in var_0 )
        var_2 linkto( self );
}
