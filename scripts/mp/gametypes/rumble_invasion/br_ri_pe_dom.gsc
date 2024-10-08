// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    superonunset();
    level.start_reach_exhaust_waste.setupteamplunderhud = spawnstruct();
    level.start_reach_exhaust_waste.setupteamplunderhud.active = 0;
    level.start_reach_exhaust_waste.setupteamplunderhud.duration = getdvarint( "scr_ri_pe_hardpoint_duration", 120 );
    var_0 = spawnstruct();
    var_0.weight = getdvarfloat( "scr_ri_pe_hardpoint_weight", 1.0 );
    var_0.attackerswaittime = ::attackerswaittime;
    var_0._id_140CF = ::_id_140CF;
    var_0._id_14382 = ::_id_14382;
    var_0._id_11B78 = getdvarint( "scr_ri_pe_hardpoint_max_times", 1 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "hardpoint", "10   5   0   0           0   0   0   0" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 101, var_0 );
}

_id_140CF()
{
    return 0;
}

_id_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
    var_0 = forest_combat();
    wait( var_0 );
}

forest_combat()
{
    var_0 = getdvarfloat( "scr_ri_pe_hardpoint_starttime_min", 795 );
    var_1 = getdvarfloat( "scr_ri_pe_hardpoint_starttime_max", 1110 );

    if ( var_1 > var_0 )
        return randomfloatrange( var_0, var_1 );
    else
        return var_0;
}

attackerswaittime()
{
    var_0 = randomint( level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions.size );
    _id_122C0( var_0 );
}

superonunset()
{
    level.start_reach_exhaust_waste.setupteamplunderleaderboard = [];

    for ( var_0 = 0; var_0 < 7; var_0++ )
    {
        var_1 = scripts\engine\utility::getstructarray( "brRumbleInv_hardpoint_zones" + var_0, "targetname" );

        if ( var_1.size < 0 )
            continue;

        var_2 = [];

        foreach ( var_4 in var_1 )
            var_2[var_2.size] = var_4.origin;

        level.start_reach_exhaust_waste.setupteamplunderleaderboard = scripts\engine\utility::array_add( level.start_reach_exhaust_waste.setupteamplunderleaderboard, var_2 );
    }

    if ( level.start_reach_exhaust_waste.setupteamplunderleaderboard.size < 0 )
    {
        var_6 = [ [ ( 1517, 643, 3154 ) ], [ ( -16156, -12766, 946 ) ], [ ( 35718, 35730, 2010 ) ], [ ( 3109, 38466, 714 ) ], [ ( -26003, 14132, 2286 ) ], [ ( 5385, -26020, 2630 ) ], [ ( 35361, -1082, 1226 ) ] ];
        level.start_reach_exhaust_waste.setupteamplunderleaderboard = var_6;
    }

    for ( var_7 = 0; var_7 < 4; var_7++ )
    {
        for ( var_8 = 0; var_8 < level.start_reach_exhaust_waste.setupteamplunderleaderboard.size; var_8++ )
        {
            if ( level.start_reach_exhaust_waste.setupteamplunderleaderboard[var_8].size > 0 )
                level.start_reach_exhaust_waste._id_12E2C _id_12AF0( var_7, race_ui_checkpoint( var_8 ) );
        }
    }
}

_id_12AF0( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = level.start_reach_exhaust_waste.maphints;

    if ( !isdefined( self.manualturret_toggleallowuseactions ) )
        self.manualturret_toggleallowuseactions = [];

    if ( !isdefined( self.manualturret_toggleallowuseactions[var_0] ) )
        self.manualturret_toggleallowuseactions[var_0] = [];

    var_3 = spawnstruct();
    var_3._id_135CE = var_0;
    var_3.location = getgroundposition( var_1, 5 );
    var_3.get_current_building_obj_struct = var_2;
    self.manualturret_toggleallowuseactions[var_0] = scripts\engine\utility::array_add( self.manualturret_toggleallowuseactions[var_0], var_3 );
}

