// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\engine\scriptable::_id_12F5B( "body", ::_id_12ED6 );
    var_0 = scripts\mp\gametypes\br_quest_util.gsc::registerquestcategory( "scavenger_soa_tower", 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2A( "scavenger_soa_tower", "brloot_scavenger_tablet_soa_tower" );

    if ( !var_0 )
        return;

    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_12FA0 = getdvarint( "scr_br_SOATower_searchCircleSize", 1000 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_11C4C = getdvarint( "scr_br_SOATower_missionTimeBase", 300 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_11C4D = getdvarint( "scr_br_SOATower_missionTimeBonus", 60 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_12C83 = getdvarint( "scr_br_SOATower_resetTimerOnPickup", 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B3D( "scavenger_soa_tower", ::_id_13732 );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "scavenger_soa_tower", ::_id_1372C );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2E( "scavenger_soa_tower", ::_id_13728 );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestlocale( "scavenger_locale_soa_tower" );
    scripts\mp\gametypes\br_quest_util.gsc::registercreatequestlocale( "scavenger_locale_soa_tower", ::_id_1371C );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2B( "scavenger_locale_soa_tower", ::_id_13722 );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "scavenger_locale_soa_tower", ::_id_1372A );
    scripts\mp\gametypes\br_quest_util.gsc::registercheckiflocaleisavailable( "scavenger_locale_soa_tower", ::_id_13718 );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestcircletick( "scavenger_locale_soa_tower", ::_id_1371A );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2D( "scavenger_locale_soa_tower", ::_id_1371F );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B30( "scavenger_locale_soa_tower", ::_id_1372F );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1297C( "scavenger_soa_tower", 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B31( "scavenger_soa_tower", ::_id_13725 );
    var_1 = [];
    var_1[0] = scripts\mp\gametypes\br_quest_util.gsc::filtercondition_isdead;
    scripts\mp\gametypes\br_quest_util.gsc::registerplayerfilter( "scavenger_soa_tower", var_1 );
    level thread _id_13463();
}

_id_13463()
{
    level waittill( "prematch_fade_done" );
    streakdeploy_playtabletdeploydialog();
    _id_13465( ( 19934, -12275, -174 ) );
    _id_13465( ( 18431, -16469, -102 ) );
    _id_13465( ( 19912, -16488, -88 ) );
}

_id_13465( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::_id_135DF( "scavenger_soa_tower", scripts\engine\utility::drop_to_ground( var_0, 0, -100, ( 0, 0, 1 ) ) + ( 0, 0, 25 ), 0 );
    scripts\mp\gametypes\br_pickups.gsc::_id_12B3A( var_1 );
}

_id_1372C()
{
    scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( self.team );
}

_id_13728( var_0 )
{
    if ( var_0.team == self.team )
    {
        var_1 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
        scripts\mp\gametypes\br_quest_util.gsc::getquestinstancedata( "scavenger_locale_soa_tower", self.team ).playerlist = var_1;

        if ( isdefined( self._id_1393B ) && isdefined( self._id_1393B.force_spawn_all_dead_players ) && var_1.size )
            self._id_1393B.force_spawn_all_dead_players setotherent( var_1[0] );

        if ( !scripts\mp\gametypes\br_quest_util.gsc::isteamvalid( var_0.team ) )
        {
            self.result = "fail";
            scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
        }
    }
}

_id_1371F( var_0 )
{
    if ( !gethost( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
    scripts\mp\gametypes\br_quest_util.gsc::spawn_downed_friendly( var_0 );
}

_id_1372F( var_0 )
{
    if ( !gethost( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "scavenger_soa_tower" );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1336C( var_0 );
}

gethost( var_0 )
{
    if ( var_0.team == self.subscribedinstances[0].team )
        return 1;
    else
        return 0;
}

_id_1371C( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::createlocaleinstance( "scavenger_locale_soa_tower", "scavenger_soa_tower", self.team );

    if ( !isdefined( var_0 ) )
    {
        var_1.curorigin = ( 0, 0, 0 );
        var_1.enabled = 0;
        return var_1;
    }

    var_1 scripts\mp\gametypes\br_quest_util.gsc::init_tape_machine_animations( "ui_mp_br_mapmenu_icon_vault_objective", "current" );
    var_1.playerlist = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    var_1._id_12320 = 0;
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "scavenger_locale_soa_tower", var_1 );
    var_1 _id_1325A( var_0 );
    return var_1;
}

_id_13722( var_0 )
{
    self._id_12320++;
    var_1 = _id_1325A( var_0 );

    if ( var_1 )
    {
        self.subscribedinstances[0].intelprogress = var_0.origin;
        scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.subscribedinstances[0].team, "br_scavenger_soa_tower_quest_next_location" );
        level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_obj_next_nptarget", self.subscribedinstances[0].team, 1 );

        if ( istrue( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_12C83 ) )
            self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util.gsc::_id_1297D( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_11C4C, 1 );
        else
            self.subscribedinstances[0] scripts\mp\gametypes\br_quest_util.gsc::_id_1297B( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_11C4D );
    }
}

_id_1325A( var_0 )
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
    _id_14016();
    return 1;
}

_id_1372A()
{
    lastdroppableweaponchanged();
    self.playerlist = undefined;
    self.subscribedinstances = undefined;

    if ( isdefined( self.force_spawn_all_dead_players ) )
    {
        if ( self.force_spawn_all_dead_players getscriptablepartstate( "body" ) == "scavenger_soa_tower_closed" )
            self.force_spawn_all_dead_players delete();
    }
}

_id_1371A( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_1 ) )
        return;

    if ( !isdefined( self.curorigin ) )
        return;

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

_id_13718()
{
    return 0;
}

takequestitem( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::createquestinstance( "scavenger_soa_tower", self.team, var_0.index, var_0 );
    var_1 scripts\mp\gametypes\br_quest_util.gsc::registerteamonquest( self.team, self );
    var_1 scripts\mp\gametypes\br_quest_util.gsc::_id_12B15( self );
    var_1.team = self.team;
    var_1.playerlist = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    var_1.startlocation = self.origin;
    var_1.intelprogress = self.origin;
    var_1._id_12C4A = var_0._id_12C4A;
    var_2 = _id_11A00( var_1.startlocation, var_1._id_12C4A[0] );
    var_3 = var_1 scripts\mp\gametypes\br_quest_util.gsc::requestquestlocale( "scavenger_locale_soa_tower", var_2, 1 );
    scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshowtoteam( "scavenger_soa_tower", self.team );
    var_1.totalscavengeditems = 0;
    var_1 scripts\mp\gametypes\br_quest_util.gsc::_id_1297D( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "scavenger_soa_tower" )._id_11C4C, 4 );
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "scavenger_soa_tower", var_1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_13879( "scavenger_soa_tower", self, self.team );
    var_4 = spawnstruct();
    var_4.excludedplayers = [];
    var_4.excludedplayers[0] = self;
    var_4._id_127D5 = scripts\mp\gametypes\br_quest_util.gsc::rewardmodifier( "scavenger_soa_tower", scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team ) );
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_soa_tower_quest_start_team", var_4 );
    scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( self, "br_scavenger_soa_tower_quest_start_tablet_finder", var_4 );

    if ( !scripts\mp\gametypes\br_public.gsc::validtousesticker() )
        scripts\mp\gametypes\br_quest_util.gsc::searchfunc( self.team, "br_mission_pickup_tablet" );

    scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_1.team, self, 6, scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger_soa_tower" ) );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_gen_accept", var_1.team, 1 );
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
    var_1 = scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "overrideQuestSearchParams", "scavenger_soa_tower" );

    if ( isdefined( var_1 ) )
        return var_1;

    var_2 = scripts\mp\utility\game::round_vehicle_logic();

    switch ( var_2 )
    {
        case "mini":
        case "risk":
        case "rat_race":
        case "dmz":
            var_0 = 1;
            break;
    }

    return var_0;
}

