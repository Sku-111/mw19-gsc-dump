// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    maintacopsinit();
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    maintacopspostinit();
    level.startedfromtacops = 0;
    level.onstartgametype = ::onstartgametype;
}

maintacops()
{
    maintacopsinit();
    maintacopspostinit();
    level.startedfromtacops = 1;
    onstartgametype();
}

maintacopsinit()
{
    level.tacopssublevel = "to_hstg";
    level.currentmode = "to_hstg";
    setomnvar( "ui_tac_ops_submode", level.currentmode );
}

maintacopspostinit()
{
    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
    }
    else
    {
        scripts\mp\utility\game::registerroundswitchdvar( "to_hstg", 0, 0, 9 );
        scripts\mp\utility\game::registertimelimitdvar( "to_hstg", 10 );
        scripts\mp\utility\game::registerscorelimitdvar( "to_hstg", 85 );
        scripts\mp\utility\game::registerroundlimitdvar( "to_hstg", 1 );
        scripts\mp\utility\game::registerwinlimitdvar( "to_hstg", 1 );
        scripts\mp\utility\game::registernumlivesdvar( "to_hstg", 0 );
        scripts\mp\utility\game::registerhalftimedvar( "to_hstg", 0 );
        scripts\mp\utility\game::registerdogtagsenableddvar( "to_hstg", 0 );
    }

    updategametypedvars();
    setuphudelements();
    level.resetscoreonroundstart = 1;
    level.spawnedhostagecount = 0;
    scripts\mp\gametypes\obj_grindzone.gsc::init();
    level.teambased = 1;
    level.onplayerconnect = ::onplayerconnect;
    level.onnormaldeath = ::onnormaldeath;
    level.modeonspawnplayer = ::onspawnplayer;
    level.onsuicidedeath = ::onsuicidedeath;
    level.ontimelimit = ::ontimelimit;
}

initializematchrules()
{
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( "scr_to_hstg_bankTime", getmatchrulesdata( "grindData", "bankTime" ) );
    setdynamicdvar( "scr_to_hstg_bankRate", getmatchrulesdata( "grindData", "bankRate" ) );
    setdynamicdvar( "scr_to_hstg_bankCaptureTime", getmatchrulesdata( "grindData", "bankCaptureTime" ) );
    setdynamicdvar( "scr_to_hstg_megaBankLimit", getmatchrulesdata( "grindData", "megaBankLimit" ) );
    setdynamicdvar( "scr_to_hstg_bankBonus", getmatchrulesdata( "grindData", "megaBankBonus" ) );
    setdynamicdvar( "scr_to_hstg_halftime", 0 );
    scripts\mp\utility\game::registerhalftimedvar( "to_hstg", 0 );
    setdynamicdvar( "scr_to_hstg_promode", 0 );
}

seticonnames()
{
    level.waypointcolors["waypoint_capture_recover"] = "neutral";
    level.waypointbgtype["waypoint_capture_recover"] = 1;
    level.waypointcolors["koth_enemy"] = "enemy";
    level.waypointbgtype["koth_enemy"] = 1;
    level.icontarget = "waypoint_hardpoint_target";
    level.iconneutral = "koth_neutral";
    level.iconcapture = "koth_enemy";
    level.icondefend = "koth_friendly";
    level.iconcontested = "waypoint_hardpoint_contested";
    level.icontaking = "waypoint_taking_chevron";
    level.iconlosing = "waypoint_hardpoint_losing";
    level.iconbombcapture = "waypoint_target";
    level.iconbombdefend = "waypoint_defend";
    level.iconrecover = "waypoint_capture_recover";
    level.iconescort = "waypoint_escort";
    level.icondefendhvt = "waypoint_defend_round";
    level.iconkill = "waypoint_capture_kill_round";
}

