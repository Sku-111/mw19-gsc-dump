// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_11ED7()
{
    level._effects["vfx_nova_round_scrnfx"] = loadfx( "vfx/iw8_br/gameplay/rumble/vfx_nova_round_scrnfx" );
    level._effect["vfx_chem_round_enemy_death"] = loadfx( "vfx/iw8_br/island/weap/_imp/chem_round/vfx_br3_chem_smk_down_enemy" );
    level._effect["vfx_br3_canister_exp_large_chem"] = loadfx( "vfx/iw8_br/island/weap/_imp/cannister/vfx_br3_canister_exp_large_chem" );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "nova_rounds", "hitByNovaRounds", ::spawn_juggernauts_hangar );
    scripts\mp\utility\sound::besttime( "proj_bullet_chem_rounds" );
    test_bag_pickup();
    level thread _id_11ED8();
}

test_bag_pickup()
{
    if ( !isdefined( level.getserverroomspawnpoint ) )
    {
        level.getserverroomspawnpoint = spawnstruct();
        level.getserverroomspawnpoint.plunder_economy_shapshot_loop = [];
    }

    level.getserverroomspawnpoint._id_127E0 = getdvarfloat( "scr_chem_rounds_poisoned_duration", 5 );
    level.getserverroomspawnpoint.plunder_awarded_by_missions_total = getdvarfloat( "scr_chem_rounds_gas_cloud_lifetime", 10 );
    level.getserverroomspawnpoint.plunder_getleveldataforrepository = getdvarfloat( "scr_chem_rounds_gas_damage_per_tick", 5 );
    level.getserverroomspawnpoint.gas_damage_per_tick_agent_multiplier = getdvarfloat( "scr_chem_rounds_gas_damage_per_tick_agent_multiplier", 5 );
    level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer = getdvarint( "scr_chem_rounds_gas_cloud_size", 180 );
    level.getserverroomspawnpoint.gas_cloud_height = getdvarint( "scr_chem_rounds_gas_cloud_height", 96 );
}

_id_11ED8()
{
    waitframe();

    if ( getdvarint( "scr_city_killer_nova_rounds_chain_cloud", 0 ) == 1 )
        level.brjugg_watchtimerstart = 1;

    level._id_12074 = ::_id_1447F;
    level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty( ::gettacroverspawns, level );
    level._id_120AE _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty( ::getteamcarriedplunder, level );
    level._id_1203F = ::spawn_juggernauts_hangar;
}

spawn_juggernauts_hangar( var_0, var_1, var_2, var_3 )
{
    if ( istrue( var_0.should_take_damage ) || istrue( var_0.waittill_trigger_player ) || istrue( var_3 ) )
    {
        if ( isdefined( var_1 ) )
        {
            if ( isdefined( var_2 ) )
            {
                var_4 = easepower( "vfx_chem_rounds_enemy_hit", var_1 );
                var_4 thread _id_12AAB( 1.0 );

                if ( !istrue( var_2.updateteamplunderscore ) )
                {
                    if ( isplayer( var_2 ) )
                    {
                        stopfxontagforclients( level._effects["vfx_nova_round_scrnfx"], var_2, "j_head", var_2 );
                        playfxontagforclients( level._effects["vfx_nova_round_scrnfx"], var_2, "j_head", var_2 );
                    }

                    var_2.updateteamplunderscore = 1;

                    if ( isdefined( self ) )
                        self playlocalsound( "bullet_chem_round_dmg_plr_trans" );
                }

                var_2 thread _id_1447F( var_0 );
            }
        }
    }
}

_id_12AAB( var_0 )
{
    level endon( "game_ended" );
    wait( var_0 );
    self freescriptable();
}

