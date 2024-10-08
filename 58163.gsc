// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

tr_vis_facing_dist_add_override( var_0 )
{
    if ( !isdefined( level._id_14675 ) )
        level._id_14675 = [];
}

_id_1403E( var_0 )
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "end_launcher" );
    var_1 = safehouse_restart( var_0 );

    if ( var_1 == "mag_xmike109" )
        return;

    var_2 = safehouse_revive_and_move_players( var_1 );
    thread start_chopper_boss( var_0, var_1, var_2 );
}

handlerelicmartyrdomgas()
{
    self waittill( "end_launcher" );
    wait 6;
    self notify( "cleanupXMike109ImpactWatcher" );
}

start_chopper_boss( var_0, var_1, var_2 )
{
    self notify( "cleanupXMike109ImpactWatcher" );
    self endon( "disconnect" );
    self endon( "cleanupXMike109ImpactWatcher" );
    childthread handlerelicmartyrdomgas();

    if ( var_1 == "default" )
        return;

    for (;;)
    {
        self waittill( "bullet_first_impact", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( var_0 != var_7 )
            continue;

        setup_tut_zones( var_3, var_4, var_10, var_5, var_6, var_7, var_8, var_9, var_2, var_1, var_11 );
    }
}

setup_tut_zones( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10 )
{
    var_11 = _id_1331F( var_4, var_9, var_0, var_1, var_3, var_6 );
    var_12 = _id_1368B( var_7, var_6, var_9, var_5, var_11, var_3, var_10 );

    if ( _id_132F1( var_0 ) )
    {
        var_12 delete();
        return;
    }
    else if ( _id_13309( var_0, var_11 ) )
        linktoent( var_12, var_0, var_1 );

    if ( isdefined( var_8 ) )
        [[ var_8 ]]( var_12, var_0, var_1, var_2, var_4, var_11 );
}

start_bomb_vest_defusal( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    var_6 = 0.1;
    var_0.grenade = magicgrenademanual( "semtex_xmike109_mp", var_0.origin, ( 0, 0, 0 ), var_6 );
    var_0.grenade.angles = var_0.angles;
    var_0.grenade linkto( var_0, "tag_origin" );
    thread _id_128CC( var_0, var_6, var_3 );
}

start_bomb_vest_defusal_sequence( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    thread _id_128CD( var_0, var_1, var_2, var_3, var_5 );
}

start_bomb_vest_global_timer( var_0, var_1, var_2, var_3, var_4, var_5 )
{

}

_id_128CC( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    var_0 endon( "entitydeleted" );
    var_0.grenade scripts\engine\utility::_id_143BF( var_1, "explode" );
    var_0 setscriptablepartstate( "effects", "explode" );
    var_3 = getcompleteweaponname( "semtex_xmike109_mp" );
    var_4 = getcompleteweaponname( "semtex_xmike109_splash_mp" );
    var_3._id_121D9 = var_0.weapon;
    var_4._id_121D9 = var_0.weapon;
    glassradiusdamage( var_0.origin, 150, 50, 1 );

    if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
    {
        var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
        var_0.stuckenemyentity dodamage( 140, var_0.origin, self, self, "MOD_EXPLOSIVE", var_3, var_2 );
        var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
    }

    getplaylistname( var_0.origin, 9, 35, 15, 25, 60, 14, self, "MOD_EXPLOSIVE", var_4 );
    wait 0.4;

    if ( !var_0 _id_140D4() )
        return;

    var_0 delete();
}

_id_128CD( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( var_0.unset_relic_hideobjicons ) )
    {
        var_0 setscriptablepartstate( "effects", "reflectThermite" );
        _id_1437F( var_0 );
    }

    var_0 setscriptablepartstate( "effects", "burn" );
    thread _id_13B2B( var_0 );
    thread _id_13B27( var_0 );
    thread _id_13B26( var_0 );
}

_id_1437F( var_0 )
{
    var_0 endon( "stuckWaitTimeout" );
    var_0 thread _id_128D1();
    var_0 waittill( "missile_stuck", var_1, var_2 );

    if ( isdefined( var_1 ) )
    {
        linktoent( var_0, var_1, var_2 );
        var_0.debug_listing_helis = 1;
    }
}

_id_128D1()
{
    wait 3;

    if ( isdefined( self ) )
        self notify( "stuckWaitTimeout" );
}

