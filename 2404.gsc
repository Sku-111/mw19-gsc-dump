// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

hasplayerdiedwhileusingkillstreak( var_0 )
{
    return var_0.lifeid != scripts\cp_mp\utility\killstreak_utility::getcurrentplayerlifeidforkillstreak();
}

addtoactivekillstreaklist( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = self getentitynumber();
    self.activeid = var_2 getactivekillstreakid();

    if ( isdefined( var_0 ) )
    {
        if ( isremotekillstreak( var_0 ) )
        {
            addtoremotekillstreaklist( var_7 );
            thread removefromremotekillstreaklistondeath( var_7 );
        }

        if ( isuavkillstreak( var_0 ) )
        {
            addtouavlist( var_7, var_2 );
            thread removefromuavlistondeath( var_7, var_2 );
        }
        else if ( isairstrikekillstreak( var_0 ) )
        {
            addtoairstrikelist( var_7 );
            thread removefromairstrikelistondeath( var_7 );
        }
        else if ( islittlebirdkillstreak( var_0 ) )
        {
            addtolittlebirdlist( var_7 );
            thread removefromlittlebirdlistondeath( var_7 );
        }
        else if ( ishelikillstreak( var_0 ) )
        {
            addtohelilist( var_7 );
            thread removefromhelilistondeath( var_7 );
        }
        else if ( isturretkillstreak( var_0 ) )
        {
            addtoturretlist( var_7 );
            thread removefromturretlistondeathorcarry( var_7 );
        }
        else if ( iscarrykillstreak( var_0 ) )
        {
            addtocarrylist( var_7 );
            thread removefromcarrylistondeathorcarry( var_7 );
        }
        else if ( isprojectilekillstreak( var_0 ) )
        {
            addtoprojectilelist( var_7 );
            thread removefromprojectilelistondeath( var_7 );
        }
        else if ( issupportdronekillstreak( var_0 ) )
        {
            addtosupportdronelist( var_7 );
            thread removefromsupportdronelistondeath( var_7 );
        }
        else if ( isassaultdronekillstreak( var_0 ) )
        {
            addtoassaultdronelist( var_7 );
            thread removefromassaultdronelistondeath( var_7 );
        }
        else
        {
            addtoplayerkillstreaklist( var_7 );
            thread removefromplayerkillstreaklistondeath( var_7 );
        }

        if ( iskillstreaklockonable( var_0 ) )
            self.affectedbylockon = 1;
    }

    level.activekillstreaks[var_7] = self;
    level.activekillstreaks[var_7].streakname = var_0;

    if ( var_1 == "Killstreak_Air" )
    {
        self.isairkillstreak = 1;

        if ( !isdefined( var_0 ) || var_0 != "directional_uav" && var_0 != "harp" )
            self enableplayermarks( "air_killstreak" );
    }
    else
    {
        self.isairkillstreak = 0;
        self enableplayermarks( "killstreak" );
    }

    if ( level.teambased )
        self filteroutplayermarks( var_2.team );
    else
        self filteroutplayermarks( var_2 );

    if ( istrue( var_3 ) )
    {
        var_8 = undefined;
        var_9 = undefined;

        if ( level.teambased )
        {
            if ( scripts\cp_mp\utility\killstreak_utility::isridekillstreak( var_0 ) )
            {
                foreach ( var_11 in level.players )
                {
                    if ( var_11.team == self.team && var_11 != self.owner )
                        var_8 = scripts\mp\utility\outline::outlineenableforplayer( self, var_11, "outline_nodepth_cyan", "lowest" );

                    if ( isdefined( var_8 ) )
                        thread removeoutlineonnotify( var_8, var_6 );
                }

                var_9 = 1;
            }
            else
                var_8 = scripts\mp\utility\outline::outlineenableforteam( self, var_2.team, "outline_nodepth_cyan", "lowest" );
        }
        else
            var_8 = scripts\mp\utility\outline::outlineenableforplayer( self, var_2, "outline_nodepth_cyan", "lowest" );

        if ( !istrue( var_9 ) )
            thread removeoutlineonnotify( var_8, var_6 );
    }

    if ( istrue( var_4 ) )
    {
        var_13 = 0;

        if ( var_2 scripts\mp\utility\player::isusingremote() )
            var_13 = 1;

        var_14 = undefined;

        if ( level.teambased )
            var_14 = thread scripts\cp_mp\entityheadicons::setheadicon_factionimage( 0, var_5, 1, 10000, undefined, undefined, 1, var_13 );
        else
        {
            if ( istrue( var_13 ) )
                return;

            var_14 = thread scripts\cp_mp\entityheadicons::setheadicon_singleimage( var_2, "hud_icon_head_equipment_friendly", var_5, 1, 10000, undefined, undefined, 1 );
        }

        thread removeteamheadicononnotify( var_14, var_6 );
    }
}

getactivekillstreakid()
{
    if ( !isdefined( self.pers["nextActiveID"] ) )
        self.pers["nextActiveID"] = 0;

    var_0 = self.pers["nextActiveID"];
    self.pers["nextActiveID"]++;
    return var_0;
}