_id_1447F( var_0, var_1 )
{
    if ( isplayer( self ) || isbot( self ) )
        self endon( "disconnect" );

    level endon( "game_ended" );
    self notify( "poisoned_watching_for_death" );
    self endon( "poisoned_watching_for_death" );
    var_2 = level.getserverroomspawnpoint._id_127E0;

    if ( isdefined( var_1 ) )
        var_2 = var_1;

    if ( var_2 > 0 )
    {
        var_3 = scripts\engine\utility::_id_143B9( level.getserverroomspawnpoint._id_127E0, "death" );

        if ( var_3 == "timeout" )
        {
            if ( isplayer( self ) )
            {
                stopfxontagforclients( level._effects["vfx_nova_round_scrnfx"], self, "j_head", self );
                self.updateteamplunderscore = 0;
            }

            return;
        }
    }
    else
        self waittill( "death" );

    if ( isplayer( self ) )
    {
        stopfxontagforclients( level._effects["vfx_nova_round_scrnfx"], self, "j_head", self );
        self.updateteamplunderscore = 0;
    }

    var_4 = self.origin;
    var_5 = easepower( "super_nova_rounds_audio", var_4 );
    var_6 = spawn( "trigger_radius", var_4, 0, level.getserverroomspawnpoint.plunder_clearrepositorywidgetforplayer, level.getserverroomspawnpoint.gas_cloud_height );
    var_6.attacker = var_0;
    waitframe();
    var_7 = easepower( "vfx_chem_rounds_enemy_death", var_4 );
    var_5 setscriptablepartstate( "sfx_gas_npc", "npc_gas_expl" );
    scripts\mp\utility\trigger::makeenterexittrigger( var_6, ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5 );
    level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add( level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6 );
    wait( level.getserverroomspawnpoint.plunder_awarded_by_missions_total );
    level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove( level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6 );

    foreach ( var_9 in var_6.triggerenterents )
    {
        if ( var_9 getstreamedinplayercount() )
            var_9 scripts\mp\gametypes\br_pickups.gsc::plunderrankupdate( "chem_rounds_gas" );
    }

    var_5 freescriptable();
    var_6 notify( "gas_cloud_disipate" );
    var_7 freescriptable();
    var_6 delete();
}

playericonfilter( var_0, var_1, var_2, var_3 )
{
    var_4 = easepower( "super_nova_rounds_audio", var_1 );
    var_4 setscriptablepartstate( "sfx_weapon_chem", "sfx_weapon_chem_sweetner" );
    var_5 = scripts\engine\utility::ter_op( isdefined( var_3 ), var_3, level.getserverroomspawnpoint.gas_cloud_height );
    var_6 = spawn( "trigger_radius", var_1, 0, var_5, var_5 );
    var_6.attacker = var_0;
    scripts\mp\utility\trigger::makeenterexittrigger( var_6, ::_id_13DAB, ::_id_13DAC, undefined, undefined, ::_id_13DA5 );
    var_7 = scripts\engine\utility::ter_op( isdefined( var_2 ), var_2, "vfx_chem_rounds_enemy_death" );

    if ( isdefined( var_2 ) && var_2 == "nospawn" )
        var_7 = "nospawn";

    if ( var_7 != "nospawn" )
    {
        var_8 = easepower( var_7, var_1 );
        var_8 thread _id_12AAB( 8.0 );
    }

    level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_add( level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6 );
    wait( level.getserverroomspawnpoint.plunder_awarded_by_missions_total );
    level.getserverroomspawnpoint.plunder_economy_shapshot_loop = scripts\engine\utility::array_remove( level.getserverroomspawnpoint.plunder_economy_shapshot_loop, var_6 );

    foreach ( var_10 in var_6.triggerenterents )
    {
        if ( var_10 getstreamedinplayercount() )
            var_10 scripts\mp\gametypes\br_pickups.gsc::plunderrankupdate( "chem_rounds_gas" );
    }

    var_6 notify( "gas_cloud_disipate" );
    var_6 delete();
    var_4 freescriptable();
}

_id_13DAB( var_0, var_1 )
{
    var_0 thread _id_11C1D( var_1 );
}

_id_13DAC( var_0, var_1 )
{
    var_0.start_coop_escape_safehouse = 0;
    var_0 notify( "out_of_poison_cloud" );

    if ( isplayer( var_0 ) && var_0 getstreamedinplayercount() )
        scripts\mp\gametypes\br_pickups.gsc::plunderrankupdate( "chem_rounds_gas" );
}

_id_13DA5( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( isplayer( var_0 ) || isbot( var_0 ) || isagent( var_0 ) )
        return 0;

    return 1;
}

getstreamedinplayercount()
{
    foreach ( var_1 in level.getserverroomspawnpoint.plunder_economy_shapshot_loop )
    {
        if ( scripts\engine\utility::array_contains( var_1.triggerenterents, self ) )
            return 0;
    }

    return 1;
}

