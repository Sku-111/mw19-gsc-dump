// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = revivent_watchfordeath_safety( game["attackers"] );

    foreach ( var_2 in var_0 )
        alwayssnowfight( var_2 );

    var_4 = revivent_watchfordeath_safety( game["defenders"] );

    foreach ( var_2 in var_4 )
        alwayssnowfight( var_2 );

    scripts\mp\gametypes\br_quest_util.gsc::registerquestlocale( "cap_locale" );
    scripts\mp\gametypes\br_quest_util.gsc::registercreatequestlocale( "cap_locale", ::get_consecutive_def );
    scripts\mp\gametypes\br_quest_util.gsc::registercheckiflocaleisavailable( "cap_locale", ::get_comp_dist_for_info_loop );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "cap_locale", ::get_corpse_array );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestcircletick( "cap_locale", ::get_connected_nodes_targetname_array );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2D( "cap_locale", ::get_control_station_side_array );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B30( "cap_locale", ::get_convoy_vehicle_get_in_scene_name );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "cap_locale" ).nextid = 0;
    _id_1322D();
    scripts\mp\gametypes\br_gametypes.gsc::_id_12B11( "canTakePickupLoot", ::get_chopperexfil_transient );
    game["dialog"]["mission_cap_accept"] = "mission_mission_dom_accept_secure";
    game["dialog"]["mission_cap_success"] = "mission_mission_dom_success";
}

revivent_watchfordeath_safety( var_0 )
{
    if ( var_0 == game["attackers"] )
        return registermovequestlocale();
    else
        return relic_nuketimer_playvo();
}

registermovequestlocale()
{
    return [ "capshoot_killstreak" ];
}

relic_nuketimer_playvo()
{
    return [ "capshoot_killstreak_d" ];
}

alwayssnowfight( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::registerquestcategory( var_0, 1 );

    if ( !var_1 )
        return;

    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2A( var_0, "brloot_domination_tablet" );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B3D( var_0, ::get_current_ai_cap );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( var_0, ::get_correct_bomb_wire_pair );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1297C( var_0, 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B31( var_0, ::get_closest_available_player_new );
    scripts\mp\gametypes\br_quest_util.gsc::_id_13180( var_0 );
}

get_correct_bomb_wire_pair()
{
    if ( isdefined( level._id_13AC8[self.team] ) )
        level._id_13AC8[self.team] = scripts\engine\utility::array_remove( level._id_13AC8[self.team], self.squadindex );

    scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( self.team );
    scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehidefromteam( self.team );
    self._id_1393B thread get_combat_station_next_combat_action();
}

get_corpse_array()
{
    foreach ( var_1 in self.subscribedinstances )
        var_1 thread scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();

    last_vampire_feedback();
    self.get_closest_living_player_not_in_laststand = undefined;
}

get_current_ai_cap()
{
    self.questcategory = "capshoot";
    return 1;
}

get_consecutive_def( var_0 )
{
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "cap_locale" ).nextid++;
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::createlocaleinstance( "cap_locale", self.questcategory, "CapPoint:" + scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "cap_locale" ).nextid );

    if ( !isdefined( var_0 ) )
    {
        var_1.curorigin = ( 0, 0, 0 );
        var_1.enabled = 0;
        return var_1;
    }

    var_2 = var_0.origin;

    if ( !( var_0.spawnflags & 23 ) )
    {

    }

    var_3 = scripts\mp\gametypes\br_quest_util.gsc::_id_12971( var_0 );
    var_4 = spawn( "trigger_radius", var_2, 0, int( var_3 ), int( level.debugpayloadobjectivesstart_infil ) );
    var_4.script_label = "";
    level._id_13135 = ::get_closest_valid_player;
    var_5 = scripts\mp\gametypes\obj_dom.gsc::setupobjective( var_4 );
    var_5.onuse = ::get_closest_spawns;
    var_5.onbeginuse = ::get_closest_origin_index;
    var_5.onuseupdate = ::get_closest_unclaimed_destination;
    var_5.onenduse = ::get_closest_player_dist;
    var_5.usecondition = ::get_combat_action;
    var_5.lockupdatingicons = 1;
    var_5.getrandompointincirclewithindistance = 1;
    var_5.flagmodel setmodel( "x2_military_old_recon_station" );
    scripts\mp\objidpoolmanager::update_objective_position( var_5.objidnum, var_5.curorigin + ( 0, 0, 60 ) );
    level.flagcapturetime = getdvarfloat( "scr_br_cap_quest_capture_time", 30 );
    var_5 scripts\mp\gameobjects::setusetime( level.flagcapturetime );
    var_1.lastcircletick = -1;
    var_1.get_closest_living_player_not_in_laststand = var_5;
    var_1.curorigin = var_5.curorigin;
    var_1.team = self.team;
    var_5.locale = var_1;
    var_5.squadindex = self.squadindex;
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "cap_locale", var_1 );
    return var_1;
}

