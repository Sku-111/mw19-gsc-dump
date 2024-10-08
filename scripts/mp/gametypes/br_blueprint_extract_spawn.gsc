// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.control_room_button = undefined;
    level.contract_death_cash_flag = undefined;
    level.contributingplayers = undefined;

    if ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" )
    {
        level.control_room_button = getdvarfloat( "scr_blueprint_dmz_maxPerMatch", 4 );
        level.contract_death_cash_flag = getdvarfloat( "scr_blueprint_dmz_chanceBase", 0.02 );
        level.contributingplayers = getdvarfloat( "scr_blueprint_dmz_chancePerContract", 0.0 );
    }
    else
    {
        level.control_room_button = getdvarfloat( "scr_blueprint_br_maxPerMatch", 4 );
        level.contract_death_cash_flag = getdvarfloat( "scr_blueprint_br_chanceBase", 0.02 );
        level.contributingplayers = getdvarfloat( "scr_blueprint_br_chancePerContract", 0.0 );
    }

    level.convoy4_module_snipers = 0;
    level.convoy4_failed_extract = level.contract_death_cash_flag;
    level.control_station = undefined;
    scripts\mp\gametypes\br_pickups.gsc::_id_12B33( "brloot_blueprintextract_tablet", ::controls_unlink_safe );
    scripts\mp\gametypes\br_pickups.gsc::_id_12B33( "brloot_blueprintextract_tablet_easterevent", ::controls_linkto_safe );
}

convoy4_actively_hacking( var_0, var_1 )
{
    if ( !convert_remaining_to_ai( var_0, var_1 ) )
        return undefined;

    if ( level.convoy4_module_snipers >= level.control_room_button )
        return undefined;

    var_2 = randomfloat( 1 );

    if ( var_2 <= level.convoy4_failed_extract )
    {
        level.convoy4_module_snipers = level.convoy4_module_snipers + 1;
        return "brloot_blueprintextract_tablet";
    }
    else
    {
        level.convoy4_failed_extract = level.convoy4_failed_extract + level.contributingplayers;
        return undefined;
    }
}

convert_remaining_to_ai( var_0, var_1 )
{
    if ( scripts\mp\gametypes\br_public.gsc::turret_headicon() )
        return 0;

    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
        return 0;

    if ( istrue( level.convoy_handle_stuck_compromise ) )
        return 0;

    if ( isdefined( var_1 ) && var_1 == "br_lep_quest_cache" )
        return 0;

    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && isdefined( level.br_level ) && isdefined( level.br_level.br_circleclosetimes ) )
    {
        var_2 = level.br_circle.circleindex;
        var_3 = level.br_level.br_circleclosetimes.size - 1;

        if ( var_3 - var_2 < 4 )
            return 0;
    }

    if ( !scripts\mp\gametypes\br_extract_quest.gsc::outofboundstriggersplanetrace( var_0 ) )
        return 0;

    return 1;
}

control_station_interact( var_0, var_1 )
{
    level.control_station = var_0;
    level.control_room_button_green = var_1;
}

add_neurotoxin_damage_area( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::risk_flagspawndebugobjicons( var_0 );
    controlslinked( var_1 );
    thread controlledcallbacksqueue();
    thread controlledcallbacks();
}

controls_unlink_safe()
{
    var_0 = scripts\engine\utility::ter_op( getdvarint( "scr_br_alt_mode_bblitz", 0 ), 2, 0 );
    add_neurotoxin_damage_area( var_0 );
}

controls_linkto_safe()
{
    add_neurotoxin_damage_area( 1 );
}

controlslinked( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::riotshield_init_cp( var_0 );
    scripts\mp\gametypes\br_pickups.gsc::_id_119F5( self, var_1 );
    self.overwatch_soldiers_05_bombers = var_0;
}

controlledcallbacksqueue()
{
    var_0 = level.control_station;
    level.control_station = undefined;
    var_1 = level.control_room_button_green;
    level.control_room_button_green = undefined;

    if ( !isdefined( var_0 ) )
        return;

    if ( isdefined( var_1 ) && istrue( var_1._id_11FF8 ) )
        return;

    var_2 = scripts\mp\objidpoolmanager::requestobjectiveid( 1 );

    if ( var_2 != -1 )
    {
        scripts\mp\objidpoolmanager::objective_add_objective( var_2, "invisible", ( 0, 0, 0 ), "ui_mp_br_mapmenu_icon_extraction_objective" );
        scripts\mp\objidpoolmanager::objective_set_play_intro( var_2, 1 );
        scripts\mp\objidpoolmanager::update_objective_setbackground( var_2, 1 );

        foreach ( var_4 in scripts\mp\utility\teams::getteamdata( var_0, "players" ) )
        {
            if ( !var_4 scripts\mp\gametypes\br_public.gsc::isplayeringulag() )
                objective_addclienttomask( var_2, var_4 );
        }
    }

    var_6 = gettime();

    while ( isdefined( self ) && gettime() - var_6 < 15000 )
    {
        var_7 = self.origin + ( 0, 0, 10 );
        scripts\mp\objidpoolmanager::update_objective_position( var_2, var_7 );
        waitframe();
    }

    scripts\mp\objidpoolmanager::objective_playermask_hidefromall( var_2 );
    scripts\mp\objidpoolmanager::returnobjectiveid( var_2 );
}

controlledcallbacks()
{
    while ( isdefined( self ) )
    {
        if ( !scripts\mp\gametypes\br_extract_quest.gsc::outofboundstriggersplanetrace( self.origin ) )
        {
            scripts\mp\gametypes\br_pickups.gsc::lastgoodjobplayer();
            return;
        }

        waitframe();
    }
}