_id_11C1D( var_0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self notify( "gas_damage_watcher_triggered" );
    self endon( "gas_damage_watcher_triggered" );
    var_1 = 0;

    for (;;)
    {
        wait 0.5;

        if ( !isdefined( var_0 ) )
            break;

        if ( !scripts\engine\utility::array_contains( var_0.triggerenterents, self ) )
            break;

        if ( isdefined( var_0.attacker ) && isdefined( var_0.attacker.team ) )
        {
            if ( self.team == var_0.attacker.team && self != var_0.attacker )
                break;
        }

        if ( isdefined( self.poisonimmune ) && self.poisonimmune )
            break;

        if ( istrue( self.start_death_from_above_sequence ) )
        {
            if ( !scripts\mp\gametypes\br_pickups.gsc::ks_circlecount( self ) )
                scripts\mp\gametypes\br_pickups.gsc::plunderrankupdate( "chem_rounds_gas" );

            continue;
        }

        if ( scripts\cp_mp\gasmask::hasgasmask( self ) )
        {
            if ( !scripts\mp\gametypes\br_pickups.gsc::ks_circlecount( self ) )
                scripts\mp\gametypes\br_pickups.gsc::plunderrepositoryref( "chem_rounds_gas" );

            scripts\cp_mp\gasmask::processdamage( level.getserverroomspawnpoint.plunder_getleveldataforrepository );
        }
        else
        {
            if ( !is_player_visible_to_trigger( var_0, self ) )
                continue;

            if ( istrue( level.brjugg_watchtimerstart ) && self.health - level.getserverroomspawnpoint.plunder_getleveldataforrepository <= 0 )
            {
                self.updateteamplunderscore = 1;
                thread _id_1447F( var_0.attacker );
            }

            var_2 = scripts\engine\utility::ter_op( isagent( self ), level.getserverroomspawnpoint.gas_damage_per_tick_agent_multiplier, 1 );
            var_3 = level.getserverroomspawnpoint.plunder_getleveldataforrepository * var_2;

            if ( scripts\mp\gametypes\br_public.gsc::hasarmor() )
                scripts\mp\gametypes\br_public.gsc::damagearmor( var_3 );
            else
            {
                var_4 = var_0.attacker;

                if ( !isdefined( var_0.attacker ) || isdefined( var_0.attacker.unittype ) && var_0.attacker.unittype == "zombie" && !isalive( var_0.attacker ) )
                    var_4 = self;

                self dodamage( var_3, var_0.origin, var_4, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
            }

            if ( isagent( self ) )
            {
                var_5 = easepower( "vfx_chem_rounds_enemy_hit", self.origin + ( 0, 0, 50 ) );
                var_5 thread _id_12AAB( 1.0 );
            }

            if ( !scripts\mp\gametypes\br_pickups.gsc::ks_circlecount( self ) )
                scripts\mp\gametypes\br_pickups.gsc::plunderrankupdate( "chem_rounds_gas" );
        }

        scripts\mp\gametypes\br_circle.gsc::_id_13E18();
    }

    scripts\mp\gametypes\br_pickups.gsc::plunderrankupdate( "chem_rounds_gas" );
}

getsearchparams()
{
    self notify( "watching_chem_missile" );
    self endon( "watching_chem_missile" );
    self endon( "stop_watching_chem_fire" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "missile_fire", var_0, var_1 );

        if ( !istrue( self._id_11ED4 ) )
            return;

        var_0 thread getserachparams( self );
    }
}

getscrapassistplayers()
{
    self notify( "watching_chem_projectile" );
    self endon( "watching_chem_projectile" );
    self endon( "stop_watching_chem_fire" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1 );
        var_2 = weaponinventorytype( var_1.basename );

        if ( var_2 != "primary" )
            continue;

        if ( !istrue( self._id_11ED4 ) )
            return;

        var_0 thread getserachparams( self );
    }
}

getserachparams( var_0 )
{
    self waittill( "explode", var_1 );
    thread playericonfilter( var_0, var_1 );
    var_0 thread _id_13580( var_1 );
}

_id_12BE2()
{
    wait 0.1;

    if ( isdefined( self ) )
    {
        self._id_11ED4 = 0;
        self notify( "stop_watching_chem_fire" );
    }
}

_id_13580( var_0 )
{
    level endon( "game_ended" );
    var_1 = spawn( "script_model", var_0 );
    var_1 setmodel( "tag_origin" );
    waitframe();
    var_1._id_14293 = playfxontag( scripts\engine\utility::getfx( "vfx_br3_canister_exp_large_chem" ), var_1, "tag_origin" );
    var_2 = 2;
    wait( level.getserverroomspawnpoint.plunder_awarded_by_missions_total - var_2 );
    stopfxontag( scripts\engine\utility::getfx( "vfx_br3_canister_exp_large_chem" ), var_1, "tag_origin" );
    var_1 delete();
}

