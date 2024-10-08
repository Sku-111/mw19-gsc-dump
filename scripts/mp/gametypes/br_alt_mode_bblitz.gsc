// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( !getdvarint( "scr_br_alt_mode_bblitz", 0 ) )
        return;

    level.clear_cypher_icon = 0;
    level.clear_and_give_killstreak_loadout_assault = getdvarint( "scr_br_alt_mode_bblitz_goal", 3 );
    level thread impactfunc_null();
}

impactfunc_null()
{
    level endon( "game_ended" );
    level waittill( "prematch_done" );
    var_0 = getarraykeys( level.teamdata );

    foreach ( var_2 in var_0 )
        level.teamdata[var_2]["bblitzCounter"] = 0;

    if ( !getdvarint( "scr_br_alt_mode_bblitz_shutdown_check", 1 ) )
        return;

    for (;;)
    {
        wait 1;
        var_4 = ( 0, 0, 0 );

        if ( isdefined( level.br_circle ) )
        {
            var_5 = level.br_level.default_class_chosen.size - level.br_level.delay_start_escort_protect_hvi_objective - 1;
            var_4 = level.br_level.default_class_chosen[var_5];
        }

        if ( !scripts\mp\gametypes\br_extract_quest.gsc::outofboundstriggersplanetrace( var_4 ) )
            break;
    }

    clear_cypher_icon();
}

clear_cypher_icon()
{
    if ( level.clear_cypher_icon )
        return;

    level.clear_cypher_icon = 1;

    foreach ( var_2, var_1 in level.teamdata )
        clear_bomb_vest_controller_holder( var_2, -1 );

    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_bblitz_shutdown" );
}

clear_all_remaining( var_0 )
{
    if ( !getdvarint( "scr_br_alt_mode_bblitz", 0 ) )
        return 0;

    if ( level.clear_cypher_icon )
        return 0;

    var_1 = var_0.team;

    if ( !isdefined( var_1 ) )
        return 0;

    var_2 = scripts\mp\utility\teams::getteamdata( var_1, "bblitzCounter" ) + 1;
    clear_bomb_vest_controller_holder( var_1, var_2 );

    if ( var_2 == level.clear_and_give_killstreak_loadout_assault )
    {
        clear_bomb_vest_controller_holder( var_1, 0 );

        if ( getdvarint( "scr_br_alt_mode_bblitz_consolation", 1 ) && !scripts\mp\gametypes\br_extract_quest.gsc::outofboundstriggersplanetrace( var_0.origin ) )
        {
            thread clear_and_give_killstreak_loadout_demo( var_0 );
            return var_2;
        }

        var_3 = spawnstruct();
        var_3.ml_p3_to_safehouse_transition = 0;
        var_4 = scripts\mp\gametypes\br_pickups.gsc::getitemdroporiginandangles( var_3, var_0.origin, ( 0, 0, 0 ), undefined, 0, 0, 35 );
        var_5 = scripts\mp\gametypes\br_pickups.gsc::spawnpickup( "brloot_blueprintextract_tablet", var_4, 0, 1 );
    }

    return var_2;
}

clear_bomb_vest_controller_holder( var_0, var_1 )
{
    scripts\mp\utility\teams::setteamdata( var_0, "bblitzCounter", var_1 );

    foreach ( var_3 in scripts\mp\utility\teams::getteamdata( var_0, "players" ) )
        var_3 setclientomnvar( "ui_br_bblitz", var_1 );
}

clear_and_give_killstreak_loadout_support()
{
    return getdvarfloat( "scr_br_alt_mode_bblitz_search_travel_speed", 0.0 );
}

clear_and_give_killstreak_loadout_recon()
{
    return getdvarfloat( "scr_br_alt_mode_bblitz_search_min_time", 120.0 );
}

clear_and_give_killstreak_loadout_demo( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( var_0.team, var_0.squadindex );

    foreach ( var_3 in var_1 )
        var_3 scripts\mp\utility\lower_message::_id_1316E( "br_assassination_notargets", undefined, 5 );

    var_5 = "mp/loot/br/default/lootset_cache_lege.csv";
    var_6 = [];
    var_6[var_6.size] = registerscriptedspawnpoints( "weapon", 3, 4, var_5 );
    var_6[var_6.size] = "brloot_super_munitionsbox";
    var_6[var_6.size] = "brloot_plunder_cash_epic_1";
    var_7 = spawnstruct();
    var_7.origin = var_0.origin;
    var_7.angles = var_0.angles;
    var_7.itemsdropped = 0;
    var_7 scripts\mp\gametypes\br_lootcache.gsc::_id_11A42( var_6, 0 );
}