hint_target_think( var_0 )
{
    var_1 = easepower( "brloot_access_card_gold_vault_lockbox_1", var_0.origin + ( 0, 0, 20 ) );
    scripts\mp\gametypes\br_pickups.gsc::_id_12B3A( var_1 );
    playsoundatpos( var_1.origin, "br_legendary_loot_drop" );
    var_2 = spawnstruct();
    var_3 = scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team );
    var_4 = scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger_soa_tower" );
    var_5 = scripts\mp\gametypes\br_quest_util.gsc::rewardtovalue( scripts\mp\gametypes\br_quest_util.gsc::rewardtotype( "scavenger_soa_tower" ) );
    var_2._id_121B5 = scripts\mp\gametypes\br_quest_util.gsc::_id_121B9( var_4, var_3, var_5 );

    foreach ( var_7 in self.playerlist )
    {
        if ( isdefined( var_7 ) && getdvarint( "MLNNMOPQOP", 0 ) == 6 )
            var_7 scripts\cp\vehicles\vehicle_compass_cp::_id_12C3F( "t9_ch_global_complete_side_mission_for_s3_5_event_wz", 1 );
    }

    if ( !scripts\mp\gametypes\br_public.gsc::validtousesticker() )
    {
        scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_soa_tower_quest_complete", var_2 );
        level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_misc_success", self.team, 1, 1 );
    }

    self._id_12D2E = var_0.origin;
    self._id_12D2B = var_0.angles;
    self.result = "success";
    scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
}