removeoutlineonnotify( var_0, var_1 )
{
    var_2 = [ "death" ];

    if ( isdefined( var_1 ) )
        var_2[var_2.size] = var_1;

    scripts\engine\utility::waittill_any_in_array_return_no_endon_death( var_2 );
    scripts\mp\utility\outline::outlinedisable( var_0, self );
}

removeteamheadicononnotify( var_0, var_1 )
{
    var_2 = [ "death" ];

    if ( isdefined( var_1 ) )
        var_2[var_2.size] = var_1;

    scripts\engine\utility::waittill_any_in_array_return_no_endon_death( var_2 );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var_0 );
}

removefromactivekillstreaklist( var_0 )
{
    level.activekillstreaks[var_0] = undefined;
}

activekillstreaklistcontains( var_0 )
{
    if ( !isdefined( level.activekillstreaks ) )
        return 0;

    return isdefined( level.activekillstreaks[var_0] );
}

addtoremotekillstreaklist( var_0 )
{
    if ( !isdefined( level.remotekillstreaks ) )
        level.remotekillstreaks = [];

    level.remotekillstreaks[var_0] = self;
}

removefromremotekillstreaklistondeath( var_0 )
{
    self waittill( "death" );
    level.remotekillstreaks[var_0] = undefined;
}

addtouavlist( var_0, var_1 )
{
    if ( !isdefined( level.uavmodels ) )
        level.uavmodels = [];

    if ( level.teambased )
    {
        var_2 = undefined;

        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) )
            var_2 = level [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]();

        if ( istrue( var_2 ) && getdvarint( "scr_uav_for_squad_only", 1 ) )
        {
            var_3 = var_1.team + var_1.squadindex;
            level.uavmodels[var_3][level.uavmodels[var_3].size] = self;
            return;
        }

        level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
        return;
    }
    else
        level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

removefromuavlistondeath( var_0, var_1 )
{
    self waittill( "death" );

    if ( isdefined( self.uavrig ) )
        self.uavrig delete();

    if ( level.teambased )
    {
        var_2 = undefined;

        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "game", "squadAsTeamEnabled" ) )
            var_2 = level [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "game", "squadAsTeamEnabled" ) ]]();

        if ( istrue( var_2 ) && getdvarint( "scr_uav_for_squad_only", 1 ) )
        {
            var_3 = var_1.team + var_1.squadindex;
            level.uavmodels[var_3] = scripts\engine\utility::array_removeundefined( level.uavmodels[var_3] );
        }
        else
            level.uavmodels[self.team] = scripts\engine\utility::array_removeundefined( level.uavmodels[self.team] );
    }
    else
        level.uavmodels = scripts\engine\utility::array_removeundefined( level.uavmodels );

    if ( isdefined( self ) )
        self delete();

    removefromactivekillstreaklist( var_0 );
}

addtoairstrikelist( var_0 )
{
    if ( !isdefined( level.airstrikemodels ) )
        level.airstrikemodels = [];

    level.airstrikemodels[var_0] = self;
}

