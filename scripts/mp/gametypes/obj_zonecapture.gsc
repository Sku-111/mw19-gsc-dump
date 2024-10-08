// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

setupobjective( var_0, var_1, var_2, var_3 )
{
    var_4 = var_0;

    if ( !isdefined( var_1 ) )
    {
        var_1 = [];
        var_1[0] = var_4;
    }

    var_4 = postshipmodifiedkothzones( var_4 );

    if ( istrue( var_2 ) )
        var_5 = 0;
    else
        var_5 = undefined;

    var_4 = scripts\mp\gameobjects::createuseobject( "neutral", var_4, var_1, ( 0, 0, 0 ), var_5, var_3 );
    var_4 scripts\mp\gameobjects::disableobject();

    if ( scripts\mp\utility\game::getgametype() == "koth" )
    {
        for ( var_6 = 0; var_6 < var_4.visuals.size; var_6++ )
            var_4.visuals[var_6] hide();
    }
    else
        var_4.visuals[0] scriptmodelplayanim( "iw8_mp_military_hq_crate_close" );

    var_4 scripts\mp\gameobjects::cancontestclaim( 1 );
    var_4.claimgracetime = level.zonecapturetime * 1000;
    var_4 scripts\mp\gameobjects::pinobjiconontriggertouch();

    if ( isdefined( var_0.objectivekey ) )
        var_4.objectivekey = var_0.objectivekey;
    else
        var_4.objectivekey = var_4 scripts\mp\gameobjects::getlabel();

    if ( level.usehqrules && !level.usehprules )
        var_4 scripts\mp\gameobjects::mustmaintainclaim( 0 );
    else
        var_4 scripts\mp\gameobjects::mustmaintainclaim( 1 );

    var_4.id = "hardpoint";

    if ( isdefined( var_4.trigger.target ) && scripts\mp\utility\game::getgametype() == "koth" )
        var_4 thread assignchevrons( var_4.trigger.target, var_4.trigger.script_label );

    if ( istrue( level.setplayerselfrevivingextrainfo ) )
    {
        if ( scripts\mp\utility\game::getgametype() == "hq" )
            var_4 thread _id_14396( var_4 );
        else if ( scripts\mp\utility\game::getgametype() == "grnd" )
            var_4 thread _id_14395( var_4 );
    }

    return var_4;
}

_id_14396( var_0 )
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    var_1 = anglestoforward( var_0.visuals[0].angles );
    var_2 = var_1 * 5;
    var_3 = var_0.visuals[0] gettagorigin( "j_laptop_tray" );
    playfx( level.spawnoffsettacinsertmax["ghostcat_hw"], var_3 + var_2 );
}

_id_14395( var_0 )
{
    scripts\mp\flags::gameflagwait( "prematch_done" );
    playfx( level.spawnoffsettacinsertmax["blood_floor_hw"], getgroundposition( var_0.trigger.origin, 4 ) + ( 0, 0, 2 ) );
}

postshipmodifiedkothzones( var_0 )
{
    if ( level.mapname == "mp_malyshev" )
    {
        if ( var_0.script_label == "1" )
            var_0.origin = var_0.origin - ( 0, 0, 5 );
    }
    else if ( level.mapname == "mp_herat" )
    {
        if ( var_0.script_label == "1" )
            var_0.origin = var_0.origin + ( 0, 3, 0 );
    }

    return var_0;
}

assignchevrons( var_0, var_1 )
{
    wait 1.0;
    var_2 = getentitylessscriptablearrayinradius( var_0, "targetname" );
    var_2 = _id_12BFF( var_2, var_1 );
    var_2 = _id_12806( var_2, var_1 );
    var_3 = [];

    foreach ( var_5 in var_2 )
    {
        var_6 = var_3.size;
        var_3[var_6] = var_5;
        var_3[var_6].numchevrons = 1;

        if ( isdefined( var_5.script_noteworthy ) )
        {
            if ( var_5.script_noteworthy == "2" )
            {
                var_3[var_6].numchevrons = 2;
                continue;
            }

            if ( var_5.script_noteworthy == "3" )
            {
                var_3[var_6].numchevrons = 3;
                continue;
            }

            if ( var_5.script_noteworthy == "4" )
                var_3[var_6].numchevrons = 4;
        }
    }

    self.chevrons = var_3;
}

updatechevrons( var_0 )
{
    if ( scripts\mp\utility\game::getgametype() != "koth" )
        return;

    self notify( "updateChevrons" );
    self endon( "updateChevrons" );

    while ( !isdefined( self.chevrons ) )
        waitframe();

    foreach ( var_2 in self.chevrons )
    {
        for ( var_3 = 0; var_3 < var_2.numchevrons; var_3++ )
            var_2 setscriptablepartstate( "chevron_" + var_3, var_0 );
    }
}

