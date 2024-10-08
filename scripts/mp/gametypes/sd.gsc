// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    if ( getdvar( "mapname" ) == "mp_background" )
        return;

    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    var_0[0] = scripts\mp\utility\game::getgametype();
    var_0[1] = "bombzone";
    var_0[2] = "blocker";
    scripts\mp\gameobjects::main( var_0 );

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
    }
    else
    {
        scripts\mp\utility\game::registerroundswitchdvar( scripts\mp\utility\game::getgametype(), 3, 0, 12 );
        scripts\mp\utility\game::registertimelimitdvar( scripts\mp\utility\game::getgametype(), 150 );
        scripts\mp\utility\game::registerscorelimitdvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registerroundlimitdvar( scripts\mp\utility\game::getgametype(), 0 );
        scripts\mp\utility\game::registerwinlimitdvar( scripts\mp\utility\game::getgametype(), 4 );
        scripts\mp\utility\game::registernumlivesdvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registerhalftimedvar( scripts\mp\utility\game::getgametype(), 0 );
        scripts\mp\utility\game::registerwinbytwoenableddvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registerwinbytwomaxroundsdvar( scripts\mp\utility\game::getgametype(), 4 );
    }

    updategametypedvars();
    level.objectivebased = 1;
    level.teambased = 1;
    level.nobuddyspawns = 1;
    level.onprecachegametype = ::onprecachegametype;
    level.onstartgametype = ::onstartgametype;
    level.getspawnpoint = ::getspawnpoint;
    level.modeonspawnplayer = ::onspawnplayer;
    level.onplayerkilled = ::onplayerkilled;
    level.ondeadevent = ::ondeadevent;
    level.ononeleftevent = ::ononeleftevent;
    level.ontimelimit = ::ontimelimit;
    level.onnormaldeath = ::onnormaldeath;
    level.gamemodemaydropweapon = scripts\mp\utility\game::isplayeroutsideofanybombsite;
    level.onobjectivecomplete = ::onbombexploded;
    level.resetuiomnvargamemode = scripts\mp\gametypes\obj_bombzone.gsc::resetuiomnvargamemode;
    level.allowlatecomers = 0;
    level.bombsplanted = 0;
    level.aplanted = 0;
    level.bplanted = 0;
    game["dialog"]["gametype"] = "gametype_sanddestroy";

    if ( getdvarint( "OSMSLRTOP" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "NOSLRNTRKL" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];

    if ( !isdefined( game["roundsPlayed"] ) )
    {
        var_1 = "boost_sndattack";
        var_2 = "boost_snddefend";
    }
    else
    {
        var_1 = "boost_sndattack_short";
        var_2 = "boost_snddefend_short";
    }

    game["dialog"]["offense_obj"] = var_1;
    game["dialog"]["defense_obj"] = var_2;
    game["dialog"]["bomb_achieve"] = "bomb_achieve";
    game["dialog"]["bomb_pickup"] = "bomb_pickup";
    game["dialog"]["bomb_pickup_first"] = "bomb_pickup_first";
    game["dialog"]["bomb_taken"] = "bomb_taken";
    game["dialog"]["bomb_lost"] = "bomb_enemyowns";
    game["dialog"]["bomb_defused"] = "bomb_defused";
    game["dialog"]["bomb_planting"] = "bomb_planting";
    game["dialog"]["bomb_planting_a"] = "bomb_planting_a";
    game["dialog"]["bomb_planting_b"] = "bomb_planting_b";
    game["dialog"]["bomb_planted"] = "bomb_planted";
    game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
    game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
    game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
    game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";
    game["dialog"]["lead_lost"] = "null";
    game["dialog"]["lead_tied"] = "null";
    game["dialog"]["lead_taken"] = "null";
    setomnvar( "ui_bomb_timer_endtime_a", 0 );
    setomnvar( "ui_bomb_timer_endtime_b", 0 );
    setomnvar( "ui_bomb_planted_a", 0 );
    setomnvar( "ui_bomb_planted_b", 0 );
    setomnvar( "ui_bomb_interacting", 0 );
    level.nosuspensemusic = 1;
}