removefromairstrikelistondeath( var_0 )
{
    self waittill( "death" );
    level.airstrikemodels[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtolittlebirdlist( var_0 )
{
    if ( !isdefined( level.littlebirds ) )
        level.littlebirds = [];

    level.littlebirds[var_0] = self;
}

removefromlittlebirdlistondeath( var_0 )
{
    self waittill( "death" );
    level.littlebirds[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtohelilist( var_0 )
{
    if ( !isdefined( level.helis ) )
        level.helis = [];

    level.helis[var_0] = self;
}

removefromhelilist( var_0 )
{
    level.helis[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

removefromhelilistondeath( var_0 )
{
    self waittill( "death" );
    level.helis[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtoturretlist( var_0 )
{
    if ( !isdefined( level.turrets ) )
        level.turrets = [];

    level.turrets[var_0] = self;
}

removefromturretlistondeathorcarry( var_0 )
{
    scripts\engine\utility::_id_143A5( "death", "carried" );
    level.turrets[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtocarrylist( var_0 )
{
    if ( !isdefined( level.deployables ) )
        level.deployables = [];

    level.deployables[var_0] = self;
}

removefromcarrylistondeathorcarry( var_0 )
{
    scripts\engine\utility::_id_143A5( "death", "carried" );
    level.deployables[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtosupportdronelist( var_0 )
{
    if ( !isdefined( level.supportdrones ) )
        level.supportdrones = [];

    level.supportdrones[var_0] = self;
}

removefromsupportdronelistondeath( var_0 )
{
    self waittill( "death" );
    level.supportdrones[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtoassaultdronelist( var_0 )
{
    if ( !isdefined( level.assaultdrones ) )
        level.assaultdrones = [];

    level.assaultdrones[var_0] = self;
}

removefromassaultdronelistondeath( var_0 )
{
    self waittill( "death" );
    level.assaultdrones[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtoprojectilelist( var_0 )
{
    if ( !isdefined( level.projectilekillstreaks ) )
        level.projectilekillstreaks = [];

    level.projectilekillstreaks[var_0] = self;
}

removefromprojectilelistondeath( var_0 )
{
    self waittill( "death" );
    level.projectilekillstreaks[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

addtoplayerkillstreaklist( var_0 )
{
    if ( !isdefined( level.playerkillstreaks ) )
        level.playerkillstreaks = [];

    level.playerkillstreaks[var_0] = self;
}

removefromplayerkillstreaklistondeath( var_0 )
{
    self waittill( "death" );
    level.playerkillstreaks[var_0] = undefined;
    removefromactivekillstreaklist( var_0 );
}

setkillstreakcontrolpriority( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    self makeusable();
    self setcursorhint( "HINT_NOICON" );
    self sethintonobstruction( "show" );
    self sethintstring( var_1 );
    self sethintdisplayfov( var_2 );
    self setusefov( var_3 );
    self sethintdisplayrange( var_4 );
    self setuserange( var_5 );
    self setusepriority( 1 );
    level thread applyplayercontrolonconnect( self );

    foreach ( var_9 in level.players )
    {
        if ( var_9 == var_0 && !istrue( var_7 ) )
        {
            self enableplayeruse( var_9 );
            continue;
        }

        self disableplayeruse( var_9 );
    }
}

applyplayercontrolonconnect( var_0 )
{
    var_0 endon( "death" );
    level endon( "game_ended" );

    for (;;)
    {
        level waittill( "connected", var_1 );
        var_0 disableplayeruse( var_1 );
    }
}

applykillstreakplayeroutline( var_0, var_1 )
{
    var_2 = self.team;
    var_3 = self.owner;
    var_4 = undefined;
    var_5 = undefined;

    if ( !var_0 scripts\cp_mp\utility\player_utility::_isalive() || var_0.team == "spectator" || var_0.team == "follower" )
        return;

    if ( var_0 == var_3 )
        var_4 = "outlinefill_depth_cyan";
    else if ( var_0 != var_3 )
    {
        if ( level.teambased && var_0.team != var_2 || !level.teambased )
        {
            var_4 = "outlinefill_depth_orange";
            var_5 = 1;
        }
        else
            return;
    }

    if ( isdefined( var_4 ) )
    {
        if ( istrue( var_5 ) )
        {
            if ( var_0 scripts\mp\utility\perk::_hasperk( "specialty_noplayertarget" ) )
                return;
        }

        var_6 = scripts\mp\utility\outline::outlineenableforplayer( var_0, self.owner, var_4, "killstreak" );
        thread watchoutlineremoveonkillstreakend( var_6, var_0, var_1 );
        thread watchoutlineremoveonplayerend( var_6, var_0, var_1 );
    }
}

watchoutlineremoveonkillstreakend( var_0, var_1, var_2 )
{
    var_1 endon( "death_or_disconnect" );
    level endon( "game_ended" );
    self waittill( var_2 );
    scripts\mp\utility\outline::outlinedisable( var_0, var_1 );
}

watchoutlineremoveonplayerend( var_0, var_1, var_2 )
{
    self endon( var_2 );
    level endon( "game_ended" );
    var_1 waittill( "death_or_disconnect" );
    scripts\mp\utility\outline::outlinedisable( var_0, var_1 );
}

getmodifiedantikillstreakdamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_3 = scripts\mp\damage::handleshotgundamage( var_1, var_2, var_3 );
    var_3 = scripts\mp\damage::handleapdamage( var_1, var_2, var_3, var_0 );
    var_11 = var_1.isalternatemode;
    var_12 = 0;

    if ( istrue( var_11 ) )
    {
        var_13 = scripts\mp\utility\weapon::getweaponattachmentsbasenames( var_1 );

        foreach ( var_15 in var_13 )
        {
            if ( var_15 == "gl" )
            {
                var_12 = 1;
                break;
            }
        }
    }

    var_17 = undefined;

    if ( var_2 != "MOD_MELEE" )
    {
        switch ( var_1.basename )
        {
            case "nuke_mp":
            case "cruise_proj_mp":
                self.largeprojectiledamage = 1;
                self.killoneshot = 1;
                var_17 = 1;
                break;
            case "fuelstrike_proj_mp":
            case "emp_drone_non_player_direct_mp":
            case "emp_drone_non_player_mp":
            case "assault_drone_mp":
            case "hover_jet_proj_mp":
            case "ac130_105mm_mp":
            case "apache_proj_mp":
            case "at_mine_mp":
            case "iw8_la_gromeoks_mp":
            case "iw8_la_juliet_mp":
            case "iw8_la_rpapa7_mp":
            case "iw8_la_kgolf_mp":
            case "iw8_la_gromeo_mp":
            case "iw8_la_t9freefire_mp":
            case "iw8_la_t9standard_mp":
            case "bradley_tow_proj_ks_mp":
            case "bradley_tow_proj_mp":
                self.largeprojectiledamage = 1;
                var_17 = var_5;
                break;
            case "big_bird_mp":
            case "motorcycle_mp":
            case "little_bird_mg_mp":
            case "van_mp":
            case "med_transport_mp":
            case "pickup_truck_mp":
            case "large_transport_mp":
            case "tac_rover_mp":
            case "cargo_truck_mg_mp":
            case "technical_mp":
            case "hoopty_truck_mp":
            case "hoopty_mp":
            case "cop_car_mp":
            case "apc_rus_mp":
            case "cargo_truck_mp":
            case "atv_mp":
            case "lighttank_mp":
            case "white_phosphorus_proj_mp":
            case "emp_grenade_mp":
            case "ac130_40mm_mp":
            case "toma_proj_mp":
            case "little_bird_mp":
            case "lighttank_tur_ks_mp":
            case "lighttank_tur_mp":
                self.largeprojectiledamage = 1;
                var_17 = var_6;
                break;
            case "ac130_25mm_mp":
            case "artillery_mp":
            case "semtex_aalpha12_mp":
            case "semtex_xmike109_mp":
            case "semtex_bolt_mp":
            case "claymore_mp":
            case "at_mine_ap_mp":
            case "c4_mp_p":
            case "semtex_mp":
            case "frag_grenade_mp":
            case "pac_sentry_turret_mp":
                self.largeprojectiledamage = 0;
                var_17 = var_7;
                break;
            case "thermite_xmike109_radius_mp":
            case "thermite_bolt_radius_mp":
            case "thermite_xmike109_mp":
            case "thermite_bolt_mp":
            case "thermite_av_mp":
                self.largeprojectiledamage = 0;
                var_17 = var_9;
                break;
        }
    }
    else
    {
        self.largeprojectiledamage = 0;
        var_17 = var_8;
    }

    if ( isdefined( var_10 ) )
        self.largeprojectiledamage = var_10;

    if ( isdefined( var_17 ) && isdefined( var_2 ) && ( var_2 == "MOD_EXPLOSIVE" || var_2 == "MOD_EXPLOSIVE_BULLET" || var_2 == "MOD_FIRE" || var_2 == "MOD_PROJECTILE" || var_2 == "MOD_PROJECTILE_SPLASH" || var_2 == "MOD_GRENADE" || var_2 == "MOD_GRENADE_SPLASH" || var_2 == "MOD_MELEE" ) )
        var_3 = ceil( var_4 / var_17 );

    var_18 = 0;

    if ( isdefined( var_0 ) && isdefined( self.owner ) && !var_18 )
    {
        if ( isdefined( var_0.owner ) )
            var_0 = var_0.owner;

        if ( var_0 == self.owner && !istrue( self.killoneshot ) )
            var_3 = ceil( var_3 / 2 );
    }

    return int( var_3 );
}

isexplosiveantikillstreakweapon( var_0 )
{
    var_1 = 0;
    var_2 = 0;

    if ( isstring( var_0 ) )
        var_2 = issubstr( var_0, "alt_" );
    else if ( issameweapon( var_0 ) )
        var_2 = var_0.isalternate;

    var_3 = 0;

    if ( istrue( var_2 ) )
    {
        var_4 = scripts\mp\utility\weapon::getweaponattachmentsbasenames( var_0 );

        foreach ( var_6 in var_4 )
        {
            if ( var_6 == "gl" )
            {
                var_3 = 1;
                break;
            }
        }
    }

    var_8 = scripts\mp\utility\weapon::getweaponbasenamescript( var_0 );

    switch ( var_8 )
    {
        case "power_exploding_drone_mp":
        case "sentry_shock_missile_mp":
        case "kineticpulse_emp_mp":
        case "switch_blade_child_mp":
        case "jackal_cannon_mp":
        case "drone_hive_projectile_mp":
        case "emp_grenade_mp":
        case "pop_rocket_mp":
        case "artillery_mp":
        case "c4_mp_p":
        case "iw8_la_juliet_mp":
        case "iw8_la_rpapa7_mp":
        case "iw8_la_t9freefire_mp":
        case "super_trophy_mp":
            var_1 = 1;
            break;
    }

    return var_1;
}

nulldamagecheck( var_0 )
{
    return isdefined( var_0 ) && var_0 == self.owner;
}

dodamagetokillstreak( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = ( 0, 0, 0 );
    var_8 = ( 0, 0, 0 );
    var_9 = ( 0, 0, 0 );
    var_10 = ( 0, 0, 0 );
    var_11 = "";
    var_12 = "";
    var_13 = "";
    var_14 = undefined;

    if ( isdefined( var_3 ) )
    {
        if ( level.teambased )
        {
            if ( !scripts\mp\utility\entity::isvalidteamtarget( var_1, var_3, self ) )
                return;
        }
        else if ( !scripts\mp\utility\entity::isvalidffatarget( var_1, var_3, self ) )
            return;
    }

    if ( isagent( self ) )
        self dodamage( var_0, var_4, var_1, var_2, var_5, var_6 );
    else if ( scripts\cp_mp\vehicles\vehicle::isvehicle() )
        self dodamage( var_0, var_4, var_1, var_2, var_5, var_6 );
    else
    {
        var_15 = asmdevgetallstates( var_6 );
        self notify( "damage", var_0, var_1, var_7, var_8, var_5, var_11, var_12, var_13, var_14, var_15, var_4, var_9, var_10, var_2 );
    }
}

playdlightfx( var_0, var_1 )
{
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        var_0 = ( 0, 0, 0 );

    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    var_2 = scripts\engine\utility::getfx( "dlight_large" );

    if ( istrue( self.isairdrop ) )
        var_2 = scripts\engine\utility::getfx( "dlight_small" );

    self.fxdlightent = spawn( "script_model", self.origin );
    self.fxdlightent setmodel( "tag_origin" );
    self.fxdlightent linkto( self, "tag_origin", var_0, var_1 );
    self.fxdlightent thread deleteonparentdeath( self );
    wait 0.1;
    playfxontag( var_2, self.fxdlightent, "tag_origin" );
}

deleteonparentdeath( var_0 )
{
    self endon( "death" );
    var_0 waittill( "death" );

    if ( isdefined( self ) )
        self delete();
}

isaffectedbyblindeye( var_0 )
{
    switch ( var_0 )
    {
        case "jackal":
        case "sentry_shock":
            return 1;
    }

    return 0;
}

getplayerkillstreakcombatmode( var_0 )
{
    var_1 = "NONE";

    if ( isdefined( var_0.owner ) && isdefined( var_0.owner.currentcombatmode ) )
        var_1 = var_0.owner.currentcombatmode;

    return var_1;
}

watchsupertrophynotify( var_0 )
{
    var_0 endon( "disconnect" );
    self endon( "explode" );

    for (;;)
    {
        var_0 waittill( "destroyed_by_trophy", var_1, var_2, var_3, var_4, var_5 );

        if ( var_3 != self.weapon_name )
            continue;

        var_0 scripts\mp\damagefeedback::updatedamagefeedback( "" );
        break;
    }
}

watchhostmigrationlifetime( var_0, var_1, var_2 )
{
    if ( var_0 != "death" )
        self endon( "death" );

    self endon( var_0 );
    level endon( "game_ended" );
    var_3 = gettime() + int( var_1 * 1000 );
    level waittill( "host_migration_begin" );
    self notify( "host_migration_lifetime_update" );
    var_4 = gettime();
    var_5 = var_3 - var_4;
    level waittill( "host_migration_end" );
    var_6 = gettime();
    var_7 = var_6 + var_5;
    var_5 = var_5 / 1000;

    if ( isdefined( self.streakname ) && scripts\cp_mp\utility\killstreak_utility::isridekillstreak( self.streakname ) )
        self.owner setclientomnvar( "ui_killstreak_countdown", var_7 );

    self [[ var_2 ]]( var_5 );
}

getenemytargets( var_0 )
{
    var_1 = [];

    foreach ( var_3 in level.players )
    {
        if ( var_0 scripts\mp\utility\player::isenemy( var_3 ) )
            var_1[var_1.size] = var_3;
    }

    return var_1;
}

_beginlocationselection( var_0, var_1, var_2, var_3 )
{
    self beginlocationselection( var_1, var_2, 0, var_3 );
    self.selectinglocation = 1;
    self setblurforplayer( 10.3, 0.3 );
    thread endselectiononaction( "cancel_location" );
    thread endselectiononaction( "death" );
    thread endselectiononaction( "disconnect" );
    thread endselectiononaction( "used" );
    thread endselectiononaction( "weapon_change" );
    self endon( "stop_location_selection" );
    thread endselectiononendgame();

    if ( isdefined( var_0 ) && self.team != "spectator" && self.team != "follower" )
    {
        if ( isdefined( self.streakmsg ) )
            self.streakmsg destroy();

        if ( self issplitscreenplayer() )
        {
            self.streakmsg = scripts\mp\hud_util::createfontstring( "default", 1.3 );
            self.streakmsg scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, -98 );
        }
        else
        {
            self.streakmsg = scripts\mp\hud_util::createfontstring( "default", 1.6 );
            self.streakmsg scripts\mp\hud_util::setpoint( "CENTER", "CENTER", 0, -190 );
        }
    }
}

stoplocationselection( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = "generic";

    if ( !var_0 )
    {
        self setblurforplayer( 0, 0.3 );
        self endlocationselection();
        self.selectinglocation = undefined;

        if ( isdefined( self.streakmsg ) )
            self.streakmsg destroy();
    }

    self notify( "stop_location_selection", var_1 );
}

endselectiononaction( var_0 )
{
    self endon( "stop_location_selection" );
    self waittill( var_0 );
    thread stoplocationselection( var_0 == "disconnect", var_0 );
}

endselectiononendgame()
{
    self endon( "stop_location_selection" );
    level waittill( "game_ended" );
    thread stoplocationselection( 0, "end_game" );
}

streakshouldchain( var_0 )
{
    var_1 = scripts\mp\killstreaks\killstreaks::calcstreakcost( var_0 );
    var_2 = scripts\mp\killstreaks\killstreaks::getnextstreakname();
    var_3 = scripts\mp\killstreaks\killstreaks::calcstreakcost( var_2 );
    return var_1 < var_3;
}

streakcheckistargetindoors( var_0, var_1 )
{
    var_2 = 0;
    var_3 = scripts\engine\trace::create_contents( 0, 1, 0, 1, 1, 0 );

    if ( !scripts\engine\trace::ray_trace_passed( var_0, var_0 + ( 0, 0, 10000 ), var_1, var_3 ) )
        var_2 = 1;

    return var_2;
}

validateusestreak( var_0, var_1 )
{
    if ( ( !self isonground() || self iswallrunning() ) && scripts\cp_mp\utility\killstreak_utility::isridekillstreak( var_0 ) )
    {
        scripts\mp\hud_message::showerrormessage( "KILLSTREAKS/UNAVAILABLE" );
        return 0;
    }

    if ( isdefined( self.selectinglocation ) )
        return 0;

    if ( scripts\mp\utility\game::isairdenied() )
    {
        if ( isflyingkillstreak( var_0 ) )
        {
            if ( !( isdefined( var_1 ) && var_1 ) )
                scripts\mp\hud_message::showerrormessage( "KILLSTREAKS_UNAVAILABLE_WHEN_AA" );

            return 0;
        }
    }

    if ( self isusingturret() && ( scripts\cp_mp\utility\killstreak_utility::isridekillstreak( var_0 ) || iscarrykillstreak( var_0 ) || isturretkillstreak( var_0 ) ) )
    {
        if ( !( isdefined( var_1 ) && var_1 ) )
            scripts\mp\hud_message::showerrormessage( "KILLSTREAKS/UNAVAILABLE_USING_TURRET" );

        return 0;
    }

    if ( !scripts\common\utility::is_weapon_allowed() )
        return 0;

    if ( isdefined( level.civilianjetflyby ) && isflyingkillstreak( var_0 ) )
    {
        if ( !( isdefined( var_1 ) && var_1 ) )
        {

        }

        return 0;
    }

    if ( isdefined( var_0 ) && var_0 == "sentry_shock" && scripts\mp\arbitrary_up::isinarbitraryup() )
    {
        if ( !( isdefined( var_1 ) && var_1 ) )
            scripts\mp\hud_message::showerrormessage( "KILLSTREAKS/UNAVAILABLE" );

        return 0;
    }

    return 1;
}

isplayerkillstreak( var_0 )
{
    if ( !isdefined( var_0.activeplayerstreak ) )
        return 0;

    switch ( var_0.activeplayerstreak )
    {
        default:
            return 0;
    }
}

iscarrykillstreak( var_0 )
{
    switch ( var_0 )
    {
        default:
            return 0;
    }
}

isremotekillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "radar_drone_recon":
        case "assault_drone":
        case "gunship":
        case "chopper_gunner":
        case "cruise_predator":
        case "pac_sentry":
            var_1 = 1;
            break;
    }

    return var_1;
}

isuavkillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "harp":
        case "counter_uav":
        case "directional_uav":
        case "uav":
            var_1 = 1;
            break;
    }

    return var_1;
}

isairstrikekillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "multi_airstrike":
        case "white_phosphorus":
        case "hover_jet":
        case "gunship":
        case "fuel_airstrike":
        case "toma_strike":
        case "precision_airstrike":
            var_1 = 1;
            break;
    }

    return var_1;
}

islittlebirdkillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "airdrop":
            var_1 = 1;
            break;
    }

    return var_1;
}

ishelikillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "chopper_support":
        case "chopper_gunner":
            var_1 = 1;
            break;
    }

    return var_1;
}

isballdronekillstreak( var_0 )
{
    var_1 = 0;
    return var_1;
}

isturretkillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "manual_turret":
            var_1 = 1;
            break;
    }

    return var_1;
}

isprojectilekillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "cruise_predator":
            var_1 = 1;
            break;
    }

    return var_1;
}

issupportdronekillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "scrambler_drone_escort":
        case "radar_drone_escort":
        case "radar_drone_recon":
        case "assault_drone":
        case "radar_drone_overwatch":
        case "scrambler_drone_guard":
            var_1 = 1;
            break;
    }

    return var_1;
}