activatezone()
{
    self.onuse = ::zone_onuse;
    self.onbeginuse = ::zone_onusebegin;
    self.onuseupdate = ::zone_onuseupdate;
    self.onenduse = ::zone_onuseend;
    self.onunoccupied = ::zone_onunoccupied;
    self.oncontested = ::zone_oncontested;
    self.onuncontested = ::zone_onuncontested;
    self.stompprogressreward = ::zone_stompprogressreward;
    self.onpinnedstate = ::zone_onpinnedstate;
    self.onunpinnedstate = ::zone_onunpinnedstate;
    self.didstatusnotify = 0;
    scripts\mp\gameobjects::requestid( 1, 1, 0, 1, 0 );
    var_0 = self.curorigin;

    if ( isdefined( level.remove_last_used_node ) )
        var_0 = [[ level.remove_last_used_node ]]();

    var_1 = 1024;

    if ( isdefined( level.remove_launcher_xmags ) )
        var_1 = [[ level.remove_launcher_xmags ]]();

    var_2 = [];
    var_2[var_2.size] = scripts\mp\spawnlogic::addspawndangerzone( var_0 - ( 0, 0, 2048 ), var_1, 4096, "allies", undefined, undefined, undefined, undefined, undefined, 1 );
    var_2[var_2.size] = scripts\mp\spawnlogic::addspawndangerzone( var_0 - ( 0, 0, 2048 ), var_1, 4096, "axis", undefined, undefined, undefined, undefined, undefined, 1 );
    self.isburstweapon = var_2;

    if ( scripts\mp\utility\game::getgametype() == "koth" || scripts\mp\utility\game::getgametype() == "grnd" )
    {
        self.ignorestomp = 1;
        self.alwaysstalemate = 1;
        level thread scripts\mp\gametypes\koth.gsc::awardcapturepoints();
    }
    else
    {
        self._id_138B2 = ::_id_1471E;
        scripts\mp\objidpoolmanager::update_objective_position( self.objidnum, self.visuals[0].origin + ( 0, 0, 70 ) );
    }
}

deactivatezone()
{
    self.onuse = undefined;
    self.onbeginuse = undefined;
    self.onuseupdate = undefined;
    self.onunoccupied = undefined;
    self.oncontested = undefined;
    self.onuncontested = undefined;
    self.stalemate = 0;
    self.wasstalemate = 0;
    self.didstatusnotify = 0;
    thread updatechevrons( "off" );

    foreach ( var_1 in self.isburstweapon )
        scripts\mp\spawnlogic::removespawndangerzone( var_1 );

    self.isburstweapon = undefined;

    foreach ( var_4 in level.players )
        scripts\mp\objidpoolmanager::objective_unpin_player( self.objidnum, var_4 );

    self.trigger scripts\engine\utility::trigger_off();
    thread _id_1439D();
    scripts\mp\gameobjects::releaseid( 1, 0 );

    if ( scripts\mp\utility\game::getgametype() == "hq" )
    {
        self.visuals[0] playsound( "mp_hq_deactivate_sfx" );
        thread scripts\mp\music_and_dialog::headquarters_deactivate_music( self.lastclaimteam );
        self.visuals[0] scriptmodelplayanim( "iw8_mp_military_hq_crate_close" );
        level.zone.visuals[0] stoploopsound();
    }

    level._id_12F0E = 0;
}

zonetimerwait()
{
    level endon( "game_ended" );
    level endon( "dev_force_zone" );
    var_0 = int( level.zonemovetime * 1000 + gettime() );

    if ( !isdefined( level.zoneselectiondelay ) || level.zoneselectiondelay < 10 )
        thread hp_move_soon( level.zonemovetime );

    level thread handlehostmigration( var_0 );
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( level.zonemovetime );
}

hp_move_soon( var_0 )
{
    level endon( "game_ended" );

    if ( scripts\mp\utility\game::getgametype() == "hq" )
        level endon( "zone_destroyed" );

    if ( int( var_0 ) > 12 )
    {
        var_1 = var_0 - 12;
        scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause( var_1 );

        foreach ( var_3 in level.teamnamelist )
            level scripts\mp\utility\dialog::statusdialog( "hp_move_soon", var_3 );
    }
}

handlehostmigration( var_0 )
{
    level endon( "game_ended" );
    level endon( "bomb_defused" );
    level endon( "disconnect" );
    level endon( "zone_captured" );
    level waittill( "host_migration_begin" );
    setomnvar( "ui_objective_timer_stopped", 1 );
    var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();
    setomnvar( "ui_objective_timer_stopped", 0 );

    if ( var_1 > 0 )
        setomnvar( "ui_hardpoint_timer", level.zoneendtime + var_1 );
    else
        setomnvar( "ui_hardpoint_timer", level.zoneendtime );
}

_id_1199E( var_0, var_1 )
{
    level endon( "game_ended" );
    var_2 = level.framedurationseconds;
    var_3 = var_2 * 1000;
    var_4 = var_0 * 1000;
    var_5 = var_4 - var_3;
    self.radialtimeobjid = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );

    if ( self.radialtimeobjid != -1 )
    {
        var_6 = "invisible";
        scripts\mp\objidpoolmanager::objective_add_objective( self.radialtimeobjid, var_6, var_1 );
        scripts\mp\objidpoolmanager::objective_set_play_intro( self.radialtimeobjid, 0 );
        scripts\mp\objidpoolmanager::objective_set_play_outro( self.radialtimeobjid, 0 );
        scripts\mp\objidpoolmanager::objective_playermask_showtoall( self.radialtimeobjid );
        self.showworldicon = 1;
    }

    scripts\mp\gameobjects::setobjectivestatusicons( level.icontarget, level.icontarget, self.radialtimeobjid );
    var_7 = gettime() + var_4;

    while ( gettime() < var_7 )
    {
        var_8 = var_5 / var_4;
        scripts\mp\objidpoolmanager::objective_show_progress( self.radialtimeobjid, 1 );
        scripts\mp\objidpoolmanager::objective_set_progress( self.radialtimeobjid, var_8 );
        var_5 = max( var_5 - var_3, 1 );
        waitframe();
    }

    scripts\mp\objidpoolmanager::returnobjectiveid( self.radialtimeobjid );
    self.radialtimeobjid = -1;
}

