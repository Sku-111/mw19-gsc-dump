// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = scripts\mp\gametypes\br_quest_util.gsc::registerquestcategory( "timedrun", 1 );

    if ( !var_0 )
        return;

    var_0 = scripts\mp\gametypes\br_quest_util.gsc::registerquestcategory( "timedrun_redacted", 1 );

    if ( var_0 )
    {
        scripts\mp\gametypes\br_quest_util.gsc::_id_12B2A( "timedrun_redacted", "brloot_redacted_timedrun_tablet" );
        scripts\mp\gametypes\br_quest_util.gsc::_id_12B3D( "timedrun_redacted", ::_id_13DE0 );
    }

    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" )._id_11C4C = getdvarint( "scr_br_tr_missionTimeBase", 120 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_elevator = getdvarint( "scr_br_tr_kioskSearchRadiusMax", 23000 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_enemies_cleared = getdvarint( "scr_br_tr_kioskSearchRadiusMin", 10000 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_delay_and_then_blowup_plane = getdvarint( "scr_br_tr_kioskSearchRadiusIdealMax", 23000 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_door_open = getdvarint( "scr_br_tr_kioskSearchRadiusIdealMin", 17000 );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "timedrun", ::_id_13C27 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2E( "timedrun", ::_id_13C25 );

    if ( !var_0 )
        return;

    scripts\mp\gametypes\br_quest_util.gsc::_id_12B3D( "timedrun", ::_id_13DE0 );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestlocale( "timedrun_locale" );
    scripts\mp\gametypes\br_quest_util.gsc::registercreatequestlocale( "timedrun_locale", ::_id_13C1F );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "timedrun_locale", ::_id_13C26 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2D( "timedrun_locale", ::_id_13C21 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B30( "timedrun_locale", ::_id_13C28 );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestcircletick( "timedrun_locale", ::_id_13C1E );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestthink( "timedrun_locale", ::_id_13C20, 0.1 );
    game["dialog"]["mission_timedrun_accept"] = "mission_mission_time_accept";
    game["dialog"]["mission_timedrun_fail"] = "mission_mission_time_failed";
}

_id_13DE0()
{
    var_0 = _id_13C23( self );
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::play_train_speaker_vo( "timedrun", var_0 );

    if ( !isdefined( var_1 ) )
        return 0;

    self._id_12C4A = var_1;
    return 1;
}

takequestitem( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::createquestinstance( "timedrun", self.team, var_0.index, var_0 );
    var_1 scripts\mp\gametypes\br_quest_util.gsc::registerteamonquest( self.team, self );
    var_1.team = self.team;
    var_1.startlocation = self.origin;
    var_1._id_13869 = self;
    scripts\mp\gametypes\br_quest_util.gsc::searchfunc( self.team, "br_mission_pickup_tablet" );
    var_2 = "";

    if ( var_0.type == "brloot_redacted_timedrun_tablet" )
        var_2 = "_redacted";

    var_1.modifier = var_2;
    var_3 = _id_13C23( var_0 );
    var_1.starttime = gettime();
    var_4 = var_1 scripts\mp\gametypes\br_quest_util.gsc::requestquestlocale( "timedrun_locale", var_3, 1 );
    var_4.team = self.team;

    if ( !var_4.enabled )
    {
        var_1.result = "no_locale";
        var_1 scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( self.team );
        return;
    }

    scripts\mp\gametypes\br_quest_util.gsc::_id_1297C( "timedrun", 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B31( "timedrun", ::_id_13C24 );
    var_1 scripts\mp\gametypes\br_quest_util.gsc::_id_1297D( getdvarint( "scr_br_timedrun_questTimeBase", getdvarint( "scr_br_tr_missionTimeBase", 120 ) ), 4 );
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "timedrun", var_1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_13879( "timedrun", self, self.team );
    var_5 = spawnstruct();
    var_5.excludedplayers = [];
    var_5.excludedplayers[0] = self;
    var_5._id_127D5 = scripts\mp\gametypes\br_quest_util.gsc::rewardmodifier( "timedrun", scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team ), var_1.modifier );
    scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( self, "br_timedrun_quest_start_tablet_finder", var_5 );
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( var_1.team, "br_timedrun_quest_start_team_notify", var_5 );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_timedrun_accept", var_1.team, 1, 1 );
}

gethillspawnshutofforigin( var_0 )
{
    if ( var_0.team == self.subscribedinstances[0].team )
        return 1;
    else
        return 0;
}

_id_13C29( var_0 )
{
    var_1 = spawnstruct();
    var_1._id_12FA3 = "GetEntitylessScriptableArray";
    var_1._id_12F9F = var_0;
    var_1._id_12FA6 = 6000;
    var_1._id_12FA7 = 0;
    var_1._id_12FA4 = 4000;
    var_1._id_12FA5 = 0;
    var_1.mintime = 1;
    return var_1;
}

