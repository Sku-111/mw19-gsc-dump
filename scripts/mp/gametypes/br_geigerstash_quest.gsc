// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\engine\scriptable::_id_12F5B( "body", ::postspawn_rpg );
    var_0 = scripts\mp\gametypes\br_quest_util.gsc::registerquestcategory( "geigerstash", 1 );

    if ( !var_0 )
        return;

    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "geigerstash" )._id_12FA0 = getdvarint( "scr_br_geigerstash_searchCircleSize", 7000 );
    scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "geigerstash" )._id_11C4C = getdvarint( "scr_br_geigerstash_missionTimeBase", 180 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B3D( "geigerstash", ::postspawn_sniper );
    scripts\mp\gametypes\br_quest_util.gsc::registerremovequestinstance( "geigerstash", ::postspawn_assault3_bombers );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2E( "geigerstash", ::postplunder );
    scripts\mp\gametypes\br_quest_util.gsc::registerquestcircletick( "geigerstash", ::postgamestate );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B2D( "geigerstash", ::postkillcamplunderlost );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B30( "geigerstash", ::postspawn_initial_allies );
    scripts\mp\gametypes\br_quest_util.gsc::_id_1297C( "geigerstash", 1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_12B31( "geigerstash", ::postlaunchscenenodecorrection );
}

postspawn_sniper()
{
    var_0 = self.origin;
    var_1 = _id_11A00( var_0 );
    var_2 = scripts\mp\gametypes\br_quest_util.gsc::play_train_speaker_vo( "geigerstash", var_1 );

    if ( !isdefined( var_2 ) )
        return 0;

    getlootspawnpointcount( var_2.index );
    var_0 = var_2.origin;
    self._id_12C4A = var_2;
    return 1;
}

postgamestate( var_0, var_1 )
{
    if ( !isdefined( self.lastcircletick ) )
        self.lastcircletick = -1;

    var_2 = gettime();

    if ( self.lastcircletick == var_2 )
        return;

    self.lastcircletick = var_2;
    var_3 = distance2d( self.curorigin, var_0 );

    if ( var_3 > var_1 )
        pathstruct();
}

postkillcamplunderlost( var_0 )
{
    if ( !gethillspawnshutofforigin( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
}

postspawn_initial_allies( var_0 )
{
    if ( !gethillspawnshutofforigin( var_0 ) )
        return;

    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "geigerstash" );
}

postlaunchscenenodecorrection()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_geigerstash_quest_timer_expired" );
    var_0 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( self.team, 0 );
    postshipmodifychevrons( var_0 );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_gen_fail", self.team, 1 );
}

postshipmodifychevrons( var_0 )
{
    var_1 = "secondary";
    var_2 = "equip_geiger_counter";
    var_0[0] scripts\mp\equipment::_id_13A30( var_0, var_1, var_2, 0 );

    foreach ( var_4 in var_0 )
    {
        if ( isdefined( var_4.modespawnclient ) )
            scripts\mp\gametypes\br_pickups.gsc::_id_11A21( var_4.modespawnclient );
    }
}

postspawn_assault3_bombers()
{
    lastboredscore();

    foreach ( var_1 in self.playerlist )
        var_1 setclientomnvar( "ui_br_geiger_target", -1 );

    scripts\mp\gametypes\br_quest_util.gsc::releaseteamonquest( self.team );
}

postplunder( var_0 )
{
    if ( var_0.team == self.team )
    {
        var_1 = scripts\mp\utility\teams::getteamdata( self.team, "players" );
        scripts\mp\gametypes\br_quest_util.gsc::getquestinstancedata( "geigerstash", self.team ).playerlist = var_1;

        if ( isdefined( self ) && isdefined( self.force_spawn_all_dead_players ) && var_1.size )
            self.force_spawn_all_dead_players setotherent( var_1[0] );

        if ( !scripts\mp\gametypes\br_quest_util.gsc::isteamvalid( var_0.team ) )
        {
            self.result = "fail";
            scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
        }
    }
}

gethillspawnshutofforigin( var_0 )
{
    if ( var_0.team == self.team )
        return 1;
    else
        return 0;
}

takequestitem( var_0 )
{
    var_1 = scripts\mp\gametypes\br_quest_util.gsc::createquestinstance( "geigerstash", self.team, var_0.index, var_0 );
    var_1 scripts\mp\gametypes\br_quest_util.gsc::registerteamonquest( self.team, self );
    var_1 scripts\mp\gametypes\br_quest_util.gsc::_id_12B15( self );
    var_1.team = self.team;
    var_1.startlocation = self.origin;
    var_1.intelprogress = self.origin;
    var_1._id_12C4A = var_0._id_12C4A;
    var_1.playerlist = scripts\mp\utility\teams::getteamdata( self.team, "players" );
    var_2 = _id_11A00( var_1.startlocation, var_1._id_12C4A );
    var_1 _id_13659( var_1._id_12C4A.origin, var_1._id_12C4A.angles );
    var_1 _id_13FDC();
    scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshowtoteam( "geigerstash", self.team );
    var_1 scripts\mp\gametypes\br_quest_util.gsc::_id_1297D( scripts\mp\gametypes\br_quest_util.gsc::getquestdata( "geigerstash" )._id_11C4C, 4 );
    scripts\mp\gametypes\br_quest_util.gsc::addquestinstance( "geigerstash", var_1 );
    scripts\mp\gametypes\br_quest_util.gsc::_id_13879( "geigerstash", self, self.team );
    var_3 = spawnstruct();
    var_3.excludedplayers = [];
    var_3.excludedplayers[0] = self;
    var_3._id_127D5 = scripts\mp\gametypes\br_quest_util.gsc::rewardmodifier( "geigerstash", scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team ) );
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_geigerstash_quest_start_team_notify", var_3 );
    scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( self, "br_geigerstash_quest_start_tablet_finder", var_3 );
    scripts\mp\gametypes\br_quest_util.gsc::searchfunc( self.team, "br_mission_pickup_tablet" );
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
    var_2.mintime = 60;

    if ( getdvar( "scr_br_gametype", "" ) == "dmz" || getdvar( "scr_br_gametype", "" ) == "rat_race" )
    {
        if ( var_2._id_12FA6 < level._id_12969 )
            var_2._id_12FA6 = level._id_12969;

        var_2._id_12FA4 = level._id_12969;
        var_2._id_12FA5 = level._id_1296A;
    }

    return var_2;
}

