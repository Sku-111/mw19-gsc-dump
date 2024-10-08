// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    scripts\mp\globallogic::init();
    scripts\mp\globallogic::setupcallbacks();
    var_0[0] = scripts\mp\utility\game::getgametype();
    scripts\mp\gameobjects::main( var_0 );

    if ( isusingmatchrulesdata() )
    {
        level.initializematchrules = ::initializematchrules;
        [[ level.initializematchrules ]]();
        level thread scripts\mp\utility\game::reinitializematchrulesonmigration();
    }
    else
    {
        scripts\mp\utility\game::registertimelimitdvar( scripts\mp\utility\game::getgametype(), 600 );
        scripts\mp\utility\game::registerscorelimitdvar( scripts\mp\utility\game::getgametype(), 30 );
        scripts\mp\utility\game::registerwinlimitdvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registerroundlimitdvar( scripts\mp\utility\game::getgametype(), 1 );
        scripts\mp\utility\game::registernumlivesdvar( scripts\mp\utility\game::getgametype(), 0 );
        scripts\mp\utility\game::registerhalftimedvar( scripts\mp\utility\game::getgametype(), 0 );
    }

    updategametypedvars();
    level.onstartgametype = ::onstartgametype;
    level.onplayerconnect = ::onplayerconnect;
    level.getspawnpoint = ::getspawnpoint;
    level.modeonspawnplayer = ::onspawnplayer;
    level.onnormaldeath = ::onnormaldeath;
    level.onplayerscore = ::onplayerscore;
    level.didhalfscorevoboost = 0;
    setteammode( "ffa" );

    if ( istrue( level.aonrules ) )
    {
        scripts\mp\gametypes\common.gsc::bearsred();
        level.bypassclasschoicefunc = ::alwaysgamemodeclass;
        setomnvarforallclients( "ui_skip_loadout", 1 );
        setspecialloadout();
        game["dialog"]["gametype"] = "gametype_aon";
    }
    else
        game["dialog"]["gametype"] = "gametype_ffa";

    if ( getdvarint( "OSMSLRTOP" ) )
        game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
    else if ( getdvarint( "NOSLRNTRKL" ) )
        game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];

    game["dialog"]["ffa_lead_first"] = "gamestate_lead";
    game["dialog"]["ffa_lead_second"] = "gamestate_second";
    game["dialog"]["ffa_lead_third"] = "gamestate_third";
    game["dialog"]["ffa_lead_last"] = "gamestate_last";
    game["dialog"]["offense_obj"] = "hint_killall";
    game["dialog"]["defense_obj"] = "hint_ffa";
}

alwaysgamemodeclass()
{
    return "gamemode";
}

initializematchrules()
{
    scripts\mp\utility\game::setcommonrulesfrommatchrulesdata( 1 );
    setdynamicdvar( "scr_dm_aonrules", getmatchrulesdata( "dmData", "aonRules" ) );
    setdynamicdvar( "scr_dm_scoreontargetplayer", getmatchrulesdata( "dmData", "scoreOnTargetPlayer" ) );
    setdynamicdvar( "scr_dm_targetplayercycle", getmatchrulesdata( "dmData", "targetPlayerCycle" ) );
    setdynamicdvar( "scr_dm_showtargettime", getmatchrulesdata( "dmData", "showTargetTime" ) );
    setdynamicdvar( "scr_dm_winlimit", 1 );
    scripts\mp\utility\game::registerwinlimitdvar( "dm", 1 );
    setdynamicdvar( "scr_dm_roundlimit", 1 );
    scripts\mp\utility\game::registerroundlimitdvar( "dm", 1 );
    setdynamicdvar( "scr_dm_halftime", 0 );
    scripts\mp\utility\game::registerhalftimedvar( "dm", 0 );
}