failscavengerquest()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_soa_tower_quest_circle_failure" );
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
        var_1 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "scavenger_soa_tower" );
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

_id_13725()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_scavenger_soa_tower_quest_timer_expired" );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_gen_fail", self.team, 1 );
}

_id_13698( var_0, var_1, var_2 )
{
    var_3 = _id_129F6();
    var_0 = var_3.origin;
    var_1 = var_3.angles;
    var_4 = spawn( "script_model", var_0 );
    var_5 = var_2.playerlist[0];
    var_4.angles = var_1;
    var_4 setotherent( var_5 );
    var_4 setmodel( "military_loot_crate_01_br_scavenger_01_soa_tower" );
    var_4 setscriptablepartstate( "body", "scavenger_soa_tower_closed" );
    var_4.questlocale = var_2;
    var_2.force_spawn_all_dead_players = var_4;
    var_2 scripts\mp\gametypes\br_quest_util.gsc::_id_11DB0( var_3.origin + ( 0, 0, 50 ) );

    foreach ( var_7 in level.players )
    {
        if ( var_7 != var_5 && ( var_5.team == "none" || var_7.team != var_5.team ) )
            var_4 disablescriptableplayeruse( var_7 );
    }
}

streakdeploy_playtabletdeploydialog()
{
    level.areanygulagfightsactive = [];
    level.areanygulagfightsactive[0] = [];
    level.areanygulagfightsactive[1] = [];
    level.areanygulagfightsactive[2] = [];
    level.areanygulagfightsactive[0][0] = strafereverse_cleanup( scripts\engine\utility::drop_to_ground( ( 20355, -14236, -22 ), 0, -100, ( 0, 0, 1 ) ), ( 0, 180, 0 ) );
    level.areanygulagfightsactive[0][1] = strafereverse_cleanup( scripts\engine\utility::drop_to_ground( ( 20915, -14865, -22 ), 0, -100, ( 0, 0, 1 ) ), ( 0, 90, 0 ) );
    level.areanygulagfightsactive[0][2] = strafereverse_cleanup( scripts\engine\utility::drop_to_ground( ( 19789, -13962, -22 ), 0, -100, ( 0, 0, 1 ) ), ( 0, 0, 0 ) );
    level.areanygulagfightsactive[1][0] = strafereverse_cleanup( scripts\engine\utility::drop_to_ground( ( 19656, -14016, 298 ), 0, -100, ( 0, 0, 1 ) ), ( 0, 180, 0 ) );
    level.areanygulagfightsactive[1][1] = strafereverse_cleanup( scripts\engine\utility::drop_to_ground( ( 20346, -15735, 298 ), 0, -100, ( 0, 0, 1 ) ), ( 0, 45, 0 ) );
    level.areanygulagfightsactive[1][2] = strafereverse_cleanup( ( 20900, -14194, 241 ), ( 0, 90, 0 ) );
    level.areanygulagfightsactive[2][0] = strafereverse_cleanup( scripts\engine\utility::drop_to_ground( ( 19699, -13932, 437 ), 0, -100, ( 0, 0, 1 ) ), ( 0, 90, 0 ) );
    level.areanygulagfightsactive[2][1] = strafereverse_cleanup( ( 20072, -15288, 387 ), ( 0, 0, 0 ) );
    level.areanygulagfightsactive[2][2] = strafereverse_cleanup( scripts\engine\utility::drop_to_ground( ( 20500, -15233, 442 ), 0, -100, ( 0, 0, 1 ) ), ( 0, 270, 0 ) );
}