onstartgametype()
{
    createzones();
    seticonnames();
    scripts\mp\tac_ops\hostage_utility::hostagesysteminit();
    setdvar( "MTLTONMMQT", 0.75 );
    level.zoneduration = 120;
    level.hostagestates = [];
    level.hostagecarrystates = [];
    level.debughostagegame = 1;
    createhvt();
    level.extractionlocent = getent( "hvtExtractionLoc", "targetname" );
    level.hostagecheckpointent = [];
    level.hostagecheckpointent[0] = scripts\engine\utility::getstructarray( "hostage_waypoint_1", "targetname" );
    level.hostagecheckpointent[1] = scripts\engine\utility::getstructarray( "hostage_waypoint_2", "targetname" );
    level.hostagecheckpointent[2] = scripts\engine\utility::getstructarray( "hostage_waypoint_3", "targetname" );
    thread createhvtextractionsite();
    level.hostagehidespots = [];
    level.hostagehidespots[0] = level.hvtlocent;
    level.hostageexitpoints = [];
    level.hostageexitpoints[0] = level.objectives[0];
    scripts\mp\tac_ops\hostage_utility::spawnallhostages();
    level.hostages[0].outlineid = scripts\mp\utility\outline::outlineenableforteam( level.hostages[0].body, level.hostages[0].team, "outline_nodepth_cyan", "killstreak_personal" );
    setdvar( "MTLTONMMQT", 0.75 );
    level.zoneduration = 120;
    level.hostagestates = [];
    level.hostagecarrystates = [];
    level.debughostagegame = 1;
    level.objectives[0] scripts\mp\gameobjects::setkeyobject( level.hostages[0] );
    level.fixedlzs = [];
    level.fixedlzs[0] = level.objectives[0];
    initializefixedlzs();
    level thread watchpushtriggers();

    if ( !istrue( level.startedfromtacops ) )
    {
        var_0[0] = "dom";
        scripts\mp\gameobjects::main( var_0 );
        scripts\mp\gametypes\tac_ops.gsc::commoninit();
        activatespawns();
    }

    var_1 = scripts\mp\utility\game::gettimelimit();
    level.extratime = 0;
    scripts\mp\utility\dvars::setoverridewatchdvar( "timelimit", 6 );
    level.tacopssubmodetimeron = 1;
}

setusablebyteam( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_2.team != var_0 )
        {
            self disableplayeruse( var_2 );
            continue;
        }

        self enableplayeruse( var_2 );
    }
}

updategametypedvars()
{
    scripts\mp\gametypes\common.gsc::updatecommongametypedvars();
    level.banktime = scripts\mp\utility\dvars::dvarfloatvalue( "bankTime", 2, 0, 10 );
    level.bankrate = scripts\mp\utility\dvars::dvarintvalue( "bankRate", 1, 1, 10 );
    level.bankcapturetime = scripts\mp\utility\dvars::dvarintvalue( "bankCaptureTime", 0, 0, 10 );
    level.megabanklimit = scripts\mp\utility\dvars::dvarintvalue( "megaBankLimit", 5, 5, 15 );
    level.megabankbonus = scripts\mp\utility\dvars::dvarintvalue( "megaBankBonus", 150, 0, 750 );
}

setuphudelements()
{
    level.iconenemyextract3d = "waypoint_extract_enemy";
    level.iconenemyextract2d = "waypoint_extract_enemy";
    level.iconfriendlyextract3d = "waypoint_extract_friendly";
    level.iconfriendlyextract2d = "waypoint_extract_friendly";
    level.iconfriendlyzone3d = "waypoint_staging_friendly";
    level.iconfriendlyzone2d = "waypoint_staging_friendly";
}

updateextracticons()
{
    scripts\mp\gameobjects::setobjectivestatusicons( level.iconfriendlyextract2d );
}

onspawnplayer()
{
    if ( isdefined( self.tagscarried ) )
        self setclientomnvar( "ui_grind_tags", self.tagscarried );

    scripts\mp\playerlogic::incrementalivecount( self.team );
    self.hostagecarried = undefined;
    scripts\mp\tac_ops\roles_utility::kitspawn();
}

onplayerconnect( var_0 )
{
    var_0.isscoring = 0;
    var_0 thread monitorjointeam();
}

monitorjointeam()
{
    self endon( "disconnect" );

    for (;;)
    {
        self waittill( "joined_team" );
        var_0 = 0;

        if ( self.team == "allies" )
            var_0 = 1;
        else if ( self.team == "axis" )
            var_0 = 2;

        self setclientomnvar( "ui_tacops_team", var_0 );

        if ( !isdefined( level.startedfromtacops ) )
        {
            scripts\mp\supers::clearsuper();
            scripts\mp\tac_ops\roles_utility::latejointeamkitobjective();
        }
    }
}

