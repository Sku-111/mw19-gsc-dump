// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\engine\scriptable::_id_12F5B( "body", ::_id_12ED4 );
    var_0 = scripts\mp\gametypes\br_quest_util.gsc::registerquestcategory( "scavenger", 1 );

    if ( !var_0 )
        return;

    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_12FA0 = getdvarint( "scr_br_scavenger_searchCircleSize", 1000 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_11C4C = getdvarint( "scr_br_scavenger_missionTimeBase", 300 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_11C4D = getdvarint( "scr_br_scavenger_missionTimeBonus", 60 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_12C83 = getdvarint( "scr_br_scavenger_resetTimerOnPickup", 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B3D( "scavenger", ::_id_13730 );
    var_0 = scripts\mp\gametypes\br_quest_util.gsc::registerquestcategory( "scavenger_redacted", 1 );

    if ( var_0 )
    {
        scripts\mp\gametypes\br_quest_util.gsc::_id_12B2A( "scavenger_redacted", "brloot_redacted_scavenger_tablet" );
        scripts\mp\gametypes\br_quest_util.gsc::_id_12B3D( "scavenger_redacted", ::_id_13730 );
    }

    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "scavenger", ::sq_removequestinstance );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2E( "scavenger", ::_id_13726 );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestlocale( "scavenger_locale" );
    scripts\mp\gametypes\br_quest_util.gsc::registercreatequestlocale( "scavenger_locale", ::sq_createquestlocale );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2B( "scavenger_locale", ::_id_13720 );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "scavenger_locale", ::sq_removelocaleinstance );
    scripts\mp\gametypes\br_quest_util.gsc::registercheckiflocaleisavailable( "scavenger_locale", ::sq_checkiflocaleisavailable );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestcircletick( "scavenger_locale", ::sq_circletick );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2D( "scavenger_locale", ::_id_1371D );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B30( "scavenger_locale", ::_id_1372D );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1297C( "scavenger", 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B31( "scavenger", ::_id_13723 );
    var_1 = [];
    var_1[0] = scripts\mp\gametypes\br_quest_util.gsc::filtercondition_isdead;
    scripts\mp\gametypes\br_quest_util.gsc::registerplayerfilter( "scavenger", var_1 );
    game["dialog"]["mission_scav_accept"] = "mission_mission_scav_accept";
    game["dialog"]["mission_scav_success"] = "mission_mission_scav_success";
}

sq_removequestinstance()
{
    scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( self.team );
}

_id_13726( var_0 )
{
    if ( var_0.team == self.team )
    {
        var_1 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
        scripts\mp\gametypes\br_quest_util.gsc::getquestinstancedata( "scavenger_locale", self.team ).playerlist = var_1;

        if ( isdefined( self._id_1393B ) && isdefined( self._id_1393B.force_spawn_all_dead_players ) && var_1.size )
            self._id_1393B.force_spawn_all_dead_players setotherent( var_1[0] );

        if ( !scripts\mp\gametypes\br_quest_util.gsc::isteamvalid( var_0.team ) )
        {
            self.result = "fail";
            scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
        }
    }
}

_id_1371D( var_0 )
{
    if ( !gethillspawnshutofforigin( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util.gsc::spawn_downed_friendly( var_0 );
}

_id_1372D( var_0 )
{
    if ( !gethillspawnshutofforigin( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "scavenger" + self.modifier );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1336C( var_0 );
}

gethillspawnshutofforigin( var_0 )
{
    if ( var_0.team == self.subscribedinstances[0].team )
        return 1;
    else
        return 0;
}

sq_createquestlocale( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::createlocaleinstance( "scavenger_locale", "scavenger", self.team );

    if ( !isdefined( var_0 ) )
    {
        var_1.curorigin = ( 0, 0, 0 );
        var_1.enabled = 0;
        return var_1;
    }

    var_1.modifier = self.modifier;
    var_1 scripts\mp\gametypes\br_quest_util.gsc::init_tape_machine_animations( "ui_mp_br_mapmenu_icon_scavengerhunt_objective", "current" );
    var_1.playerlist = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    var_1._id_12320 = 0;
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "scavenger_locale", var_1 );
    var_1 _id_13258( var_0 );
    return var_1;
}

_id_13720( var_0 )
{
    self._id_12320++;
    var_1 = _id_13258( var_0 );
    var_2 = scripts\engine\utility::ter_op( isdefined( var_0._id_11C4E ), var_0._id_11C4E, "?" );
    var_3 = scripts\engine\utility::ter_op( isdefined( var_0 ), var_0.origin, "no origin" );
    logstring( "Scavenger Debug: " + var_2 + " - moving - " + var_3 + ", phaseIndex=" + self._id_12320 );

    if ( var_1 )
    {
        logstring( "Scavenger Debug: " + var_2 + " - setup locale succeeded - " + var_3 );
        self.subscribedinstances[0].intelprogress = var_0.origin;
        scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.subscribedinstances[0].team, "br_scavenger_quest_next_location" );
        level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_obj_next_nptarget", self.subscribedinstances[0].team, 1 );

        if ( istrue( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_12C83 ) )
            self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util.gsc::_id_1297D( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_11C4C, 1 );
        else
            self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util.gsc::_id_1297B( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_11C4D );
    }
    else
        logstring( "Scavenger Debug: " + var_2 + " - setup locale failed - " + var_3 );
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

    getlootspawnpointcount( var_0.index );
    _id_13698( var_0.origin, var_0.angles, self );
    self.curorigin = var_0.origin + ( 0, 0, 50 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_11DB0( self.curorigin );
    _id_14016();
    return 1;
}

sq_removelocaleinstance()
{
    lastdroppableweaponchanged();
    self.playerlist = undefined;
    self.subscribedinstances = undefined;

    if ( isdefined( self.force_spawn_all_dead_players ) )
    {
        if ( self.force_spawn_all_dead_players getscriptablepartstate( "body" ) == "scavenger_closed" )
            self.force_spawn_all_dead_players delete();
    }
}

sq_circletick( var_0, var_1 )
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
            var_5 failscavengerquest();
    }
}

sq_checkiflocaleisavailable()
{
    return 0;
}

takequestitem( var_0 )
{
    var_1 = scripts\engine\utility::ter_op( isdefined( var_0.index ), var_0.index, "?" );

    if ( !isdefined( var_0._id_12C4A ) && !var_0 _id_13730() )
    {
        logstring( "Scavenger Debug: " + var_1 + " - reservedPlacement undefined and no placements found." );
        var_0 freescriptable();
        return;
    }

    var_2 = scripts\mp\gametypes\br_quest_util.gsc::createquestinstance( "scavenger", self.team, var_0.index, var_0 );
    var_2 scripts\mp\gametypes\br_quest_util.gsc::registerteamonquest( self.team, self );
    var_2 scripts\mp\gametypes\br_quest_util.gsc::_id_12B15( self );
    var_2.team = self.team;
    var_2.startlocation = self.origin;
    var_2.intelprogress = self.origin;
    var_2._id_12C4A = var_0._id_12C4A;
    var_3 = "";

    if ( var_0.type == "brloot_redacted_scavenger_tablet" )
        var_3 = "_redacted";

    var_2.modifier = var_3;
    logstring( "Scavenger Debug: " + var_1 + " - pickup - " + var_0.origin );

    for ( var_4 = 0; var_4 < var_2._id_12C4A.size; var_4++ )
        logstring( "Scavenger Debug: " + var_1 + " - reservedPlacement[" + var_4 + "] - " + var_2._id_12C4A[var_4].origin );

    var_5 = _id_11A00( var_2.startlocation, var_2._id_12C4A[0] );
    var_6 = var_2 scripts\mp\gametypes\br_quest_util.gsc::requestquestlocale( "scavenger_locale", var_5, 1 );

    if ( !var_6.enabled )
    {
        scripts\mp\utility\lower_message::_id_1316E( "br_assassination_notargets", undefined, 5 );
        var_2.result = "no_locale";
        var_2 scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( self.team );
        var_7 = spawnstruct();
        var_7.origin = var_0.origin;
        var_7.angles = var_0.angles;
        var_7.itemsdropped = 0;

        if ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" || getdvar( "scr_br_gametype", "" ) == "risk" || getdvar( "scr_br_gametype", "" ) == "gold_war" )
        {
            var_8 = "mp/loot_set_cache_contents_dmz.csv";
            var_7 scripts\mp\gametypes\br_lootcache.gsc::chooseandspawnitems( 0, 1, "health", var_8 );
            var_7 scripts\mp\gametypes\br_lootcache.gsc::chooseandspawnitems( 0, 2, "ammo", var_8 );
            var_7 scripts\mp\gametypes\br_lootcache.gsc::chooseandspawnitems( 1, 1, "plunder", var_8 );
        }
        else
        {
            var_7 scripts\mp\gametypes\br_lootcache.gsc::chooseandspawnitems( 0, 1, "health" );
            var_7 scripts\mp\gametypes\br_lootcache.gsc::chooseandspawnitems( 0, 2, "ammo" );
            var_7 scripts\mp\gametypes\br_lootcache.gsc::chooseandspawnitems( 1, 1, "plunder" );
        }

        return;
    }

    scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshowtoteam( "scavenger" + var_2.modifier, self.team );
    var_2.totalscavengeditems = 0;
    var_2 scripts\mp\gametypes\br_quest_util.gsc::_id_1297D( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger" )._id_11C4C, 4 );
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "scavenger", var_2 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_13879( "scavenger", self, self.team );
    var_9 = spawnstruct();
    var_9.excludedplayers = [];
    var_9.excludedplayers[0] = self;
    var_9._id_127D5 = scripts\mp\gametypes\br_quest_util.gsc::rewardmodifier( "scavenger", scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team ), var_2.modifier );
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_quest_start_team", var_9 );
    scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( self, "br_scavenger_quest_start_tablet_finder", var_9 );

    if ( !scripts\mp\gametypes\br_public.gsc::validtousesticker() )
        scripts\mp\gametypes\br_quest_util.gsc::searchfunc( self.team, "br_mission_pickup_tablet" );

    scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_2.team, self, 6, scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger" ) );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_scav_accept", var_2.team, 1 );
}

_id_11A00( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2._id_12FA3 = "getUnusedLootCacheArray";
    var_2._id_12F9F = var_0;
    var_2._id_12FA6 = 10000;
    var_2._id_12FA7 = 0;
    var_2._id_12FA4 = 4000;
    var_2._id_12FA5 = 2000;
    var_2._id_12FA1 = 1;
    var_2._id_12C4A = var_1;
    var_2.mintime = 45;

    if ( playoverwatch_dialogue() )
    {
        if ( var_2._id_12FA6 < level._id_12967 )
            var_2._id_12FA6 = level._id_12967;

        var_2._id_12FA4 = level._id_12967;
        var_2._id_12FA5 = level._id_12968;
    }

    var_3 = getdvarint( "scr_br_questScavDistMin", -1 );
    var_4 = getdvarint( "scr_br_questScavDistMax", -1 );

    if ( var_3 >= 0 )
        var_2._id_12FA5 = var_3;

    if ( var_4 >= 0 )
        var_2._id_12FA4 = var_4;

    return var_2;
}

playoverwatch_dialogue()
{
    var_0 = 0;
    var_1 = scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "overrideQuestSearchParams", "scavenger" );

    if ( isdefined( var_1 ) )
        return var_1;

    var_2 = scripts\mp\utility\game::round_vehicle_logic();

    switch ( var_2 )
    {
        case "mini":
        case "gold_war":
        case "risk":
        case "rat_race":
        case "dmz":
            var_0 = 1;
            break;
    }

    return var_0;
}

