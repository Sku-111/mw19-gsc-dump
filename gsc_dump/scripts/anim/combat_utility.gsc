// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

gettargetangleoffset( var_0 )
{
    var_1 = self getshootatpos() + ( 0, 0, -3 );
    var_2 = ( var_1[0] - var_0[0], var_1[1] - var_0[1], var_1[2] - var_0[2] );
    var_2 = vectornormalize( var_2 );
    var_3 = var_2[2] * -1;
    return var_3;
}

getremainingburstdelaytime()
{
    var_0 = ( gettime() - self.a.lastshoottime ) / 1000;
    var_1 = getburstdelaytime();

    if ( var_1 > var_0 )
        return var_1 - var_0;

    return 0;
}

getburstdelaytime()
{
    if ( scripts\anim\utility_common.gsc::isusingsidearm() )
        return randomfloatrange( 0.15, 0.55 );
    else if ( scripts\anim\utility_common.gsc::weapon_pump_action_shotgun() )
        return randomfloatrange( 1.0, 1.7 );
    else if ( scripts\anim\utility_common.gsc::weapon_genade_launcher() )
        return scripts\asm\shared\utility::grenadelauncherfirerate();
    else if ( scripts\anim\utility_common.gsc::isasniper() )
        return scripts\asm\shared\utility::getsniperburstdelaytime();
    else if ( self.fastburst )
        return randomfloatrange( 0.1, 0.35 );
    else
        return randomfloatrange( 0.2, 0.4 );
}

shootuntilshootbehaviorchange()
{

}

getuniqueflagnameindex()
{
    anim.animflagnameindex++;
    return anim.animflagnameindex;
}

#using_animtree("generic_human");

setupaim( var_0 )
{
    self setanim( %exposed_aiming, 1, 0.2 );

    if ( scripts\engine\utility::actor_is3d() )
        self setflaggedanimknoblimited( "exposed_aim", scripts\anim\utility.gsc::animarray( "straight_level" ), 1, var_0 );
    else
        self setanimknoblimited( scripts\anim\utility.gsc::animarray( "straight_level" ), 1, var_0 );

    self setanimknoblimited( scripts\anim\utility.gsc::animarray( "add_aim_up" ), 1, var_0 );
    self setanimknoblimited( scripts\anim\utility.gsc::animarray( "add_aim_down" ), 1, var_0 );
    self setanimknoblimited( scripts\anim\utility.gsc::animarray( "add_aim_left" ), 1, var_0 );
    self setanimknoblimited( scripts\anim\utility.gsc::animarray( "add_aim_right" ), 1, var_0 );
    self.facialidx = scripts\anim\face.gsc::playfacialanim( undefined, "aim", self.facialidx );
}

issingleshot()
{
    if ( weaponburstcount( self.weapon ) > 0 )
        return 0;
    else if ( weaponisauto( self.weapon ) || weaponisbeam( self.weapon ) )
        return 0;

    return 1;
}

shotgunpumpsound( var_0 )
{
    if ( !scripts\anim\utility_common.gsc::weapon_pump_action_shotgun() )
        return;

    self endon( "killanimscript" );
    self notify( "shotgun_pump_sound_end" );
    self endon( "shotgun_pump_sound_end" );
    thread stopshotgunpumpaftertime( 2.0 );
    self waittillmatch( var_0, "rechamber" );
    self playsound( "ai_shotgun_pump" );
    self notify( "shotgun_pump_sound_end" );
}

stopshotgunpumpaftertime( var_0 )
{
    self endon( "killanimscript" );
    self endon( "shotgun_pump_sound_end" );
    wait( var_0 );
    self notify( "shotgun_pump_sound_end" );
}

rechamber( var_0 )
{

}

putgunbackinhandonkillanimscript()
{
    self endon( "weapon_switch_done" );
    self endon( "death" );
    self waittill( "killanimscript" );
    scripts\anim\shared.gsc::placeweaponon( self.primaryweapon, "right" );
}