isassaultdronekillstreak( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "pac_sentry":
            var_1 = 1;
            break;
    }

    return var_1;
}

iscarepackage( var_0 )
{
    return isdefined( var_0 ) && isdefined( var_0.id ) && var_0.id == "care_package";
}

isjuggernaut()
{
    return istrue( self.isjuggernaut );
}

isremotekillstreakweapon( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "ks_remote_bomber_mp":
        case "ks_remote_hack_mp":
        case "ks_assault_drone_mp":
        case "ks_remote_drone_mp":
        case "ks_remote_nuke_mp":
        case "ks_remote_map_mp":
        case "ks_remote_gunship_mp":
        case "ks_remote_device_mp":
            var_1 = 1;
            break;
    }

    return var_1;
}

iskillstreaklockonable( var_0 )
{
    switch ( var_0 )
    {
        case "harp":
        case "directional_uav":
        case "cruise_predator":
            return 0;
        default:
            return 1;
    }
}

isflyingkillstreak( var_0 )
{
    switch ( var_0 )
    {
        case "drone_hive":
        case "heli_pilot":
        case "airdrop_sentry_minigun":
        case "helicopter":
        case "airdrop_assault":
        case "airdrop":
        case "gunship":
        case "precision_airstrike":
            return 1;
        default:
            return 0;
    }
}