initializematchrules()
{
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( "scr_sd_bombtimer", getmatchrulesdata( "bombData", "bombTimer" ) );
    setdynamicdvar( "scr_sd_planttime", getmatchrulesdata( "bombData", "plantTime" ) );
    setdynamicdvar( "scr_sd_defusetime", getmatchrulesdata( "bombData", "defuseTime" ) );
    setdynamicdvar( "scr_sd_multibomb", getmatchrulesdata( "bombData", "multiBomb" ) );
    setdynamicdvar( "scr_sd_silentPlant", getmatchrulesdata( "bombData", "silentPlant" ) );
    setdynamicdvar( "scr_sd_resetprogress", getmatchrulesdata( "bombData", "resetProgress" ) );
    setdynamicdvar( "scr_sd_halftime", 0 );
    scripts\mp\utility\game::registerhalftimedvar( "sd", 0 );
    setdynamicdvar( "scr_sd_promode", 0 );
}

waittooverridegraceperiod()
{
    if ( scripts\mp\utility\game::isteamreviveenabled() || scripts\mp\utility\game::islaststandenabled() )
        game["dialog"]["gametype"] = "gametype_sandrescue";

    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.overrideingraceperiod = 1;
}

onprecachegametype()
{
    game["bomb_dropped_sound"] = "mp_war_objective_lost";
    game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

onstartgametype()
{
    if ( !isdefined( game["switchedsides"] ) )
        game["switchedsides"] = 0;

    if ( game["switchedsides"] )
    {
        var_0 = game["attackers"];
        var_1 = game["defenders"];
        game["attackers"] = var_1;
        game["defenders"] = var_0;
    }

    setclientnamemode( "manual_change" );
    level._effect["bomb_explosion"] = loadfx( "vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx" );
    level._effect["vehicle_explosion"] = loadfx( "vfx/core/expl/small_vehicle_explosion_new.vfx" );
    level._effect["building_explosion"] = loadfx( "vfx/iw7/_requests/mp/vfx_debug_warning.vfx" );
    scripts\mp\utility\game::setobjectivetext( game["attackers"], &"OBJECTIVES/SD_ATTACKER" );
    scripts\mp\utility\game::setobjectivetext( game["defenders"], &"OBJECTIVES/SD_DEFENDER" );

    if ( level.splitscreen )
    {
        scripts\mp\utility\game::setobjectivescoretext( game["attackers"], &"OBJECTIVES/SD_ATTACKER" );
        scripts\mp\utility\game::setobjectivescoretext( game["defenders"], &"OBJECTIVES/SD_DEFENDER" );
    }
    else
    {
        scripts\mp\utility\game::setobjectivescoretext( game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE" );
        scripts\mp\utility\game::setobjectivescoretext( game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE" );
    }

    scripts\mp\utility\game::setobjectivehinttext( game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT" );
    scripts\mp\utility\game::setobjectivehinttext( game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT" );
    initspawns();
    thread waittooverridegraceperiod();
    setspecialloadout();
    thread bombs();
}

initspawns()
{
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    scripts\mp\spawnlogic::addspawnpoints( game["attackers"], "mp_sd_spawn_attacker" );
    scripts\mp\spawnlogic::addspawnpoints( game["defenders"], "mp_sd_spawn_defender" );

    if ( level.mapname == "mp_m_speedball" || level.mapname == "mp_m_overunder" || level.mapname == "mp_m_overwinter" )
    {
        var_0 = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_defender" );
        var_1 = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_attacker" );
    }
    else if ( level.mapname == "mp_petrograd" )
    {
        var_0 = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_attacker" );
        var_1 = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_defender", 1 );
    }
    else
    {
        var_0 = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_attacker" );
        var_1 = scripts\mp\spawnlogic::getspawnpointarray( "mp_sd_spawn_defender" );
    }

    scripts\mp\spawnlogic::registerspawnset( "start_attackers", var_0 );
    scripts\mp\spawnlogic::registerspawnset( "start_defenders", var_1 );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
}

getspawnpoint()
{
    scripts\mp\spawnlogic::setactivespawnlogic( "StartSpawn", "Crit_Default" );
    var_0 = self.pers["team"];

    if ( var_0 == game["attackers"] )
    {
        scripts\mp\spawnlogic::activatespawnset( "start_attackers", 1 );
        var_1 = scripts\mp\spawnlogic::getspawnpoint( self, var_0, undefined, "start_attackers" );
    }
    else
    {
        scripts\mp\spawnlogic::activatespawnset( "start_defenders", 1 );
        var_1 = scripts\mp\spawnlogic::getspawnpoint( self, var_0, undefined, "start_defenders" );
    }

    return var_1;
}

onspawnplayer()
{
    self setclientomnvar( "ui_match_status_hint_text", -1 );

    if ( scripts\mp\utility\entity::isgameparticipant( self ) )
    {
        self.isplanting = 0;
        self.isdefusing = 0;
        self.isbombcarrier = 0;
        self.laststanding = 0;
    }

    if ( level.multibomb && self.pers["team"] == game["attackers"] )
        self setclientomnvar( "ui_carrying_bomb", 1 );
    else
    {
        self setclientomnvar( "ui_carrying_bomb", 0 );

        foreach ( var_1 in level.objectives )
            var_1.trigger disableplayeruse( self );
    }

    scripts\mp\utility\stats::setextrascore0( 0 );

    if ( isdefined( self.pers["plants"] ) )
        scripts\mp\utility\stats::setextrascore0( self.pers["plants"] );

    scripts\mp\utility\stats::setextrascore1( 0 );

    if ( isdefined( self.pers["defuses"] ) )
        scripts\mp\utility\stats::setextrascore1( self.pers["defuses"] );

    level notify( "spawned_player" );
    thread updatematchstatushintonspawn();
}

onplayerkilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    self setclientomnvar( "ui_carrying_bomb", 0 );
    thread checkallowspectating();
}

checkallowspectating()
{
    waitframe();
    var_0 = 0;

    if ( !scripts\mp\utility\teams::getteamdata( game["attackers"], "aliveCount" ) )
    {
        level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
        var_0 = 1;
    }

    if ( !scripts\mp\utility\teams::getteamdata( game["defenders"], "aliveCount" ) )
    {
        level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
        var_0 = 1;
    }

    if ( var_0 )
        scripts\mp\spectating::updatespectatesettings();
}

sd_endgame( var_0, var_1 )
{
    setomnvarforallclients( "ui_objective_state", 0 );
    setomnvar( "ui_bomb_interacting", 0 );
    thread scripts\mp\gamelogic::endgame( var_0, var_1 );
}

trial_race_lap_total()
{
    foreach ( var_1 in level.players )
    {
        if ( istrue( var_1.isplanting ) && isdefined( var_1.lastnonuseweapon ) )
        {
            var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate( var_1.lastnonuseweapon );
            break;
        }
    }
}

ondeadevent( var_0 )
{
    trial_race_lap_total();

    if ( level.bombexploded > 0 || level.bombdefused )
        return;

    if ( var_0 == "all" )
    {
        if ( level.bombplanted )
            sd_endgame( game["attackers"], game["end_reason"][tolower( game[game["defenders"]] ) + "_eliminated"] );
        else
            sd_endgame( game["defenders"], game["end_reason"][tolower( game[game["attackers"]] ) + "_eliminated"] );
    }
    else if ( var_0 == game["attackers"] )
    {
        if ( level.bombplanted )
            return;

        level thread sd_endgame( game["defenders"], game["end_reason"][tolower( game[game["attackers"]] ) + "_eliminated"] );
    }
    else if ( var_0 == game["defenders"] )
        level thread sd_endgame( game["attackers"], game["end_reason"][tolower( game[game["defenders"]] ) + "_eliminated"] );
}

ononeleftevent( var_0 )
{
    if ( level.bombexploded > 0 || level.bombdefused )
        return;

    var_1 = scripts\mp\utility\game::getlastlivingplayer( var_0 );
    var_1.laststanding = 1;
    var_1 thread givelastonteamwarning();
}

onnormaldeath( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    scripts\mp\gametypes\common.gsc::oncommonnormaldeath( var_0, var_1, var_2, var_3, var_4, var_5 );
    var_6 = scripts\mp\rank::getscoreinfovalue( "kill" );
    var_7 = var_0.team;
    var_8 = 0;

    if ( isdefined( var_1.laststanding ) && var_1.laststanding )
        var_1 thread scripts\mp\utility\points::giveunifiedpoints( "last_man_kill" );

    if ( var_0.isplanting )
    {
        scripts\mp\utility\game::_id_119AC( var_0, var_1, "Bomb Carrier Killed", var_0.origin, "was_planting_bomb" );
        thread scripts\common\utility::_id_13E0A( level._id_11B30, var_2, "planting" );
        var_1 scripts\mp\utility\stats::incpersstat( "defends", 1 );
        var_1 scripts\mp\persistence::statsetchild( "round", "defends", var_1.pers["defends"] );
        var_1 thread scripts\mp\awards::givemidmatchaward( "mode_sd_plant_save" );
        var_8 = 1;
    }
    else if ( var_0.isbombcarrier )
    {
        scripts\mp\utility\game::_id_119AC( var_0, var_1, "Bomb Carrier Killed", var_0.origin );
        thread scripts\common\utility::_id_13E0A( level._id_11B30, var_2, "carrying" );
    }
    else if ( var_0.isdefusing )
    {
        scripts\mp\utility\game::_id_119AC( var_0, var_1, "Defuser Killed", var_0.origin );
        thread scripts\common\utility::_id_13E0A( level._id_11B30, var_2, "defusing" );
        var_1 scripts\mp\utility\stats::incpersstat( "defends", 1 );
        var_1 scripts\mp\persistence::statsetchild( "round", "defends", var_1.pers["defends"] );
        var_1 thread scripts\mp\awards::givemidmatchaward( "mode_sd_defuse_save" );
        var_8 = 1;
    }

    if ( isdefined( level.sdbomb.carrier ) )
    {
        if ( isdefined( var_1 ) && isplayer( var_1 ) && var_1.pers["team"] != var_0.pers["team"] )
        {
            if ( var_1.pers["team"] == level.sdbomb.carrier.team && var_1 != level.sdbomb.carrier )
            {
                var_9 = distancesquared( level.sdbomb.carrier.origin, var_1.origin );

                if ( var_9 < 105625 )
                {
                    var_1 thread scripts\mp\rank::scoreeventpopup( "defend" );
                    var_1 thread scripts\mp\awards::givemidmatchaward( "mode_x_defend" );
                    var_1 scripts\mp\utility\stats::incpersstat( "defends", 1 );
                    var_1 scripts\mp\persistence::statsetchild( "round", "defends", var_1.pers["defends"] );
                    thread scripts\common\utility::_id_13E0A( level._id_11B30, var_2, "defending" );
                    var_8 = 1;
                }
            }
        }
    }

    if ( !var_8 )
        scripts\mp\gametypes\obj_bombzone.gsc::bombzone_awardgenericbombzonemedals( var_1, var_0 );
}

givelastonteamwarning()
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    scripts\mp\utility\player::waittillrecoveredhealth( 3 );
    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "inform_last_one" );
    var_0 = scripts\mp\utility\game::getotherteam( self.pers["team"] )[0];
    level thread scripts\mp\hud_util::teamplayercardsplash( "callout_lastteammemberalive", self, self.pers["team"] );
    level thread scripts\mp\hud_util::teamplayercardsplash( "callout_lastenemyalive", self, var_0 );
    level notify( "last_alive", self );
    scripts\mp\utility\game::setmlgannouncement( 3, self.team, self getentitynumber() );
}

ontimelimit()
{
    sd_endgame( game["defenders"], game["end_reason"]["time_limit_reached"] );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1.bombplantweapon ) )
        {
            var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon( var_1.bombplantweapon );
            break;
        }
    }

    scripts\mp\utility\game::_id_119AC( undefined, undefined, "Time Limit Reached" );
}

