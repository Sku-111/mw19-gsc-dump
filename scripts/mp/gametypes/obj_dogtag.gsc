// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.dogtags = [];
    level.dogtagallyonusecb = scripts\mp\gametypes\common.gsc::dogtagcommonallyonusecb;
    level.dogtagenemyonusecb = scripts\mp\gametypes\common.gsc::dogtagcommonenemyonusecb;
    level.conf_fx["vanish"] = loadfx( "vfx/core/impacts/small_snowhit" );
    level.conf_fx["vanish_gos"] = loadfx( "vfx/iw8_mp/gamemode/vfx_gos_tag_pickup.vfx" );
    level.spawnoffsettacinsertmax["vanish_hw_fr"] = loadfx( "vfx/iw8_mp/gamemode/vfx_halloween_kc_capture_friendly.vfx" );
    level.spawnoffsettacinsertmax["vanish_hw_en"] = loadfx( "vfx/iw8_mp/gamemode/vfx_halloween_kc_capture_enemy.vfx" );

    if ( istrue( level.playinggulagbink ) )
        level._id_136CD = ::_id_136CC;

    level.numlifelimited = scripts\mp\utility\game::getgametypenumlives();
}

shouldspawntags( var_0 )
{
    if ( isdefined( self.switching_teams ) )
        return 0;

    if ( isdefined( var_0 ) && var_0 == self )
        return 0;

    if ( level.teambased && isdefined( var_0 ) && isdefined( var_0.team ) && var_0.team == self.team )
        return 0;

    if ( isdefined( var_0 ) && !isdefined( var_0.team ) && ( var_0.classname == "trigger_hurt" || var_0.classname == "worldspawn" ) )
        return 0;

    return 1;
}