_id_122C0( var_0 )
{
    level endon( "game_ended" );

    if ( !isdefined( level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions ) )
        level.start_reach_exhaust_waste._id_12E2C _id_12AF0( var_0, level.start_reach_exhaust_waste._id_12E2C.ground_detection_think );

    var_1 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[var_0];
    level.start_reach_exhaust_waste._id_12E2C._id_122B5 = var_0;

    if ( !isdefined( var_1 ) || var_1.size <= 0 )
        return;

    level.maphint_cheesescriptableused = var_1.size;
    _id_122BF();

    if ( getdvarint( "scr_ri_skip_event_wait_times", 0 ) == 0 )
    {
        level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "dom_point_incoming", 0 );
        scripts\mp\gametypes\rumble_invasion\br_ri_ui.gsc::_id_12424( "br_ri_pe_dom_flags_incoming" );
        wait 20;
    }

    level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "dom_point_started", 0 );
    scripts\mp\gametypes\rumble_invasion\br_ri_ui.gsc::_id_12424( "br_ri_pe_dom_flags_online" );
    wait 3.0;
    level thread _id_122BE();
}

_id_122BC()
{
    var_0 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[level.start_reach_exhaust_waste._id_12E2C._id_122B5];

    foreach ( var_2 in var_0 )
    {
        var_3 = var_2.manned_turret_operator_validation_func;
        var_3 notify( "pe_dom_flag_end" );
        var_3 thread _id_122A3( var_3 );
    }
}

_id_122BF()
{
    var_0 = level.start_reach_exhaust_waste._id_12E2C._id_122B5;
    var_1 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[var_0];

    foreach ( var_4, var_3 in var_1 )
        var_3 thread _id_122B7();
}

_id_122BE()
{
    var_0 = [ "_a", "_b", "_c", "_d", "_e", "_f", "_g" ];

    if ( !isdefined( level.start_reach_exhaust_waste.are_all_players_in_region ) )
    {
        level.start_reach_exhaust_waste.are_all_players_in_region = [];
        level.start_reach_exhaust_waste.are_all_players_in_region["allies"] = 0;
        level.start_reach_exhaust_waste.are_all_players_in_region["axis"] = 0;
    }

    if ( !isdefined( level.start_reach_exhaust_waste.spawnsecretstashlootcache ) )
        level.start_reach_exhaust_waste.spawnsecretstashlootcache = 0;

    var_1 = level.start_reach_exhaust_waste._id_12E2C._id_122B5;
    var_2 = level.start_reach_exhaust_waste._id_12E2C.manualturret_toggleallowuseactions[var_1];

    foreach ( var_8, var_4 in var_2 )
    {
        var_5 = scripts\engine\utility::ter_op( isdefined( var_4.get_current_building_obj_struct ), var_4.get_current_building_obj_struct, level.start_reach_exhaust_waste.maphints );
        var_6 = spawn( "trigger_radius", var_4.location, 0, int( var_5 ), int( level.defend_wave_3 ) );
        var_6.script_label = var_0[level.start_reach_exhaust_waste.spawnsecretstashlootcache];
        var_6.iconname = var_0[level.start_reach_exhaust_waste.spawnsecretstashlootcache];
        level.start_reach_exhaust_waste.spawnsecretstashlootcache++;
        var_2[var_8].trigger = var_6;
        var_7 = scripts\mp\gametypes\obj_dom.gsc::setupobjective( var_2[var_8].trigger, "neutral" );
        var_7.onuse = ::_id_122B2;
        var_7.onbeginuse = ::_id_122A8;
        var_7.onuseupdate = ::_id_122B3;
        var_7.onenduse = ::_id_122AA;
        var_7.oncontested = ::_id_122A9;
        var_7.onuncontested = ::_id_122AF;
        var_7.onunoccupied = ::_id_122B0;
        var_7.onpinnedstate = ::_id_122AD;
        var_7.onunpinnedstate = ::_id_122B1;
        var_7._id_138B2 = ::_id_122AE;
        var_7.stompprogressreward = ::_id_122B8;
        var_7.id = "domFlag";
        var_7.pinobj = 1;
        var_7.lockupdatingicons = 1;
        var_7.trigger = var_6;
        var_7.get_current_bush_zone = 0;
        var_7.get_current_building_obj_struct = var_5;
        var_7.pos = var_4.location;
        var_7.vfxent = var_4.vfxent;
        var_7 scripts\mp\gameobjects::setcapturebehavior( "persistent" );
        var_7 scripts\mp\gameobjects::setusetime( level.start_reach_exhaust_waste._id_122A1 );
        playencryptedcinematicforall( var_7.objidnum, 1 );
        var_7._id_11AD0 = [];
        var_7._id_11AD0["ally"] = spawnstruct();
        var_7._id_11AD0["enemy"] = spawnstruct();
        var_7._id_11AD0["neutral"] = spawnstruct();
        var_7.waittill_pickup_or_timeout = "undefined";
        var_7._id_11AD0["neutral"] _id_122A4( 9, var_7.curorigin, var_5 );
        var_7._id_11AD0["ally"] _id_122A4( 8, var_7.curorigin, var_5 );
        var_7._id_11AD0["enemy"] _id_122A4( 0, var_7.curorigin, var_5 );
        var_7 _id_122BB( "neutral" );
        var_7 thread _id_122B9();
        var_7 thread _id_122BA();
        var_2[var_8].manned_turret_operator_validation_func = var_7;
        wait 0.5;
    }
}