_id_13C23( var_0 )
{
    var_1 = spawnstruct();
    var_1._id_12FA3 = "getKiosks";
    var_1.partname = "br_plunder_box";
    var_1.statename = "visible";
    var_1._id_12F9F = var_0.origin;
    var_1._id_12FA6 = scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_elevator;
    var_1._id_12FA7 = scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_enemies_cleared;
    var_1._id_12FA4 = scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_delay_and_then_blowup_plane;
    var_1._id_12FA5 = scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "timedrun" ).wait_for_door_open;
    var_1._id_12FA1 = 1;
    var_1._id_12C4A = var_0._id_12C4A;
    var_1.mintime = 1;
    return var_1;
}

_id_13C22( var_0 )
{
    foreach ( var_2 in scripts\mp\utility\teams::getteamdata( self.team, "players" ) )
    {
        if ( distance2d( self.startlocation, var_2.origin ) < 1500 )
        {
            if ( isdefined( var_2.vehicle ) )
                return;
        }
    }

    var_4 = getentarrayinradius( "script_vehicle", "classname", var_0._id_12F9F, var_0._id_12FA6 );
    var_4 = sortbydistance( var_4, var_0._id_12F9F );

    foreach ( var_6 in var_4 )
    {
        if ( var_6.isempty )
        {
            self._id_13A93 = var_6;
            break;
        }
        else if ( var_6.ownerteam == self.team )
            break;
    }

    if ( !isdefined( self._id_13A93 ) )
        return;

    self._id_14256 = scripts\mp\utility\outline::outlineenableforteam( self._id_13A93, self.team, "outlinefill_nodepth_yellow", "level_script" );
    thread has_tac_vis();
    thread _id_144B9();
}

_id_144B9()
{
    level endon( "game_ended" );
    self endon( "remove_TR_Outline" );
    var_0 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    scripts\engine\utility::waittill_any_ents_array( var_0, "vehicle_enter" );

    foreach ( var_2 in var_0 )
    {
        if ( distance2d( var_2.origin, self._id_13A93.origin ) < 2000 )
        {
            scripts\mp\utility\outline::outlinedisable( self._id_14256, self._id_13A93 );
            self notify( "remove_TR_Outline" );
        }
    }
}

has_tac_vis()
{
    level endon( "game_ended" );
    self endon( "remove_TR_Outline" );

    for (;;)
    {
        if ( self._id_13A93.isempty != 1 || gettime() > self.starttime + 60000 )
        {
            scripts\mp\utility\outline::outlinedisable( self._id_14256, self._id_13A93 );
            self notify( "remove_TR_Outline" );
        }

        wait 0.2;
    }
}

_id_13C1F( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::createlocaleinstance( "timedrun_locale", "timedrun", self.team );

    if ( !isdefined( var_0 ) )
    {
        var_1.curorigin = ( 0, 0, 0 );
        var_1.enabled = 0;
        return var_1;
    }

    var_1.playerlist = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    var_1.curorigin = var_0.origin;
    var_1.modifier = self.modifier;
    var_1 scripts\mp\gametypes\br_quest_util.gsc::init_tape_machine_animations( "ui_mp_br_mapmenu_icon_timedrun_objective", "current", var_1.curorigin + ( 0, 0, 65 ) );
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "timedrun_locale", var_1 );
    var_1 _id_13258( var_0 );
    return var_1;
}

_id_13258( var_0 )
{
    if ( !isdefined( var_0 ) )
    {
        var_1 = self.subscribedinstances[0];

        foreach ( var_3 in scripts\mp\utility\teams::getteamdata( var_1.team, "players" ) )
            var_3 scripts\mp\utility\lower_message::_id_1316E( "br_assassination_notargets", undefined, 5 );

        var_1.result = "no_locale";
        var_1 scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
        return 0;
    }

    self._id_13A7A = var_0;
    thread _id_13B73( self._id_13A7A.origin );
    _id_14028();
    return 1;
}

_id_13B73( var_0, var_1 )
{
    var_2 = spawnfx( level._effect["vfx_marker_base_orange_pulse"], var_0 + ( 0, 0, 10 ) );
    var_2.angles = vectortoangles( ( 0, 0, 1 ) );
    var_2 hide();
    wait 0.5;
    triggerfx( var_2 );

    foreach ( var_4 in scripts\mp\utility\teams::getteamdata( self.team, "players" ) )
        var_2 showtoplayer( var_4 );

    self.play_vo_internal = var_2;
}