reload( var_0, var_1 )
{

}

addgrenadethrowanimoffset( var_0, var_1 )
{
    if ( !isdefined( anim.grenadethrowanims ) )
    {
        anim.grenadethrowanims = [];
        anim.grenadethrowoffsets = [];
    }

    var_2 = anim.grenadethrowanims.size;
    anim.grenadethrowanims[var_2] = var_0;
    anim.grenadethrowoffsets[var_2] = var_1;
}

initgrenadethrowanims()
{

}

getgrenadethrowoffset( var_0 )
{
    var_1 = ( 0, 0, 64 );
    return var_1;
}

throwgrenadeatplayerasap_combat_utility()
{
    for ( var_0 = 0; var_0 < level.players.size; var_0++ )
    {
        if ( level.players[var_0].numgrenadesinprogresstowardsplayer == 0 )
        {
            level.players[var_0].grenadetimers["frag"] = 0;
            level.players[var_0].grenadetimers["flash_grenade"] = 0;
            level.players[var_0].grenadetimers["seeker"] = 0;
        }
    }

    anim.throwgrenadeatplayerasap = 1;
}

setactivegrenadetimer( var_0 )
{
    self.activegrenadetimer = spawnstruct();

    if ( isplayer( var_0 ) )
    {
        self.activegrenadetimer.isplayertimer = 1;
        self.activegrenadetimer.player = var_0;
        self.activegrenadetimer.timername = self.grenadeweapon.basename;
    }
    else
    {
        self.activegrenadetimer.isplayertimer = 0;
        self.activegrenadetimer.timername = "AI_" + self.grenadeweapon.basename;
    }
}

usingplayergrenadetimer()
{
    return self.activegrenadetimer.isplayertimer;
}

setgrenadetimer( var_0, var_1 )
{
    if ( var_0.isplayertimer )
    {
        var_2 = var_0.player;
        var_3 = var_2.grenadetimers[var_0.timername];
        var_2.grenadetimers[var_0.timername] = max( var_1, var_3 );
    }
    else
    {
        var_3 = anim.grenadetimers[var_0.timername];
        anim.grenadetimers[var_0.timername] = max( var_1, var_3 );
    }
}

getdesiredgrenadetimervalue()
{
    var_0 = undefined;

    if ( usingplayergrenadetimer() )
    {
        var_1 = self.activegrenadetimer.player;
        var_0 = gettime() + var_1.gs.playergrenadebasetime + randomint( var_1.gs.playergrenaderangetime );
    }
    else
        var_0 = gettime() + 30000 + randomint( 30000 );

    return var_0;
}

getgrenadetimertime( var_0 )
{
    if ( var_0.isplayertimer )
        return var_0.player.grenadetimers[var_0.timername];
    else
        return anim.grenadetimers[var_0.timername];
}

maythrowdoublegrenade( var_0 )
{
    if ( scripts\engine\utility::player_died_recently() )
        return 0;

    if ( !var_0.gs.double_grenades_allowed )
        return 0;

    var_1 = gettime();

    if ( var_1 < var_0.grenadetimers["double_grenade"] )
        return 0;

    if ( var_1 > var_0.lastfraggrenadetoplayerstart + 3000 )
        return 0;

    if ( var_1 < var_0.lastfraggrenadetoplayerstart + 500 )
        return 0;

    return var_0.numgrenadesinprogresstowardsplayer < 2;
}

mygrenadecooldownelapsed()
{
    return gettime() >= self.a.nextgrenadetrytime;
}

grenadecooldownelapsed( var_0 )
{
    if ( scripts\engine\utility::player_died_recently() )
        return 0;

    if ( self.script_forcegrenade == 1 )
        return 1;

    if ( !mygrenadecooldownelapsed() )
        return 0;

    if ( gettime() >= getgrenadetimertime( self.activegrenadetimer ) )
        return 1;

    if ( self.activegrenadetimer.isplayertimer && self.activegrenadetimer.timername == "fraggrenade" )
        return maythrowdoublegrenade( var_0 );

    return 0;
}