_id_11ED6()
{
    var_0 = self.lastweaponobj;
    var_1 = isundefinedweapon();

    if ( !scripts\mp\weapons::isnormallastweapon( var_0 ) || scripts\mp\utility\weapon::ismeleeonly( var_0 ) || scripts\mp\utility\weapon::isgamemodeweapon( var_0 ) || scripts\mp\utility\weapon::isaxeweapon( var_0 ) || !getsubgametype( var_0 ) || getstancetop( var_0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "MP/SUPPORT_BOX_INCOMPAT" );

        return 0;
    }

    self.should_take_damage = 1;
    self._id_11ED4 = 1;
    thread getsearchparams();
    thread getscrapassistplayers();
    var_2 = getsixthsensedirection();

    if ( !istrue( var_2 ) )
        return 0;

    if ( self isalternatemode( var_0 ) )
    {
        var_1 = var_0;
        var_0 = var_0 getnoaltweapon();
    }
    else
        var_1 = var_0 getaltweapon();

    var_3 = [];
    var_4 = 0;
    var_5 = 0;

    if ( !nullweapon( var_1 ) )
        var_3[var_3.size] = var_1;

    var_3[var_3.size] = var_0;

    foreach ( var_7 in var_3 )
    {
        var_8 = scripts\mp\utility\weapon::turnexfiltoside( var_7 );

        if ( isnullweapon( var_7, var_0, 0 ) )
        {
            var_9 = scripts\mp\weapons::getammooverride( var_7 );
            var_10 = var_9 * 1;

            if ( var_8 )
                var_10 = var_10 * 2;

            thread getsquadspawnlocations( self, var_7, var_10 );

            if ( 1 )
            {
                if ( var_8 )
                {
                    var_9 = self getweaponammoclip( var_7, "left" ) + self getweaponammoclip( var_7, "right" );
                    var_4 = self getweaponammostock( var_7 );
                    var_11 = var_9 + var_4;
                    var_12 = int( min( getspecialdaystickers( var_7, var_11 ), var_11 + var_10 ) );
                    self setweaponammostock( var_7, var_12 );
                    self setweaponammoclip( var_7, 0, "left" );
                    self setweaponammoclip( var_7, 0, "right" );
                }
                else
                {
                    var_9 = self getweaponammoclip( var_7 );
                    var_4 = self getweaponammostock( var_7 );
                    var_11 = var_9 + var_4;
                    var_13 = getspecialdaystickers( var_7, var_11 );
                    var_14 = var_11 + var_10;
                    var_5 = int( var_14 - var_13 );
                    var_15 = int( min( var_13, var_14 ) );

                    if ( var_7.basename == "iw8_lm_dblmg_mp" )
                        self setweaponammoclip( var_7, var_9 + var_10 );
                    else
                    {
                        self setweaponammoclip( var_7, 0 );

                        if ( scripts\mp\utility\game::getgametype() == "br" )
                        {
                            var_16 = var_15 - var_4;
                            scripts\mp\gametypes\br_weapons.gsc::delay_camera_normal( var_7, var_16 );
                        }
                        else
                            self setweaponammostock( var_7, var_15 );
                    }
                }
            }
        }
    }

    thread getteamplunder( var_0, var_4, var_5 );
    return 1;
}

getspecialdaystickers( var_0, var_1 )
{
    var_2 = var_0.maxammo;

    if ( var_1 > var_2 )
        var_2 = var_1;

    return var_2;
}

getsubgametype( var_0 )
{
    if ( !self isalternatemode( var_0 ) )
        return 1;

    var_1 = var_0.underbarrel;
    return scripts\mp\weapons::turretoverridefunc( var_1 );
}

getstancetop( var_0 )
{
    switch ( var_0.basename )
    {
        case "s4_me_axe_mp":
        case "s4_me_icepick_mp":
        case "iw8_lm_dblmg_mp":
        case "iw8_me_t9ballisticknife_mp":
        case "iw8_sm_t9nailgun_mp":
        case "iw8_fists_mp":
            return 1;
    }

    return 0;
}