_id_13B2B( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "entitydeleted" );
    var_1 = getcompleteweaponname( "thermite_xmike109_mp" );
    var_1._id_121D9 = var_0.weapon;

    if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
    {
        if ( var_0.stuckenemyentity scripts\cp_mp\vehicles\vehicle::isvehicle() || isdefined( var_0.stuckenemyentity.classname ) && var_0.stuckenemyentity.classname == "misc_turret" )
            var_2 = 0.95;
        else
            var_2 = 0.25;

        if ( istrue( var_0.debug_listing_helis ) )
            var_0.stuckenemyentity dodamage( 80, var_0.origin, self, var_0, "MOD_FIRE", var_1 );

        var_3 = int( 3.0 / var_2 );

        while ( isdefined( var_0 ) && isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) && var_3 >= 0 )
        {
            var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
            var_0.stuckenemyentity dodamage( 3, var_0.origin, self, var_0, "MOD_FIRE", var_1 );
            var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
            var_3--;
            wait( var_2 );
        }
    }
}

_id_13B27( var_0 )
{
    self endon( "disconnect" );
    var_0 endon( "entitydeleted" );
    var_1 = int( 12.0 );
    var_2 = getcompleteweaponname( "thermite_xmike109_radius_mp" );
    var_2._id_121D9 = var_0.weapon;
    var_0._id_13B28 = var_2.basename;

    while ( var_1 > 0 )
    {
        if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
            var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier( "thermite25mmStuck", 0, 0, ::_id_13B1C );

        var_0 radiusdamage( var_0.origin, 50, 2, 2, self, "MOD_FIRE", var_2 );

        if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
            var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier( "thermite25mmStuck", 0 );

        var_1--;
        wait 0.25;
    }
}

_id_13B1C( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( !isdefined( var_0._id_13B28 ) || var_0._id_13B28 != "thermite_xmike109_radius_mp" )
        return 1;

    if ( !isdefined( var_0.stuckenemyentity ) || var_0.stuckenemyentity != var_2 )
        return 1;

    return 0;
}

_id_13B26( var_0 )
{
    var_0 endon( "entitydeleted" );
    wait 3.0;

    if ( !var_0 _id_140D4() )
        return;

    var_0 setscriptablepartstate( "effects", "burnout" );
    var_0 setscriptablepartstate( "visibility", "hide" );
    wait( randomfloatrange( 0.3, 2.0 ) );

    if ( !var_0 _id_140D4() )
        return;

    wait( randomfloatrange( 2, 3 ) );
    var_0 delete();
}

_id_1368B( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( var_4 && var_2 == "thermal" )
    {
        var_7 = _id_12AC9( var_5, var_1, var_0, 1, var_6 );
        var_8 = var_0 + var_5 * 10;
        var_9 = magicgrenademanual( "xmike109_grenade", var_8, var_7, 10 );
        var_9.unset_relic_hideobjicons = 1;
        playfx( scripts\engine\utility::getfx( "xmike109ThermiteBounce" ), var_0, var_5 );
    }
    else
    {
        var_9 = spawn( "script_model", var_0 );
        var_9 setmodel( "weapon_wm_sn_xmike109_projectile" );
        var_9.origin = var_0;

        if ( var_4 )
        {
            var_7 = _id_12AC9( var_5, var_1, var_0, 0, var_6 );
            var_9 physicslaunchserver( var_0, var_7 );
        }
    }

    var_9.angles = vectortoangles( var_1 );
    var_9 _id_13142( var_2 );
    var_9.owner = self;
    var_9.brush = var_2;
    var_9.weapon = var_3;
    var_9.vehicle_collision_ignorefutureevent = 1;
    var_9 thread _id_128CB();
    _id_11AB5( var_9 );
    return var_9;
}

_id_13142( var_0 )
{
    switch ( var_0 )
    {
        case "thermal":
            thread _id_13143( 3.5 );
            self.last_saydefuse_time = 0;
            break;
        case "explosive":
            self.last_saydefuse_time = 0;
            break;
        default:
            self.last_saydefuse_time = 1;
    }
}

_id_13143( var_0 )
{
    self endon( "entitydeleted" );
    wait( var_0 );
    self.last_saydefuse_time = 1;
    _id_11AB5();
}

