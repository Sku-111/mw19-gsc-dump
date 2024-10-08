// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

teamplunderexfiltimer()
{
    if ( isdefined( level.deposit_from_compromised_convoy_delayed ) )
        return;

    level.disable_oob_immunity_on_riders = 1;
    level.deposit_from_compromised_convoy_delayed = spawnstruct();
    level.deposit_from_compromised_convoy_delayed._id_12010 = undefined;
    level.deposit_from_compromised_convoy_delayed._id_12011 = undefined;
    level.deposit_from_compromised_convoy_delayed._id_1201E = undefined;
    level.deposit_from_compromised_convoy_delayed._id_1363D = [];
    level.deposit_from_compromised_convoy_delayed.bisdeaf = [ "actor_enemy_lw_br", "actor_enemy_lw_br_german_african", "zombie" ];
    level.deposit_from_compromised_convoy_delayed ambush_lmg_guy();
    allammoboxes();
    allassassin_getsortedteams();
    all_players_within_distance2d_and_below_height();
    scripts\cp_mp\vehicles\cargo_truck_mg::init_battlechatter();
}

ambush_lmg_guy()
{
    foreach ( var_1 in level.deposit_from_compromised_convoy_delayed.bisdeaf )
    {
        _id_12B0B( var_1, ::binoculars_watchracelaststand );
        _id_12B0C( var_1, ::binoculars_watchracetake );
        _id_12B0D( var_1, ::binocularsinited );
    }
}

all_players_within_distance2d_and_below_height()
{
    anim.grenadetimers["AI_gas_grenade_mp"] = randomintrange( 0, 20000 );
}

allammoboxes()
{
    var_0 = [ [ "molotov_explosion", "vfx/iw8/core/molotov/vfx_molotov_explosion.vfx" ], [ "molotov_explosion_child", "vfx/iw8/core/molotov/vfx_molotov_explosion_child.vfx" ], [ "vfx_burn_sml_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_low.vfx" ], [ "vfx_burn_sml_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_sml_high.vfx" ], [ "vfx_burn_sml_head_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_head_low.vfx" ], [ "vfx_burn_med_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_low.vfx" ], [ "vfx_burn_med_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_med_high.vfx" ], [ "vfx_burn_lrg_low", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_low.vfx" ], [ "vfx_burn_lrg_high", "vfx/iw8/weap/_fire/molotov/vfx_mtov_ontag_lrg_high.vfx" ] ];

    if ( !isdefined( level.g_effect ) )
        level.g_effect = [];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        if ( !isdefined( level.g_effect[var_0[var_1][0]] ) )
            level.g_effect[var_0[var_1][0]] = loadfx( var_0[var_1][1] );
    }
}

allassassin_getsortedteams()
{
    if ( !scripts\engine\utility::flag_exist( "scriptables_ready" ) )
        scripts\engine\utility::flag_init( "scriptables_ready" );
}

spawnnewagent( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    if ( !isdefined( var_3 ) )
        var_3 = "actor_enemy_lw_br";

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = "team_two_hundred";

    var_5 = scripts\mp\mp_agent::spawnnewagent( var_3, var_4, var_0, var_1 );

    if ( !isdefined( var_5 ) )
        return;

    var_5.guid = var_5 getguid();
    var_5 ammobox_getbufferedattachmentsourceweapon();
    var_5 thread alwaysdoskyspawnontacinsert();
    var_5 thread activeparachutersfactionvo();
    var_5 scriptablecount( "s4_ar_voscar" );
    var_5 thread activestate();

    if ( var_2 )
        var_5 scriptable_token_scriptable_touched_callback( 250 );

    level.deposit_from_compromised_convoy_delayed._id_1363D = scripts\engine\utility::array_add( level.deposit_from_compromised_convoy_delayed._id_1363D, var_5 );
    return var_5;
}

spawnnewzombieagent( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    if ( !isdefined( var_3 ) )
        var_3 = "enemy_lw_zombie_default";

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_5 ) )
        var_5 = "team_two_hundred";

    var_6 = access_card::_id_146FA( var_3, var_0, var_1, undefined, var_4 );

    if ( !isdefined( var_6 ) )
        return;

    var_6.guid = var_6 getguid();
    var_6 thread activeparachutersfactionvo();
    var_6.use_updated_damage_modifiers = 1;

    if ( var_2 )
        var_6 scriptable_token_scriptable_touched_callback( 250 );

    level.deposit_from_compromised_convoy_delayed._id_1363D = scripts\engine\utility::array_add( level.deposit_from_compromised_convoy_delayed._id_1363D, var_6 );
    return var_6;
}