getteamplunder( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );

    for (;;)
    {
        if ( self getcurrentprimaryweapon() != var_0 )
            break;

        var_3 = self getweaponammoclip( var_0 );

        if ( var_3 > 0 )
        {
            scripts\mp\gametypes\br_quest_util.gsc::displayplayersplash( self, "nova_rounds_loaded" );
            self setclientomnvar( "ui_chemRounds", 1 );

            if ( var_2 > 0 )
                self setweaponammostock( var_0, var_1 + var_2 );

            break;
        }

        waitframe();
    }

    if ( !scripts\mp\supers::issuperinuse() )
        waitframe();

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "supers", "superUseFinished" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "supers", "superUseFinished" ) ]]();
}

getsquadspawnlocations( var_0, var_1, var_2 )
{
    var_3 = init_relic_steelballs( var_0, var_1, var_2 );
    getsquadspawnstruct( var_0, var_3 );
}

init_relic_steelballs( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.player = var_0;
    var_3.objweapon = var_1;
    var_3.rounds = var_2;
    var_3.gavehcr = 0;
    var_3.kills = 0;
    return var_3;
}

getsquadspawnstruct( var_0, var_1 )
{
    if ( !isdefined( var_0.showassassinationtargethud ) )
        var_0.showassassinationtargethud = [];

    var_2 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( var_1.objweapon );
    var_3 = var_0.showassassinationtargethud[var_2];

    if ( isdefined( var_3 ) )
        var_3 thread getteamcontenders();

    var_0.showassassinationtargethud[var_2] = var_1;
    var_1 thread getspawncamerablendtime();
    var_1 thread getspecialdaycamos();
    var_1 thread getspecialdaycosmetics();
    var_1 thread getspreadpelletspershot();
    var_0 thread getsetplundercountdatanosplash();
    var_1 thread getteamplunderhud();
    var_1 thread getteamscoreplacements();
    var_0 thread getscrapassistplayers();
}

gettacroverspawns( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    var_3 = var_1 getspectatorsofplayer( var_2 );

    if ( isdefined( var_3 ) )
    {
        var_4 = init_relic_steelballs( var_3.player, var_3.objweapon, var_3.rounds );
        var_0.showassassinationtargethud = var_4;
        var_3 thread getteamcontenders();
    }
}

getteamcarriedplunder( var_0, var_1, var_2 )
{
    var_3 = var_0.showassassinationtargethud;

    if ( !isdefined( var_3 ) )
        return;

    if ( !isdefined( var_3.player ) || !var_3.player hasweapon( var_3.objweapon ) )
        return;

    var_3.player = var_1;
    getsquadspawnstruct( var_1, var_3 );
}

getspectatorsofplayer( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    if ( !isdefined( self.showassassinationtargethud ) )
        return undefined;

    var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( var_0 );
    return self.showassassinationtargethud[var_1];
}

getsixthsensedirection()
{
    self endon( "death_or_disconnect" );
    self cancelreload();
    wait 0.05;
    return 1;
}

getteamplunderhud()
{
    self endon( "chemicalRounds_removeHCR" );
    self.player endon( "disconnect" );
    self.post_blockade_combat_logic = 0;

    while ( self.player hasweapon( self.objweapon ) )
    {
        if ( getstartparachutespawnpoint( self.player getcurrentweapon() ) )
        {
            if ( !self.post_blockade_combat_logic )
            {
                self.player scripts\mp\utility\perk::giveperk( "specialty_chemrounds" );
                self.player.should_take_damage = 1;
                self.player._id_11ED4 = 1;
                self.post_blockade_combat_logic = 1;
                self.player setclientomnvar( "ui_chemRounds", 1 );
                self.player thread getsearchparams();
                self.player thread getscrapassistplayers();
            }
        }
        else if ( self.post_blockade_combat_logic )
        {
            self.player scripts\mp\utility\perk::removeperk( "specialty_chemrounds" );
            self.player.should_take_damage = 0;
            self.player thread _id_12BE2();
            self.post_blockade_combat_logic = 0;
            self.player setclientomnvar( "ui_chemRounds", 0 );
        }

        self.player waittill( "weapon_change" );
    }

    thread getteamcontenders();
}

getteamscoreplacements()
{
    self endon( "chemicalRounds_removeHCR" );
    self.player endon( "disconnect" );

    while ( self.player hasweapon( self.objweapon ) )
    {
        self.player waittill( "weapon_fired", var_0 );

        if ( getstartparachutespawnpoint( var_0 ) )
        {
            self.rounds--;

            if ( self.rounds <= 0 )
                break;
        }
    }

    if ( isdefined( self ) )
    {
        self.player thread getteamfactionsfrommap( self.objweapon );
        thread getteamcontenders();
    }
}