createzones()
{
    var_0 = scripts\engine\utility::getstructarray( "hostage_extract_zone_A", "targetname" );
    var_1 = scripts\engine\utility::getstructarray( "hostage_extract_zone_B", "targetname" );
    level.fixedlzs = scripts\engine\utility::array_combine( var_0, var_1 );
    level.objectives = [];
}

zone_ondisableobjective()
{
    scripts\mp\gameobjects::disableobject();
    scripts\mp\gameobjects::allowuse( "none" );
}

initspawns()
{
    var_0 = level.tacopsspawns;
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_tohstg_spawn_allies", 1 );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_tohstg_spawn_axis", 1 );
    var_0.to_hstg_spawns = [];
    var_0.to_hstg_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray( "mp_tohstg_spawn_allies" );
    var_0.to_hstg_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray( "mp_tohstg_spawn_axis" );

    if ( var_0.to_hstg_spawns["allies"].size <= 0 )
    {
        scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_front_spawn_allies" );
        var_0.to_hstg_spawns["allies"] = scripts\mp\spawnlogic::getspawnpointarray( "mp_front_spawn_allies" );
    }

    if ( var_0.to_hstg_spawns["axis"].size <= 0 )
    {
        scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_front_spawn_axis" );
        var_0.to_hstg_spawns["axis"] = scripts\mp\spawnlogic::getspawnpointarray( "mp_front_spawn_axis" );
    }
}

getspawnpoint()
{
    var_0 = level.tacopsspawns;
    var_1 = self.pers["team"];
    var_2 = scripts\mp\tac_ops_map::filterspawnpoints( var_0.to_hstg_spawns[var_1] );
    var_3 = undefined;
    return var_3;
}

activatespawns()
{
    scripts\mp\spawnlogic::setactivespawnlogic( "TDM" );
    scripts\mp\tac_ops_map::setactivemapconfig( "to_hstg", "allies" );
    scripts\mp\tac_ops_map::setactivemapconfig( "to_hstg", "axis" );
    level.getspawnpoint = ::getspawnpoint;
}

ontimelimit()
{
    endhostagegame( "allies" );
}

endhostagegame( var_0 )
{
    level.extratime = undefined;
    level notify( "switch_modes" );

    foreach ( var_2 in level.hostages )
    {
        var_2 scripts\mp\tac_ops\hostage_utility::removeminimapicons();

        if ( isdefined( var_2.useobj ) )
            var_2.useobj delete();

        var_2.body delete();
        var_2.head delete();
        var_2 delete();
    }

    level.hostages = [];

    foreach ( var_5 in level.activeextractions )
    {
        var_5 cleanuplz( 0 );
        var_5 scripts\mp\gametypes\obj_grindzone.gsc::deactivatezone();
    }

    if ( isdefined( level.onphaseend ) )
        [[ level.onphaseend ]]( var_0 );

    scripts\mp\gamescore::_setteamscore( var_0, 1, 0 );
    thread scripts\mp\gamelogic::endgame( var_0, game["end_reason"]["objective_completed"] );
}

onsuicidedeath( var_0 )
{
    if ( isdefined( var_0.hostagecarried ) )
        scripts\mp\tac_ops\hostage_utility::drophostage( var_0, var_0.hostagecarried, var_0.origin );
}

onnormaldeath( var_0, var_1, var_2, var_3, var_4 )
{
    scripts\mp\gametypes\common.gsc::oncommonnormaldeath( var_0, var_1, var_2, var_3, var_4 );

    if ( isdefined( var_0.hostagecarried ) )
        scripts\mp\tac_ops\hostage_utility::drophostage( var_0, var_0.hostagecarried, var_0.origin );

    if ( !isdefined( var_0.switching_teams ) )
        var_0 scripts\mp\playerlogic::decrementalivecount( var_0.team );
}

delayedhostagespawn( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    level endon( "hostage_spawn_early" );
    wait( var_0 );
    scripts\mp\tac_ops\hostage_utility::spawnrandomhostages( var_1, var_2 );
}