spawnnewparachuteagent( var_0, var_1, var_2, var_3, var_4 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    if ( !isdefined( var_3 ) )
        var_3 = "actor_enemy_lw_br";

    if ( !isdefined( var_2 ) )
        var_2 = 0;

    if ( !isdefined( var_4 ) )
        var_4 = "team_two_hundred";

    var_5 = spawnnewagent( var_0, var_1, var_2, var_3, var_4 );
    var_5 hide();
    var_5 [[ level.fnbrsoldierparachutespawn ]]( var_0 );
    return var_5;
}

ammobox_getbufferedattachmentsourceweapon()
{
    self.recentkillcount = 0;
    self.recentdefendcount = 0;
    self.kills = 0;
    self.deaths = 0;
    self.pers["cur_kill_streak"] = 0;
    self.pers["cur_death_streak"] = 0;
    self.pers["cur_kill_streak_for_nuke"] = 0;
    self.tookweaponfrom = [];
    self.killedplayers = [];
    self._id_1407D = 0;
    self.name = "agent_" + self.entity_number;
    self.scripted_long_deaths = 0;
    self.agentdamagefeedback = 1;
    self.maxhealth = 100;
    self.health = 100;
    self.health_remaining = 100;
    self.showseasonalcontent = 100;
    self.showsplashtoall = 100;
    self.meleedamageoverride = 25;
    self.baseaccuracy = 0.35;
    self.circleclosestarttime = spawnstruct();
    self.circleclosestarttime.maxhealth = self.maxhealth;
    self.circleclosestarttime.meleedamageoverride = self.meleedamageoverride;
    self.circleclosestarttime.baseaccuracy = self.baseaccuracy;
}

activestate()
{
    self endon( "death" );

    for (;;)
    {
        self waittill( "grenade_fire", var_0, var_1, var_2, var_3 );

        if ( !scripts\mp\utility\weapon::grenadethrown( var_0 ) )
            continue;

        scripts\mp\weapons::grenadeinitialize( var_0, var_1, var_2, var_3 );
        self notify( "grenade_throw" );

        if ( !isdefined( var_0 ) )
            return;

        if ( !isdefined( var_0.weapon_name ) )
            return;

        var_0.spawnpos = var_0.origin;

        switch ( var_0.weapon_name )
        {
            case "molotov_mp":
                thread scripts\mp\equipment\molotov::molotov_used( var_0 );
                break;
            case "gas_grenade_mp":
                thread scripts\mp\equipment\gas_grenade::gas_used( var_0 );
                wait 0.1;
                var_0 notify( "missile_stuck" );
                break;
        }
    }
}

scriptable_token_scriptable_touched_callback( var_0 )
{
    if ( scripts\mp\utility\game::getgametype() == "br" )
    {
        scripts\mp\gametypes\br_armor.gsc::teamfriendlyto();
        scripts\mp\gametypes\br_armor.gsc::searchcirclesize();
        ammobox_canweaponuserandomattachments( var_0 );
    }
}

scriptablecount( var_0, var_1 )
{
    self.weapon = scripts\mp\class::buildweapon( var_0, [ "none", "none", "none", "none", "none", "none" ], "none", "none", var_1 );
    self giveweapon( self.weapon );
    self.bulletsinclip = weaponclipsize( self.weapon );
    self.primaryweapon = self.weapon;

    if ( !scripts\common\utility::isweaponinitialized( self.primaryweapon ) )
        scripts\common\utility::initweapon( self.primaryweapon );

    scripts\anim\shared.gsc::attachweapon( self.primaryweapon, "right" );
}

scriptable_used_by_part_funcs( var_0, var_1 )
{
    if ( !isdefined( self.grenadeweapon ) || self.grenadeweapon.basename != var_0 )
        self.grenadeweapon = getcompleteweaponname( var_0 );

    self.grenadeammo = var_1;
}

alwaysdoskyspawnontacinsert()
{
    self endon( "death" );
    level endon( "game_ended" );
    wait( randomfloatrange( 1.25, 2.75 ) );
    scripts\cp_mp\vehicles\cargo_truck_mg::autoassignquest( self );
    scripts\cp_mp\vehicles\cargo_truck_mg::playorderevent( "move", "movecombat", anim.player );
}

