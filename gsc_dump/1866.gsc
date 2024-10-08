// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.activejuggernauts = [];
    level._id_11B5F = getdvarint( "scr_ks_jugg_team_max", 0 );
}

jugg_makejuggernaut( var_0, var_1 )
{
    var_2 = vehicle_damage_setweaponhitdamagedata( var_0 );

    if ( !isdefined( var_2 ) )
    {
        scripts\mp\hud_message::showerrormessage( "KILLSTREAKS/JUGG_CANNOT_BECOME" );
        return 0;
    }

    var_3 = var_2 != self getstance();
    self.isjuggernaut = 1;
    scripts\mp\battlechatter_mp::disablebattlechatter( self );
    scripts\mp\equipment\gas_grenade::gas_updateplayereffects();
    var_4 = spawnstruct();
    var_4.juggconfig = var_0;
    var_4.prevhealth = self.health;
    var_4.prevmaxhealth = self.maxhealth;
    var_4.prevbody = self getcustomizationbody();
    var_4.prevhead = self getcustomizationhead();
    var_4.prevviewmodel = self getcustomizationviewmodel();
    var_4.prevspeedscale = self.playerstreakspeedscale;
    var_4.prevsuit = self.suit;
    var_4.prevclothtype = self.clothtype;
    var_4.maskomnvar = "ui_gas_mask_juggernaut";
    self.maxhealth = var_0.maxhealth;
    self.health = var_0.startinghealth;
    scripts\mp\weapons::savetogglescopestates();
    scripts\mp\weapons::savealtstates();

    if ( isdefined( level.headiconbox ) )
        self [[ level.headiconbox ]]();

    if ( isdefined( var_0.classstruct ) )
    {
        var_5 = scripts\mp\class::respawnitems_saveplayeritemstostruct();
        var_4.respawnitems = var_5;
        var_4.prevclass = self.lastclass;
        var_4.prevclassstruct = self.classstruct;
        scripts\mp\class::loadout_updateclass( var_0.classstruct, "juggernaut" );
        scripts\mp\class::preloadandqueueclassstruct( var_0.classstruct, 1, 1 );
        scripts\mp\class::giveloadout( self.team, "juggernaut", 0, 1 );
    }

    self.lastdroppableweaponobj = undefined;

    foreach ( var_8, var_7 in var_0.perks )
        scripts\mp\utility\perk::giveperk( var_8 );

    if ( istrue( self._id_12346 ) )
    {
        scripts\mp\playeractions::allowactionset( "fakeJugg", 1 );
        self._id_12346 = undefined;
    }

    jugg_toggleallows( var_0.allows, 0 );
    self skydive_setbasejumpingstatus( 0 );
    scripts\cp_mp\killstreaks\white_phosphorus::enableloopingcoughaudiosupression();
    jugg_setmodel();
    self.playerstreakspeedscale = var_0.movespeedscalar;
    scripts\mp\weapons::updatemovespeedscale();
    scripts\mp\utility\player::_setsuit( var_0.suit );
    self setclothtype( var_0.clothtype );
    jugg_enableoverlay( var_4 );
    self.juggcontext = var_4;

    if ( var_0.infiniteammo )
        thread scripts\mp\utility\weapon::infiniteammothread( var_0.infiniteammoupdaterate );
    else
    {
        var_9 = self getweaponslistexclusives();

        foreach ( var_11 in var_9 )
        {
            self setweaponammoclip( var_11, weaponclipsize( var_11 ) );

            if ( vehicle_damage_registervisualpercentcallback() )
            {
                self givemaxammo( var_11 );
                thread vehicle_damage_updatestatemaxhealthvalues( var_11 );
            }
        }
    }

    self.streakinfo = var_1;
    self notify( "juggernaut_start" );
    thread scripts\mp\gameobjects::onjuggernaut();
    thread vehicle_getturretbyweapon();
    thread jugg_watchmusictoggle();
    thread jugg_watchfordeath();
    thread jugg_watchforgameend();
    thread jugg_watchfordisconnect();
    thread vehicle_interact_initdev();
    thread vehicle_is_ambient();

    if ( vehicle_damage_registerinstance() )
    {
        self skydive_setbasejumpingstatus( 1 );
        self skydive_setdeploymentstatus( 1 );
    }

    if ( isdefined( level.battle_tracks_standingonvehicletimeout ) )
        self [[ level.battle_tracks_standingonvehicletimeout ]]();

    if ( var_3 )
        self setstance( var_2 );

    scripts\mp\healthoverlay::onexitdeathsdoor( 1 );
    vehicle_damage_onexitstatemedium();
    return 1;
}