completescavengerquest( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_3 = scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team );
    var_4 = scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger" + self.modifier );
    var_5 = scripts\mp\gametypes\br_quest_util.gsc::rewardtovalue( scripts\mp\gametypes\br_quest_util.gsc::rewardtotype( "scavenger", self.modifier ) );
    var_6 = scripts\mp\gametypes\br_alt_mode_bblitz.gsc::clear_all_remaining( var_1 );
    var_2._id_121B5 = scripts\mp\gametypes\br_quest_util.gsc::_id_121B9( var_4, var_3, var_5, undefined, var_6 );

    if ( !scripts\mp\gametypes\br_public.gsc::validtousesticker() )
    {
        scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_quest_complete", var_2 );
        level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_scav_success", self.team, 1, 1 );
    }

    self._id_12D2E = var_0.origin;
    self._id_12D2B = var_0.angles;
    self.result = "success";
    scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
}

failscavengerquest()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_quest_circle_failure" );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_obj_circle_fail", self.team, 1 );
    self.result = "fail";
    scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
}

_id_14016()
{
    foreach ( var_1 in self.playerlist )
        var_1 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivesetparameter( self._id_12320 );

    var_3 = scripts\mp\gametypes\br_quest_util.gsc::sortvalidplayersinarray( self.playerlist );

    foreach ( var_1 in var_3["valid"] )
    {
        var_1 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "scavenger" + self.modifier );
        scripts\mp\gametypes\br_quest_util.gsc::_id_1336C( var_1 );
    }

    foreach ( var_1 in var_3["invalid"] )
    {
        var_1 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
        scripts\mp\gametypes\br_quest_util.gsc::spawn_downed_friendly( var_1 );
    }
}