hostagecheckscoring()
{
    for ( var_0 = 0; var_0 < level.activeextractions.size; var_0++ )
    {
        var_1 = level.activeextractions[var_0];

        if ( distancesquared( self.origin, var_1.origin ) < 14400 )
        {
            iprintlnbold( "OPFOR EXTRACTED A HOSTAGE" );
            scripts\mp\tac_ops\hostage_utility::scorehostage( var_1.team, 3 );
            return 1;
        }
    }

    return 0;
}

initializefixedlzs()
{
    level endon( "game_ended" );
    level endon( "switch_modes" );
    level.extractionteam = "allies";

    for ( var_0 = 0; var_0 < level.fixedlzs.size; var_0++ )
        level.inactiveextractions[var_0] = level.fixedlzs[var_0];

    thread waitprematchdone();
}

initializedynamiclzs()
{
    level endon( "game_ended" );
    level endon( "switch_modes" );
    level.extractionteam = "axis";

    for ( var_0 = 0; var_0 < 2; var_0++ )
    {
        level.inactiveextractions[var_0] = level.objective[var_0];
        level.inactiveextractions[var_0] updateextracticons();
        level.inactiveextractions[var_0] scripts\mp\gameobjects::setvisibleteam( "none" );
    }

    thread waitprematchdone();
}

waitprematchdone()
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
}

createhostagelz( var_0, var_1 )
{
    var_2 = level.inactiveextractions.size;
    var_3 = level.inactiveextractions[var_2 - 1];
    var_3.marker = var_0;
    level.inactiveextractions[var_2 - 1] = undefined;
    var_4 = level.activeextractions.size;
    level.activeextractions[var_4] = var_3;
    level.activeextractors[var_4] = self;
    var_5 = int( gettime() + 119000 );

    if ( istrue( var_1 ) )
        makelzextractionvisuals( var_3 );
}

makelzextractionvisuals( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = level.extractionpos;

    var_0.origin = var_1;

    if ( isdefined( var_0.trigger ) )
        var_0.trigger.origin = var_1;

    var_0.curorigin = var_1;
    var_0 scripts\mp\gameobjects::requestid( 1, 1 );
    var_0 updateextracticons();
    var_0 scripts\mp\gametypes\obj_grindzone.gsc::activatezone();
    var_0.active = 1;
    var_0 scripts\mp\gameobjects::setvisibleteam( "friendly" );
    var_0.scriptable = scripts\mp\gametypes\obj_grindzone.gsc::setupscriptablevisuals( var_1, var_0 );
    var_0 scripts\mp\gametypes\obj_grindzone.gsc::updateflagstate( var_0.team, 0 );

    if ( isdefined( var_0.team ) )
        updateservericons( var_0.team, 0 );

    level notify( "zone_moved" );
    scripts\mp\utility\sound::playsoundonplayers( "mp_killstreak_radar" );
    var_2 = spawnfx( level._effect["vfx_smk_signal"], var_1 );

    if ( isdefined( var_2 ) )
        triggerfx( var_2 );

    var_0.fxtoplay = var_2;
}

spawnextractchopper( var_0, var_1 )
{
    self endon( "game_ended" );
    self endon( "switch_modes" );
    wait( var_1 );
    var_2 = level.extractionpos;
    var_3 = ( 0, 0, 0 );
    var_4 = 24000;
    var_5 = scripts\cp_mp\utility\killstreak_utility::removeextracthelipad();
    var_6 = var_5.origin[2];
    var_7 = getexplodedistance( var_6 );
    var_8 = 4000;
    var_9 = "jackal";
    var_10 = scripts\cp_mp\killstreaks\airstrike::getflightpath( var_2, var_3, var_4, var_5, var_6, var_8, var_7, var_9 );
    var_11 = fakestreakinfo();
    var_12 = scripts\mp\killstreaks\jackal::beginjackal( 0, var_10["startPoint"], var_2, var_11, var_0 );
    return var_12;
}