ammobox_canweaponuserandomattachments( var_0 )
{
    if ( !isdefined( var_0 ) || var_0 < 0 )
        return;

    self.br_maxarmorhealth = var_0;
    self.br_armorhealth = var_0;
    var_1 = self.br_armorhealth / self.br_maxarmorhealth;

    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_br_armor_damage", var_1 );
        scripts\mp\equipment\armor_plate::debug_state( self.br_armorhealth );
    }
}

setagentmaxhealth( var_0 )
{
    self.maxhealth = var_0;
    self.health = var_0;
}

_id_13122( var_0 )
{
    self.baseaccuracy = var_0;
}

_id_13123( var_0 )
{
    self.meleedamageoverride = var_0;
}

relic_mythic_next_pain_time()
{
    return self.enemy;
}

activeparachutersfactionvo()
{
    level endon( "game_ended" );
    self waittill( "death" );
    level.deposit_from_compromised_convoy_delayed._id_1363D = scripts\engine\utility::array_remove( level.deposit_from_compromised_convoy_delayed._id_1363D, self );
}

_id_12B0B( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    if ( !isdefined( level.agent_funcs ) )
        return;

    level.deposit_from_compromised_convoy_delayed._id_12010 = var_1;
    level.agent_funcs[var_0]["on_damaged"] = var_1;
}

_id_12B0C( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    if ( !isdefined( level.agent_funcs ) )
        return;

    level.deposit_from_compromised_convoy_delayed._id_12011 = var_1;
    level.agent_funcs[var_0]["gametype_on_damage_finished"] = var_1;
}

_id_12B0D( var_0, var_1 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    level.deposit_from_compromised_convoy_delayed._id_1201E = var_1;
    level.agent_funcs[var_0]["gametype_on_killed"] = var_1;
}

binoculars_watchracelaststand( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    var_13 = var_2;

    if ( !istrue( self._id_14693 ) )
        scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentdamaged( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13 );
}

binoculars_watchracetake( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 )
{
    if ( isdefined( level._id_1203F ) )
    {
        if ( scripts\engine\utility::isbulletdamage( var_4 ) )
        {
            if ( isplayer( var_1 ) || isbot( var_1 ) || isagent( var_1 ) )
                self [[ level._id_1203F ]]( var_1, var_6, self );
        }
    }

    if ( !istrue( self._id_14693 ) )
        scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentgametypedamagefinished( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 );
    else
        _zombieagentondamagefinishedcallback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 );
}

binocularsinited( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    scripts\mp\subway\fast_travel_subway_station::callbacksoldieragentgametypekilled( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 );
}

_zombieagentondamagefinishedcallback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 )
{
    if ( isdefined( self.zombie_callback_on_damage_finished ) )
    {
        if ( istrue( self.is_playing_spawn_performance ) )
            var_2 = int( var_2 * 0.5 );

        self [[ self.zombie_callback_on_damage_finished ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, undefined, var_11, var_12 );
        _zombieprocessarmordamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 );

        if ( isdefined( self.cursed_chest_on_damage_finished_callback ) )
            [[ self.cursed_chest_on_damage_finished_callback ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 );

        scripts\mp\subway\fast_travel_subway_station::process_damage_feedback( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, self, var_13, var_14 );
    }
}

_zombieprocessarmordamage( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 )
{
    if ( scripts\mp\gametypes\br_public.gsc::hasarmor() )
    {
        var_15 = var_2;

        if ( istrue( self.hashelmet ) && ( var_8 == "head" || var_8 == "helmet" ) )
            var_2 = int( var_2 * 0.07 );

        if ( isdefined( var_1 ) && isplayer( var_1 ) )
            var_1 playsoundtoplayer( "hit_marker_3d_armor", var_1 );

        scripts\mp\damage::armorvest_sethit( var_1 );
        var_16 = self.br_armorhealth - var_2;
        self.health = self.health + var_15;
        self.br_armorhealth = self.br_armorhealth - var_2;

        if ( scripts\engine\utility::sign( var_16 ) == -1 )
        {
            var_2 = int( abs( var_16 ) );
            self.health = self.health - var_2;
        }

        if ( self.br_armorhealth <= 0 )
        {
            self.br_armorhealth = 0;
            scripts\mp\damage::armorvest_setbroke( var_1 );

            if ( isdefined( self.attached_helmet ) )
                access_card::detachhelmetfromzombie( self.attached_helmet.model, self.attached_helmet.tag );

            if ( isdefined( var_1 ) && isplayer( var_1 ) )
                var_1 playsoundtoplayer( "hit_marker_3d_armor_break", var_1 );
        }
    }
}