get_comp_dist_for_info_loop( var_0 )
{
    var_1 = getdvarfloat( "scr_br_cap_quest_max_capture_percent", 0.2 );
    var_2 = getdvarfloat( "scr_br_cap_quest_max_teams", 4 );
    var_3 = 0;

    if ( isdefined( self.get_closest_living_player_not_in_laststand.curprogress ) )
        var_3 = self.get_closest_living_player_not_in_laststand.curprogress / self.get_closest_living_player_not_in_laststand.usetime;

    if ( var_3 > var_1 )
        return 0;

    if ( self.subscribedinstances.size >= var_2 )
        return 0;

    return 1;
}

get_connected_nodes_targetname_array( var_0, var_1 )
{
    if ( !isdefined( self.get_closest_living_player_not_in_laststand ) )
        return;

    var_2 = gettime();

    if ( self.lastcircletick == var_2 )
        return;

    self.lastcircletick = var_2;

    if ( isdefined( self.get_closest_living_player_not_in_laststand ) && isdefined( self.get_closest_living_player_not_in_laststand.traincar ) )
        self.curorigin = self.get_closest_living_player_not_in_laststand.traincar.origin;

    var_3 = distance2d( self.curorigin, var_0 );

    if ( var_3 > var_1 )
    {
        foreach ( var_5 in self.subscribedinstances )
        {
            if ( isdefined( var_5 ) )
            {
                scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( var_5.team, "br_capshoot_quest_circle_failure" );
                var_6 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( var_5.team, var_5.squadindex );
                level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "br_capshoot_quest_circle_failure", 1, var_6 );
            }

            var_5.result = "circle";
        }

        scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
    }
}

get_control_station_side_array( var_0 )
{
    get_closest_munitions( var_0 );
}

get_convoy_vehicle_get_in_scene_name( var_0 )
{
    foreach ( var_2 in self.teams )
    {
        if ( var_0.team == self.subscribedinstances[0].team )
            get_closest_visible_drone( var_0 );
    }
}

get_chopperexfil_transient( var_0 )
{
    if ( !scripts\mp\gametypes\br_pickups.gsc::usb( var_0.scriptablename ) )
        return undefined;

    var_1 = var_0.tracknonoobplayerlocation;

    if ( isdefined( var_1.questcategory ) && var_1.questcategory == "capshoot" )
    {
        if ( self.team == var_1.team )
        {
            var_2 = revivent_watchfordeath_safety( self.team );

            foreach ( var_4 in var_2 )
            {
                if ( isdefined( level.questinfo.quests[var_4] ) )
                {
                    foreach ( var_6 in level.questinfo.quests[var_4].instances )
                    {
                        if ( isdefined( var_6 ) && self.squadindex == var_6.squadindex )
                            return 10;
                    }
                }
            }

            return 1;
        }
        else
            return 22;
    }

    return undefined;
}