_id_122AB( var_0 )
{
    self._id_1265B = scripts\engine\utility::array_add( self._id_1265B, var_0 );
    var_0.truck_04_node = 1;
}

_id_122AC( var_0 )
{
    self._id_1265B = scripts\engine\utility::array_remove( self._id_1265B, var_0 );
    var_0.truck_04_node = 0;
}

_id_122B9()
{
    self endon( "game_ended" );
    self._id_1265B = [];

    while ( !self.get_current_bush_zone )
    {
        self.trigger waittill( "trigger", var_0 );

        if ( ( isplayer( var_0 ) || isbot( var_0 ) ) && !scripts\engine\utility::array_contains( self._id_1265B, var_0 ) )
            _id_122AB( var_0 );

        waitframe();
    }
}

_id_122BA()
{
    self endon( "game_ended" );

    while ( !self.get_current_bush_zone )
    {
        foreach ( var_1 in self._id_1265B )
        {
            if ( !var_1 istouching( self.trigger ) || !isalive( var_1 ) )
                _id_122AC( var_1 );
        }

        wait 0.1;
    }

    foreach ( var_1 in self._id_1265B )
        _id_122AC( var_1 );
}

_id_122A7( var_0, var_1 )
{
    if ( istrue( var_1.truck_04_node ) )
    {
        var_0 thread scripts\mp\rank::giverankxp( "rumble_dom_flag_enemy_kill", 20, var_0.weapon, 0, 1 );
        var_0 thread scripts\mp\rank::scoreeventpopup( "rumble_dom_flag_enemy_kill" );
    }

    if ( istrue( var_0.truck_04_node ) )
    {
        var_0 thread scripts\mp\rank::giverankxp( "rumble_dom_flag_defend_kill", 20, var_0.weapon, 0, 1 );
        var_0 thread scripts\mp\rank::scoreeventpopup( "rumble_dom_flag_defend_kill" );
    }
}