getkillstreakindex( var_0 )
{
    return level.killstreakglobals.streaktable.tabledatabyref[var_0]["index"];
}

getkillstreakkills( var_0 )
{
    var_1 = "kills";

    if ( scripts\mp\utility\perk::_hasperk( "specialty_killstreak_to_scorestreak" ) && var_0 != "nuke" )
        var_1 = "scoreCost";
    else if ( scripts\mp\utility\perk::_hasperk( "specialty_support_killstreaks" ) )
        var_1 = "supportCost";

    return level.killstreakglobals.streaktable.tabledatabyref[var_0][var_1];
}

getkillstreakenemyusedialogue( var_0 )
{
    return level.killstreakglobals.streaktable.tabledatabyref[var_0]["enemyUseDialog"];
}

getkillstreakaudioref( var_0 )
{
    var_1 = getkillstreakaudiorefoverride( var_0 );

    if ( var_1 != "" )
        return var_1;

    var_2 = strtok( var_0, "_" );

    foreach ( var_4 in var_2 )
    {
        if ( var_1 == "" )
        {
            var_1 = var_4;
            continue;
        }

        var_1 = var_1 + var_4;
    }

    return var_1;
}

getkillstreakaudiorefoverride( var_0 )
{
    var_1 = "";

    switch ( var_0 )
    {
        case "scrambler_drone":
            var_1 = "scrambler";
            break;
        case "cruise_predator":
            var_1 = "predator";
            break;
        case "toma_strike":
            var_1 = "clusterstrike";
            break;
        case "precision_airstrike":
            var_1 = "a10strike";
            break;
    }

    return var_1;
}