jugg_removejuggernaut()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "juggernaut_end" );
    var_0 = self.juggcontext;
    var_1 = var_0.juggconfig;
    self.musicplaying = undefined;
    jugg_disableoverlay( var_0 );
    jugg_toggleallows( var_1.allows, 1 );

    if ( scripts\mp\utility\player::isreallyalive( self ) )
    {
        self.maxhealth = var_0.prevmaxhealth;
        self.health = var_0.prevhealth;
        scripts\cp_mp\killstreaks\white_phosphorus::disableloopingcoughaudiosupression();

        if ( isdefined( var_1.classstruct ) )
        {
            scripts\mp\class::respawnitems_assignrespawnitems( var_0.respawnitems );
            scripts\mp\class::giveloadout( self.team, var_0.prevclass, 0, 1, 1 );
        }

        foreach ( var_4, var_3 in var_1.perks )
            scripts\mp\utility\perk::removeperk( var_4 );
    }

    if ( var_1.infiniteammo )
        scripts\mp\utility\weapon::stopinfiniteammothread();

    jugg_restoremodel( var_0 );
    self.playerstreakspeedscale = var_0.prevspeedscale;
    scripts\mp\weapons::updatemovespeedscale();
    scripts\mp\utility\player::_setsuit( var_0.prevsuit );
    self setclothtype( var_0.prevclothtype );
    self setscriptablepartstate( "juggernaut", "neutral", 0 );
    self setscriptablepartstate( "headVFX", "neutral", 0 );

    if ( vehicle_damage_registerinstance() )
    {
        self skydive_setbasejumpingstatus( 0 );
        self skydive_setdeploymentstatus( 0 );
    }

    self.isjuggernaut = 0;
    self.juggcontext = undefined;
    self.streakinfo = undefined;
    scripts\mp\battlechatter_mp::enablebattlechatter( self );
}

jugg_createconfig( var_0, var_1 )
{
    var_2 = spawnstruct();
    var_2.maxhealth = 3000;
    var_2.startinghealth = var_2.maxhealth;
    var_2.movespeedscalar = -0.2;
    var_2._id_11B7D = 5;

    if ( level.gametype == "br" )
        var_2._id_11B7D = 3;

    var_2.forcetostand = 1;
    var_3 = "iw8_juggernaut_mp";

    if ( scripts\common\utility::iscp() )
        var_3 = "iw8_juggernaut_cp";

    var_2.suit = var_3;
    var_2.infiniteammo = 0;
    var_2.infiniteammoupdaterate = undefined;
    var_2.classstruct = jugg_getdefaultclassstruct();
    var_2.allows = [];
    var_2.allows["stick_kill"] = 1;
    var_2.allows["health_regen"] = 1;
    var_2.allows["one_hit_melee_victim"] = 1;
    var_2.allows["flashed"] = 1;
    var_2.allows["stunned"] = 1;
    var_2.allows["prone"] = 1;
    var_2.allows["equipment"] = 1;
    var_2.allows["supers"] = 1;
    var_2.allows["killstreaks"] = 1;
    var_2.allows["slide"] = 1;
    var_2.allows["weapon_pickup"] = 1;
    var_2.allows["execution_victim"] = 1;
    var_2.allows["cough_gesture"] = 1;
    var_2.allows["offhand_throwback"] = 1;
    var_2.perks = [];
    var_2.perks["specialty_stun_resistance"] = 1;
    var_2.perks["specialty_sharp_focus"] = 1;
    var_2.perks["specialty_melee_resist"] = 1;
    var_2.perks["specialty_blastshield"] = 1;
    var_2.perks["specialty_armorpiercing"] = 1;
    return var_2;
}