_id_11AB5( var_0 )
{
    if ( isdefined( var_0 ) )
        var_1 = [ var_0 ];
    else
        var_1 = [];

    foreach ( var_3 in level._id_14675 )
    {
        if ( !isdefined( var_3 ) )
            continue;

        if ( isdefined( var_3 ) )
        {
            if ( var_1.size >= 24 && var_3.last_saydefuse_time )
            {
                var_3 delete();
                continue;
            }

            var_1[var_1.size] = var_3;
        }
    }

    level._id_14675 = var_1;
}

safehouse_restart( var_0 )
{
    var_1 = "";

    foreach ( var_3 in var_0.attachments )
    {
        if ( issubstr( var_3, "calcust1" ) )
        {
            var_1 = "calcust1_xmike109";
            break;
        }

        if ( issubstr( var_3, "calcust2" ) )
        {
            var_1 = "calcust2_xmike109";
            break;
        }
    }

    switch ( var_1 )
    {
        case "calcust2_xmike109":
            return "thermal";
        case "calcust1_xmike109":
            return "explosive";
        default:
            return "default";
    }
}

safehouse_revive_and_move_players( var_0 )
{
    switch ( var_0 )
    {
        case "thermal":
            return ::start_bomb_vest_defusal_sequence;
        case "explosive":
            return ::start_bomb_vest_defusal;
        default:
            return ::start_bomb_vest_global_timer;
    }
}

_id_1331F( var_0, var_1, var_2, var_3, var_4, var_5 )
{
    if ( !isdefined( var_0 ) )
        var_0 = "";

    if ( var_0 == "riotshield" )
        return 1;

    if ( var_1 != "thermal" )
        return 0;

    if ( !isdefined( var_2 ) && isdefined( var_3 ) )
        return 1;

    if ( use_trace_radius( var_2 ) || use_struct( var_2 ) )
        return 1;

    if ( unpause_wave_hud( var_2 ) || unpause_dmz_scoring( var_2 ) )
        return 0;

    if ( isdefined( var_2 ) )
    {
        if ( var_2 scripts\cp_mp\vehicles\vehicle::isvehicle() )
            return 0;

        if ( isdefined( var_2.equipmentref ) && var_2.equipmentref == "equip_tac_cover" )
            return 0;
    }

    switch ( var_0 )
    {
        case "glass_solid":
        case "glass_pane":
        case "riotshield":
            return 1;
        default:
            var_6 = abs( vectordot( var_5, var_4 ) );

            if ( var_6 < 0.2 )
            {
                return 1;
                return;
            }

            return 0;
            return;
    }
}

_id_12AC9( var_0, var_1, var_2, var_3, var_4 )
{
    if ( var_3 )
    {
        var_5 = 1500;
        var_6 = 500;
        var_7 = 150;
    }
    else
    {
        var_5 = 500;
        var_6 = 500;
        var_7 = 500;
    }

    if ( isdefined( var_4 ) )
    {
        var_8 = var_1;
        var_9 = 0;
    }
    else
    {
        var_8 = scripts\engine\math::vector_reflect( var_1, var_0 );
        var_8 = vectorlerp( var_8, var_0, 0.2 );
        var_9 = abs( vectordot( var_1, var_0 ) );
    }

    if ( var_9 < 0.2 )
    {
        var_9 = scripts\engine\math::normalize_value( 0, 0.2, var_9 );
        var_10 = scripts\engine\math::factor_value( var_5, var_6, var_9 );
    }
    else
    {
        var_9 = scripts\engine\math::normalize_value( 0.2, 1, var_9 );
        var_10 = scripts\engine\math::factor_value( var_6, var_7, var_9 );
    }

    var_8 = var_8 * var_10;
    return var_8;
}

_id_132F1( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isagent( var_0 ) && var_0 trytoplaydamagesound() && !isalive( var_0 ) && !isdefined( var_0 getcorpseentity() ) )
        return 1;

    return 0;
}

_id_13309( var_0, var_1 )
{
    if ( var_1 || !isdefined( var_0 ) )
        return 0;

    if ( isdefined( var_0.classname ) && var_0.classname == "weapon_scavenger_bag_mp" )
        return 0;

    return 1;
}

trytoplaydamagesound()
{
    return istrue( isdefined( self.unittype ) && self.unittype == "suicidebomber" );
}