getkillstreakoverheadicon( var_0 )
{
    return level.killstreakglobals.streaktable.tabledatabyref[var_0]["overheadIcon"];
}

currentactivevehiclecount( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = 0;

    var_1 = var_0;

    if ( isdefined( level.helis ) )
        var_1 = var_1 + level.helis.size;

    if ( isdefined( level.littlebirds ) )
        var_1 = var_1 + level.littlebirds.size;

    if ( isdefined( level.ugvs ) )
        var_1 = var_1 + level.ugvs.size;

    if ( isdefined( level.bradley ) && isdefined( level.bradley.vehicles ) )
        var_1 = var_1 + level.bradley.size;

    if ( isdefined( level.supportdrones ) )
        var_1 = var_1 + level.supportdrones.size;

    if ( isdefined( level.assaultdrones ) )
        var_1 = var_1 + level.assaultdrones.size;

    return var_1;
}

maxvehiclesallowed()
{
    return 8;
}

fauxvehiclecount()
{
    return level.fauxvehiclecount;
}

incrementfauxvehiclecount( var_0 )
{
    if ( !isdefined( var_0 ) )
        level.fauxvehiclecount++;
    else
        level.fauxvehiclecount = level.fauxvehiclecount + var_0;
}

decrementfauxvehiclecount( var_0 )
{
    if ( !isdefined( var_0 ) )
        level.fauxvehiclecount--;
    else
        level.fauxvehiclecount = level.fauxvehiclecount - var_0;

    if ( level.fauxvehiclecount < 0 )
        level.fauxvehiclecount = 0;
}

