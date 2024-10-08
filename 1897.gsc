// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( !level.potgenabled )
        return;

    level.potgglobals.eventdata = spawnstruct();
    var_0 = level.potgglobals.eventdata;
    var_0.lastkillearner = undefined;
    var_0.lastkilltime = undefined;

    if ( level.teambased )
    {
        var_0.lastteamkillearners = [];
        var_0.lastteamkilltimes = [];
    }
}

onpotgrecordingstopped()
{
    clearshotgroup();
}

getentityeventdata()
{
    var_0 = scripts\mp\potg::getentitypotgdata( self );

    if ( !isdefined( var_0 ) )
        return;

    if ( !isdefined( var_0.trackingdata ) )
        var_0.trackingdata = createentityeventdata();

    return var_0.trackingdata;
}

createentityeventdata()
{
    var_0 = spawnstruct();
    var_0.shotgroupactive = 0;
    var_0.shotgroupcount = 0;
    var_0.shotgroupaccuracy = 0;
    var_0.shotgrouplastcount = 0;
    var_0.shotgrouplastaccuracy = 0;
    return var_0;
}

onroundended( var_0 )
{
    var_1 = level.potgglobals.eventdata;
    handlefinalkill( var_0 );
}

handlefinalkill( var_0 )
{
    if ( !isdefined( var_0 ) )
        return;

    var_1 = level.potgglobals.eventdata;
    var_2 = undefined;
    var_3 = undefined;

    if ( level.teambased )
    {
        if ( isdefined( var_1.lastteamkillearners[var_0] ) )
        {
            var_2 = var_1.lastteamkillearners[var_0];
            var_3 = var_1.lastteamkilltimes[var_0];
        }
        else
        {
            var_2 = var_1.lastkillearner;
            var_3 = var_1.lastkilltime;
        }
    }
    else
    {
        var_2 = var_1.lastkillearner;
        var_3 = var_1.lastkilltime;
    }

    if ( isdefined( var_2 ) && isdefined( var_3 ) )
        var_2 scripts\mp\potg::processevent( "final_kill", var_3 );
}

onplayerdamaged( var_0, var_1, var_2 )
{
    if ( !level.potgenabled )
        return;

    if ( scripts\common\utility::getdamagetype( var_2 ) == "splash" && !var_1 scripts\mp\utility\game::isspawnprotected() )
        var_1 scripts\mp\potg::processevent( "hit_by_explosive" );
}