_id_13C27()
{
    scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( self.team );
}

_id_13C26()
{
    lastplunderbankindex();

    if ( isdefined( self.play_vo_internal ) )
        self.play_vo_internal delete();

    self.playerlist = undefined;
    self.subscribedinstances = undefined;
}

_id_13C20()
{
    foreach ( var_1 in scripts\mp\utility\teams::getteamdata( self.team, "players" ) )
    {
        if ( getdvarint( "scr_br_alt_mode_gxp", 0 ) )
        {
            if ( var_1 scripts\mp\gametypes\br_public.gsc::_id_125EC() )
                continue;
        }

        if ( distance( var_1.origin, self.curorigin ) < 150 )
        {
            foreach ( var_3 in self.subscribedinstances )
            {
                if ( var_3.team == var_1.team )
                {
                    var_3 hinttext( self._id_13A7A, var_1 );
                    return;
                }
            }
        }
    }
}

hinttext( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_3 = scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team );
    var_4 = scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "timedrun" + self.modifier );
    var_5 = scripts\mp\gametypes\br_quest_util.gsc::rewardtovalue( scripts\mp\gametypes\br_quest_util.gsc::rewardtotype( "timedrun", self.modifier ) );
    var_6 = scripts\mp\gametypes\br_alt_mode_bblitz.gsc::clear_all_remaining( var_1 );
    var_2._id_121B5 = scripts\mp\gametypes\br_quest_util.gsc::_id_121B9( var_4, var_3, var_5, undefined, var_6 );
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_timedrun_quest_complete", var_2 );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_misc_success", self.team, 1, 1 );
    var_7 = scripts\mp\utility\teams::getteamdata( self.team, "players" );

    foreach ( var_9 in var_7 )
    {
        if ( isdefined( var_9 ) && !istrue( var_9.delay_enter_combat_after_investigating_grenade ) )
            scripts\mp\gametypes\br_armory_kiosk.gsc::wait_for_enemies_inarea( var_0, var_9 );
    }

    self._id_12D2D = undefined;
    self.result = "success";
    self._id_12D2E = var_0.origin + anglestoforward( var_0.angles ) * 32;
    self._id_12D2B = var_0.angles + ( 0, -90, 0 );
    scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
}

pattern()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_timedrun_quest_circle_failure" );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_obj_circle_fail", self.team, 1, 1 );
    self.result = "fail";
    scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
}

_id_13C24()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_timedrun_quest_timer_expired" );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_timedrun_fail", self.team, 1, 1 );
}

_id_13C1E( var_0, var_1 )
{
    if ( !isdefined( self.lastcircletick ) )
        self.lastcircletick = -1;

    var_2 = gettime();

    if ( self.lastcircletick == var_2 )
        return;

    self.lastcircletick = var_2;
    var_3 = distance2d( self.curorigin, var_0 );

    if ( var_3 > var_1 )
    {
        foreach ( var_5 in self.subscribedinstances )
            var_5 pattern();
    }
}

_id_13C25( var_0 )
{
    if ( var_0.team == self.team )
    {
        scripts\mp\gametypes\br_quest_util.gsc::getquestinstancedata( "timedrun_locale", self.team ).playerlist = scripts\mp\utility\teams::getteamdata( self.team, "players" );

        if ( !scripts\mp\gametypes\br_quest_util.gsc::isteamvalid( var_0.team ) )
        {
            self.result = "fail";
            scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
        }
    }
}

_id_13C21( var_0 )
{
    if ( !gethillspawnshutofforigin( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util.gsc::spawn_downed_friendly( var_0 );
}

_id_13C28( var_0 )
{
    if ( !gethillspawnshutofforigin( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "timedrun" + self.modifier );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1336C( var_0 );
}

_id_14028()
{
    var_0 = scripts\mp\gametypes\br_quest_util.gsc::sortvalidplayersinarray( self.playerlist );

    foreach ( var_2 in var_0["valid"] )
    {
        var_2 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "timedrun" + self.modifier );
        scripts\mp\gametypes\br_quest_util.gsc::_id_1336C( var_2 );
    }

    foreach ( var_2 in var_0["invalid"] )
    {
        var_2 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
        scripts\mp\gametypes\br_quest_util.gsc::spawn_downed_friendly( var_2 );
    }
}

spawn_ending_individual_guys( var_0 )
{
    scripts\mp\gametypes\br_quest_util.gsc::spawn_downed_friendly( var_0 );
    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
}

lastplunderbankindex()
{
    foreach ( var_1 in self.playerlist )
        spawn_ending_individual_guys( var_1 );

    scripts\mp\gametypes\br_quest_util.gsc::lastdropedtime();
}