spawndogtags( var_0, var_1, var_2, var_3 )
{
    var_4 = 1;

    if ( istrue( level.numlifelimited ) )
    {
        var_4 = var_0 shouldspawntags( var_1 );

        if ( var_4 )
            var_4 = var_4 && !scripts\mp\utility\player::isreallyalive( var_0 );

        if ( var_4 )
            var_4 = var_4 && !var_0 scripts\mp\playerlogic::mayspawn();
    }

    if ( !var_4 )
        return;

    if ( isagent( var_0 ) )
        return;

    if ( isagent( var_1 ) )
        var_1 = var_1.owner;

    var_5 = 14;
    var_6 = ( 0, 0, 0 );
    var_7 = var_0.angles;

    if ( var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger() )
    {
        var_7 = var_0 getworldupreferenceangles();
        var_6 = anglestoup( var_7 );

        if ( var_6[2] < 0 )
            var_5 = -14;
    }

    if ( isdefined( level.dogtags[var_0.guid] ) )
    {
        if ( istrue( level.playinggulagbink ) )
            playfx( level.conf_fx["vanish_gos"], level.dogtags[var_0.guid].curorigin );
        else if ( istrue( level.setplayerselfrevivingextrainfo ) )
            playfx( level.spawnoffsettacinsertmax["vanish_hw_fr"], level.dogtags[var_0.guid].curorigin );
        else
            playfx( level.conf_fx["vanish"], level.dogtags[var_0.guid].curorigin );

        level.dogtags[var_0.guid] resettags();
        level.dogtags[var_0.guid].visuals[0].angles = ( 0, 0, 0 );
        level.dogtags[var_0.guid].visuals[1].angles = ( 0, 0, 0 );
    }
    else
    {
        if ( istrue( level.setplayerselfrevivingextrainfo ) )
        {
            var_8[0] = spawn( "script_model", ( 0, 0, 0 ) );
            var_8[0] setmodel( "military_dogtags_human_skull_02" );
            var_8[1] = spawn( "script_model", ( 0, 0, 0 ) );
            var_8[1] setmodel( "military_dogtags_human_skull_01" );
        }
        else
        {
            var_8[0] = spawn( "script_model", ( 0, 0, 0 ) );
            var_8[0] setmodel( "military_dogtags_iw8_orange" );
            var_8[1] = spawn( "script_model", ( 0, 0, 0 ) );
            var_8[1] setmodel( "military_dogtags_iw8_blue" );
        }

        if ( level.numlifelimited )
        {
            var_8[0] setclientowner( var_0 );
            var_8[1] setclientowner( var_0 );
        }

        var_8[0] setasgametypeobjective();
        var_8[1] setasgametypeobjective();
        var_9 = spawn( "trigger_radius", ( 0, 0, 0 ), 0, 32, 32 );

        if ( var_0 scripts\mp\gameobjects::touchingarbitraryuptrigger() )
        {
            if ( var_6[2] < 0 )
            {
                var_8[0].angles = var_7;
                var_8[1].angles = var_7;
            }
        }

        var_10 = "any";
        var_11 = 0;
        level.dogtags[var_0.guid] = scripts\mp\gameobjects::createuseobject( var_10, var_9, var_8, ( 0, 0, 16 ) );
        level.dogtags[var_0.guid].onuse = ::onuse;
        level.dogtags[var_0.guid] scripts\mp\gameobjects::setusetime( var_11 );
        level.dogtags[var_0.guid].victim = var_0;
        level.dogtags[var_0.guid].victimteam = var_0.team;
        level thread clearonvictimdisconnect( var_0 );
        var_0 thread tagteamupdater( level.dogtags[var_0.guid] );
    }

    var_12 = var_0.origin + ( 0, 0, var_5 );
    level.dogtags[var_0.guid].curorigin = var_12;
    level.dogtags[var_0.guid].trigger.origin = var_12;
    level.dogtags[var_0.guid].visuals[0].origin = var_12;
    level.dogtags[var_0.guid].visuals[1].origin = var_12;
    level.dogtags[var_0.guid] scripts\mp\gameobjects::initializetagpathvariables();
    level.dogtags[var_0.guid] scripts\mp\gameobjects::allowuse( "any" );
    level.dogtags[var_0.guid].visuals[0] showtoteam( level.dogtags[var_0.guid], var_1.team );
    level.dogtags[var_0.guid].visuals[1] showtoteam( level.dogtags[var_0.guid], var_0.team );
    level.dogtags[var_0.guid].attacker = var_1;
    level.dogtags[var_0.guid].attackerteam = var_1.team;
    level.dogtags[var_0.guid].ownerteam = var_0.team;

    if ( isdefined( level.dogtags[var_0.guid].objidnum ) )
    {
        if ( level.dogtags[var_0.guid].objidnum != -1 )
        {
            var_13 = level.dogtags[var_0.guid].objidnum;
            scripts\mp\objidpoolmanager::update_objective_state( var_13, "current" );
            scripts\mp\objidpoolmanager::update_objective_position( var_13, var_0.origin + ( 0, 0, 36 ) );
            scripts\mp\objidpoolmanager::update_objective_setbackground( var_13, 1 );
            scripts\mp\objidpoolmanager::objective_set_play_intro( level.dogtags[var_0.guid].objidnum, 0 );
            scripts\mp\objidpoolmanager::objective_set_play_outro( level.dogtags[var_0.guid].objidnum, 0 );

            if ( istrue( level.setplayerselfrevivingextrainfo ) )
                level.dogtags[var_0.guid] scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_dogtags_skull_fr", "waypoint_dogtags_skull" );
            else
                level.dogtags[var_0.guid] scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_dogtags_friendly", "waypoint_dogtags" );

            level.dogtags[var_0.guid] scripts\mp\gameobjects::setvisibleteam( "any" );
        }
    }

    if ( istrue( level.setplayerselfrevivingextrainfo ) )
        playsoundatpos( var_12, "mp_killconfirm_tags_drop_hw" );
    else
        playsoundatpos( var_12, "mp_killconfirm_tags_drop" );

    level notify( var_2, level.dogtags[var_0.guid] );
    var_0.tagavailable = 1;
    level.dogtags[var_0.guid].visuals[0] scriptmodelplayanim( "mp_dogtag_spin" );
    level.dogtags[var_0.guid].visuals[1] scriptmodelplayanim( "mp_dogtag_spin" );

    if ( level.numlifelimited )
        var_0.statusicon = "hud_status_dogtag";
}

resettags()
{
    self.attacker = undefined;
    self notify( "reset" );
    self.visuals[0] hide();
    self.visuals[1] hide();
    self.visuals[0] dontinterpolate();
    self.visuals[1] dontinterpolate();
    self.curorigin = ( 0, 0, 1000 );
    self.trigger.origin = ( 0, 0, 1000 );
    self.visuals[0].origin = ( 0, 0, 1000 );
    self.visuals[1].origin = ( 0, 0, 1000 );
    scripts\mp\gameobjects::allowuse( "none" );

    if ( self.objidnum != -1 )
        scripts\mp\objidpoolmanager::update_objective_state( self.objidnum, "done" );
}