strafereverse_cleanup( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.origin = var_0;
    var_2.angles = var_1;
    return var_2;
}

_id_129F6()
{
    var_0 = randomint( level.areanygulagfightsactive[self._id_12320].size );
    var_1 = level.areanygulagfightsactive[self._id_12320][var_0];
    level.areanygulagfightsactive[self._id_12320] = scripts\engine\utility::array_remove( level.areanygulagfightsactive[self._id_12320], var_1 );
    return var_1;
}

_id_12ED6( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_3 scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "playerSkipLootPickup", var_0 ) ) )
        return;

    if ( var_2 == "scavenger_soa_tower_closed" && isdefined( var_0.entity ) )
    {
        var_5 = var_0.entity.questlocale.subscribedinstances[0];

        if ( var_3.team != var_5.team )
        {
            var_3 iprintlnbold( "Chest Requires a Scavenger Mission" );
            return;
        }

        var_0 setscriptablepartstate( "body", "scavenger_soa_tower_opening" );
        var_6 = getdvarint( "scr_br_scavenger_cacheDeleteDelay", 30 );
        var_0.entity scripts\engine\utility::delaycallwatchself( var_6, ::delete );
        var_5 scripts\mp\gametypes\br_quest_util.gsc::_id_12B15( var_3 );

        switch ( var_0.entity.questlocale._id_12320 )
        {
            case 0:
                var_0.entity _id_13464();
                break;
            case 1:
                var_0.entity _id_13464();
                break;
            case 3:
                break;
        }

        if ( var_0.entity.questlocale._id_12320 == 2 )
        {
            var_5._id_12D2E = var_0.origin;
            var_5._id_12D2B = var_0.angles;
            scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_5.team, var_3, 8, scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger_soa_tower" ) );
            var_5 hint_target_think( var_0.entity );
        }
        else
        {
            scripts\mp\gametypes\br_quest_util.gsc::lookforvehicles( var_5.team, var_3, 7, scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "scavenger_soa_tower" ) );
            var_7 = _id_11A00( var_0.origin, var_5._id_12C4A[var_0.entity.questlocale._id_12320 + 1] );
            var_0.entity.questlocale scripts\mp\gametypes\br_quest_util.gsc::_id_11DAF( "scavenger_locale_soa_tower", var_7 );
        }

        level notify( "lootcache_opened_kill_callout" + var_0.origin );
        var_8 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var_3.team, 0 );

        foreach ( var_10 in var_8 )
            var_10 notify( "calloutmarkerping_warzoneKillQuestIcon" );
    }
}

_id_13464()
{
    var_0 = [ "weapon", "lethal", "ammo", "plunder" ];
    var_0 = scripts\engine\utility::array_randomize( var_0 );
    var_1 = var_0.size;
    var_2 = "mp/loot/br/bodycount/lootset_root.csv";
    var_3 = scripts\mp\gametypes\br_pickups.gsc::test_ai_anim();

    for ( var_4 = 0; var_4 < var_1; var_4++ )
    {
        var_5 = registerscriptedspawnpoints( var_0[var_4], 0, 3, var_2 );

        if ( scripts\mp\gametypes\br_lootcache.gsc::get_bonus_targets( var_5 ) )
        {
            var_6 = self.angles + ( 0, 45, 0 );
            scripts\mp\gametypes\br_lootcache.gsc::_id_11A41( var_5, var_3, self.origin, var_6, undefined, 0 );
        }
    }
}

_id_13732()
{
    self._id_12C4A = [];
    var_0 = self.origin;

    for ( var_1 = 0; var_1 < 3; var_1++ )
    {
        var_2 = _id_11A00( var_0 );
        var_3 = scripts\mp\gametypes\br_quest_util.gsc::play_train_speaker_vo( "scavenger_soa_tower", var_2 );

        if ( !isdefined( var_3 ) )
            return 0;

        getlootspawnpointcount( var_3.index );
        var_0 = var_3.origin;
        self._id_12C4A[var_1] = var_3;
    }

    return 1;
}