trygrenadeposproc( var_0, var_1, var_2, var_3 )
{
    if ( !self isgrenadepossafe( var_0, var_1 ) )
        return 0;
    else if ( distancesquared( self.origin, var_1 ) < 40000 )
        return 0;

    var_4 = physicstrace( var_1 + ( 0, 0, 1 ), var_1 + ( 0, 0, -500 ) );

    if ( var_4 == var_1 + ( 0, 0, -500 ) )
        return 0;

    var_4 = var_4 + ( 0, 0, 0.1 );
    return trygrenadethrow( var_0, var_4, var_2, var_3 );
}

trygrenadethrow( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{

}

reducegiptponkillanimscript( var_0 )
{
    self endon( "dont_reduce_giptp_on_killanimscript" );
    self waittill( "killanimscript" );
    var_0.numgrenadesinprogresstowardsplayer--;
}

dogrenadethrow( var_0, var_1, var_2, var_3 )
{
    self endon( "killanimscript" );

    if ( !self.arriving )
        self orientmode( "face direction", var_1 );

    scripts\anim\battlechatter_wrapper.gsc::evaluateattackevent( self.grenadeweapon.basename );
    self notify( "stop_aiming_at_enemy" );
    self setflaggedanimknoballrestart( "throwanim", var_0, %body, fasteranimspeed(), 0.1, 1 );
    thread scripts\anim\notetracks.gsc::donotetracksforever( "throwanim", "killanimscript" );
    var_4 = scripts\anim\utility_common.gsc::getgrenademodel();
    var_5 = "none";

    for (;;)
    {
        self waittill( "throwanim", var_6 );

        if ( var_6 == "grenade_left" || var_6 == "grenade_right" )
        {
            var_5 = attachgrenademodel( var_4, "TAG_INHAND" );
            self.isholdinggrenade = 1;
        }

        if ( var_6 == "grenade_throw" || var_6 == "grenade throw" )
            break;

        if ( var_6 == "end" )
        {
            self.activegrenadetimer.player.numgrenadesinprogresstowardsplayer--;
            self notify( "dont_reduce_giptp_on_killanimscript" );
            return 0;
        }
    }

    self notify( "dont_reduce_giptp_on_killanimscript" );

    if ( usingplayergrenadetimer() )
        thread watchgrenadetowardsplayer( self.activegrenadetimer.player, var_2 );

    self throwgrenade();

    if ( !usingplayergrenadetimer() )
        setgrenadetimer( self.activegrenadetimer, var_2 );

    if ( var_3 && self.activegrenadetimer.isplayertimer )
    {
        var_13 = self.activegrenadetimer.player;

        if ( var_13.numgrenadesinprogresstowardsplayer > 1 || gettime() - var_13.lastgrenadelandednearplayertime < 2000 )
            var_13.grenadetimers["double_grenade"] = gettime() + min( 5000, var_13.gs.playerdoublegrenadetime );
    }

    self notify( "stop grenade check" );

    if ( var_5 != "none" )
        self detach( var_4, var_5 );
    else
    {

    }

    self.isholdinggrenade = undefined;
    self.grenadeawareness = self.oldgrenawareness;
    self.oldgrenawareness = undefined;
    self waittillmatch( "throwanim", "end" );
    self notify( "done_grenade_throw" );
    self notify( "weapon_switch_done" );
    self setanim( %exposed_modern, 1, 0.2 );
    self setanim( %exposed_aiming, 1 );
    self aiclearanim( var_0, 0.2 );
}

watchgrenadetowardsplayer( var_0, var_1 )
{
    var_0 endon( "death" );
    watchgrenadetowardsplayerinternal( var_1 );
    var_0.numgrenadesinprogresstowardsplayer--;
}

watchgrenadetowardsplayerinternal( var_0 )
{
    var_1 = self.activegrenadetimer;
    var_2 = spawnstruct();
    var_2 thread watchgrenadetowardsplayertimeout( 5 );
    var_2 endon( "watchGrenadeTowardsPlayerTimeout" );
    var_3 = self.grenadeweapon.basename;
    var_4 = getgrenadeithrew();

    if ( !isdefined( var_4 ) )
        return;

    setgrenadetimer( var_1, min( gettime() + 5000, var_0 ) );
    var_5 = 62500;
    var_6 = 160000;

    if ( var_3 == "flash_grenade" )
    {
        var_5 = 810000;
        var_6 = 1690000;
    }

    var_7 = level.players;
    var_8 = var_4.origin;

    for (;;)
    {
        wait 0.1;

        if ( !isdefined( var_4 ) )
            break;

        if ( distancesquared( var_4.origin, var_8 ) < 400 )
        {
            var_9 = [];

            for ( var_10 = 0; var_10 < var_7.size; var_10++ )
            {
                var_11 = var_7[var_10];
                var_12 = distancesquared( var_4.origin, var_11.origin );

                if ( var_12 < var_5 )
                {
                    var_11 grenadelandednearplayer( var_1, var_0 );
                    continue;
                }

                if ( var_12 < var_6 )
                    var_9[var_9.size] = var_11;
            }

            var_7 = var_9;

            if ( var_7.size == 0 )
                break;
        }

        var_8 = var_4.origin;
    }
}

grenadelandednearplayer( var_0, var_1 )
{
    var_2 = self;
    anim.throwgrenadeatplayerasap = undefined;

    if ( gettime() - var_2.lastgrenadelandednearplayertime < 3000 )
        var_2.grenadetimers["double_grenade"] = gettime() + var_2.gs.playerdoublegrenadetime;

    var_2.lastgrenadelandednearplayertime = gettime();
    var_3 = var_2.grenadetimers[var_0.timername];
    var_2.grenadetimers[var_0.timername] = max( var_1, var_3 );
}

getgrenadeithrew()
{
    self endon( "killanimscript" );
    self waittill( "grenade_fire", var_0 );
    return var_0;
}

watchgrenadetowardsplayertimeout( var_0 )
{
    wait( var_0 );
    self notify( "watchGrenadeTowardsPlayerTimeout" );
}

attachgrenademodel( var_0, var_1 )
{
    self attach( var_0, var_1 );
    thread detachgrenadeonscriptchange( var_0, var_1 );
    return var_1;
}

detachgrenadeonscriptchange( var_0, var_1 )
{
    self endon( "stop grenade check" );
    self waittill( "killanimscript" );

    if ( !isdefined( self ) )
        return;

    if ( isdefined( self.oldgrenawareness ) )
    {
        self.grenadeawareness = self.oldgrenawareness;
        self.oldgrenawareness = undefined;
    }

    self detach( var_0, var_1 );
}

offsettoorigin( var_0 )
{
    var_1 = anglestoforward( self.angles );
    var_2 = anglestoright( self.angles );
    var_3 = anglestoup( self.angles );
    var_1 = var_1 * var_0[0];
    var_2 = var_2 * var_0[1];
    var_3 = var_3 * var_0[2];
    return var_1 + var_2 + var_3;
}

grenadeline( var_0, var_1 )
{
    level notify( "armoffset" );
    level endon( "armoffset" );
    var_0 = self.origin + offsettoorigin( var_0 );

    for (;;)
        wait 0.05;
}

getgrenadedropvelocity()
{
    var_0 = randomfloat( 360 );
    var_1 = randomfloatrange( 30, 75 );
    var_2 = sin( var_1 );
    var_3 = cos( var_1 );
    var_4 = cos( var_0 ) * var_3;
    var_5 = sin( var_0 ) * var_3;
    var_6 = randomfloatrange( 100, 200 );
    var_7 = ( var_4, var_5, var_2 ) * var_6;
    return var_7;
}

dropgrenade()
{
    if ( isdefined( self.nodropgrenade ) )
        return;

    var_0 = self gettagorigin( "tag_accessory_right" );
    var_1 = getgrenadedropvelocity();
    self magicgrenademanual( var_0, var_1, 3 );
}

shouldhelpadvancingteammate()
{
    if ( level.advancetoenemygroup[self.team] > 0 && level.advancetoenemygroup[self.team] < level.advancetoenemygroupmax )
    {
        if ( gettime() - level.lastadvancetoenemytime[self.team] > 4000 )
            return 0;

        var_0 = level.lastadvancetoenemyattacker[self.team];

        if ( var_0 == self )
            return 0;

        var_1 = isdefined( var_0 ) && distancesquared( self.origin, var_0.origin ) < 65536;

        if ( ( var_1 || distancesquared( self.origin, level.lastadvancetoenemysrc[self.team] ) < 65536 ) && ( !isdefined( self.enemy ) || distancesquared( self.enemy.origin, level.lastadvancetoenemydest[self.team] ) < 262144 ) )
            return 1;
    }

    return 0;
}

checkadvanceonenemyconditions()
{
    if ( !isdefined( level.lastadvancetoenemytime[self.team] ) )
        return 0;

    if ( shouldhelpadvancingteammate() )
        return 1;

    if ( gettime() - level.lastadvancetoenemytime[self.team] < level.advancetoenemyinterval )
        return 0;

    if ( !issentient( self.enemy ) )
        return 0;

    if ( level.advancetoenemygroup[self.team] )
        level.advancetoenemygroup[self.team] = 0;

    var_0 = isdefined( self.advance_regardless_of_numbers ) && self.advance_regardless_of_numbers;

    if ( !var_0 && getaicount( self.team ) < getaicount( self.enemy.team ) )
        return 0;

    return 1;
}

tryrunningtoenemy( var_0 )
{
    if ( !isdefined( self.enemy ) )
        return 0;

    if ( self.fixednode )
        return 0;

    if ( self.combatmode == "ambush" || self.combatmode == "ambush_nodes_only" )
        return 0;

    if ( !self isingoal( self.enemy.origin ) )
        return 0;

    if ( scripts\anim\utility_common.gsc::islongrangeai() )
        return 0;

    if ( !checkadvanceonenemyconditions() )
        return 0;

    if ( isdefined( self.usingnavmesh ) && self.usingnavmesh )
        return 0;

    self findreacquiredirectpath( var_0 );

    if ( self reacquiremove() )
    {
        self.keepclaimednodeifvalid = 0;
        self.keepclaimednode = 0;
        self.a.magicreloadwhenreachenemy = 1;

        if ( level.advancetoenemygroup[self.team] == 0 )
        {
            level.lastadvancetoenemytime[self.team] = gettime();
            level.lastadvancetoenemyattacker[self.team] = self;
        }

        level.lastadvancetoenemysrc[self.team] = self.origin;
        level.lastadvancetoenemydest[self.team] = self.enemy.origin;
        level.advancetoenemygroup[self.team]++;
        return 1;
    }

    return 0;
}

getpitchtoshootspot( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    var_1 = var_0 - self getshootatpos();
    var_1 = vectornormalize( var_1 );
    var_2 = vectortoangles( var_1 )[0];
    return angleclamp180( var_2 );
}

watchreloading()
{
    self.isreloading = 0;
    self.lastreloadstarttime = -1;

    for (;;)
    {
        self waittill( "reload_start" );
        self.isreloading = 1;
        self.lastreloadstarttime = gettime();
        scripts\anim\battlechatter_wrapper.gsc::evaluatereloadevent();
        waittillreloadfinished();
        self.isreloading = 0;
    }
}

waittillreloadfinished()
{
    thread timednotify( 4, "reloadtimeout" );
    self endon( "reloadtimeout" );
    self endon( "weapon_taken" );

    for (;;)
    {
        self waittill( "reload" );
        var_0 = self getcurrentweapon();

        if ( nullweapon( var_0 ) )
            break;

        if ( self getcurrentweaponclipammo() >= weaponclipsize( var_0 ) )
            break;
    }

    self notify( "reloadtimeout" );
}

timednotify( var_0, var_1 )
{
    self endon( var_1 );
    wait( var_0 );
    self notify( var_1 );
}

checkgrenadethrowdist()
{
    var_0 = self.enemy.origin - self.origin;
    var_1 = lengthsquared( ( var_0[0], var_0[1], 0 ) );

    if ( self.grenadeweapon.basename == "flash_grenade" )
        return var_1 < 589824;

    return var_1 >= 40000 && var_1 <= 1562500;
}

monitorflash()
{
    self endon( "death" );

    if ( !isdefined( level.neverstopmonitoringflash ) )
        self endon( "stop_monitoring_flash" );

    for (;;)
    {
        var_0 = undefined;
        var_1 = undefined;
        var_2 = undefined;
        var_3 = undefined;
        var_4 = undefined;
        self waittill( "flashbang", var_1, var_0, var_2, var_3, var_4 );

        if ( isdefined( self.flashbangimmunity ) && self.flashbangimmunity )
            continue;

        if ( isdefined( self.script_immunetoflash ) && self.script_immunetoflash != 0 )
            continue;

        if ( isdefined( self.team ) && isdefined( var_4 ) && self.team == var_4 )
        {
            var_0 = 3 * ( var_0 - 0.75 );

            if ( var_0 < 0 )
                continue;

            if ( isdefined( self.teamflashbangimmunity ) )
                continue;
        }

        var_5 = 0.2;

        if ( var_0 > 1 - var_5 )
            var_0 = 1.0;
        else
            var_0 = var_0 / ( 1 - var_5 );

        var_6 = 4.5 * var_0;

        if ( var_6 < 0.25 )
            continue;

        self.flashingteam = var_4;
        flashbangstart( var_6 );
        self notify( "doFlashBanged", var_1, var_3 );
    }
}

flashbangstart( var_0 )
{
    if ( isdefined( self.flashbangimmunity ) && self.flashbangimmunity )
        return;

    if ( isdefined( self.syncedmeleetarget ) )
        return;

    if ( self isinscriptedstate() || scripts\asm\asm_bb::bb_isanimscripted() )
        return;

    if ( !self.allowpain || !self.allowpain_internal )
        return;

    var_1 = gettime() + var_0 * 1000.0;

    if ( isdefined( self.flashendtime ) )
        self.flashendtime = max( self.flashendtime, var_1 );
    else
    {
        self.flashendtime = var_1;

        if ( isdefined( self.asm ) )
            scripts\asm\asm::asm_setstate( "pain_flashed_transition" );
    }

    self notify( "flashed" );
}

fasteranimspeed()
{
    return 1.5;
}

randomfasteranimspeed()
{
    return randomfloatrange( 1, 1.2 );
}

player_sees_my_scope()
{
    var_0 = self geteye();

    foreach ( var_2 in level.players )
    {
        if ( !self cansee( var_2 ) )
            continue;

        var_3 = var_2 geteye();
        var_4 = vectortoangles( var_0 - var_3 );
        var_5 = anglestoforward( var_4 );
        var_6 = var_2 getplayerangles();
        var_7 = anglestoforward( var_6 );
        var_8 = vectordot( var_5, var_7 );

        if ( var_8 < 0.805 )
            continue;

        if ( scripts\engine\utility::cointoss() && var_8 >= 0.996 )
            continue;

        return 1;
    }

    return 0;
}

combat_playfacialanim( var_0, var_1 )
{
    self.facialidx = scripts\anim\face.gsc::playfacialanim( var_0, var_1, self.facialidx );
}

combat_clearfacialanim()
{
    self.facialidx = undefined;
    self aiclearanim( %head, 0.2 );
}