onplayerkilled( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !level.potgenabled )
        return;

    var_6 = level.potgglobals.eventdata;
    var_7 = gettime();

    if ( !isplayer( var_0 ) )
        return;

    var_8 = var_0 getentityeventdata();
    var_9 = var_2 getentityeventdata();
    var_10 = var_0 calckillmultiplier( var_0 );
    var_11 = var_3 == "MOD_EXPLOSIVE" || var_3 == "MOD_GRENADE" || var_3 == "MOD_GRENADE_SPLASH" || var_3 == "MOD_PROJECTILE";
    var_12 = scripts\engine\trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1 );
    var_13 = physics_raycast( var_0 geteye(), var_2 geteye(), var_12, undefined, 0, "physicsquery_closest", 1 );
    var_14 = isdefined( var_13 ) && var_13.size > 0;
    var_15 = scripts\engine\utility::within_fov( var_0 geteye(), var_0 getplayerangles(), var_2.origin, cos( 80 ) );
    var_16 = var_4.basename == "iw8_la_juliet_mp";
    var_17 = ( var_16 || var_11 ) && ( !var_15 || var_14 );

    if ( !var_17 )
        var_0 scripts\mp\potg::processevent( "kill", var_7, var_7, var_5, undefined, var_10 );

    if ( isdefined( self.prevlastkilltime ) && isdefined( var_0.lastspawntime ) )
    {
        if ( var_0.lastspawntime < self.prevlastkilltime )
        {
            var_18 = var_7 - self.prevlastkilltime;

            if ( var_18 < 1800 )
            {
                var_19 = 1.0 - var_18 / 1800;
                var_0 scripts\mp\potg::processevent( "kill_rate_bonus", self.prevlastkilltime, var_7, var_5, undefined, var_19 );
            }
        }
    }

    var_0 handlekillmodifiers( var_0, var_3, var_4, var_2, var_10, var_5 );

    if ( var_3 == "MOD_PROJECTILE_SPLASH" && !var_16 )
        var_0 scripts\mp\potg::processevent( "missile_splash_kill", var_7, var_7, var_5, undefined, var_10 );

    if ( scripts\common\utility::getdamagetype( var_3 ) == "splash" )
    {
        if ( scripts\mp\utility\game::gettimepassed() <= 12000 && randomintrange( 0, 2 ) == 0 )
            var_0 scripts\mp\potg::processevent( "round_start_grenade" );
    }

    if ( istrue( var_0.modifiers["bullet_damage"] ) && var_2 scripts\mp\equipment\molotov::molotov_is_burning() )
        var_0 scripts\mp\potg::processevent( "victim_on_fire", var_7, var_7, var_5, undefined, var_10 );

    if ( var_0 scripts\mp\equipment\molotov::molotov_is_burning() )
        var_0 scripts\mp\potg::processevent( "kill_while_on_fire", var_7, var_7, var_5, undefined, var_10 );

    if ( istrue( var_0.modifiers["airborne"] ) )
    {
        var_8.lastinairkilltime = var_7;
        var_8.inairsincelastkill = 1;
        var_0 thread watchforpostkilllanding();
    }

    if ( isdefined( var_0.lastdooropentime ) && var_7 - var_0.lastdooropentime < 3500 )
        var_0 scripts\mp\potg::processevent( "open_door_before_kill", var_0.lastdooropentime, var_7, var_5, undefined, var_10 );

    if ( isdefined( var_0.attackerdata ) && var_0.attackerdata.size > 3 )
        var_0 scripts\mp\potg::processevent( "outnumbered", var_7, var_7, var_5, undefined, var_10 );

    if ( isdefined( var_9.lastteabagtime ) && var_7 - var_9.lastteabagtime < 1000 && randomintrange( 0, 2 ) == 0 )
        var_0 scripts\mp\potg::processevent( "kill_teabagger", var_9.lastteabagtime, var_7, var_5, undefined, var_10 );

    var_0 handleequipmentkills( var_0, var_1, var_2, var_3, var_4, var_10 );
    var_0 handlemeleekills( var_0, var_1, var_2, var_3, var_4, var_10, var_5 );

    if ( var_8.shotgroupactive )
    {
        if ( var_8.shotgroupaccuracy >= 0.9 )
            var_0 scripts\mp\potg::processevent( "accuracy_good", var_7, var_7, var_5, undefined, var_10 );
        else if ( var_8.shotgroupaccuracy <= 0.075 )
            var_0 scripts\mp\potg::processevent( "accuracy_very_bad", var_7, var_7, var_5, undefined, var_10 );
        else if ( var_8.shotgroupaccuracy <= 0.15 )
            var_0 scripts\mp\potg::processevent( "accuracy_bad", var_7, var_7, var_5, undefined, var_10 );
    }

    if ( level.teambased )
    {
        var_6.lastteamkillearners[var_0.team] = var_0;
        var_6.lastteamkilltimes[var_0.team] = var_7;
    }

    var_6.lastkillearner = var_0;
    var_6.lastkilltime = var_7;
}

calckillmultiplier( var_0 )
{
    var_1 = 1.0;

    if ( !istrue( var_0.modifiers["victim_in_standard_view"] ) )
        var_1 = var_1 * 0.15;

    return var_1;
}

handlemeleekills( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_3 == "MOD_MELEE" )
    {
        if ( isdefined( var_0.lastspawntime ) )
        {
            var_7 = isdefined( var_0.lastshotfiredtime ) && var_0.lastshotfiredtime >= var_0.lastspawntime;

            if ( !var_7 )
                var_0 scripts\mp\potg::processevent( "no_shots_fired_kill", undefined, undefined, var_6, undefined, var_5 );
        }
    }
}

handleequipmentkills( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( isdefined( var_1 ) && istrue( var_1.isequipment ) || scripts\mp\utility\weapon::validatefuelstability( var_4, var_1 ) )
    {
        var_6 = scripts\mp\utility\weapon::isthrowingknife( var_4 ) || scripts\mp\utility\weapon::validatefuelstability( var_4, var_1 );

        if ( isdefined( var_1.spawnpos ) )
        {
            var_7 = distancesquared( var_1.spawnpos, var_1.origin );

            if ( var_6 )
            {
                if ( var_7 >= 640000 )
                    var_0 scripts\mp\potg::processevent( "long_throwing_knife" );
                else
                    var_0 scripts\mp\potg::processevent( "throwing_knife" );
            }
            else if ( var_7 >= 1440000 )
                var_0 scripts\mp\potg::processevent( "long_grenade_throw" );
        }

        if ( scripts\mp\utility\game::gettimepassed() <= 12000 )
        {
            if ( var_6 && level.mapname != "mp_shipment" )
                var_0 scripts\mp\potg::processevent( "round_start_throwing_knife" );
        }
    }
}