isassaultkillstreak( var_0 )
{
    switch ( var_0 )
    {
        case "drone_hive":
        case "harp":
        case "directional_uav":
        case "uav":
            return 1;
        default:
            return 0;
    }
}

isresourcekillstreak( var_0 )
{
    switch ( var_0 )
    {
        case "deployable_ammo":
        case "uav_3dping":
        case "aa_launcher":
        case "recon_agent":
        case "sam_turret":
        case "deployable_vest":
            return 1;
        default:
            return 0;
    }
}

issupportkillstreak( var_0 )
{
    switch ( var_0 )
    {
        default:
            return 0;
    }
}

isspecialistkillstreak( var_0 )
{
    switch ( var_0 )
    {
        default:
            return 0;
    }
}

gethelipilotmeshoffset()
{
    return ( 0, 0, 5000 );
}

gethelipilottraceoffset()
{
    return ( 0, 0, 2500 );
}

isnavmeshkillstreak( var_0 )
{
    var_1 = 0;
    return var_1;
}

iscontrollingproxyagent()
{
    var_0 = 0;

    if ( isdefined( self.playerproxyagent ) && isalive( self.playerproxyagent ) )
        var_0 = 1;

    return var_0;
}

killshouldaddtokillstreak( var_0 )
{
    if ( scripts\mp\utility\perk::_hasperk( "specialty_explosivebullets" ) )
        return 0;

    return !scripts\mp\utility\weapon::iskillstreakweapon( var_0.basename ) && !scripts\mp\utility\points::update_objective_setmlgbackground( var_0 );
}