hardpoint_setneutral()
{
    self notify( "flag_neutral" );
    scripts\mp\gameobjects::setownerteam( "neutral" );
    playhardpointneutralfx();
    thread updatechevrons( "idle" );
}

trackgametypevips()
{
    thread cleanupgametypevips();
    level endon( "game_ended" );
    level endon( "zone_moved" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            if ( var_1 istouching( level.zone.trigger ) )
            {
                var_1 setgametypevip( 1 );
                continue;
            }

            var_1 setgametypevip( 0 );
        }

        wait 0.5;
    }
}

cleanupgametypevips()
{
    level scripts\engine\utility::_id_143A5( "game_ended", "zone_moved" );

    foreach ( var_1 in level.players )
        var_1 setgametypevip( 0 );
}

zone_onuse( var_0 )
{
    scripts\mp\objidpoolmanager::objective_set_progress( self.objidnum, 0 );
    scripts\mp\objidpoolmanager::objective_show_progress( self.objidnum, 0 );
    var_1 = var_0.team;
    var_2 = gettime();
    var_3 = [];
    var_4 = getarraykeys( self.touchlist[var_1] );

    for ( var_5 = 0; var_5 < var_4.size; var_5++ )
        var_3[var_4[var_5]] = self.touchlist[var_1][var_4[var_5]];

    if ( level.usehqrules && !level.usehprules && self.ownerteam != "neutral" )
    {
        setomnvar( "ui_hq_ownerteam", 0 );
        level notify( "zone_destroyed" );

        foreach ( var_7 in level.players )
            scripts\mp\objidpoolmanager::objective_unpin_player( self.objidnum, var_7 );

        level.zone thread _id_1439D();
        level scripts\mp\gametypes\koth.gsc::updateservericons( "zone_shift", 0 );

        if ( isdefined( var_3 ) )
        {
            var_9 = getarraykeys( var_3 );

            foreach ( var_11 in var_9 )
            {
                var_7 = self.assisttouchlist[var_1][var_11].player;

                if ( isdefined( var_7.owner ) )
                    var_7 = var_7.owner;

                if ( !isplayer( var_7 ) )
                    continue;

                var_7 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
            }
        }

        level thread scripts\mp\gametypes\hq.gsc::give_capture_credit( var_3, var_2, var_1, undefined, var_0, self );

        if ( scripts\mp\utility\game::getgametype() == "hq" )
        {
            level scripts\mp\utility\dialog::statusdialog( "hp_captured_friendly", var_0.team );
            level scripts\mp\utility\dialog::statusdialog( "hp_owned_lost", self.ownerteam );
        }
        else
        {
            level scripts\mp\utility\dialog::statusdialog( "hp_captured_friendly", var_0.team );
            level scripts\mp\utility\dialog::statusdialog( "hp_captured_enemy", self.ownerteam );
        }
    }
    else
    {
        if ( scripts\mp\utility\game::getgametype() == "hq" )
        {
            var_13 = scripts\mp\utility\teams::getteamdata( var_1, "players" );

            foreach ( var_7 in var_13 )
            {
                var_7 scripts\cp\vehicles\vehicle_compass_cp::_id_12003();
                var_7.skipspawncamera = 1;
            }
        }

        var_16 = scripts\mp\gameobjects::getownerteam();
        var_17 = scripts\mp\utility\game::getotherteam( var_1 )[0];
        scripts\mp\gameobjects::setownerteam( var_1 );

        if ( level.usehqrules && !level.usehprules )
        {
            setomnvar( "ui_hq_ownerteam", scripts\mp\gametypes\hq.gsc::gethqownerteamvalue( self.ownerteam ) );
            setomnvar( "ui_hq_num_alive", scripts\mp\utility\teams::getteamdata( self.ownerteam, "aliveCount" ) );
        }

        if ( scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules )
        {
            level thread scripts\mp\gametypes\hq.gsc::awardcapturepoints();
            var_18 = scripts\mp\gamescore::_getteamscore( var_1 );
            var_19 = scripts\mp\gamescore::_getteamscore( var_17 );

            if ( var_18 > var_19 )
                level._id_12F0E = 1;

            binoculars_clearexpirationtimer( var_1 );
        }
        else if ( level._id_1221A )
            level scripts\mp\gamelogic::pausetimer();

        level.usestartspawns = 0;
        var_20 = 0;
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
        level scripts\mp\gametypes\koth.gsc::updateservericons( var_1, 0 );

        if ( scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules )
        {
            thread scripts\mp\utility\print::printandsoundoneveryone( var_1, var_17, undefined, undefined, "mp_dom_flag_captured", undefined, var_0 );
            thread scripts\mp\music_and_dialog::headquarters_captured_music();
        }

        if ( !isdefined( level.lastcaptureteam ) || level.lastcaptureteam != var_1 )
        {
            if ( scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules )
            {
                if ( isdefined( level.kothhillrotation && level.kothhillrotation == 0 ) )
                    level.delayleadtakendialog = 4;
                else
                    level.delayleadtakendialog = undefined;

                level thread delaydialogstatustoavoidcaptureoverlap( var_1, var_17 );
            }
            else
            {
                level scripts\mp\utility\dialog::statusdialog( "hp_captured_friendly", var_1 );
                level scripts\mp\utility\dialog::statusdialog( "hp_captured_enemy", var_17 );
            }

            if ( scripts\mp\utility\game::getgametype() == "koth" )
                level thread scripts\mp\gametypes\koth.gsc::give_capture_credit( var_3, var_2, var_1, level.lastcaptureteam, var_0, self );
            else if ( scripts\mp\utility\game::getgametype() == "grnd" )
                level thread scripts\mp\gametypes\grnd.gsc::give_capture_credit( var_3, var_2, var_1, level.lastcaptureteam, var_0, self );
            else
                level thread scripts\mp\gametypes\hq.gsc::give_capture_credit( var_3, var_2, var_1, level.lastcaptureteam, var_0, self );
        }

        foreach ( var_22 in level.players )
            showcapturedhardpointeffecttoplayer( var_1, var_22 );

        level.zone thread updatechevrons( var_1 );

        if ( scripts\mp\utility\game::getgametype() == "hq" )
        {
            level.zone.visuals[0] stoploopsound();
            level.zone.visuals[0] scriptmodelplayanim( "iw8_mp_military_hq_crate_open_idle" );

            if ( !level.usehprules )
            {
                var_24 = scripts\mp\utility\teams::getteamdata( var_1, "players" );

                foreach ( var_7 in var_24 )
                    var_7 thread scripts\mp\gametypes\hq.gsc::showrespawnwarningmessage();
            }
        }

        level.hpcapteam = var_1;
        self.capturecount++;
        level.lastcaptureteam = var_1;
        level notify( "zone_captured" );
        level notify( "zone_captured" + var_1 );
    }

    if ( istrue( level.setplayerselfrevivingextrainfo ) )
        playfx( level.spawnoffsettacinsertmax["vanish_hw_fr"], level.zone.trigger.origin + ( 0, 0, 40 ) );
}