handlekillmodifiers( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = gettime();
    var_7 = scripts\mp\utility\weapon::getweapongroup( var_2 );

    foreach ( var_10, var_9 in var_0.modifiers )
    {
        switch ( var_10 )
        {
            case "backstab":
                if ( var_1 == "MOD_MELEE" )
                    var_0 scripts\mp\potg::processevent( "backstab", var_6, var_6, var_5, undefined, var_4 );

                break;
            case "pointblank":
                if ( var_7 == "weapon_sniper" )
                    var_0 scripts\mp\potg::processevent( "pointblank_sniper", var_6, var_6, var_5, undefined, var_4 );
                else
                    var_0 scripts\mp\potg::processevent( "pointblank", var_6, var_6, var_5, undefined, var_4 );

                break;
            case "airborne":
                if ( isdefined( var_0.modifiers["ads"] ) )
                {
                    if ( var_7 == "weapon_sniper" )
                        var_0 scripts\mp\potg::processevent( "airborne_ads_sniper_kill", var_6, var_6, var_5, undefined, var_4 );
                    else
                        var_0 scripts\mp\potg::processevent( "airborne_ads_kill", var_6, var_6, var_5, undefined, var_4 );
                }

                break;
            case "victim_airborne":
                if ( var_7 == "weapon_sniper" )
                    var_0 scripts\mp\potg::processevent( "victim_airborne_sniper", var_6, var_6, var_5, undefined, var_4 );
                else
                    var_0 scripts\mp\potg::processevent( "victim_airborne", var_6, var_6, var_5, undefined, var_4 );

                break;
            case "longshot":
                if ( !isdefined( var_0.modifiers["very_longshot"] ) )
                    var_0 scripts\mp\potg::processevent( "longshot", var_6, var_6, var_5, undefined, var_4 );

                break;
            case "last_bullet_kill":
                if ( var_7 != "weapon_sniper" && var_7 != "weapon_projectile" )
                    var_0 scripts\mp\potg::processevent( "last_bullet_kill", var_6, var_6, var_5, undefined, var_4 );

                break;
            case "victim_sprinting":
                if ( var_7 == "weapon_sniper" )
                    var_0 scripts\mp\potg::processevent( "victim_sprinting_sniper", var_6, var_6, var_5, undefined, var_4 );

                break;
            default:
                if ( scripts\mp\potg::eventtable_isevent( var_10 ) )
                    var_0 scripts\mp\potg::processevent( var_10, var_6, var_6, var_5, undefined, var_4 );

                break;
        }
    }
}

collateral( var_0, var_1 )
{
    if ( !level.potgenabled )
        return;

    if ( var_1 == 2 )
        var_0 scripts\mp\potg::processevent( "collateral" );
    else if ( var_1 == 3 )
        var_0 scripts\mp\potg::processevent( "triple_collateral" );
    else
        var_0 scripts\mp\potg::processevent( "multi_collateral" );
}

shotguncollateral( var_0, var_1 )
{
    if ( !level.potgenabled )
        return;

    if ( var_1 == 2 )
        var_0 scripts\mp\potg::processevent( "shotgun_collateral" );
    else
        var_0 scripts\mp\potg::processevent( "shotgun_multi_collateral" );
}

quadfeed( var_0, var_1, var_2 )
{
    if ( !level.potgenabled )
        return;

    var_0 scripts\mp\potg::processevent( "quad_feed", var_1, var_2 );
}

processeventforwitnesses( var_0, var_1, var_2, var_3, var_4 )
{
    var_5 = scripts\common\utility::playersnear( var_0, 1000 );

    foreach ( var_7 in var_5 )
    {
        if ( !scripts\mp\utility\player::isreallyalive( var_7 ) )
            continue;

        var_8 = var_0 - var_7 geteye();
        var_9 = anglestoforward( var_7 getplayerangles() );

        if ( vectordot( var_8, var_9 ) < 0 )
            continue;

        var_7 scripts\mp\potg::processevent( var_2, var_3, var_4 );
    }
}

watchforpostkilllanding()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    var_0 = getentityeventdata();

    for (;;)
    {
        if ( self isonground() )
        {
            var_0.inairsincelastkill = 0;
            break;
        }

        waitframe();
    }
}

predatormissileimpact( var_0 )
{
    if ( !level.potgenabled )
        return;

    processeventforwitnesses( var_0, 1000000, "witness_predator_impact" );
}

largevehicleexplosion( var_0 )
{
    if ( !level.potgenabled )
        return;

    processeventforwitnesses( var_0, 640000, "witness_vehicle_explode" );
}

vehiclekilled( var_0 )
{
    if ( !level.potgenabled )
        return;

    if ( !isdefined( var_0.attacker ) || !isplayer( var_0.attacker ) )
        return;

    var_0.attacker scripts\mp\potg::processevent( "vehicle_destroyed" );
}

missilewhizby( var_0 )
{
    if ( !level.potgenabled )
        return;

    var_0 scripts\mp\potg::processevent( "witness_missile_whizby" );
}

bombdefused( var_0, var_1, var_2 )
{
    if ( !level.potgenabled )
        return;

    if ( var_2 )
        var_0 scripts\mp\potg::processevent( "ninja_defuse" );
    else if ( var_1 )
        var_0 scripts\mp\potg::processevent( "last_alive_defuse" );
    else
        var_0 scripts\mp\potg::processevent( "defuse" );
}