_id_13659( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0 );
    var_3 = self.playerlist[0];
    var_2.angles = var_1;
    var_2 setotherent( var_3 );
    var_2 setmodel( "military_loot_crate_01_br_geigerstash_01" );
    var_2 setscriptablepartstate( "body", "geigerstash_closed" );
    var_2._id_12970 = self;
    self.force_spawn_all_dead_players = var_2;
    var_2._id_12970.curorigin = var_2.origin;

    foreach ( var_5 in level.players )
    {
        if ( var_5 != var_3 && ( var_3.team == "none" || var_5.team != var_3.team ) )
            var_2 disablescriptableplayeruse( var_5 );
    }

    var_7 = "secondary";
    var_8 = "equip_geiger_counter";
    self.playerlist[0] scripts\mp\equipment::scriptablescleanupbatchsize( self.playerlist, var_7, var_8 );
    var_9 = self.force_spawn_all_dead_players getentitynumber();

    foreach ( var_5 in self.playerlist )
        var_5 setclientomnvar( "ui_br_geiger_target", var_9 );
}

_id_13FDC()
{
    var_0 = scripts\mp\gametypes\br_quest_util.gsc::sortvalidplayersinarray( self.playerlist );

    foreach ( var_2 in var_0["valid"] )
        var_2 scripts\mp\gametypes\br_quest_util.gsc::uiobjectiveshow( "geigerstash" );

    foreach ( var_2 in var_0["invalid"] )
        var_2 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
}

spawn_carriables_from_scriptables_individual_percentage( var_0 )
{
    var_0 scripts\mp\gametypes\br_quest_util.gsc::uiobjectivehide();
}

lastboredscore()
{
    foreach ( var_1 in self.playerlist )
        spawn_carriables_from_scriptables_individual_percentage( var_1 );
}

postspawn_rpg( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_3 scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "playerSkipLootPickup", var_0 ) ) )
        return;

    if ( var_2 == "geigerstash_closed" && isdefined( var_0.entity ) )
    {
        var_5 = var_0.entity._id_12970;

        if ( istrue( var_5.removed ) )
        {
            var_3 scripts\mp\utility\lower_message::_id_1316E( "contract_expired", undefined, 5 );
            return;
        }

        var_0 setscriptablepartstate( "body", "geigerstash_opening" );
        var_6 = getdvarint( "scr_br_geigerstash_cacheDeleteDelay", 30 );
        var_0.entity scripts\engine\utility::delaycallwatchself( var_6, ::delete );
        var_5._id_12D2E = var_0.origin;
        var_5._id_12D2B = var_0.angles;
        var_5 hint_escape_maze( var_0.entity );
        level notify( "lootcache_opened_kill_callout" + var_0.origin );
        var_7 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "getFriendlyPlayers" ) ]]( var_3.team, 0 );

        foreach ( var_9 in var_7 )
            var_9 notify( "calloutmarkerping_warzoneKillQuestIcon" );

        postshipmodifychevrons( var_7 );
    }
}

hint_escape_maze( var_0 )
{
    var_1 = spawnstruct();
    var_2 = scripts\mp\gametypes\br_quest_util.gsc::ringing( self.team );
    var_3 = scripts\mp\gametypes\br_quest_util.gsc::getquestindex( "geigerstash" );
    var_4 = scripts\mp\gametypes\br_quest_util.gsc::rewardtovalue( scripts\mp\gametypes\br_quest_util.gsc::rewardtotype( "geigerstash" ) );
    var_1._id_121B5 = scripts\mp\gametypes\br_quest_util.gsc::_id_121B9( var_3, var_2, var_4 );
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_geigerstash_quest_complete", var_1 );
    self._id_12D2E = var_0.origin;
    self._id_12D2B = var_0.angles;
    self.result = "success";

    foreach ( var_6 in self.playerlist )
        var_6 setclientomnvar( "ui_br_geiger_target", -1 );

    scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();

    foreach ( var_6 in scripts\mp\utility\teams::getteamdata( self.team, "players" ) )
        var_6 scripts\cp\vehicles\vehicle_compass_cp::_id_12004( "br_geiger_contract" );
}

pathstruct()
{
    scripts\mp\gametypes\br_quest_util.gsc::displayteamsplash( self.team, "br_geigerstash_quest_circle_failure" );
    level thread scripts\mp\gametypes\br_public.gsc::dmztut_luicallback( "mission_obj_circle_fail", self.team, 1 );
    self.result = "fail";

    foreach ( var_1 in self.playerlist )
        var_1 setclientomnvar( "ui_br_geiger_target", -1 );

    scripts\mp\gametypes\br_quest_util.gsc::removequestinstance();
}