fakestreakinfo()
{
    var_0 = spawnstruct();
    var_0.available = 1;
    var_0.firednotify = "offhand_fired";
    var_0.isgimme = 1;
    var_0.kid = 5;
    var_0.lifeid = 0;
    var_0.madeavailabletime = gettime();
    var_0.scriptuseagetype = "gesture_script_weapon";
    var_0.streakname = "jackal";
    var_0.streaksetupinfo = undefined;
    var_0.variantid = -1;
    var_0.weaponname = "ks_gesture_generic_mp";
    var_0.objweapon = getcompleteweaponname( var_0.weaponname );
    return var_0;
}

getexplodedistance( var_0 )
{
    var_1 = 850;
    var_2 = 1500;
    var_3 = var_1 / var_0;
    var_4 = var_3 * var_2;
    return var_4;
}

waitlzextractarrival( var_0 )
{
    level endon( "game_ended" );
    level endon( "switch_modes" );
    self endon( "extraction_destroyed" );
    thread extractvehicledeathwatcher();
    wait 119;

    foreach ( var_2 in level.jackals )
    {
        if ( !isdefined( var_2.lz ) || !isdefined( var_2.lz.marker ) )
            continue;

        if ( self.marker == var_2.lz.marker )
            var_2 notify( "extract_hostages" );
    }

    if ( level.objectives[0].ownerteam == "allies" )
    {
        scripts\mp\gamescore::_setteamscore( "allies", 1, 0 );
        thread scripts\mp\gamelogic::endgame( "allies", game["end_reason"]["objective_completed"] );
    }
    else
    {
        scripts\mp\gamescore::_setteamscore( "axis", 1, 0 );
        thread scripts\mp\gamelogic::endgame( "axis", game["end_reason"]["objective_completed"] );
    }
}

extractvehicledeathwatcher()
{
    level endon( "switch_modes" );
    self endon( "game_ended" );
    self endon( "extract_hostages" );
    self waittill( "extraction_destroyed" );
    cleanuplz( 0 );
}

cleanuplz( var_0 )
{
    if ( var_0 )
        checkhostagescoring();

    cleanuplzvisuals();
    level.inactiveextractions[level.inactiveextractions.size] = self;
    level.activeextractors = scripts\engine\utility::array_remove_index( level.activeextractors, 0 );
    level.activeextractions = scripts\engine\utility::array_remove_index( level.activeextractions, 0 );
}

cleanuplzvisuals()
{
    if ( isdefined( self.scriptable ) )
    {
        scripts\mp\gametypes\obj_grindzone.gsc::updateflagstate( "off", 0 );
        self.scriptable delete();
    }

    if ( isdefined( self.fxtoplay ) )
        self.fxtoplay delete();

    if ( isdefined( self.marker ) && isdefined( self.marker.visual ) )
    {
        self.marker.visual delete();
        scripts\mp\gameobjects::allowuse( "none" );
        scripts\mp\gameobjects::releaseid();
    }

    self.active = 0;
    updateservericons( "zone_shift", 0 );
    scripts\mp\gametypes\obj_grindzone.gsc::deactivatezone();
    self.active = 1;
    self.lastactivatetime = gettime();
}

checkhostagescoring()
{
    var_0 = [];
    var_1 = "none";

    foreach ( var_3 in level.hostages )
    {
        if ( var_3 hostagecheckscoring() )
            var_0[var_0.size] = var_3;

        var_1 = var_3.team;
    }

    level.hostages = scripts\engine\utility::array_remove_array( level.hostages, var_0 );
    tryhostagerespawn( var_1 );
}

tryhostagerespawn( var_0 )
{
    if ( level.hostages.size == 0 )
    {
        level notify( "hostage_spawn_early" );
        scripts\mp\tac_ops\hostage_utility::spawnrandomhostages( 2, var_0 );
        waitframe();
        var_1 = scripts\mp\gametypes\tac_ops.gsc::gettacopstimelimitms() / 1000;
        thread delayedhostagespawn( var_1 * 0.2, 2 );
        thread delayedhostagespawn( var_1 * 0.4, 2 );
        thread delayedhostagespawn( var_1 * 0.6, 2 );
    }
}

handlehostmigration( var_0 )
{
    level endon( "game_ended" );
    level endon( "bomb_defused" );
    level endon( "disconnect" );
    level waittill( "host_migration_begin" );
    var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

    if ( var_1 > 0 )
        return;

    return;
}