updategametypedvars()
{
    scripts\mp\gametypes\common.gsc::updatecommongametypedvars();
    level.bombtimer = scripts\mp\utility\dvars::dvarfloatvalue( "bombtimer", 45, 1, 240 );
    level.planttime = scripts\mp\utility\dvars::dvarfloatvalue( "planttime", 5, 0, 20 );
    level.defusetime = scripts\mp\utility\dvars::dvarfloatvalue( "defusetime", 5, 0, 20 );
    level.multibomb = scripts\mp\utility\dvars::dvarintvalue( "multibomb", 0, 0, 1 );
    level.silentplant = scripts\mp\utility\dvars::dvarintvalue( "silentPlant", 0, 0, 1 );
    level.resetprogress = scripts\mp\utility\dvars::dvarintvalue( "resetProgress", 0, 0, 1 );
}

removebombzonec( var_0 )
{
    var_1 = [];
    var_2 = getentarray( "script_brushmodel", "classname" );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4.script_gameobjectname ) && var_4.script_gameobjectname == "bombzone" )
        {
            foreach ( var_6 in var_0 )
            {
                if ( distance( var_4.origin, var_6.origin ) < 100 && issubstr( tolower( var_6.script_label ), "c" ) )
                {
                    var_6.relatedbrushmodel = var_4;
                    var_1[var_1.size] = var_6;
                    break;
                }
            }
        }
    }

    foreach ( var_10 in var_1 )
    {
        var_10.relatedbrushmodel delete();
        var_11 = getentarray( var_10.target, "targetname" );

        foreach ( var_13 in var_11 )
            var_13 delete();

        var_10 delete();
    }

    return scripts\engine\utility::array_removeundefined( var_0 );
}