takequestitem( var_0 )
{
    var_1 = search( var_0._id_139EB, self, 1, var_0 );

    if ( !isdefined( var_1 ) )
        return;

    _id_1336D( var_0._id_139EB, [ self ] );
    var_1 _id_13742( [ self ] );

    if ( istrue( level.disable_super_in_turret._id_12273 ) && isdefined( var_0._id_12157 ) )
    {
        var_2 = [[ var_0._id_12157 ]]( var_0 );

        if ( isdefined( var_2 ) && isdefined( var_0._id_12158 ) )
        {
            if ( getdvarint( "scr_br_alt_mode_mini", 0 ) == 1 )
                search( var_0._id_12158, var_2, 0, var_0, var_1 );
            else
                search( var_0._id_12158, var_2, 0, var_0 );

            _id_1336D( var_0._id_12158, [ var_2 ] );
            var_1 _id_13742( [ var_2 ] );
        }
    }

    if ( isdefined( level.disable_super_in_turret._id_12979 ) && isdefined( var_1._id_12978 ) )
        level.disable_super_in_turret._id_12979 = scripts\engine\utility::array_remove( level.disable_super_in_turret._id_12979, var_1._id_12978 );
}

search( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = getdvarint( "scr_br_CAP_questTime", 240 );
    var_6 = adjust_angles_for_heli_path( var_0, var_1, var_5, var_3 );
    var_7 = undefined;
    var_8 = spawnstruct();
    var_8 = var_1 rocket_missile( var_0 );

    if ( isdefined( var_3 ) && isdefined( var_3._id_12395 ) )
    {
        var_9 = [[ var_3._id_12395 ]]( var_1, var_3 );

        if ( isdefined( var_9 ) )
        {
            var_8._id_12C4A = var_9;
            var_7 = var_9._id_12978;
        }
    }

    if ( !isdefined( var_4 ) )
        var_4 = var_6 scripts\mp\gametypes\br_quest_util.gsc::requestquestlocale( "cap_locale", var_8, var_2 );

    if ( !isdefined( var_4 ) || !istrue( var_4.enabled ) )
    {
        var_6.result = "no_locale";
        var_6 scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( var_1.team );
    }
    else
    {
        if ( isdefined( var_4.get_closest_living_player_not_in_laststand ) )
            var_3.stadium_three_death_func = var_4.get_closest_living_player_not_in_laststand.flagmodel;

        var_4._id_12978 = var_7;
        var_4.squadindex = var_1.squadindex;
        var_4 get_combat_alias();
        scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( var_0, var_6 );
    }
}

rocket_missile( var_0 )
{
    var_1 = self;
    var_2 = spawnstruct();
    var_2._id_12FA3 = "questPointsArray";
    var_2._id_12F9F = ( var_1.origin[0], var_1.origin[1], 0 );
    var_2._id_12FA6 = getdvarfloat( "scr_br_cap_search_max_radius", 7500 );
    var_2._id_12FA7 = 0;
    var_2._id_12FA4 = getdvarfloat( "scr_br_cap_search_ideal_max_radius", 5000 );
    var_2._id_12FA5 = getdvarfloat( "scr_br_cap_search_ideal_min_radius", 2500 );
    var_2._id_1297F = 7;
    var_2.mintime = getdvarfloat( "scr_br_cap_quest_capture_time", 30 );
    var_2._id_12FA1 = 1;
    var_2._id_12C4A = var_1._id_12C4A;

    if ( playlinkfx( var_0 ) )
    {
        if ( var_2._id_12FA6 < level._id_12965 )
            var_2._id_12FA6 = level._id_12965;

        var_2._id_12FA4 = level._id_12965;
        var_2._id_12FA5 = level._id_12966;
    }

    if ( istrue( var_1._id_11FF8 ) )
    {
        var_2._id_12FA3 = "questPointsArrayWZTrain";
        var_2._id_1407E = 1;
    }

    var_3 = getdvarint( "scr_br_questCapDistMin", -1 );
    var_4 = getdvarint( "scr_br_questCapDistMax", -1 );

    if ( var_3 >= 0 )
        var_2._id_12FA5 = var_3;

    if ( var_4 >= 0 )
        var_2._id_12FA4 = var_4;

    return var_2;
}

usageloop()
{
    var_0 = revivent_watchfordeath_safety( game["attackers"] );

    foreach ( var_2 in var_0 )
    {
        if ( isdefined( level.questinfo.quests[var_2].instances[game["attackers"]] ) )
            return 1;
    }

    var_4 = revivent_watchfordeath_safety( game["defenders"] );

    foreach ( var_2 in var_4 )
    {
        if ( isdefined( level.questinfo.quests[var_2].instances[game["defenders"]] ) )
            return 1;
    }

    return 0;
}