onstartgametype()
{
    setclientnamemode( "auto_change" );

    foreach ( var_1 in level.teamnamelist )
    {
        scripts\mp\utility\game::setobjectivetext( var_1, &"OBJECTIVES/DM" );

        if ( level.splitscreen )
            scripts\mp\utility\game::setobjectivescoretext( var_1, &"OBJECTIVES/DM" );
        else
            scripts\mp\utility\game::setobjectivescoretext( var_1, &"OBJECTIVES/DM_SCORE" );

        scripts\mp\utility\game::setobjectivehinttext( var_1, &"OBJECTIVES/DM_HINT" );
    }

    scripts\mp\spawnlogic::setactivespawnlogic( "FreeForAll", "Crit_Default" );
    level.spawnmins = ( 0, 0, 0 );
    level.spawnmaxs = ( 0, 0, 0 );
    scripts\mp\spawnlogic::addstartspawnpoints( "mp_dm_spawn_start", 1 );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_dm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "allies", "mp_dm_spawn_secondary", 1, 1 );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_dm_spawn" );
    scripts\mp\spawnlogic::addspawnpoints( "axis", "mp_dm_spawn_secondary", 1, 1 );
    var_3 = scripts\mp\spawnlogic::getspawnpointarray( "mp_dm_spawn" );
    var_4 = scripts\mp\spawnlogic::getspawnpointarray( "mp_dm_spawn_secondary" );
    scripts\mp\spawnlogic::registerspawnset( "dm", var_3 );
    scripts\mp\spawnlogic::registerspawnset( "dm_fallback", var_4 );
    level.mapcenter = scripts\mp\spawnlogic::findboxcenter( level.spawnmins, level.spawnmaxs );
    setmapcenter( level.mapcenter );
    level.quickmessagetoall = 1;
}

updategametypedvars()
{
    scripts\mp\gametypes\common.gsc::updatecommongametypedvars();
    level.aonrules = scripts\mp\utility\dvars::dvarintvalue( "aonRules", 0, 0, 4 );
    level.scoreontargetplayer = scripts\mp\utility\dvars::dvarintvalue( "scoreOnTargetPlayer", 0, 0, 1 );
    level.targetplayercycle = scripts\mp\utility\dvars::dvarintvalue( "targetPlayerCycle", 0, 0, 1 );
    level.showtargettime = scripts\mp\utility\dvars::dvarintvalue( "showTargetTime", 1, 0, 6 );

    switch ( level.showtargettime )
    {
        case 0:
            level.objpingdelay = 60.0;
            break;
        case 1:
            level.objpingdelay = 0.05;
            break;
        case 2:
            level.objpingdelay = 1.0;
            break;
        case 3:
            level.objpingdelay = 1.5;
            break;
        case 4:
            level.objpingdelay = 2.0;
            break;
        case 5:
            level.objpingdelay = 3.0;
            break;
        case 6:
            level.objpingdelay = 4.0;
            break;
    }

    if ( level.aonrules > 0 )
        level.blockweapondrops = 1;
    else
        level notify( "cancel_loadweapons" );
}

getspawnpoint()
{
    var_0 = undefined;

    if ( level.ingraceperiod )
    {
        var_1 = scripts\mp\spawnlogic::getspawnpointarray( "mp_dm_spawn_start" );

        if ( !isdefined( level.requiresminstartspawns ) )
        {

        }

        if ( var_1.size > 0 )
            var_0 = scripts\mp\spawnlogic::getspawnpoint_startspawn( var_1, 1 );

        if ( !isdefined( var_0 ) )
        {
            var_1 = scripts\mp\spawnlogic::getteamspawnpoints( self.team );
            var_0 = scripts\mp\spawnscoring::getstartspawnpoint_freeforall( var_1 );
        }
    }
    else
        var_0 = scripts\mp\spawnlogic::getspawnpoint( self, "none", "dm", "dm_fallback" );

    return var_0;
}