bombs()
{
    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_setupbombcase( "sd_bomb" );
    var_0 = getentarray( "bombzone", "targetname" );
    var_0 = removebombzonec( var_0 );
    level.objectives = [];

    foreach ( var_2 in var_0 )
    {
        var_3 = scripts\mp\gametypes\obj_bombzone.gsc::setupobjective( var_2, 1, 1 );
        var_3.onbeginuse = ::onbeginuse;
        var_3.onenduse = ::onenduse;
        var_3.onuse = ::onuseplantobject;
        level.objectives[var_3.objectivekey] = var_3;
    }

    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
        level scripts\engine\utility::_id_143A5( "prematch_done", "start_mode_setup" );

    level.sdbomb scripts\mp\gameobjects::requestid( 1, 1, 2 );
    level.sdbomb scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_bomb" );
    level.sdbomb scripts\mp\gameobjects::setvisibleteam( "friendly" );
    level.sdbombmodel = level.sdbomb.visuals[0];
    level.sdbombmodel scripts\mp\gametypes\obj_bombzone.gsc::setteaminhuddatafromteamname( game["attackers"] );
    level.sdbombmodel setasgametypeobjective();
    hastacvis( level.sdbomb.objidnum, 1 );
    scripts\mp\objidpoolmanager::objective_set_play_intro( level.sdbomb.objidnum, 0 );
    scripts\mp\objidpoolmanager::objective_set_play_outro( level.sdbomb.objidnum, 0 );

    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
        wait 0.5;

    foreach ( var_3 in level.objectives )
    {
        var_6 = scripts\mp\gametypes\obj_bombzone.gsc::getreservedobjid( var_3.objectivekey );
        var_3 scripts\mp\gameobjects::requestid( 1, 1, var_6 );
        var_3 scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend", "waypoint_target" );
        var_3 scripts\mp\gameobjects::setvisibleteam( "any" );
    }
}