_id_122A4( var_0, var_1, var_2 )
{
    scripts\mp\gametypes\br_quest_util.gsc::init_tactical_boxes( var_0, 0, 0, var_1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1316F( int( var_2 ) );
}

_id_122BB( var_0 )
{
    if ( var_0 != self.waittill_pickup_or_timeout )
    {
        self.waittill_pickup_or_timeout = var_0;

        foreach ( var_2 in self._id_11AD0 )
            var_2 scripts\mp\gametypes\br_quest_util.gsc::spawn_double_cargo();

        var_4 = self.waittill_pickup_or_timeout != "axis" && self.waittill_pickup_or_timeout != "allies";
        var_5 = undefined;

        foreach ( var_7 in level.players )
        {
            var_8 = var_7.team == self.waittill_pickup_or_timeout;

            if ( var_4 )
                var_5 = self._id_11AD0["neutral"];
            else
                var_5 = scripts\engine\utility::ter_op( var_8, self._id_11AD0["ally"], self._id_11AD0["enemy"] );

            if ( isdefined( var_5 ) )
                var_5 scripts\mp\gametypes\br_quest_util.gsc::_id_1336A( var_7 );
        }

        if ( isdefined( var_5 ) )
            scripts\mp\objidpoolmanager::objective_teammask_addtomask( self.objidnum, var_0 );
    }
}

_id_122A5()
{
    foreach ( var_1 in self._id_11AD0 )
    {
        if ( isdefined( var_1 ) )
            var_1 scripts\mp\gametypes\br_quest_util.gsc::lastdirtyscore();
    }
}

_id_122B2( var_0 )
{
    var_1 = var_0.team;
    self.get_current_station_signage_structs = var_1;
    self.capturetime = gettime();
    self.get_current_bush_zone = 1;

    if ( self.touchlist[var_1].size == 0 && isdefined( self.oldtouchlist ) )
        self.touchlist = self.oldtouchlist;

    self notify( "pe_dom_flag_end" );
    thread _id_122A2( var_1 );
}

_id_122A8( var_0 )
{
    self.userate = 1.0;

    if ( !isdefined( self._id_11F63 ) || !self._id_11F63 )
    {
        self._id_11F63 = 1;
        scripts\mp\gametypes\br_quest_util.gsc::_id_140B1( self.curorigin, "dom" );
        var_1 = scripts\mp\utility\teams::getfriendlyplayers( var_0.team, 0 );

        foreach ( var_3 in var_1 )
            var_3 notify( "calloutmarkerping_warzoneKillQuestIcon" );
    }
}

_id_122B3( var_0, var_1, var_2, var_3 )
{
    self.userate = 1.0;

    if ( var_1 < 1.0 && !level.gameended && !istrue( self.get_current_bush_zone ) )
        _id_12427( var_1, var_0 );

    if ( var_1 > 0.05 && var_2 && !istrue( self.didstatusnotify ) )
        self.didstatusnotify = 1;

    _id_122BB( var_0 );
}

_id_122AA( var_0, var_1, var_2 )
{
    scripts\mp\gametypes\obj_dom.gsc::dompoint_onuseend( var_0, var_1, var_2 );
}

_id_122A9()
{
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_contested_br" );
    scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, undefined );
    level thread scripts\mp\gametypes\br_public.gsc::brleaderdialog( "exfil_contested" );
    var_0 = scripts\mp\gameobjects::getownerteam();
}

_id_122AF( var_0 )
{
    var_1 = scripts\mp\gameobjects::getownerteam();
    var_2 = undefined;
    var_3 = _id_122A6();

    if ( var_3 <= 1 )
    {
        foreach ( var_5 in level.teamnamelist )
        {
            var_6 = self.teamprogress[var_5];

            if ( var_6 > 0 )
            {
                var_2 = var_5;
                break;
            }
        }

        if ( isdefined( var_2 ) )
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var_2 );
        else if ( var_1 != "neutral" )
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var_1 );
        else if ( var_0 != "none" )
            scripts\mp\objidpoolmanager::objective_set_progress_team( self.objidnum, var_0 );

        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend_br", "waypoint_capture_br" );

        if ( var_0 == "none" || var_1 == "neutral" )
            self.didstatusnotify = 0;
    }
}

_id_122B0()
{
    var_0 = scripts\mp\gameobjects::getownerteam();

    if ( var_0 == "neutral" )
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_captureneutral_br" );
    else
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend_br", "waypoint_capture_br" );

    self.didstatusnotify = 0;
}

_id_122AD( var_0 )
{
    if ( self.ownerteam != "neutral" && self.numtouching[self.ownerteam] && !self.stalemate )
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defending_br", "waypoint_capture_br" );
}

_id_122B1( var_0 )
{
    if ( self.ownerteam != "neutral" && !self.numtouching[self.ownerteam] && !self.stalemate )
        scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defend_br", "waypoint_capture_br" );
}

_id_122AE( var_0 )
{
    self.userate = level.start_reach_exhaust_waste.manualturret_watchturretusetimeout;
    var_1 = scripts\mp\utility\teams::getenemyteams( var_0 );
    var_2 = undefined;

    foreach ( var_4 in var_1 )
    {
        var_5 = self.teamprogress[var_4];

        if ( var_5 > 0 )
            var_2 = var_5 / self.usetime;
    }
}