_id_1439D()
{
    waitframe();
    scripts\mp\gameobjects::setvisibleteam( "none" );
}

zone_onusebegin( var_0 )
{
    if ( scripts\mp\utility\game::getgametype() == "hq" && !level.usehprules )
    {
        var_1 = scripts\mp\gameobjects::getownerteam();

        if ( var_1 != "neutral" && self.claimteam != var_1 )
            binoculars_clearexpirationtimer( var_1, 1 );

        if ( !istrue( var_0.ui_dom_securing ) || !istrue( self.stalemate ) )
        {
            if ( var_1 == "neutral" )
                var_0 setclientomnvar( "ui_objective_state", 1 );
            else
                var_0 setclientomnvar( "ui_objective_state", 2 );

            var_0.ui_dom_securing = 1;
        }
    }

    if ( !isdefined( self.statusnotifytime ) )
        self.statusnotifytime = gettime();

    if ( self.statusnotifytime > self.statusnotifytime + 10000 )
    {
        self.didstatusnotify = 0;
        self.statusnotifytime = gettime();
    }

    scripts\mp\gameobjects::setusetime( level.zonecapturetime );

    if ( level.zonecapturetime > 0 )
    {
        self.prevownerteam = scripts\mp\utility\game::getotherteam( var_0.team )[0];
        scripts\mp\gameobjects::setobjectivestatusicons( level.iconlosing, level.icontaking );
    }
}

zone_onuseupdate( var_0, var_1, var_2, var_3 )
{
    var_4 = scripts\mp\gameobjects::getownerteam();

    if ( var_4 == "neutral" && self.claimteam != var_4 )
        binoculars_clearexpirationtimer( self.claimteam );
    else if ( var_4 != "neutral" && self.claimteam != var_4 )
        binoculars_clearexpirationtimer( var_4, 1 );
    else if ( level._id_1221A )
        level scripts\mp\gamelogic::pausetimer();

    if ( ( scripts\mp\utility\game::getgametype() == "hq" || scripts\mp\utility\game::getgametype() == "arm" ) && var_1 < 1.0 && !level.usehprules && !level.gameended )
        playcapturesound( var_1, var_0 );

    var_4 = scripts\mp\gameobjects::getownerteam();
    var_5 = scripts\mp\utility\game::getotherteam( var_0 )[0];

    if ( var_1 > 0.05 && var_2 && !self.didstatusnotify )
    {
        if ( var_4 == "neutral" )
        {
            scripts\mp\utility\dialog::statusdialog( "hp_capturing_friendly", var_0 );
            scripts\mp\utility\dialog::statusdialog( "hp_capturing_enemy", var_5 );
        }
        else if ( scripts\mp\utility\game::getgametype() == "hq" )
        {
            scripts\mp\utility\dialog::statusdialog( "hp_disabling_friendly", var_4 );
            scripts\mp\utility\dialog::statusdialog( "hp_disabling_enemy", var_0 );
        }
        else
        {
            scripts\mp\utility\dialog::statusdialog( "hp_capturing_enemy", var_4 );
            scripts\mp\utility\dialog::statusdialog( "hp_capturing_friendly", var_0 );
        }

        self.didstatusnotify = 1;
    }
}