adjust_angles_for_heli_path( var_0, var_1, var_2, var_3 )
{
    var_4 = scripts\mp\gametypes\br_quest_util.gsc::createquestinstance( var_0, var_1.team, "", var_3, var_1.squadindex );
    var_4.squadindex = var_1.squadindex;
    var_4 scripts\mp\gametypes\br_quest_util.gsc::registerteamonquest( var_1.team, var_1 );
    var_4 scripts\mp\gametypes\br_quest_util.gsc::_id_12B15( var_1 );
    var_4.team = var_1.team;
    var_4 scripts\mp\gametypes\br_quest_util.gsc::_id_1297D( var_2, 4 );
    return var_4;
}

_id_1336D( var_0, var_1 )
{
    foreach ( var_3 in var_1 )
    {
        var_3 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshowtoteam( var_0, var_3.team );
        var_3 scripts\mp\gametypes\br_quest_util.gsc::_id_13879( var_0, var_3, var_3.team );
    }

    var_5 = spawnstruct();
    var_5.excludedplayers = [];

    foreach ( var_3 in var_1 )
    {
        var_5.excludedplayers[0] = var_3;
        var_3 scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( var_3, "br_capshoot_quest_start_tablet_finder_noplunder", var_5 );
        var_3 scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( var_3.team, "br_capshoot_quest_start_team_noplunder", var_5 );
        var_3 scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_3.team, var_3, 6, scripts\mp\gametypes\br_quest_util.gsc::getquestindex( var_0 ) );
        var_7 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( var_3.team, var_3.squadindex );
        level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "contract_acquired", 1, var_7 );
    }
}

_id_13742( var_0 )
{
    if ( isdefined( self.get_closest_living_player_not_in_laststand ) )
    {
        foreach ( var_2 in var_0 )
            self.get_closest_living_player_not_in_laststand scripts\mp\gameobjects::squadallowuse( var_2.team, var_2.squadindex );
    }
}

get_combat_alias()
{
    if ( !isdefined( self.get_closest_living_player_not_in_laststand ) || !isdefined( self.get_closest_living_player_not_in_laststand.objidnum ) )
        return;

    objective_showtoplayersinmask( self.get_closest_living_player_not_in_laststand.objidnum );
    objective_removeallfrommask( self.get_closest_living_player_not_in_laststand.objidnum );

    foreach ( var_1 in self.subscribedinstances )
    {
        foreach ( var_3 in scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( var_1.team, var_1.squadindex ) )
        {
            if ( !var_3 scripts\mp\gametypes\br_public.gsc::isplayeringulag() )
                objective_addclienttomask( self.get_closest_living_player_not_in_laststand.objidnum, var_3 );
        }
    }
}

get_closest_munitions( var_0 )
{
    if ( !isdefined( self.get_closest_living_player_not_in_laststand ) || !isdefined( self.get_closest_living_player_not_in_laststand.objidnum ) )
        return;

    objective_removeclientfrommask( self.get_closest_living_player_not_in_laststand.objidnum, var_0 );
}

get_closest_visible_drone( var_0 )
{
    if ( !isdefined( self.get_closest_living_player_not_in_laststand ) || !isdefined( self.get_closest_living_player_not_in_laststand.objidnum ) )
        return;

    objective_addclienttomask( self.get_closest_living_player_not_in_laststand.objidnum, var_0 );
}

get_combat_station_next_combat_action()
{
    self endon( "removed" );
    waittillframeend;
    get_combat_alias();
}

last_vampire_feedback()
{
    foreach ( var_1 in self.get_closest_living_player_not_in_laststand.visuals )
        var_1 delete();

    if ( isdefined( self.get_closest_living_player_not_in_laststand.flagmodel ) )
        self.get_closest_living_player_not_in_laststand.flagmodel delete();

    if ( isdefined( self.get_closest_living_player_not_in_laststand.scriptable ) )
        self.get_closest_living_player_not_in_laststand.scriptable delete();

    if ( isdefined( self.get_closest_living_player_not_in_laststand.trigger ) )
    {
        self.get_closest_living_player_not_in_laststand.trigger delete();
        self.get_closest_living_player_not_in_laststand.trigger = undefined;
    }

    self.get_closest_living_player_not_in_laststand thread gameobjectreleaseid_delayed();
    self.get_closest_living_player_not_in_laststand notify( "deleted" );
}