jugg_toggleallows( var_0, var_1 )
{
    foreach ( var_4, var_3 in var_0 )
    {
        if ( var_3 )
        {
            var_4 = tolower( var_4 );
            self thread [[ level.allow_funcs[var_4] ]]( var_1, "juggernaut" );
        }
    }

    if ( !istrue( level.loadout_updateammo ) )
    {
        scripts\common\utility::allow_mount_top( var_1, "juggernaut" );
        scripts\common\utility::allow_mount_side( var_1, "juggernaut" );
    }
}

jugg_getdefaultclassstruct()
{
    var_0 = scripts\mp\class::loadout_getclassstruct();
    var_0.loadoutarchetype = "archetype_assault";
    var_0.loadoutprimary = "iw8_minigunksjugg_mp";
    var_0.loadoutsecondary = "none";
    return var_0;
}

vehicle_getturretbyweapon()
{
    if ( vehicle_damage_registerdefaultvisuals() )
    {
        var_0 = getdvarint( "scr_jugg_event_models", 0 );

        if ( var_0 )
        {
            var_1 = undefined;

            if ( vehicle_damage_updatestate_br( var_0 ) )
                var_1 = "flames";

            if ( isdefined( var_1 ) )
                self setscriptablepartstate( "headVFX", var_1, 0 );
        }
    }
}

jugg_watchmusictoggle()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    self endon( "juggernaut_end" );
    var_0 = 0;

    if ( isdefined( level.disable_super_in_turret ) && isdefined( level.disable_super_in_turret.name ) && getdvarint( "scr_br_alt_mode_zxp", 0 ) )
        return;

    if ( !isbot( self ) && !isagent( self ) )
    {
        self notifyonplayercommand( "toggle_music", "+actionslot 3" );
        self notifyonplayercommand( "toggle_music", "killstreak_wheel" );
    }

    var_1 = getcompleteweaponname( "ks_gesture_jugg_music_mp" );
    var_2 = weaponfiretime( var_1 );

    if ( !isdefined( self.musicplaying ) )
    {
        var_3 = self getjuggdefaultmusicenabled();
        self.musicplaying = var_3;
    }

    if ( !istrue( self.musicplaying ) )
        self setscriptablepartstate( "juggernaut", "neutral", 0 );
    else
        self setscriptablepartstate( "juggernaut", "music", 0 );

    for (;;)
    {
        self waittill( "toggle_music" );

        if ( self isonladder() || self ismantling() )
            continue;

        self giveandfireoffhand( var_1 );
        self playsoundonmovingent( "mp_jugg_mus_toggle_foley" );
        self playlocalsound( "mp_jugg_mus_toggle_button" );
        var_4 = 0.2;

        if ( istrue( self.musicplaying ) )
            var_4 = 0.65;

        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var_4 );

        if ( istrue( self.musicplaying ) )
        {
            self.musicplaying = 0;
            self setscriptablepartstate( "juggernaut", "neutral", 0 );
        }
        else
        {
            self.musicplaying = 1;
            self setscriptablepartstate( "juggernaut", "music", 0 );
        }

        scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( 1.5 );
    }
}

jugg_watchfordeath()
{
    self endon( "juggernaut_end" );
    self waittill( "death" );
    thread jugg_removejuggernaut();
}

jugg_watchforgameend()
{
    self endon( "juggernaut_end" );
    var_0 = self.juggcontext;
    level waittill( "game_ended" );

    if ( isdefined( self ) )
    {
        self.maxhealth = var_0.prevmaxhealth;
        self.health = var_0.prevhealth;
        jugg_disableoverlay( var_0 );
        self setscriptablepartstate( "juggernaut", "neutral", 0 );
    }
}