removetags( var_0, var_1, var_2 )
{
    if ( isdefined( level.dogtags[var_0] ) )
    {
        level.dogtags[var_0] scripts\mp\gameobjects::allowuse( "none" );

        if ( istrue( var_1 ) && isdefined( level.dogtags[var_0].attacker ) )
            level.dogtags[var_0].attacker thread scripts\mp\rank::scoreeventpopup( "kill_denied" );

        if ( istrue( level.playinggulagbink ) )
        {
            if ( isdefined( level._id_136CD ) )
                level [[ level._id_136CD ]]( level.dogtags[var_0], var_2 );
        }
        else if ( istrue( level.setplayerselfrevivingextrainfo ) )
        {
            if ( isdefined( var_2 ) && var_2.team == level.dogtags[var_0].ownerteam )
            {
                playfx( level.conf_fx["vanish"], level.dogtags[var_0].curorigin );
                playfx( level.spawnoffsettacinsertmax["vanish_hw_fr"], level.dogtags[var_0].curorigin + ( 0, 0, 45 ) );
            }
            else
            {
                playfx( level.conf_fx["vanish"], level.dogtags[var_0].curorigin );
                playfx( level.spawnoffsettacinsertmax["vanish_hw_en"], level.dogtags[var_0].curorigin + ( 0, 0, 45 ) );
            }
        }
        else
            playfx( level.conf_fx["vanish"], level.dogtags[var_0].curorigin );

        level.dogtags[var_0] notify( "reset" );
        waitframe();

        if ( isdefined( level.dogtags[var_0] ) )
        {
            level.dogtags[var_0] notify( "death" );

            for ( var_3 = 0; var_3 < level.dogtags[var_0].visuals.size; var_3++ )
                level.dogtags[var_0].visuals[var_3] delete();

            if ( !isdefined( level.dogtags[var_0].skipminimapids ) )
                level.dogtags[var_0] thread scripts\mp\gameobjects::deleteuseobject();

            level.dogtags[var_0] = undefined;
        }
    }
}

_id_136CC( var_0, var_1 )
{
    var_2 = 20;
    var_3 = 600;
    var_4 = var_0.curorigin + ( 0, 0, var_2 );
    var_5 = var_0.curorigin + ( 0, 0, var_3 );
    var_6 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 1, 1 );
    var_7 = [];
    var_7[var_7.size] = var_0.visuals[0];
    var_7[var_7.size] = var_0.visuals[1];

    if ( isplayer( var_1 ) )
        var_7[var_7.size] = var_1;

    var_8 = scripts\engine\trace::ray_trace( var_4, var_5, var_7, var_6, 0 );

    if ( isplayer( var_8["entity"] ) )
        var_8["entity"] = undefined;

    if ( isdefined( var_8["entity"] ) && isdefined( var_8["entity"].code_classname ) && var_8["entity"].code_classname == "script_vehicle" )
    {
        var_7[var_7.size] = var_8["entity"];
        var_8 = scripts\engine\trace::ray_trace( var_4, var_5, var_7, var_6, 0 );
    }

    if ( var_8["fraction"] != 1 )
        playfx( level.conf_fx["vanish_gos"], var_0.curorigin );
    else
    {
        playfx( level.conf_fx["vanish_gos"], var_0.curorigin );
        playfx( level.select_stairway_spawners["gos_fireworks"], var_0.curorigin );
        level thread scripts\mp\gametypes\common.gsc::_id_14397( var_0.curorigin );
    }
}

onplayerjoinedteam( var_0 )
{
    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
        return;

    foreach ( var_2 in level.dogtags )
    {
        if ( isdefined( var_2.attackerteam ) )
        {
            if ( var_0.team == var_2.attackerteam )
                var_2.visuals[0] showtoplayer( var_0 );

            if ( var_0.team == "spectator" && var_2.attackerteam == "allies" )
                var_2.visuals[0] showtoplayer( var_0 );
        }

        if ( isdefined( var_2.ownerteam ) )
        {
            if ( var_0.team == var_2.ownerteam )
                var_2.visuals[1] showtoplayer( var_0 );

            if ( var_0.team == "spectator" && var_2.ownerteam == "allies" )
                var_2.visuals[1] showtoplayer( var_0 );
        }
    }
}