getteamfactionsfrommap( var_0 )
{
    self endon( "disconnect" );

    if ( !isdefined( self ) )
        return;

    var_1 = scripts\mp\utility\weapon::getweaponrootname( var_0 );

    if ( var_1 != "iw8_sn_crossbow" && var_1 != "iw8_sn_t9crossbow" )
        return;

    self.waittill_trigger_player = 1;
    scripts\engine\utility::_id_143C0( 2, "weapon_fired", "weapon_change" );
    self.waittill_trigger_player = undefined;
}

getteamcontenders()
{
    self notify( "chemicalRounds_removeHCR" );

    if ( isdefined( self.player ) )
    {
        if ( istrue( self.post_blockade_combat_logic ) )
        {
            if ( isdefined( self.player.perks["specialty_chemrounds"] ) )
                self.player scripts\mp\utility\perk::removeperk( "specialty_chemrounds" );

            self.player.should_take_damage = 0;
            self.player thread _id_12BE2();
            self.player setclientomnvar( "ui_chemRounds", 0 );
        }

        if ( isdefined( self ) )
            getsolospawnstruct();
    }
}

getsuperrefforsuperextraweapon()
{
    self notify( "chemicalRounds_removeHCR" );

    if ( isdefined( self.player ) )
        getsolospawnstruct();
}

getsolospawnstruct()
{
    if ( isdefined( self.player.showassassinationtargethud ) )
    {
        var_0 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( self.objweapon );
        var_1 = self.player.showassassinationtargethud[var_0];

        if ( isdefined( var_1 ) && var_1 == self )
            self.player.showassassinationtargethud[var_0] = undefined;

        self.player scripts\cp\vehicles\vehicle_compass_cp::_id_12032( "super_nova_box", self.kills );
        self.player setclientomnvar( "ui_chemRounds", 0 );
        self.player.should_take_damage = 0;
        scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.player, level.superglobals.staticsuperdata["super_nova_box"].id, self.kills, 0 );
    }
}

getstartparachutespawnpoint( var_0 )
{
    var_1 = self.player getammotype( self.objweapon );
    var_2 = self.player getammotype( var_0 );
    var_3 = var_1 == var_2;
    return isnullweapon( var_0, self.objweapon, 1 ) && var_3;
}

getspawncamerablendtime()
{
    self.player endon( "disconnect" );
    self endon( "chemicalRounds_removeHCR" );
    self.player waittill( "death" );
    thread getteamcontenders();
}

getspecialdaycamos()
{
    self.player endon( "disconnect" );
    self endon( "chemicalRounds_removeHCR" );
    level waittill( "game_ended" );
    thread getteamcontenders();
}

getspecialdaycosmetics()
{
    self.player endon( "disconnect" );
    self endon( "chemicalRounds_removeHCR" );
    self.player waittill( "all_perks_cleared" );
    thread getsuperrefforsuperextraweapon();
}

getspreadpelletspershot()
{
    self.player endon( "death_or_disconnect" );
    self.player scripts\mp\utility\perk::giveperk( "specialty_fastreload" );
    self.player scripts\engine\utility::_id_143A6( "weapon_fired", "weapon_change", "chemicalRounds_removeHCR" );
    self.player scripts\mp\utility\perk::removeperk( "specialty_fastreload" );
}

getsetplundercountdatanosplash()
{
    self endon( "death_or_disconnect" );
    scripts\common\utility::allow_sprint( 0 );
    wait 0.4;
    scripts\common\utility::allow_sprint( 1 );
}

is_player_visible_to_trigger( var_0, var_1 )
{
    var_2 = physics_createcontents( [ "physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_sky", "physicscontents_item", "physicscontents_vehicle" ] );
    var_3 = vectorcross( vectornormalize( var_0.origin - var_1.origin ), anglestoup( var_1.angles ) );
    var_4 = var_1 geteye();
    var_5 = var_0.origin + ( 0, 0, level.getserverroomspawnpoint.gas_cloud_height / 2 );
    var_6 = [];
    var_6[0] = var_4 + var_3 * 20;
    var_6[1] = var_4 - var_3 * 20;

    foreach ( var_8 in var_6 )
    {
        var_9 = physics_raycast( var_5, var_8, var_2, undefined, 0, "physicsquery_closest", 1 );

        if ( !( isdefined( var_9 ) && var_9.size > 0 ) )
            return 1;

        waitframe();
    }

    return 0;
}