updateservericons( var_0, var_1 )
{
    var_2 = -1;

    if ( var_1 )
        var_2 = -2;
    else
    {
        switch ( var_0 )
        {
            case "axis":
            case "allies":
                var_3 = thread getownerteamplayer( var_0 );

                if ( isdefined( var_3 ) )
                    var_2 = var_3 getentitynumber();

                break;
            case "zone_activation_delay":
                var_2 = -3;
                break;
            case "zone_shift":
            default:
                break;
        }
    }
}

getownerteamplayer( var_0 )
{
    var_1 = undefined;

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == var_0 )
        {
            var_1 = var_3;
            break;
        }
    }

    return var_1;
}

setupextractioncallouts( var_0 )
{
    var_1 = 1;
    level.extractionteam = var_0;

    if ( !isdefined( level.extractionteam ) )
        var_1 = 2;
    else if ( level.extractionteam == "allies" )
        var_1 = 0;

    foreach ( var_3 in level.players )
    {
        if ( isdefined( var_1 ) )
            var_3 setclientomnvar( "ui_hp_callout_id", var_1 );
    }
}

trycreateextractpoint( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( level.activeextractions.size < 2 )
    {
        level.extractionpos = var_0;
        createhostagelz( var_1, var_2 );
        self iprintlnbold( "Extraction copter deployed, hold out!" );
        return 1;
    }
    else
    {
        self iprintlnbold( "Request Denied - All copters already en route!" );
        return 0;
    }
}

getextractiontimeconst()
{
    return 120;
}

createhvt()
{
    var_0 = getent( "hvtSpawnLoc", "targetname" );
    level.hvtlocent = var_0;
}

createhvtextractionsite()
{
    var_0 = getent( "hvtExtractionLoc", "targetname" );
    level.objectives = [];
    level.objectives[0] = var_0;
    var_1 = scripts\mp\gametypes\obj_dom.gsc::setupobjective( level.objectives[0] );
    scripts\engine\utility::delaythread( 3.0, ::delayset );
    var_1.onuse = ::hostagedompoint_onuse;
    level.objectives[0] = var_1;
    level.flagcapturetime = 0.1;
    level.flagneutralization = 0;
    waitframe();
    var_1 scripts\mp\gameobjects::setownerteam( "neutral" );
    var_1 scripts\mp\gameobjects::setvisibleteam( "any" );
    var_1 scripts\mp\gameobjects::allowuse( "enemy" );
    var_1 scripts\mp\gameobjects::cancontestclaim( 1 );
    var_1 scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconfriendlyextract3d );
}

delayset()
{
    level.objectives[0] scripts\mp\gameobjects::setownerteam( "axis" );
    level.objectives[0] scripts\mp\gameobjects::allowuse( "enemy" );
    level.objectives[0] scripts\mp\gametypes\obj_dom.gsc::updateflagstate( "axis", 0 );
    level.objectives[0] scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconfriendlyextract3d );
}

watchpushtriggers()
{
    level endon( "game_ended" );
    level endon( "hostage_phase_ended" );
    var_0 = getentarray( "to_hstg_push_trigger", "targetname" );

    if ( !isdefined( var_0 ) || var_0.size <= 0 )
        return;

    var_1 = [];

    foreach ( var_3 in var_0 )
    {
        var_4 = int( var_3.script_noteworthy );
        var_1[var_4] = var_3;
    }

    var_6 = 0;

    for (;;)
    {
        wait 1.0;
        var_7 = var_1[var_6 + 1];

        if ( isdefined( var_7 ) )
        {
            foreach ( var_9 in level.hostages )
            {
                if ( var_9 istouching( var_7 ) )
                {
                    var_6++;
                    var_10 = "to_hstg_" + var_6;
                    scripts\mp\tac_ops_map::setactivemapconfig( var_10, "allies" );
                    scripts\mp\tac_ops_map::setactivemapconfig( var_10, "axis" );
                    level notify( "hostage_spawns_pushed" );
                }
            }
        }
    }
}