onspawnplayer()
{
    self setclientomnvar( "ui_match_status_hint_text", 0 );

    if ( level.aonrules > 0 )
        thread onspawnfinished();

    if ( level.scoreontargetplayer )
    {
        if ( !isdefined( self.targetvictim ) )
        {
            thread gettarget();
            thread newtargetmessage();
        }
    }

    level notify( "spawned_player" );
}

onnormaldeath( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    scripts\mp\gametypes\common.gsc::oncommonnormaldeath( var_0, var_1, var_2, var_3, var_4, var_5 );

    if ( level.aonrules > 0 )
    {

    }

    var_6 = 0;

    foreach ( var_8 in level.players )
    {
        if ( isdefined( var_8.score ) && var_8.score > var_6 )
            var_6 = var_8.score;
    }

    if ( !level.didhalfscorevoboost )
    {
        if ( var_1.score >= int( level.scorelimit * level.currentround - level.scorelimit / 2 ) )
            thread dohalftimevo( var_1 );
    }

    if ( var_1.score == level.scorelimit - 2 )
        level.kick_afk_check = 1;

    var_10 = var_1 scripts\mp\utility\stats::getpersstat( "killChains" );

    if ( isdefined( var_10 ) )
        var_1 scripts\mp\utility\stats::setextrascore1( var_10 );
}

onplayerscore( var_0, var_1, var_2, var_3 )
{
    var_1 scripts\mp\utility\stats::incpersstat( "gamemodeScore", var_2 );
    var_4 = int( var_1 scripts\mp\utility\stats::getpersstat( "gamemodeScore" ) );
    var_1 scripts\mp\persistence::statsetchild( "round", "gamemodeScore", var_4 );

    if ( var_1.pers["cur_kill_streak"] > var_1 scripts\mp\utility\stats::getpersstat( "killChains" ) )
    {
        var_1.pers["killChains"] = var_1.pers["cur_kill_streak"];
        var_1 scripts\mp\utility\stats::setextrascore1( var_1.pers["cur_kill_streak"] );
    }

    if ( issubstr( var_0, "super_" ) )
        return 0;

    if ( issubstr( var_0, "kill_ss" ) )
        return 0;

    if ( issubstr( var_0, "kill" ) )
    {
        if ( level.scoreontargetplayer )
        {
            if ( var_3 != var_1.targetvictim )
                return 0;
            else
            {
                var_1 notify( "target_eliminated" );
                var_1.targetvictim = undefined;
                var_1 thread gettarget();
                var_1 thread newtargetmessage();
            }
        }

        var_5 = scripts\mp\rank::getscoreinfovalue( "score_increment" );
        return var_5;
    }
    else if ( var_0 == "assist_ffa" )
        var_1 scripts\mp\utility\script::bufferednotify( "earned_score_buffered", var_2 );

    return 0;
}

dohalftimevo( var_0 )
{
    var_0 scripts\mp\utility\dialog::leaderdialogonplayer( "ffa_lead_first" );
    var_1 = scripts\engine\utility::array_sort_with_func( level.players, ::compare_player_score );

    if ( isdefined( var_1[1] ) )
        var_1[1] scripts\mp\utility\dialog::leaderdialogonplayer( "ffa_lead_second" );

    if ( isdefined( var_1[2] ) && var_1.size > 2 )
        var_1[2] scripts\mp\utility\dialog::leaderdialogonplayer( "ffa_lead_third" );

    if ( isdefined( var_1[var_1.size - 1] ) && var_1.size > 3 )
        var_1[var_1.size - 1] scripts\mp\utility\dialog::leaderdialogonplayer( "ffa_lead_last" );

    level.didhalfscorevoboost = 1;
}

compare_player_score( var_0, var_1 )
{
    return var_0.score >= var_1.score;
}

onspawnfinished()
{
    self endon( "death_or_disconnect" );
    self setclientomnvar( "ui_skip_loadout", 1 );
    self waittill( "giveLoadout" );
    runaonrules();
}