gameobjectreleaseid_delayed()
{
    wait 0.1;
    scripts\mp\gameobjects::releaseid();
}

_id_1322D()
{
    if ( isdefined( level.debugpayloadobjectivesstart_infil ) )
        return;

    level.disableinitplayergameobjects = 0;
    level.debugpayloadobjectivesstart_infil = 120;
    level.iconneutral = "waypoint_captureneutral_br";
    level.iconcapture = "waypoint_capture_br";
    level.icondefend = "waypoint_defend_br";
    level.icondefending = "waypoint_defending_br";
    level.iconcontested = "waypoint_contested_br";
    level.icontaking = "waypoint_taking_br";
    level.iconlosing = "waypoint_losing_br";
    level.squadspawndebug = "icon_waypoint_ot";
    ammobox_checkclearbufferedattachmentweapon( "icon_waypoint_dom_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_taking_br", "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", 1 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_capture_br", "enemy", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_defend_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", 0 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_defending_br", "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", 0 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_blocking_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKING_CAPS", 0 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_blocked_br", "friendly", "MP_INGAME_ONLY/OBJ_BLOCKED_CAPS", 0 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_losing_br", "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", 1 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_captureneutral_br", "neutral", "MP_BR_INGAME/DOM_CAPTURE", 0 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_contested_br", "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", 1 );
    ammobox_checkclearbufferedattachmentweapon( "waypoint_dom_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0 );
    ammobox_checkclearbufferedattachmentweapon( "icon_waypoint_target_br", "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", 0 );
    ammobox_checkclearbufferedattachmentweapon( "icon_waypoint_ot", "neutral", "MP_INGAME_ONLY/OBJ_OTFLAGLOC_CAPS", 0 );
}

ammobox_checkclearbufferedattachmentweapon( var_0, var_1, var_2, var_3 )
{
    level.waypointcolors[var_0] = var_1;
    level.waypointbgtype[var_0] = 1;
    level.waypointstring[var_0] = var_2;
    level.waypointshader[var_0] = "ui_mp_br_mapmenu_icon_dom_objective";
    level.waypointpulses[var_0] = var_3;
}

get_closest_unclaimed_destination( var_0, var_1, var_2, var_3 )
{
    if ( var_1 < 1.0 && !level.gameended )
        _id_12427( var_1, var_0 );

    if ( var_1 > 0.05 && var_2 && !istrue( self.didstatusnotify ) )
        self.didstatusnotify = 1;
}

get_closest_origin_index( var_0 )
{
    if ( !isdefined( self._id_11F63 ) || !self._id_11F63 )
    {
        self._id_11F63 = 1;

        if ( isdefined( self.traincar ) )
        {
            if ( isdefined( level._id_145F1 ) && istrue( level._id_145F1.get_closest_destination ) )
            {
                var_1 = self.traincar.get_closest_attackable_player + ( 200, 0, 0 );
                var_2 = self.traincar.origin + rotatevector( var_1, self.traincar.angles );
                level thread scripts\mp\gametypes\br_quest_util.gsc::_id_140B1( var_2, "dom", 3 );
            }
        }
        else
            level thread scripts\mp\gametypes\br_quest_util.gsc::_id_140B1( self.curorigin, "dom" );

        foreach ( var_4 in level.players )
        {
            if ( isdefined( var_4 ) && isalive( var_4 ) && ( var_4.team != var_0.team || var_4.squadindex != var_0.squadindex ) )
                var_4 thread scripts\mp\hud_message::showsplash( "br_capshoot_quest_alert" );
        }

        var_6 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( var_0.team, var_0.squadindex );

        foreach ( var_8 in var_6 )
            var_8 notify( "calloutmarkerping_warzoneKillQuestIcon" );
    }
}

get_closest_spawns( var_0 )
{
    foreach ( var_2 in self.locale.subscribedinstances )
    {
        var_3 = var_2.team;

        if ( var_3 == var_0.team )
        {
            var_4 = scripts\mp\gametypes\br_quest_util.gsc::ringing( var_0.team );
            var_5 = scripts\mp\gametypes\br_quest_util.gsc::getquestindex( var_2.questcategory );
            var_6 = scripts\mp\gametypes\br_quest_util.gsc::rewardtovalue( scripts\mp\gametypes\br_quest_util.gsc::rewardtotype( var_2.questcategory ) );
            var_7 = spawnstruct();
            var_7._id_121B5 = scripts\mp\gametypes\br_quest_util.gsc::_id_121B9( var_5, var_4, var_6 );
            self.squadindex = var_2.squadindex;
            scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( var_3, "br_capshoot_quest_complete_noplunder", var_7 );
            scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_3, var_0, 8, var_5 );
            var_8 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( var_0.team, var_0.squadindex );
            level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "contract_complete", 1, var_8, 0, 1 );
            var_2._id_12D2E = self.flagmodel.origin;
            var_2._id_12D2B = self.flagmodel.angles;
            var_2.result = "success";

            if ( isdefined( self.assisttouchlist ) )
            {
                if ( isdefined( self.assisttouchlist[var_3] ) )
                {
                    var_9 = getarraykeys( self.assisttouchlist[var_3] );

                    foreach ( var_11 in var_9 )
                    {
                        var_12 = self.assisttouchlist[var_3][var_11].player;

                        if ( isdefined( var_12.owner ) )
                            var_12 = var_12.owner;

                        if ( !isplayer( var_12 ) )
                            continue;

                        var_12 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F( "t9_ch_global_complete_recon_objective_for_operator_mission", 1 );
                        var_12 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F( "t9_ch_global_complete_recon_objective_for_operator_mission_op2", 1 );
                        var_2 scripts\mp\gametypes\br_quest_util.gsc::_id_12B15( var_12 );
                    }
                }
            }

            continue;
        }

        scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( var_3, "br_capshoot_quest_failure", undefined, var_2.squadindex );
        var_8 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( var_3, var_2.squadindex );
        level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "contract_fail", 1, var_8 );
        var_2.result = "fail";
    }

    self.locale thread scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
}