onbeginuse( var_0 )
{
    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_onbeginuse( var_0 );

    if ( !scripts\mp\gameobjects::isfriendlyteam( var_0.pers["team"] ) )
    {
        if ( level.multibomb )
        {
            if ( self.objectivekey == "_a" )
            {
                level.objectives["_b"] scripts\mp\gameobjects::allowuse( "none" );
                level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam( "friendly" );
            }
            else
            {
                level.objectives["_a"] scripts\mp\gameobjects::allowuse( "none" );
                level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam( "friendly" );
            }
        }
    }
}

onenduse( var_0, var_1, var_2 )
{
    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_onenduse( var_0, var_1, var_2 );

    if ( isdefined( var_1 ) && !scripts\mp\gameobjects::isfriendlyteam( var_1.pers["team"] ) )
    {
        if ( level.multibomb && !var_2 )
        {
            if ( self.objectivekey == "_a" )
            {
                level.objectives["_b"] scripts\mp\gameobjects::allowuse( "enemy" );
                level.objectives["_b"] scripts\mp\gameobjects::setvisibleteam( "any" );
            }
            else
            {
                level.objectives["_a"] scripts\mp\gameobjects::allowuse( "enemy" );
                level.objectives["_a"] scripts\mp\gameobjects::setvisibleteam( "any" );
            }
        }
    }
}