delaydialogstatustoavoidcaptureoverlap( var_0, var_1 )
{
    wait 0.5;
    level scripts\mp\utility\dialog::statusdialog( "hp_secured_friendly", var_0 );
    level scripts\mp\utility\dialog::statusdialog( "hp_captured_enemy", var_1 );
}

playcapturesound( var_0, var_1 )
{
    if ( !isdefined( self.lastsfxplayedtime ) )
        self.lastsfxplayedtime = gettime();

    if ( self.lastsfxplayedtime + 995 < gettime() )
    {
        self.lastsfxplayedtime = gettime();
        var_2 = "";
        var_0 = int( floor( var_0 * 10 ) );
        var_2 = "mp_dom_capturing_tick_0" + var_0;
        self.visuals[0] playsoundtoteam( var_2, var_1 );
    }
}

zone_onuseend( var_0, var_1, var_2 )
{
    var_3 = level.zone scripts\mp\gameobjects::getownerteam();

    if ( !var_2 )
    {
        if ( scripts\mp\utility\game::getgametype() == "hq" )
        {
            if ( level.usehprules )
            {
                if ( level._id_1221A )
                    level scripts\mp\gamelogic::resumetimer();
            }
            else if ( var_3 != "neutral" )
                binoculars_clearexpirationtimer( var_3 );
        }
        else if ( level._id_1221A )
            level scripts\mp\gamelogic::resumetimer();
    }

    if ( isplayer( var_1 ) )
    {
        var_1 setclientomnvar( "ui_objective_state", 0 );
        var_1.ui_dom_securing = undefined;
    }

    if ( var_3 == "neutral" )
    {
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );

        if ( istrue( level.usehpzonebrushes ) )
        {
            foreach ( var_1 in level.players )
                level.zone showzoneneutralbrush( var_1 );
        }
    }
    else
    {
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );

        foreach ( var_1 in level.players )
            level.zone showcapturedhardpointeffecttoplayer( var_3, var_1 );
    }
}

zone_onunoccupied()
{
    if ( level.usehqrules && !level.usehprules && self.ownerteam != "neutral" )
    {
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
        binoculars_clearexpirationtimer( self.ownerteam );
    }
    else
    {
        level notify( "zone_destroyed" );
        level.hpcapteam = "neutral";

        if ( level._id_1221A )
            level scripts\mp\gamelogic::resumetimer();

        var_0 = 1;

        foreach ( var_2 in level.teamnamelist )
        {
            if ( self.numtouching[var_2] > 0 )
            {
                var_0 = 0;
                break;
            }
        }

        if ( var_0 )
        {
            level.zone.wasleftunoccupied = 1;
            level scripts\mp\gametypes\koth.gsc::updateservericons( "neutral", 0 );
            level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );
            level.zone playhardpointneutralfx();
            level.zone thread updatechevrons( "idle" );
        }
    }
}

zone_oncontested()
{
    if ( level._id_1221A )
        level scripts\mp\gamelogic::resumetimer();

    self.hostvictimoverride = gettime();
    var_0 = level.zone scripts\mp\gameobjects::getownerteam();
    level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.iconcontested );
    level scripts\mp\gametypes\koth.gsc::updateservericons( var_0, 1 );
    level.zone thread updatechevrons( "contested" );

    foreach ( var_2 in level.teamnamelist )
    {
        if ( self.touchlist[var_2].size )
        {
            var_3 = self.touchlist[var_2];
            var_4 = getarraykeys( var_3 );

            for ( var_5 = 0; var_5 < var_4.size; var_5++ )
            {
                var_6 = var_3[var_4[var_5]].player;
                var_6 setclientomnvar( "ui_objective_state", 3 );
            }
        }
    }

    foreach ( var_6 in level.players )
        level.zone showcapturedhardpointeffecttoplayer( var_0, var_6 );

    if ( var_0 == "neutral" )
        var_10 = self.claimteam;
    else
        var_10 = var_0;

    foreach ( var_12 in level.teamnamelist )
        scripts\mp\utility\dialog::statusdialog( "hp_contested", var_12 );

    level.zone thread scripts\common\utility::_id_13E0A( level._id_11B29, "hill_contested", level.zone.trigger.origin );
    self.didstatusnotify = 1;
}