get_closest_player_dist( var_0, var_1, var_2 )
{
    scripts\mp\gametypes\obj_dom.gsc::dompoint_onuseend( var_0, var_1, var_2 );
}

_id_12427( var_0, var_1 )
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

get_closest_valid_player( var_0, var_1, var_2 )
{
    switch ( var_1 )
    {
        case "contested":
        case "idle":
        case "off":
            return 0;
        default:
            var_1 = "using";

            if ( isdefined( var_2 ) )
                var_1 = var_1 + var_2;

            self.scriptable setscriptablepartstate( var_0, var_1 );

            if ( var_0 == "pulse" )
                self.scriptable setscriptablepartstate( "flag", var_1 );

            return 1;
    }
}

get_combat_action( var_0 )
{
    var_1 = var_0.team;

    foreach ( var_3 in self.locale.subscribedinstances )
    {
        if ( isdefined( var_3 ) )
        {
            if ( var_3.team == var_1 )
                return 1;
        }
    }

    return 0;
}

get_closest_available_player_new()
{
    if ( isdefined( self._id_1393B.get_closest_living_player_not_in_laststand.numtouching ) )
    {
        while ( self._id_1393B.get_closest_living_player_not_in_laststand.numtouching[self.id] )
            waitframe();
    }

    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_capshoot_quest_timer_expired" );
    var_0 = scripts\mp\gametypes\br_public.gsc::round_enemy_stuck_logic( self.team, self.squadindex );
    level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "contract_fail", 1, var_0 );
}

playlinkfx( var_0 )
{
    var_1 = 0;
    var_2 = scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "overrideQuestSearchParams", var_0 );

    if ( isdefined( var_2 ) )
        return var_2;

    var_3 = scripts\mp\utility\game::round_vehicle_logic();

    switch ( var_3 )
    {
        case "mini":
        case "risk":
        case "rat_race":
        case "dmz":
            var_1 = 1;
            break;
    }

    return var_1;
}