showtoteam( var_0, var_1 )
{
    self hide();

    foreach ( var_3 in level.players )
    {
        if ( var_3.team == var_1 )
            self showtoplayer( var_3 );

        if ( var_3.team == "spectator" && var_1 == "allies" )
            self showtoplayer( var_3 );
    }
}

playercanusetags( var_0 )
{
    return 1;
}

onuse( var_0 )
{
    if ( !playercanusetags( var_0 ) )
        return;

    if ( isdefined( var_0.owner ) )
        var_0 = var_0.owner;

    if ( scripts\mp\utility\game::getgametype() == "conf" )
        var_0 thread watchrapidtagpickup();

    if ( var_0.pers["team"] == self.victimteam )
    {
        if ( istrue( level.setplayerselfrevivingextrainfo ) )
            self.trigger playsound( "mp_killconfirm_tags_deny_hw" );
        else
            self.trigger playsound( "mp_killconfirm_tags_deny" );

        var_0 scripts\mp\utility\stats::incpersstat( "denied", 1 );
        var_0 scripts\mp\persistence::statsetchild( "round", "denied", var_0.pers["denied"] );

        if ( level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena" )
            lifelimitedallyonuse( var_0 );
        else
            allyonuse( var_0 );

        if ( isdefined( level.dogtagallyonusecb ) && !level.gameended )
            self thread [[ level.dogtagallyonusecb ]]( var_0 );
    }
    else
    {
        if ( istrue( level.setplayerselfrevivingextrainfo ) )
            self.trigger playsound( "mp_killconfirm_tags_pickup_hw" );
        else
            self.trigger playsound( "mp_killconfirm_tags_pickup" );

        if ( scripts\mp\utility\game::getgametype() != "grind" && scripts\mp\utility\game::getgametype() != "pill" )
        {
            var_0 scripts\mp\utility\stats::incpersstat( "confirmed", 1 );
            var_0 scripts\mp\persistence::statsetchild( "round", "confirmed", var_0.pers["confirmed"] );
        }

        if ( level.numlifelimited && scripts\mp\utility\game::getgametype() != "arena" )
            lifelimitedenemyonuse( var_0 );
        else
            enemyonuse( var_0 );

        if ( isdefined( level.dogtagenemyonusecb ) && !level.gameended )
            self thread [[ level.dogtagenemyonusecb ]]( var_0 );

        var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
    }

    self.victim notify( "tag_removed" );
    thread removetags( self.victim.guid, undefined, var_0 );
}

watchrapidtagpickup()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self notify( "watchRapidTagPickup()" );
    self endon( "watchRapidTagPickup()" );

    if ( !isdefined( self.recenttagcount ) )
        self.recenttagcount = 1;
    else
    {
        self.recenttagcount++;

        if ( self.recenttagcount == 3 )
            thread scripts\mp\awards::givemidmatchaward( "mode_kc_3_tags" );
    }

    wait 3.0;
    self.recenttagcount = 0;
}

tagteamupdater( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_0 endon( "death" );

    for (;;)
    {
        self waittill( "joined_team" );
        thread removetags( self.guid, 1 );
    }
}

clearonvictimdisconnect( var_0 )
{
    var_0 notify( "clearOnVictimDisconnect" );
    var_0 endon( "clearOnVictimDisconnect" );
    var_0 endon( "tag_removed" );
    level endon( "game_ended" );
    var_1 = var_0.guid;
    var_0 waittill( "disconnect" );
    thread removetags( var_1, 1 );
}

ontagpickupevent( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( !isdefined( self.pers ) )
        waitframe();

    thread scripts\mp\utility\points::giveunifiedpoints( var_0 );
}

lifelimitedallyonuse( var_0 )
{
    var_0.pers["rescues"]++;
    var_0 scripts\mp\persistence::statsetchild( "round", "rescues", var_0.pers["rescues"] );
    var_1 = [];
    var_1[var_1.size] = self.victim;
    scripts\mp\hud_message::notifyteam( "sr_ally_respawned", "sr_enemy_respawned", self.victim );

    if ( isdefined( self.victim ) )
    {
        self.victim thread scripts\mp\hud_message::showsplash( "sr_respawned" );
        level notify( "sr_player_respawned", self.victim );
        self.victim scripts\mp\utility\dialog::leaderdialogonplayer( "revived" );

        if ( !level.gameended )
            self.victim thread respawn();

        self.victim.tagavailable = undefined;
        self.victim.statusicon = "";
    }

    if ( isdefined( self.attacker ) )
        self.attacker thread scripts\mp\rank::scoreeventpopup( "kill_denied" );

    var_0 thread ontagpickupevent( "kill_denied" );

    if ( !isdefined( var_0.rescuedplayers ) )
        var_0.rescuedplayers = [];

    var_0.rescuedplayers[self.victim.guid] = 1;
}