setspecialloadout()
{
    if ( scripts\mp\utility\game::matchmakinggame() )
    {
        var_0 = scripts\engine\utility::ter_op( randomintrange( 0, 99 ) > 50, "iw8_me_akimboblades", "iw8_knife" );

        if ( var_0 == "iw8_knife" )
            var_1 = 11;
        else
            var_1 = 0;

        if ( getdvarint( "scr_dm_randomAONMelee", 1 ) == 1 )
        {
            var_2 = randomintrange( 0, 99 );

            if ( var_2 > 75 )
            {
                var_0 = "iw8_me_akimboblunt";
                var_1 = 2;
            }
        }
    }
    else
    {
        switch ( level.aonrules )
        {
            case 1:
                var_0 = "iw8_knife";
                var_1 = 11;
                break;
            case 2:
                var_0 = "iw8_me_akimboblades";
                var_1 = 0;
                break;
            case 3:
                var_0 = "iw8_me_akimboblunt";
                var_1 = 2;
                break;
            default:
                var_0 = "iw8_knife";
                var_1 = 11;
                break;
        }
    }

    level.aon_loadouts["allies"]["loadoutPrimary"] = var_0;
    level.aon_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
    level.aon_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
    level.aon_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
    level.aon_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
    level.aon_loadouts["allies"]["loadoutPrimaryVariantID"] = var_1;
    level.aon_loadouts["allies"]["loadoutSecondary"] = "iw8_pi_golf21";
    level.aon_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
    level.aon_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
    level.aon_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
    level.aon_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
    level.aon_loadouts["allies"]["loadoutSecondaryVariantID"] = 1;
    level.aon_loadouts["allies"]["loadoutEquipmentPrimary"] = "equip_throwing_knife";
    level.aon_loadouts["allies"]["loadoutEquipmentSecondary"] = "none";
    level.aon_loadouts["allies"]["loadoutSuper"] = "none";
    level.aon_loadouts["allies"]["loadoutStreakType"] = "assault";
    level.aon_loadouts["allies"]["loadoutKillstreak1"] = "none";
    level.aon_loadouts["allies"]["loadoutKillstreak2"] = "none";
    level.aon_loadouts["allies"]["loadoutKillstreak3"] = "none";
    level.aon_loadouts["allies"]["loadoutUsingSpecialist"] = 1;
    level.aon_loadouts["allies"]["loadoutPerks"] = [ "specialty_hustle", "specialty_hardline" ];
    level.aon_loadouts["allies"]["loadoutExtraPerks"] = [ "specialty_scavenger_plus", "specialty_huntmaster", "specialty_surveillance" ];
    level.aon_loadouts["allies"]["loadoutGesture"] = "playerData";
    level.aon_loadouts["allies"]["loadoutFieldUpgrade1"] = "super_deadsilence";
    level.aon_loadouts["allies"]["loadoutFieldUpgrade2"] = "none";
    level.aon_loadouts["axis"] = level.aon_loadouts["allies"];
}

runaonrules()
{
    giveextraaonperks();
    var_0 = getcompleteweaponname( "iw8_knifestab_mp" );
    self giveweapon( var_0 );
    self assignweaponmeleeslot( var_0 );
}

giveextraaonperks()
{
    var_0 = [ "specialty_blindeye", "specialty_gpsjammer", "specialty_falldamage", "specialty_sharp_focus", "specialty_stalker" ];

    foreach ( var_2 in var_0 )
        scripts\mp\utility\perk::giveperk( var_2 );
}

onplayerconnect( var_0 )
{
    if ( level.aonrules > 0 )
    {
        if ( level.allowkillstreaks )
        {

        }

        var_0.pers["class"] = "gamemode";
        var_0.pers["lastClass"] = "";
        var_0.class = var_0.pers["class"];
        var_0.lastclass = var_0.pers["lastClass"];
        var_0.pers["gamemodeLoadout"] = level.aon_loadouts["allies"];
        var_0 loadweaponsforplayer( [ "iw8_pi_golf21_mp", "iw8_knife_mp" ], 1 );
    }
}