hostagedompoint_onuse( var_0 )
{
    scripts\mp\gametypes\obj_dom.gsc::dompoint_onuse( var_0 );

    if ( var_0.team == "allies" )
    {
        if ( isdefined( var_0.hostagecarried ) )
        {
            var_1 = scripts\mp\tac_ops\hostage_utility::drophostage( var_0, var_0.hostagecarried, var_0.origin );
            var_1.trackedobject scripts\mp\gameobjects::deletetrackedobject();
            var_1 makeunusable();
            var_1.useobj unlink();
            var_1.useobj makeunusable();
        }

        var_0 thread trycreateextractpoint( var_0.origin, undefined, 0 );
        var_2 = scripts\mp\gametypes\tac_ops.gsc::gettacopstimeremainingms();

        if ( var_2 < getextractiontimeconst() * 1000 )
            scripts\mp\gametypes\tac_ops.gsc::extendtacopstimelimitms( getextractiontimeconst() * 1000 - var_2 );
        else
            scripts\mp\gametypes\tac_ops.gsc::reducetacopstimelimitms( var_2 - getextractiontimeconst() * 1000 );

        level.objectives[0].onuse = scripts\mp\gametypes\obj_dom.gsc::dompoint_onuse;
        level.objectives[0] scripts\mp\gameobjects::setkeyobject( undefined );
        level.objectives[0] scripts\mp\gameobjects::setvisibleteam( "any" );
        level.objectives[0] scripts\mp\gameobjects::allowuse( "enemy" );

        if ( scripts\mp\utility\teams::getteamdata( "allies", "teamCount" ) )
        {
            level.topplayers = scripts\engine\utility::array_sort_with_func( scripts\mp\utility\teams::getteamdata( "allies", "players" ), ::compare_player_score );
            var_3 = level.topplayers[0] spawnextractchopper( self, 0 );
            var_4 = scripts\mp\utility\teams::getteamdata( "axis", "players" );
            var_5 = var_4.size;
            var_5 = max( var_5, 1 );
            var_6 = 1666.67;
            var_3.health = int( var_5 * var_6 );
            var_3.maxhealth = var_3.health;
            level.objectives[0] thread copterdeathwatcher();
            var_3 thread copterhealthwatcher();
            setomnvar( "ui_tacops_helo_health_percent", 1.0 );
            thread holdoutphase();
        }
    }
}

holdouttext()
{
    wait 7;
    scripts\mp\gametypes\tac_ops.gsc::teamprint( &"MISC_MESSAGES_MP/TO_ALLY_HSTG_DEFEND_1", &"MISC_MESSAGES_MP/TO_AXIS_HSTG_DEFEND_1" );
}

copterhealthwatcher()
{
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "damage", var_0 );
        setomnvar( "ui_tacops_helo_health_percent", self.health / self.maxhealth );
    }
}

copterdeathwatcher()
{
    level endon( "game_ended" );
    self waittill( "extraction_destroyed" );
    scripts\mp\gametypes\tac_ops.gsc::pausetacopstimer();
    wait 5;
    endhostagegame( "axis" );
}

holdoutphase()
{
    level endon( "game_ended" );
    self endon( "extraction_destroyed" );
    level notify( "hostage_holdout_phase_begun" );
    thread holdouttext();
    startcopteroutofbounds();
    wait( getextractiontimeconst() - 110.0 );
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team( "dx_mpb_us1_phase1_wina", "allies" );
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team( "dx_mpb_aqcm_lz_capture", "axis" );
    wait 10.0;
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team( "dx_mpb_ovl_lz_hold", "allies" );
    wait 20.0;
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team( "dx_mpb_us2_phase3_introa4", "allies" );
    wait 55.0;
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team( "dx_mpb_us2_phase1_infila6", "allies" );
    scripts\mp\tac_ops\radio_utility::queue_dialogue_for_team( "dx_mpb_aqcm_phase1_lesstimeb", "axis" );
}

startcopteroutofbounds()
{
    var_0 = getentarray( "holdout_outofbounds", "targetname" );
    var_1 = scripts\mp\utility\teams::getteamdata( "allies", "players" );

    foreach ( var_3 in var_1 )
    {
        foreach ( var_5 in var_0 )
            var_3 startphaseoob( var_5, "copterHoldOut" );
    }
}

startphaseoob( var_0, var_1 )
{
    level endon( "game_ended" );
    level endon( "switch_modes" );
}

compare_player_score( var_0, var_1 )
{
    return var_0.score >= var_1.score;
}