jugg_watchfordisconnect()
{
    self endon( "juggernaut_end" );
    var_0 = self.juggcontext;
    self waittill( "disconnect" );

    if ( isdefined( self ) )
    {
        self.maxhealth = var_0.prevmaxhealth;
        self.health = var_0.prevhealth;
    }
}

vehicle_interact_initdev()
{
    self endon( "juggernaut_end" );

    for (;;)
    {
        self waittill( "weapon_fired" );

        if ( isdefined( self.streakinfo ) && isdefined( self.streakinfo.shots_fired ) )
            self.streakinfo.shots_fired++;
    }
}

vehicle_damage_registerdefaultvisuals()
{
    var_0 = 0;
    var_1 = getdvarint( "scr_jugg_event_access", 0 );

    if ( scripts\mp\utility\game::matchmakinggame() || var_1 )
        var_0 = 1;

    return var_0;
}

jugg_getjuggmodels()
{
    var_0 = [];
    var_0["body"] = "body_opforce_juggernaut_mp_lod1";
    var_0["head"] = "head_opforce_juggernaut";

    if ( vehicle_damage_registerdefaultvisuals() )
    {
        var_1 = getdvarint( "scr_jugg_event_models", 0 );

        if ( var_1 )
        {
            if ( vehicle_damage_updatestate_br( var_1 ) )
            {
                var_2 = [ "head_mp_halloween_pumpkin_jackolantern_2_1", "head_mp_halloween_pumpkin_jackolantern_3_1" ];
                var_0["head"] = var_2[randomint( var_2.size )];
            }
        }
    }

    var_0["view"] = "viewhands_opforce_juggernaut";
    return var_0;
}

jugg_setmodel()
{
    var_0 = jugg_getjuggmodels();

    if ( isdefined( self.headmodel ) )
        self detach( self.headmodel );

    var_1 = var_0["body"];
    var_2 = var_0["head"];
    var_3 = var_0["view"];
    self setmodel( var_1 );
    self setviewmodel( var_3 );
    self attach( var_2, "", 1 );
    self.headmodel = var_2;
}

jugg_restoremodel( var_0 )
{
    self.operatorcustomization = undefined;

    if ( scripts\cp_mp\utility\player_utility::_isalive() )
    {
        self setcustomization( var_0.prevbody, var_0.prevhead );
        scripts\mp\teams::setcharactermodels( var_0.prevbody, var_0.prevhead, var_0.prevviewmodel );
    }
}

vehicle_damage_setweaponhitdamagedata( var_0 )
{
    var_1 = undefined;
    var_2 = self getstance();

    if ( var_2 != "stand" )
    {
        var_3 = !istrue( var_0.forcetostand ) && !isdefined( var_0.allows["crouch"] ) || istrue( var_0.allowcrouch );
        var_4 = !istrue( var_0.forcetostand ) && !isdefined( var_0.allows["prone"] ) || istrue( var_0.allowprone );
        var_5 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 0 );

        if ( !var_3 && !var_4 )
            var_1 = "stand";
        else if ( var_2 == "crouch" )
        {
            if ( !var_3 )
            {
                var_6 = scripts\engine\trace::ray_trace_passed( self.origin, scripts\mp\utility\player::round_smoke_logic( "stand" ), self, var_5 );

                if ( var_6 )
                    var_1 = "stand";
            }
            else
                var_1 = "crouch";
        }
        else if ( var_2 == "prone" )
        {
            if ( !var_4 )
            {
                if ( var_3 )
                {
                    var_7 = scripts\engine\trace::ray_trace_passed( self.origin, scripts\mp\utility\player::round_smoke_logic( "crouch" ), self, var_5 );

                    if ( var_7 )
                        var_1 = "crouch";
                }
                else
                {
                    var_6 = scripts\engine\trace::ray_trace_passed( self.origin, scripts\mp\utility\player::round_smoke_logic( "stand" ), self, var_5 );

                    if ( var_6 )
                        var_1 = "stand";
                }
            }
            else
                var_1 = "prone";
        }
    }
    else
        var_1 = "stand";

    return var_1;
}