_id_122B8( var_0 )
{
    var_0 thread scripts\mp\utility\points::giveunifiedpoints( "obj_prog_defend" );
    scripts\mp\gameobjects::setobjectivestatusicons( "waypoint_defending_br", "waypoint_capture_br" );

    if ( isdefined( self.lastprogressteam ) )
        self.lastprogressteam = undefined;
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

_id_122A2( var_0 )
{
    if ( isdefined( var_0 ) && var_0 != "tie" )
    {
        level.start_reach_exhaust_waste.are_all_players_in_region[var_0] = level.start_reach_exhaust_waste.are_all_players_in_region[var_0] + 1;

        foreach ( var_2 in level.players )
        {
            if ( isdefined( var_2 ) && isdefined( var_2.team ) && var_2.team == var_0 )
            {
                var_2 thread _id_122B4( 1, var_0 );
                var_2 thread scripts\mp\hud_message::showsplash( "br_ri_pe_dom_flag_captured_ally" );
                continue;
            }

            if ( isdefined( var_2 ) && isdefined( var_2.team ) && var_2.team != var_0 )
            {
                var_2 thread _id_122B4( 0, var_0 );
                var_2 thread scripts\mp\hud_message::showsplash( "br_ri_pe_dom_flag_captured_enemy" );
            }
        }

        var_4 = undefined;

        foreach ( var_6 in self.touchlist[var_0] )
        {
            var_2 = var_6.player;
            var_2 thread scripts\mp\rank::giverankxp( "rumble_dom_flag_capture", 250, var_2 getcurrentprimaryweapon() );
            var_2 thread scripts\mp\rank::scoreeventpopup( "rumble_dom_flag_capture" );

            if ( !isdefined( var_4 ) )
                var_4 = var_2;
        }

        thread _id_122B6();
        thread _id_122A3( self );
    }
}

_id_122B4( var_0, var_1 )
{
    var_2 = level.start_reach_exhaust_waste.are_all_players_in_region[var_1];

    switch ( var_2 )
    {
        case 1:
            if ( var_0 )
                level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "dom_point_friendly_capture_1", self );
            else
                level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "dom_point_enemy_capture_1", self );

            break;
        case 2:
            if ( var_0 )
                level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "dom_point_friendly_capture_2", self );
            else
                level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "dom_point_enemy_capture_2", self );

            break;
        case 3:
            if ( var_0 )
                level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "dom_point_friendly_capture_all", self );
            else
                level thread scripts\mp\gametypes\br_public.gsc::dmztut_endgamewithreward( "dom_point_enemy_capture_all", self );

            break;
    }
}

_id_122A3( var_0 )
{
    if ( isdefined( var_0.vfxent ) )
        stopfxontag( scripts\engine\utility::getfx( "vfx_smk_signal_green" ), var_0.vfxent, "tag_origin" );

    level.maphint_cheesescriptableused--;

    if ( level.maphint_cheesescriptableused == 0 )
    {
        var_1 = scripts\mp\gamelogic::gettimeremaining() / 1000;
        level.manifest_music_started = -1;
        level.manned_turret_createhintobject = ceil( var_1 ) - 60 + 20;
    }

    var_0 _id_122A5();
    scripts\mp\gametypes\obj_dom.gsc::removeobjective( var_0 );
}

_id_122B7()
{
    var_0 = spawn( "script_model", self.location - ( 0, 0, 3 ) );
    var_0 setmodel( "tag_origin" );
    self.vfxent = var_0;
    wait 1.0;
    playfxontag( scripts\engine\utility::getfx( "vfx_smk_signal_green" ), var_0, "tag_origin" );
}

_id_122B6()
{
    level thread scripts\mp\gametypes\br_gametype_rumble_invasion.gsc::_id_119F7( self.pos, "loot_table_dom_flag_capture_cash", 25 );
    level thread scripts\mp\gametypes\br_gametype_rumble_invasion.gsc::_id_119F7( self.pos, "loot_table_dom_flag_capture_weapons", 5 );
}

_id_122A6()
{
    var_0 = 0;

    foreach ( var_3, var_2 in self.numtouching )
    {
        if ( var_2 > 0 && ( !isstring( var_3 ) || var_3 != "none" ) )
            var_0++;
    }

    return var_0;
}

race_ui_checkpoint( var_0 )
{
    var_1 = randomint( level.start_reach_exhaust_waste.setupteamplunderleaderboard[var_0].size );
    return level.start_reach_exhaust_waste.setupteamplunderleaderboard[var_0][var_1];
}