gettarget()
{
    level endon( "game_ended" );
    self notify( "get_target" );
    self endon( "get_target" );

    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
        level waittill( "prematch_done" );

    var_0 = 0;

    if ( !isdefined( self.targetarray ) || !level.targetplayercycle )
    {
        self.targetarray = [];
        self.targetindex = 0;
        var_0 = 1;

        foreach ( var_2 in level.players )
        {
            if ( var_2 == self )
                continue;
            else
                self.targetarray[self.targetarray.size] = var_2;
        }
    }

    if ( self.targetarray.size > 0 )
    {
        if ( !level.targetplayercycle )
            self.targetindex = randomint( self.targetarray.size );
        else
        {
            if ( !var_0 )
                self.targetindex++;

            if ( self.targetindex == self.targetarray.size )
                self.targetindex = 0;
        }
    }

    self.targetvictim = self.targetarray[self.targetindex];

    if ( !isdefined( self.targetvictim ) )
    {
        waitframe();
        thread gettarget();
        thread newtargetmessage();
        return;
    }

    waitframe();

    if ( level.showtargettime != 0 )
    {
        self.curorigin = self.origin;
        self.offset3d = ( 0, 0, 10 );
        scripts\mp\gameobjects::requestid( 1, 1 );
        var_4 = self.objidnum;
        objective_setlabel( var_4, "MP_INGAME_ONLY/OBJ_TARGET_CAPS" );
        objective_setzoffset( var_4, 90 );
        objective_icon( var_4, "hud_icon_targeted_player_cir" );
        objective_setplayintro( var_4, 1 );
        scripts\mp\objidpoolmanager::objective_playermask_single( var_4, self );
        objective_setbackground( var_4, 2 );
        objective_position( var_4, self.curorigin );
        objective_state( var_4, "current" );
        scripts\mp\objidpoolmanager::update_objective_onentity( var_4, self.targetvictim );
        objective_setownerclient( var_4, self.targetvictim );

        if ( level.showtargettime > 1 )
            thread updatetargetlocation();
    }

    thread targetvictimdeathwatcher();
}

targetvictimdeathwatcher()
{
    level endon( "game_ended" );
    self waittill( "target_eliminated" );
    thread scripts\mp\hud_message::showsplash( "target_eliminated", scripts\mp\rank::getscoreinfovalue( "kill" ) );
    objective_state( self.objidnum, "done" );
    scripts\mp\gameobjects::releaseid();
}

updatetargetlocation()
{
    level endon( "game_ended" );
    self.targetvictim endon( "disconnect" );
    self endon( "target_eliminated" );
    thread updatetargetcurorigin();
    objective_setpings( self.objidnum, 1 );

    if ( !isdefined( level.objpingdelay ) )
        level.objpingdelay = 3.0;

    for (;;)
    {
        if ( isdefined( self.targetvictim ) )
        {
            scripts\mp\objidpoolmanager::update_objective_position( self.objidnum, self.curorigin + self.offset3d );
            objective_ping( self.objidnum );
            wait( level.objpingdelay );
            continue;
        }

        waitframe();
    }
}

updatetargetcurorigin()
{
    level endon( "game_ended" );
    self.targetvictim endon( "disconnect" );
    self endon( "target_eliminated" );

    for (;;)
    {
        if ( isdefined( self.targetvictim ) )
            self.curorigin = self.targetvictim.origin + ( 0, 0, 90 );

        waitframe();
    }
}

newtargetmessage()
{
    level endon( "game_ended" );
    self notify( "endDeathWatcher" );
    self endon( "endDeathWatcher" );

    if ( !scripts\mp\flags::gameflag( "prematch_done" ) )
        level waittill( "prematch_done" );

    wait 2.5;

    if ( isdefined( self.targetvictim ) )
        self iprintlnbold( &"MP/DM_NEW_TARGET", self.targetvictim.name );
}