onuseplantobject( var_0 )
{
    if ( !scripts\mp\gameobjects::isfriendlyteam( var_0.pers["team"] ) )
    {
        foreach ( var_2 in level.objectives )
        {
            if ( var_2 == self )
                continue;

            var_2 scripts\mp\gameobjects::disableobject();
        }
    }

    scripts\mp\gametypes\obj_bombzone.gsc::bombzone_onuseplantobject( var_0 );
    scripts\mp\utility\game::_id_119AC( var_0, undefined, "Bomb Planted", var_0.origin );
    thread scripts\mp\music_and_dialog::bombplanted_music();
}

setspecialloadout()
{
    if ( isusingmatchrulesdata() && scripts\mp\utility\game::getmatchrulesdatawithteamandindex( "defaultClasses", game["attackers"], 5, "class", "inUse" ) )
        level.sd_loadout[game["attackers"]] = scripts\mp\utility\game::getmatchrulesspecialclass( game["attackers"], 5 );
}

onbombexploded( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( level.nukeincoming ) )
        return;

    if ( var_3 == game["attackers"] )
    {
        setgameendtime( 0 );
        wait 3;
        scripts\mp\utility\game::_id_119AC( undefined, undefined, "Target Destroyed" );
        sd_endgame( game["attackers"], game["end_reason"]["target_destroyed"] );
    }
    else
    {
        wait 1.5;
        setgameendtime( 0 );
        sd_endgame( game["defenders"], game["end_reason"]["bomb_defused"] );
    }
}

updatematchstatushintonspawn()
{
    if ( level.bombplanted )
    {
        if ( game["attackers"] == self.team )
            self setclientomnvar( "ui_match_status_hint_text", 22 );
        else
            self setclientomnvar( "ui_match_status_hint_text", 23 );
    }
    else if ( isdefined( level.sdbomb ) )
    {
        if ( isdefined( level.sdbomb.carrier ) )
        {
            if ( level.sdbomb.carrier.team == self.team )
            {
                if ( level.sdbomb.carrier == self )
                    self setclientomnvar( "ui_match_status_hint_text", 21 );
                else
                    self setclientomnvar( "ui_match_status_hint_text", 25 );
            }
            else
                self setclientomnvar( "ui_match_status_hint_text", 26 );
        }
        else if ( game["attackers"] == self.team )
            self setclientomnvar( "ui_match_status_hint_text", 24 );
        else
            self setclientomnvar( "ui_match_status_hint_text", 26 );
    }
    else
        self setclientomnvar( "ui_match_status_hint_text", -1 );
}