linktoent( var_0, var_1, var_2 )
{
    if ( ( isplayer( var_1 ) || isagent( var_1 ) ) && !isalive( var_1 ) )
    {
        var_3 = var_1 getcorpseentity();

        if ( isdefined( var_3 ) )
            var_1 = var_3;
    }

    if ( isplayer( var_1 ) )
        var_0 hidefromplayer( var_1 );

    if ( isdefined( var_2 ) )
        var_0 linkto( var_1, var_2 );
    else
        var_0 linkto( var_1 );

    if ( get_center_loc_among_target_players( var_1 ) )
    {
        var_0.stuckenemyentity = var_1;
        var_0 thread _id_12C28( var_1 );
    }

    if ( !istrue( var_0.unset_relic_hideobjicons ) )
        var_0 notsolid();

    var_0 thread _id_128D0( var_1 );
    var_0 thread _id_128CA( var_1, "vehicle_deleted" );
    var_0 thread _id_128CA( var_1, "detonated" );
    var_0 thread _id_128CA( var_1, "beginC130" );
}

_id_140D4()
{
    if ( isdefined( self ) && istrue( self.vehicle_collision_ignorefutureevent ) )
        return 1;
    else
    {

    }
}

_id_12C28( var_0 )
{
    self endon( "entitydeleted" );
    var_0 scripts\engine\utility::_id_143A6( "entitydeleted", "death", "disconnect" );

    if ( !_id_140D4() )
        return;

    self.stuckenemyentity = undefined;

    if ( isdefined( var_0 ) && isdefined( var_0.nocorpse ) )
        self delete();
}

_id_128D0( var_0 )
{
    self endon( "entitydeleted" );

    if ( isagent( var_0 ) )
        var_0 waittill( "entitydeleted" );
    else
        var_0 scripts\engine\utility::_id_143A5( "entitydeleted", "disconnect" );

    if ( !_id_140D4() )
        return;

    _id_128CF();
}

_id_128CF( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = ( 0, 0, 100 );

    if ( self islinked() )
        self unlink();

    if ( !istrue( self.unset_relic_hideobjicons ) )
        self solid();

    self physicslaunchserver( self.origin, var_0 );
}

_id_128CA( var_0, var_1 )
{
    self endon( "entitydeleted" );
    var_0 waittill( var_1 );

    if ( !_id_140D4() )
        return;

    self delete();
}

_id_128CB()
{
    self waittill( "entitydeleted" );

    if ( isdefined( self.grenade ) )
        self.grenade delete();
}

use_trace_radius( var_0 )
{
    if ( !isplayer( var_0 ) )
        return 0;

    if ( scripts\mp\utility\player::isenemy( var_0 ) )
        return 0;
    else
        return 1;
}

unpause_wave_hud( var_0 )
{
    if ( !isplayer( var_0 ) )
        return 0;

    if ( scripts\mp\utility\player::isenemy( var_0 ) )
        return 1;
    else
        return 0;
}

use_struct( var_0 )
{
    if ( !isagent( var_0 ) )
        return 0;

    if ( isdefined( var_0.agentteam ) && self.team == var_0.agentteam )
        return 1;

    return 0;
}

unpause_dmz_scoring( var_0 )
{
    if ( !isagent( var_0 ) )
        return 0;

    if ( isdefined( var_0.agentteam ) && self.team == var_0.agentteam )
        return 0;

    return 1;
}

get_center_loc_among_target_players( var_0 )
{
    var_1 = 0;

    if ( isplayer( var_0 ) || isagent( var_0 ) )
        var_1 = 1;

    if ( var_0 scripts\cp_mp\vehicles\vehicle::isvehicle() )
        var_1 = 1;

    if ( isdefined( var_0.classname ) )
    {
        if ( var_0.classname == "misc_turret" )
            var_1 = 1;

        if ( var_0.classname == "script_model" )
        {
            if ( isdefined( var_0.streakinfo ) && ( var_0.streakinfo.streakname == "uav" || var_0.streakinfo.streakname == "gunship" ) )
                var_1 = 1;
        }
    }

    if ( isdefined( var_0.equipmentref ) )
    {
        if ( var_0.equipmentref == "equip_tac_cover" )
            var_1 = 1;
    }

    return var_1;
}