zone_onuncontested( var_0 )
{
    if ( level._id_1221A )
        level scripts\mp\gamelogic::pausetimer();

    var_1 = level.zone scripts\mp\gameobjects::getownerteam();

    if ( var_0 == "none" || var_1 == "neutral" )
    {
        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.iconneutral );

        if ( istrue( level.usehpzonebrushes ) )
        {
            foreach ( var_3 in level.players )
                level.zone showzoneneutralbrush( var_3 );
        }

        level.zone thread scripts\common\utility::_id_13E0A( level._id_11B29, "hill_empty", level.zone.trigger.origin );
    }
    else
    {
        if ( scripts\mp\utility\game::getgametype() == "koth" )
        {
            scripts\mp\utility\sound::playsoundonplayers( "mp_hardpoint_captured_positive", var_1 );
            scripts\mp\utility\sound::playsoundonplayers( "mp_hardpoint_captured_negative", scripts\mp\utility\game::getotherteam( var_1 )[0] );
        }
        else if ( scripts\mp\utility\game::getgametype() == "grnd" )
        {
            scripts\mp\utility\sound::playsoundonplayers( "mp_dropzone_captured_positive", var_1 );
            scripts\mp\utility\sound::playsoundonplayers( "mp_dropzone_captured_negative", scripts\mp\utility\game::getotherteam( var_1 )[0] );
        }

        level.zone scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );

        foreach ( var_3 in level.players )
            level.zone showcapturedhardpointeffecttoplayer( var_1, var_3 );

        level.zone thread scripts\common\utility::_id_13E0A( level._id_11B29, "hill_uncontested", level.zone.trigger.origin );
    }

    var_7 = ( gettime() - self.hostvictimoverride ) * 0.001;
    scripts\mp\utility\game::_id_119AC( undefined, undefined, "Zone Contested", level.zone.trigger.origin, var_7 + " seconds" );
    self.hostvictimoverride = undefined;
    var_8 = scripts\engine\utility::ter_op( var_1 == "neutral", "idle", var_1 );
    level.zone thread updatechevrons( var_8 );
    level scripts\mp\gametypes\koth.gsc::updateservericons( var_1, 0 );
    self.didstatusnotify = 0;
}

_id_1471E( var_0 )
{
    binoculars_clearexpirationtimer( var_0 );
}

zone_stompprogressreward( var_0 )
{
    var_0 thread scripts\mp\rank::scoreeventpopup( "defend" );
    var_0 thread scripts\mp\awards::givemidmatchaward( "mode_x_defend" );
    scripts\mp\gameobjects::setobjectivestatusicons( level.icondefending, level.iconcapture );
}

zone_onpinnedstate( var_0 )
{
    if ( self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate )
        scripts\mp\gameobjects::setobjectivestatusicons( level.icondefending, level.iconcapture );
}

zone_onunpinnedstate( var_0 )
{
    if ( self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate )
        scripts\mp\gameobjects::setobjectivestatusicons( level.icondefend, level.iconcapture );
}

binoculars_clearexpirationtimer( var_0, var_1 )
{
    if ( !level._id_1221A )
        return;

    var_2 = scripts\mp\gamescore::_getteamscore( var_0 );
    var_3 = scripts\mp\gamescore::_getteamscore( scripts\mp\utility\game::getotherteam( var_0 )[0] );

    if ( istrue( var_1 ) )
    {
        if ( var_3 > var_2 )
            level scripts\mp\gamelogic::resumetimer();
        else
            level scripts\mp\gamelogic::pausetimer();
    }
    else if ( var_2 > var_3 )
        level scripts\mp\gamelogic::resumetimer();
    else
        level scripts\mp\gamelogic::pausetimer();
}

setcrankedtimerzonecap( var_0 )
{
    if ( isdefined( level.supportcranked ) && level.supportcranked && isdefined( var_0.cranked ) && var_0.cranked )
        var_0 scripts\mp\cranked::setcrankedplayerbombtimer( "assist" );
}

playhardpointneutralfx()
{
    if ( istrue( level.usehpzonebrushes ) )
    {
        foreach ( var_1 in level.players )
            showzoneneutralbrush( var_1 );
    }
}

showcapturedhardpointeffecttoplayer( var_0, var_1 )
{
    var_2 = var_1.team;
    var_3 = var_1 ismlgspectator();

    if ( var_3 )
    {
        if ( var_1 enablereloading() || var_1 useinvisibleplayerduringspawnselection() )
            var_2 = "allies";
        else
            var_2 = var_1 getmlgspectatorteam();
    }

    if ( istrue( level.usehpzonebrushes ) )
    {
        if ( level.zone.stalemate )
            showzonecontestedbrush( var_1 );
        else if ( var_2 == var_0 )
            showzonefriendlybrush( var_1 );
        else
            showzoneenemybrush( var_1 );
    }
}

showzoneneutralbrush( var_0 )
{
    level.zone.friendlybrush hidefromplayer( var_0 );
    level.zone.enemybrush hidefromplayer( var_0 );
    level.zone.contestedbrush hidefromplayer( var_0 );
    level.zone.neutralbrush showtoplayer( var_0 );
}

showzonefriendlybrush( var_0 )
{
    level.zone.friendlybrush showtoplayer( var_0 );
    level.zone.enemybrush hidefromplayer( var_0 );
    level.zone.contestedbrush hidefromplayer( var_0 );
    level.zone.neutralbrush hidefromplayer( var_0 );
}

showzoneenemybrush( var_0 )
{
    level.zone.friendlybrush hidefromplayer( var_0 );
    level.zone.enemybrush showtoplayer( var_0 );
    level.zone.contestedbrush hidefromplayer( var_0 );
    level.zone.neutralbrush hidefromplayer( var_0 );
}

showzonecontestedbrush( var_0 )
{
    level.zone.friendlybrush hidefromplayer( var_0 );
    level.zone.enemybrush hidefromplayer( var_0 );
    level.zone.contestedbrush showtoplayer( var_0 );
    level.zone.neutralbrush hidefromplayer( var_0 );
}

hideplayerspecificbrushes( var_0 )
{
    self.friendlybrush hidefromplayer( var_0 );
    self.enemybrush hidefromplayer( var_0 );
    self.neutralbrush hidefromplayer( var_0 );
    self.contestedbrush hidefromplayer( var_0 );
}