spawn_dwn_twn_enemy_sentry( var_0 )
{
    scripts\mp\gametypes\br_quest_util.gsc::spawn_downed_friendly( var_0 );
    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
}

lastdroppableweaponchanged()
{
    foreach ( var_1 in self.playerlist )
        spawn_dwn_twn_enemy_sentry( var_1 );

    scripts\mp\gametypes\br_quest_util.gsc::lastdropedtime();
}

_id_13723()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_quest_timer_expired" );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_gen_fail", self.team, 1 );
}

_id_13698( var_0, var_1, var_2 )
{
    var_3 = spawn( "script_model", var_0 );
    var_4 = var_2.playerlist[0];
    var_3.angles = var_1;
    var_3 setotherent( var_4 );
    var_3 setmodel( "military_loot_crate_scavenger_ch3" );
    var_3 setscriptablepartstate( "body", "scavenger_closed" );
    var_3.questlocale = var_2;
    var_2.force_spawn_all_dead_players = var_3;

    foreach ( var_6 in level.players )
    {
        if ( var_6 != var_4 && ( var_4.team == "none" || var_6.team != var_4.team ) )
            var_3 disablescriptableplayeruse( var_6 );
    }
}

_id_12ED4( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_3 scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "playerSkipLootPickup", var_0 ) ) )
        return;

    if ( var_2 == "scavenger_closed" && isdefined( var_0.entity ) )
    {
        var_5 = var_0.entity.questlocale.subscribedinstances[0];

        if ( var_3.team != var_5.team )
        {
            var_3 iprintlnbold( "Chest Requires a Scavenger Mission" );
            return;
        }

        var_0 setscriptablepartstate( "body", "scavenger_opening" );
        var_6 = getdvarint( "scr_br_scavenger_cacheDeleteDelay", 30 );
        var_0.entity scripts\engine\utility::delaycallwatchself( var_6, ::delete );
        var_5 scripts\mp\gametypes\br_quest_util.gsc::_id_12B15( var_3 );

        switch ( var_0.entity.questlocale._id_12320 )
        {
            case 0:
                scripts\mp\gametypes\br_quest_util.gsc::search_activate_battle_station( "scavenger_1" + var_5.modifier, var_3.team, var_0.origin, var_0.angles, var_5._id_12D30 );
                break;
            case 1:
                scripts\mp\gametypes\br_quest_util.gsc::search_activate_battle_station( "scavenger_2" + var_5.modifier, var_3.team, var_0.origin, var_0.angles, var_5._id_12D30 );
                break;
            case 3:
                break;
        }

        var_7 = scripts\engine\utility::ter_op( isdefined( var_5._id_11C4E ), var_5._id_11C4E, "?" );

        if ( var_0.entity.questlocale._id_12320 == 2 )
        {
            var_5._id_12D2E = var_0.origin;
            var_5._id_12D2B = var_0.angles;
            scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_5.team, var_3, 8, scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger" ) );
            var_5 completescavengerquest( var_0.entity, var_3 );
            logstring( "Scavenger Debug: " + var_7 + " - complete - " + var_0.origin );
        }
        else
        {
            logstring( "Scavenger Debug: " + var_7 + " - move - " + var_0.origin );
            scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_5.team, var_3, 7, scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger" ) );
            var_8 = _id_11A00( var_0.origin, var_5._id_12C4A[var_0.entity.questlocale._id_12320 + 1] );
            var_8._id_11C4E = var_5._id_11C4E;
            var_0.entity.questlocale scripts\mp\gametypes\br_quest_util.gsc::_id_11DAF( "scavenger_locale", var_8 );
        }

        level notify( "lootcache_opened_kill_callout" + var_0.origin );
        var_9 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var_3.team, 0 );

        foreach ( var_11 in var_9 )
            var_11 notify( "calloutmarkerping_warzoneKillQuestIcon" );
    }
}

_id_13730()
{
    self._id_12C4A = [];
    var_0 = self.origin;

    for ( var_1 = 0; var_1 < 3; var_1++ )
    {
        var_2 = _id_11A00( var_0 );
        var_3 = scripts\mp\gametypes\br_quest_util.gsc::play_train_speaker_vo( "scavenger", var_2 );

        if ( !isdefined( var_3 ) )
            return 0;

        getlootspawnpointcount( var_3.index );
        var_0 = var_3.origin;
        self._id_12C4A[var_1] = var_3;
    }

    return 1;
}