iskillstreak( var_0 )
{
    return getkillstreakindex( var_0 ) != -1;
}

getairdropcrates()
{
    if ( isdefined( level.cratedata ) )
        return level.cratedata.crates;

    return [];
}

getnumairdropcrates()
{
    if ( isdefined( level.cratedata ) )
        return level.cratedata.crates.size;

    return 0;
}

attackerinremotekillstreak()
{
    if ( !isdefined( self ) )
        return 0;

    if ( isdefined( level.gunshipplayer ) && self == level.gunshipplayer )
        return 1;

    if ( isdefined( level.chopper ) && isdefined( level.chopper.gunner ) && self == level.chopper.gunner )
        return 1;

    if ( isdefined( self.using_remote_tank ) && self.using_remote_tank )
        return 1;

    return 0;
}

killstreak_make_vehicle( var_0, var_1, var_2, var_3, var_4 )
{
    self.vehiclename = var_0;
    self.scorepopup = var_1;
    self.vodestroyed = var_2;
    self.votimeout = var_3;
    self.destroyedsplash = var_4;
    self enableplayermarks( "killstreak" );

    if ( level.teambased )
        self filteroutplayermarks( self.team );
    else
        self filteroutplayermarks( self.owner );

    scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_enableownerdamage( self );
    scripts\mp\vehicles\damage::get_vehicle_mod_damage_data( var_0, 1 );
}

killstreak_vehicle_callback_init()
{
    if ( !istrue( level.kscallbackinitcomplete ) )
    {
        level.kscallbackinitcomplete = 1;
        level.kspremoddamagecallback = ::killstreak_pre_mod_damage_callback;
        level.kspostmoddamagecallback = ::killstreak_post_mod_damage_callback;
        level.ksdeathcallback = ::killstreak_death_callback;
    }
}

killstreak_pre_mod_damage_callback( var_0 )
{
    var_1 = var_0.damage;
    var_2 = var_0.attacker;

    if ( !istrue( self.killoneshot ) )
    {
        if ( isdefined( var_2 ) && isdefined( self.owner ) && var_2 == self.owner )
            var_1 = int( ceil( var_1 * 0.5 ) );

        var_0.damage = var_1;
    }

    var_3 = 1;
    var_4 = self.kspremoddamagecallback;

    if ( isdefined( var_4 ) )
        var_3 = self [[ var_4 ]]( var_0 );

    return var_3;
}

killstreak_post_mod_damage_callback( var_0 )
{
    scripts\mp\killstreaks\killstreaks::killstreakhit( var_0.attacker, var_0.objweapon, self, var_0.meansofdeath, var_0.damage );
    var_1 = 1;
    var_2 = self.kspostmoddamagecallback;

    if ( isdefined( var_2 ) )
        var_1 = self [[ var_2 ]]( var_0 );

    return var_1;
}

killstreak_death_callback( var_0 )
{
    scripts\mp\damage::onkillstreakkilled( self.streakname, var_0.attacker, var_0.objweapon, var_0.meansofdeath, var_0.damage, self.scorepopup, self.vodestroyed, self.destroyedsplash );
    var_1 = 1;
    var_2 = self.ksdeathcallback;

    if ( isdefined( var_2 ) )
        var_1 = self [[ var_2 ]]( var_0 );

    return var_1;
}

killstreak_set_pre_mod_damage_callback( var_0, var_1 )
{
    killstreak_vehicle_callback_init();
    scripts\mp\vehicles\damage::set_pre_mod_damage_callback( var_0, level.kspremoddamagecallback );
    self.kspremoddamagecallback = var_1;
}

killstreak_set_post_mod_damage_callback( var_0, var_1 )
{
    killstreak_vehicle_callback_init();
    scripts\mp\vehicles\damage::set_post_mod_damage_callback( var_0, level.kspostmoddamagecallback );
    self.kspostmoddamagecallback = var_1;
}

killstreak_set_death_callback( var_0, var_1 )
{
    killstreak_vehicle_callback_init();
    scripts\mp\vehicles\damage::set_death_callback( var_0, level.ksdeathcallback );
    self.ksdeathcallback = var_1;
}

getkillstreaknamefromweapon( var_0 )
{
    var_1 = var_0.basename;

    if ( isdefined( level.killstreakweaponmap[var_1] ) )
        return level.killstreakweaponmap[var_1];

    return undefined;
}