jugg_enableoverlay( var_0 )
{
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak( "juggernaut", "mask_on" );
    self setclientomnvar( var_0.maskomnvar, 1 );
    self.juggoverlaystatelabel = "mask_on";
    self.juggoverlaystate = 1;
    thread jugg_watchoverlaydamagestates( var_0 );
    thread jugg_watchforoverlayexecutiontoggle( var_0 );
}

jugg_watchoverlaydamagestates( var_0 )
{
    self endon( "juggernaut_end" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_1 = self.health;
    var_2 = var_1 - var_1 * 0.1;
    var_3 = var_1 - var_1 * 0.35;
    var_4 = var_1 - var_1 * 0.6;
    var_5 = var_1 - var_1 * 0.85;
    var_6 = 1;
    var_7 = var_6;
    var_8 = "mask_on";

    for (;;)
    {
        scripts\engine\utility::_id_143A5( "damage", "jugg_health_regen" );

        if ( self.health <= var_5 )
        {
            var_8 = "mask_damage_critical";
            var_6 = 5;
        }
        else if ( self.health <= var_4 )
        {
            var_8 = "mask_damage_high";
            var_6 = 4;
        }
        else if ( self.health <= var_3 )
        {
            var_8 = "mask_damage_med";
            var_6 = 3;
        }
        else if ( self.health <= var_2 )
        {
            var_8 = "mask_damage_low";
            var_6 = 2;
        }
        else
        {
            var_8 = "mask_on";
            var_6 = 1;
        }

        if ( var_7 != var_6 )
        {
            scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak( "juggernaut", var_8 );
            self setclientomnvar( var_0.maskomnvar, var_6 );
            var_7 = var_6;
            self.juggoverlaystatelabel = var_8;
            self.juggoverlaystate = var_6;
        }
    }
}

jugg_watchforoverlayexecutiontoggle( var_0 )
{
    self endon( "juggernaut_end" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_1 = 0;

    for (;;)
    {
        if ( !self isinexecutionattack() )
        {
            if ( istrue( var_1 ) )
            {
                scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak( "juggernaut", self.juggoverlaystatelabel );
                self setclientomnvar( var_0.maskomnvar, self.juggoverlaystate );
                var_1 = 0;
            }

            waitframe();
            continue;
        }

        if ( !istrue( var_1 ) )
        {
            scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak( "juggernaut", "off" );
            self setclientomnvar( var_0.maskomnvar, -1 );
            var_1 = 1;
        }

        waitframe();
    }
}

jugg_disableoverlay( var_0 )
{
    scripts\cp_mp\utility\killstreak_utility::_setvisibiilityomnvarforkillstreak( "juggernaut", "off" );
    self setclientomnvar( var_0.maskomnvar, 0 );
    self.juggoverlaystatelabel = undefined;
    self.juggoverlaystate = undefined;
}

jugg_getmovespeedscalar()
{
    return -0.2;
}

vehicle_damage_setweaponclassmoddamageforvehicle()
{
    return self.juggcontext.juggconfig.classstruct.loadoutprimary;
}

vehicle_damage_registervisualpercentcallback()
{
    return istrue( self.juggcontext.juggconfig._id_14092 );
}

vehicle_damage_setdeathcallback()
{
    return istrue( self.juggcontext.juggconfig._id_140A7 );
}

vehicle_damage_updatestatemaxhealthvalues( var_0 )
{
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    var_1 = self getweaponammostock( var_0 );
    thread vehicle_isenemytoplayer( var_0, var_1 );
    thread vehicle_has_flare( var_0, var_1 );

    for (;;)
    {
        self waittill( "minigun_restock" );
        self setweaponammostock( var_0, var_1 );
    }
}

vehicle_isenemytoplayer( var_0, var_1 )
{
    self endon( "death_or_disconnect" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );

    for (;;)
    {
        if ( self isbnetkr15player() )
        {
            var_2 = self getweaponammostock( var_0 );

            if ( var_2 < var_1 )
                self notify( "minigun_restock" );
        }

        waitframe();
    }
}

vehicle_has_flare( var_0, var_1 )
{
    self endon( "death_or_disconnect" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );

    for (;;)
    {
        var_2 = self getweaponammoclip( var_0 );

        if ( var_2 == 0 )
        {
            var_3 = self getweaponammostock( var_0 );

            if ( var_3 < var_1 )
                self notify( "minigun_restock" );
        }

        waitframe();
    }
}

vehicle_damage_onexitstatemedium()
{
    if ( !isdefined( level.activejuggernauts ) )
        level.activejuggernauts = [];

    level.activejuggernauts[level.activejuggernauts.size] = self;
    thread vehicle_invalid_seats();
}

vehicle_invalid_seats()
{
    level endon( "game_ended" );
    scripts\engine\utility::waittill_any_in_array_return_no_endon_death( [ "juggernaut_end", "disconnect" ] );
    vehicle_getteamfriendlyto();
}

vehicle_getteamfriendlyto()
{
    if ( !isdefined( self ) )
        level.activejuggernauts = scripts\engine\utility::array_removeundefined( level.activejuggernauts );
    else
        level.activejuggernauts = scripts\engine\utility::array_remove( level.activejuggernauts, self );
}

vehicle_is_ambient()
{
    self endon( "death_or_disconnect" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    var_0 = self.juggcontext.juggconfig;
    var_0.spawn_all_unique_drones = 0;

    for (;;)
    {
        self waittill( "perform_hero_drop" );

        if ( !istrue( var_0.spawn_all_unique_drones ) )
        {
            var_0.spawn_all_unique_drones = 1;
            self radiusdamage( self.origin, 500, 2000, 500, self, "MOD_CRUSH" );
            thread vehicle_getturrets( var_0 );
        }
    }
}

vehicle_getturrets( var_0 )
{
    self endon( "death_or_disconnect" );
    self endon( "juggernaut_end" );
    level endon( "game_ended" );
    self setscriptablepartstate( "heroDiveVfx", "on", 0 );
    wait 1;
    self setscriptablepartstate( "heroDiveVfx", "off", 0 );
    var_0.spawn_all_unique_drones = 0;
}

vehicle_deletenextframe()
{
    if ( self isskydiving() )
        self skydive_interrupt();

    self notify( "perform_hero_drop" );
    return 0;
}

vehicle_deregister_on_death( var_0, var_1 )
{
    var_2 = self.maxhealth;
    var_3 = self.juggcontext.juggconfig;
    var_4 = 0.5;
    var_5 = 10;

    if ( isdefined( var_1 ) && isexplosivedamagemod( var_1 ) )
    {
        var_4 = 7;
        var_5 = var_3._id_11B7D;
    }

    var_6 = var_0 * var_4;
    var_7 = var_2 / var_5;
    var_8 = scripts\mp\utility\script::roundup( min( var_7, var_6 ) );
    return int( var_8 );
}

vehicle_deletenextframelate( var_0 )
{
    return int( var_0 / 2 );
}

vehicle_damage_registerinstance()
{
    var_0 = 0;
    var_1 = 0;

    if ( var_1 || scripts\mp\utility\game::gametypesupportsbasejumping() && scripts\mp\utility\game::mapsupportsbasejumping() )
        var_0 = 1;

    return var_0;
}

vehicle_damage_updatestate_br( var_0 )
{
    return istrue( level.setplayerselfrevivingextrainfo ) && var_0 == 1;
}

changecirclestateatlowtime()
{
    if ( istrue( level._id_11B5F ) && level.activejuggernauts.size > 0 )
    {
        var_0 = 0;
        var_1 = level.activejuggernauts.size;

        for ( var_2 = 0; var_2 < var_1; var_2++ )
        {
            var_3 = level.activejuggernauts[var_2];

            if ( isdefined( var_3 ) && self.team == var_3.team )
                var_0++;
        }

        if ( var_0 >= level._id_11B5F )
            return 1;
    }

    return 0;
}