revivedplayer( var_0, var_1 )
{
    if ( !level.potgenabled )
        return;

    var_0 scripts\mp\potg::processevent( "revived_ally" );
}

playerworlddeath( var_0, var_1 )
{
    if ( !level.potgenabled )
        return;

    var_2 = getentityeventdata();

    if ( istrue( var_2.inairsincelastkill ) )
        var_0 scripts\mp\potg::processevent( "fall_to_death_kill", var_2.lastinairkilltime, gettime() );
}

doorused( var_0, var_1 )
{
    if ( !level.potgenabled )
        return;

    if ( !var_1 && isdefined( var_0.lastkilltime ) && gettime() - var_0.lastkilltime < 2000 )
        var_0 scripts\mp\potg::processevent( "closed_door_after_kill" );
}

playerstancechanged( var_0 )
{
    if ( !level.potgenabled || !( isdefined( self.petwatch ) && self.petwatch._id_12314 == "pet_turbo" ) )
        return;

    var_1 = getentityeventdata();
    var_2 = gettime();

    if ( var_0 == "crouch" )
    {
        scripts\mp\potg::processevent( "recent_crouch" );

        if ( isdefined( self.lastkillvictimpos ) )
        {
            if ( distancesquared( self.lastkillvictimpos, self.origin ) < 40000 )
            {
                var_3 = var_2 - self.laststancetimes["crouch"];

                if ( var_3 < 750 )
                {
                    var_4 = isdefined( self.lastspawntime ) && ( isdefined( var_1.lastteabagtime ) && self.lastspawntime < var_1.lastteabagtime );

                    if ( !var_4 )
                        scripts\mp\potg::processevent( "teabag" );

                    if ( !isdefined( var_1.lastteabagtime ) || var_2 - var_1.lastteabagtime > 5000 )
                    {
                        if ( !isdefined( self.pers["teaBags"] ) )
                            self.pers["teaBags"] = 0;

                        self.pers["teaBags"]++;
                        scripts\cp_mp\pet_watch::bearwatch();
                    }

                    var_1.lastteabagtime = var_2;
                }
            }
        }
    }
    else if ( var_0 == "prone" )
        scripts\mp\potg::processevent( "recent_prone" );
}

shothit()
{
    if ( !level.potgenabled )
        return;

    var_0 = getentityeventdata();
    updateshotgroup( 1 );
}

shotmissed()
{
    if ( !level.potgenabled )
        return;

    var_0 = getentityeventdata();
    updateshotgroup( 0 );
}

updateshotgroup( var_0 )
{
    if ( !level.potgenabled )
        return;

    var_1 = getentityeventdata();
    var_2 = scripts\engine\utility::ter_op( var_0, 1.0, 0.0 );
    var_1.shotgroupaccuracy = ( var_1.shotgroupaccuracy * var_1.shotgroupcount + var_2 ) / ( var_1.shotgroupcount + 1 );
    var_1.shotgroupcount++;
    thread shotgroupendwatcher();
}

shotgroupendwatcher()
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "clearShotGroup" );
    self notify( "shotGroupEndWatcher()" );
    self endon( "shotGroupEndWatcher()" );

    if ( !level.potgenabled )
        return;

    var_0 = getentityeventdata();
    var_0.shotgroupactive = 1;
    wait 2.0;
    clearshotgroup();
}

clearshotgroup()
{
    if ( !level.potgenabled )
        return;

    var_0 = getentityeventdata();
    var_0.shotgroupactive = 0;
    var_0.shotgrouplastcount = var_0.shotgroupcount;
    var_0.shotgrouplastaccuracy = var_0.shotgroupaccuracy;
    var_0.shotgroupcount = 0;
    var_0.shotgroupaccuracy = 0;
    self notify( "clearShotGroup" );
}

grenadethrownevent( var_0 )
{
    if ( !level.potgenabled )
        return;

    if ( var_0 )
        scripts\mp\potg::processevent( "recent_lethal" );
    else
        scripts\mp\potg::processevent( "recent_tactical" );
}

crouch()
{
    if ( !level.potgenabled )
        return;

    scripts\mp\potg::processevent( "recent_crouch" );
}

jump()
{
    if ( !level.potgenabled )
        return;

    scripts\mp\potg::processevent( "recent_jump" );
}

prone()
{
    if ( !level.potgenabled )
        return;

    scripts\mp\potg::processevent( "recent_prone" );
}

slide()
{
    if ( !level.potgenabled )
        return;

    scripts\mp\potg::processevent( "recent_slide" );
}

mantle()
{
    if ( !level.potgenabled )
        return;

    scripts\mp\potg::processevent( "recent_mantle" );
}