onplayerjoinedteam( var_0 )
{
    if ( var_0.team != "spectator" && level.zone.ownerteam != "neutral" )
        level.zone showcapturedhardpointeffecttoplayer( level.zone.ownerteam, var_0 );
}

_id_12BFF( var_0, var_1 )
{
    var_2 = [];
    var_3 = [];

    switch ( level.mapname )
    {
        case "mp_m_speed":
            var_3["1"] = [ ( -564, 1848, 24 ) ];
            var_3["2"] = [ ( -1314, 440, 24 ), ( -1362, 816, 24 ) ];
            break;
        case "mp_cave":
        case "mp_cave_am":
            var_3["3"] = [ ( -692, 1828, 42 ), ( -300, 1548, 76 ) ];
            break;
        case "mp_raid":
            var_3["8"] = [ ( 688, 256, 280 ) ];
            var_3["20"] = [ ( 212, 1436, 338 ) ];
            break;
        case "mp_herat":
            var_3["7"] = [ ( -1230.29, -25.4772, 240.125 ) ];
            break;
        default:
            break;
    }

    if ( isdefined( var_3[var_1] ) )
    {
        foreach ( var_5 in var_0 )
        {
            foreach ( var_7 in var_3[var_1] )
            {
                if ( distance( var_5.origin, var_7 ) < 10 )
                {
                    var_2[var_2.size] = var_5;
                    break;
                }
            }
        }
    }

    var_0 = scripts\engine\utility::array_remove_array( var_0, var_2 );
    return var_0;
}

_id_12806( var_0, var_1 )
{
    var_2 = [];
    var_3 = [];

    switch ( level.mapname )
    {
        case "mp_m_speed":
            var_2["1"] = [];
            var_2["1"][0] = [ ( -564, 1880, 24 ), ( 0, 180, 0 ) ];
            var_2["1"][1] = [ ( -564, 1976, 24 ), ( 0, 180, 0 ) ];
            var_2["1"][2] = [ ( -564, 2072, 24 ), ( 0, 180, 0 ) ];
            var_2["2"] = [];
            var_2["2"][0] = [ ( -1314, 472, 24 ), ( 0, 180, 0 ) ];
            var_2["2"][1] = [ ( -1314, 568, 24 ), ( 0, 180, 0 ) ];
            var_2["2"][2] = [ ( -1474, 816, 24 ), ( 0, 270, 0 ) ];
            var_2["2"][3] = [ ( -1378, 816, 24 ), ( 0, 270, 0 ) ];
            var_2["4"] = [];
            var_2["4"][0] = [ ( -1298, 1992, 24 ), ( 0, 180, 0 ) ];
            var_2["4"][1] = [ ( -1400, 2262, 24 ), ( 0, 270, 0 ) ];
            var_2["4"][2] = [ ( -1690, 2264, 24 ), ( 0, 270, 0 ) ];
            break;
        case "mp_deadzone":
            var_2["2"] = [];
            var_2["2"][0] = [ ( 436, 3435, 207.694 ), ( 0, 360, 0 ) ];
            var_2["2"][1] = [ ( 436, 3188, 247.694 ), ( 0, 360, 0 ) ];
            var_2["2"][2] = [ ( 436, 3098, 258.694 ), ( 0, 360, 0 ) ];
            var_2["2"][3] = [ ( 1051, 2796, 304 ), ( 0, 117.509, 0 ) ];
            var_2["2"][4] = [ ( 931, 2680, 304 ), ( 0, 147.509, 0 ) ];
            var_2["2"][5] = [ ( 515, 3522, 215 ), ( 0, 276, 0 ) ];
            var_2["12"] = [];
            var_2["12"][0] = [ ( -400, 651, 436 ), ( 0, 180, 0 ) ];
            var_2["12"][1] = [ ( -400, 557, 439 ), ( 0, 180, 0 ) ];
            var_2["12"][2] = [ ( -400, 461, 446 ), ( 0, 180, 0 ) ];
            var_2["12"][3] = [ ( -410, -65, 446 ), ( 0, 180, 0 ) ];
            var_2["12"][4] = [ ( -408, 31, 448 ), ( 0, 180, 0 ) ];
            break;
        case "mp_raid":
            var_2["5"] = [];
            var_2["5"][0] = [ ( -3118.59, 230.46, 292 ), ( 0, 0, 0 ) ];
            var_2["8"] = [];
            var_2["8"][0] = [ ( 688, 256, 295 ), ( 0, 270, 0 ) ];
            var_2["8"][1] = [ ( 749, 248, 295 ), ( 0, 270, 0 ) ];
            var_2["12"] = [];
            var_2["12"][0] = [ ( -1490.62, -972.979, 422 ), ( 0, 90, 0 ) ];
            var_2["13"] = [];
            var_2["13"][0] = [ ( -1695.67, 3211.7, 310 ), ( 0, 270, 0 ) ];
            var_2["13"][1] = [ ( -1804.59, 3219.27, 284 ), ( 0, 270, 0 ) ];
            var_2["20"] = [];
            var_2["20"][0] = [ ( 260, 1416, 338 ), ( 0, 90, 0 ) ];
            break;
        case "mp_cave":
        case "mp_cave_am":
            var_2["3"] = [];
            var_2["3"][0] = [ ( -514, 1328, 32 ), ( 0, 100, 0 ) ];
            var_2["3"][1] = [ ( -692, 1828, 42 ), ( 0, 260, 0 ) ];
            var_2["3"][2] = [ ( -564, 1804, 44 ), ( 0, 260, 0 ) ];
            var_2["3"][3] = [ ( -500, 1788, 54 ), ( 0, 260, 0 ) ];
            var_2["3"][4] = [ ( -312, 1528, 78 ), ( 0, 145, 0 ) ];
            break;
        case "mp_hackney_yard":
        case "mp_hackney_am":
            var_2["8"] = [];
            var_2["8"][0] = [ ( 994.552, 1760.12, 44 ), ( 0, 270, 0 ) ];
            var_2["9"] = [];
            var_2["9"][0] = [ ( 1322, -407.18, 29.184 ), ( 0, 90, 0 ) ];
            break;
        case "mp_aniyah":
            var_2["13"] = [];
            var_2["13"][0] = [ ( 1995.79, 394.828, 424 ), ( 0, 270, 0 ) ];
            break;
        case "mp_herat":
            var_2["7"] = [];
            var_2["7"][0] = [ ( -1231.9, -132.317, 183.246 ), ( 0, 90, 0 ) ];
            break;
        default:
            break;
    }

    if ( isdefined( var_2[var_1] ) )
    {
        foreach ( var_5 in var_2[var_1] )
        {
            var_6 = var_5[0];
            var_7 = var_5[1];
            var_8 = easepower( "hardpoint_chevron", var_6, var_7 );
            var_3[var_3.size] = var_8;
        }
    }

    var_0 = scripts\engine\utility::array_combine( var_0, var_3 );
    return var_0;
}