lifelimitedenemyonuse( var_0 )
{
    if ( isdefined( self.victim ) )
    {
        self.victim thread scripts\mp\hud_message::showsplash( "sr_eliminated" );
        level notify( "sr_player_eliminated", self.victim );
    }

    var_1 = [];
    var_1[var_1.size] = self.victim;
    scripts\mp\hud_message::notifyteam( "sr_ally_eliminated", "sr_enemy_eliminated", self.victim );

    if ( isdefined( self.victim ) )
    {
        if ( !level.gameended )
        {
            self.victim scripts\mp\utility\lower_message::setlowermessageomnvar( 2 );
            self.victim thread scripts\mp\playerlogic::removespawnmessageshortly( 3.0 );
        }

        self.victim.tagavailable = undefined;
        self.victim.statusicon = "hud_status_dead";
    }

    if ( self.attacker != var_0 )
        self.attacker thread ontagpickupevent( "kill_confirmed" );

    var_0 thread ontagpickupevent( "kill_confirmed" );
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer( "kill_confirmed" );
}

respawn()
{
    scripts\mp\playerlogic::incrementalivecount( self.team );
    self.alreadyaddedtoalivecount = 1;
    thread scripts\mp\playerlogic::waittillcanspawnclient();
}

allyonuse( var_0 )
{
    if ( self.victim == var_0 )
    {
        var_0 thread scripts\mp\rank::scoreeventpopup( "tag_retrieved" );
        var_0 thread scripts\mp\awards::givemidmatchaward( "mode_kc_own_tags" );
    }
    else if ( issubstr( scripts\mp\utility\game::getgametype(), "conf" ) )
        var_0 ontagpickupevent( "kill_denied" );
    else if ( scripts\mp\utility\game::getgametype() != "grind" )
        var_0 ontagpickupevent( "tag_denied" );
    else
    {
        var_0 ontagpickupevent( "tag_collected" );
        var_0 playersettagcount( var_0.tagscarried + 1 );
    }

    if ( isdefined( self.attacker ) )
        self.attacker thread scripts\mp\rank::scoreeventpopup( "tag_denied" );

    if ( isdefined( level.supportcranked ) && level.supportcranked )
    {
        if ( isdefined( var_0.cranked ) && var_0.cranked )
            var_0 scripts\mp\cranked::setcrankedplayerbombtimer( "friendly_tag" );
        else
            var_0 scripts\mp\cranked::oncranked( undefined, var_0 );
    }
}

enemyonuse( var_0 )
{
    if ( issubstr( scripts\mp\utility\game::getgametype(), "conf" ) )
        var_0 ontagpickupevent( "kill_confirmed" );
    else
        var_0 ontagpickupevent( "tag_collected" );

    if ( scripts\mp\utility\game::getgametype() == "grind" )
        var_0 playersettagcount( var_0.tagscarried + 1 );

    if ( self.attacker != var_0 )
    {
        if ( scripts\mp\utility\game::getgametype() == "grind" )
            self.attacker thread ontagpickupevent( "grind_friendly_pickup" );
        else
            self.attacker thread ontagpickupevent( "kc_friendly_pickup" );
    }

    if ( isdefined( level.supportcranked ) && level.supportcranked )
    {
        if ( isdefined( var_0.cranked ) && var_0.cranked )
            var_0 scripts\mp\cranked::setcrankedplayerbombtimer( "kill" );
        else
            var_0 scripts\mp\cranked::oncranked( undefined, var_0 );

        if ( var_0 != self.attacker && isdefined( self.attacker.cranked ) && self.attacker.cranked )
            self.attacker scripts\mp\cranked::setcrankedplayerbombtimer( "kill" );
    }
}

playersettagcount( var_0 )
{
    self.tagscarried = var_0;
    self.game_extrainfo = var_0;

    if ( var_0 > 999 )
        var_0 = 999;

    self setclientomnvar( "ui_grind_tags", var_0 );
}