init_vo_arrays( var_0, var_1, var_2 )
{
    var_0.origin = var_1;
    var_0.angles = var_2;
    return var_0;
}

_id_144DA()
{
    level endon( "game_ended" );
    level endon( "stop_watching_trigger" );
    var_0 = self.entnum;
    self.trigger scripts\engine\utility::trigger_on();

    foreach ( var_2 in level.teamnamelist )
    {
        self.playerzombiedelayturnonfx[var_2] = 0;
        self.playerzombiedestroyhud[var_2] = [];
    }

    self.playerzombiedelayturnonfx["neutral"] = 0;
    self.playerzombiedestroyhud["neutral"] = [];
    self.playerzombiedestroyhud["none"] = [];
    self.getinventoryslotvo = 1;

    for (;;)
    {
        self.trigger waittill( "trigger", var_4 );

        if ( !scripts\mp\utility\player::isreallyalive( var_4 ) )
            continue;

        if ( isagent( var_4 ) )
            continue;

        if ( !scripts\mp\utility\entity::isgameparticipant( var_4 ) )
            continue;

        if ( istrue( var_4.inlaststand ) )
            continue;

        if ( isdefined( var_4.classname ) && var_4.classname == "script_vehicle" )
            continue;

        if ( !isdefined( var_4.initialized_gameobject_vars ) )
            continue;

        var_5 = scripts\mp\gameobjects::getrelativeteam( var_4.pers["team"] );

        if ( isdefined( self.teamusetimes[var_5] ) && self.teamusetimes[var_5] < 0 )
            continue;

        if ( scripts\mp\utility\player::isreallyalive( var_4 ) && !isdefined( var_4.touchtriggers[var_0] ) )
        {
            var_2 = var_4.pers["team"];
            self.playerzombiedelayturnonfx[var_2]++;
            var_6 = var_4.guid;
            var_7 = spawnstruct();
            var_7.player = var_4;
            var_7.starttime = gettime();
            self.playerzombiedestroyhud[var_2][var_6] = var_7;
            var_4.spawn_sentry_at_pos = 0;
        }

        if ( scripts\mp\utility\player::isreallyalive( var_4 ) && !isdefined( var_4.touchtriggers[var_0] ) )
            var_4 thread playerzombiedovehicledamageimmunity( self );
    }
}

playerzombiedovehicledamageimmunity( var_0 )
{
    level endon( "stop_watching_trigger" );
    var_1 = self.pers["team"];

    while ( scripts\mp\utility\player::isreallyalive( self ) && isdefined( var_0.trigger ) && self istouching( var_0.trigger ) && !level.gameended )
    {
        if ( isdefined( var_0.checkinteractteam ) && var_0.team != var_1 )
            break;

        if ( istrue( self.inlaststand ) )
            break;

        if ( isdefined( var_0.interactsquads ) && !isdefined( var_0.interactsquads[self.team] ) || isdefined( var_0.interactsquads ) && !scripts\engine\utility::array_contains( var_0.interactsquads[self.team], self.squadindex ) )
            break;

        waitframe();
    }

    if ( level.gameended )
        return;

    if ( isdefined( self ) )
    {
        var_0.playerzombiedestroyhud[var_1][self.guid] = undefined;
        self.spawn_sentry_at_pos = 0;
    }
    else
    {
        var_2 = [];

        foreach ( var_5, var_4 in var_0.playerzombiedestroyhud[var_1] )
        {
            if ( !isdefined( var_4.player ) )
                var_2[var_2.size] = var_5;
        }

        foreach ( var_5 in var_2 )
            var_0.playerzombiedestroyhud[var_1][var_5] = undefined;
    }

    var_0.playerzombiedelayturnonfx[var_1]--;
}