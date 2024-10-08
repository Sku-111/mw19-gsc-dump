// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

teleport_text_updated( var_0 )
{
    if ( !isdefined( level.init_weapon_variant_spawns ) )
        level.init_weapon_variant_spawns = [];
}

initarmor( var_0 )
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "end_launcher" );
    var_1 = relic_mythic_can_do_pain( var_0 );
    var_2 = relic_mythic_do_pain( var_1 );
    thread init_wind_tunnels( var_0, var_1, var_2 );
}

handlerelicmartyrdomgas()
{
    self waittill( "end_launcher" );
    wait 6;
    self notify( "cleanupImpactWatcher" );
}

init_wind_tunnels( var_0, var_1, var_2 )
{
    self notify( "cleanupImpactWatcher" );
    self endon( "disconnect" );
    self endon( "cleanupImpactWatcher" );
    childthread handlerelicmartyrdomgas();

    for (;;)
    {
        self waittill( "bullet_first_impact", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11 );

        if ( var_0 != var_7 )
            continue;

        var_12 = _id_1362B( var_9, var_8, var_1, var_7 );
        setup_tut_zones( var_12, var_3, var_4, var_10, var_5, var_6, var_7, var_8, var_9, var_2 );
    }
}

setup_tut_zones( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 )
{
    if ( _id_1331F( var_5, var_0, var_1, var_2 ) )
        _id_12AC6( var_0, var_4, var_7, var_8 );
    else if ( _id_132F1( var_1 ) )
    {
        var_0 delete();
        return;
    }
    else if ( _id_13309( var_1 ) )
        linktoent( var_0, var_1, var_2 );

    if ( isdefined( var_9 ) )
        [[ var_9 ]]( var_0, var_1, var_2, var_3, var_5 );
}

start_authentication_timer( var_0, var_1, var_2, var_3, var_4 )
{

}

start_bomb_vest_defusal( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 setscriptablepartstate( "effects", "impact" );

    if ( isdefined( var_1 ) && ( isplayer( var_1 ) || isagent( var_1 ) ) )
        var_5 = 1.1;
    else
        var_5 = 2;

    var_0.grenade = magicgrenademanual( "semtex_bolt_mp", var_0.origin, ( 0, 0, 0 ), var_5 );
    var_0.grenade.angles = var_0.angles;
    var_0.grenade linkto( var_0, "tag_origin" );
    thread onsupportboxusedbyplayer( var_0, var_5 );
}

start_bomb_vest_defusal_sequence( var_0, var_1, var_2, var_3, var_4 )
{
    var_0.surfacetype = var_4;
    var_0 setscriptablepartstate( "effects", "impact" );
    thread _id_13B25( var_0, var_1, var_2, var_3 );
    var_5 = 0;

    if ( isdefined( level._id_132A4 ) && [[ level._id_132A4.lowpopallowtweaks ]]( var_0 ) )
        var_5 = 1;

    if ( !var_5 )
        thread _id_13B24( var_0, var_1 );

    thread _id_13B23( var_0, var_5 );
}

start_box_set_up( var_0, var_1, var_2, var_3, var_4 )
{
    if ( _id_13937( var_1, var_4 ) )
    {
        var_0 setscriptablepartstate( "impact", "active" );

        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "gas_createTrigger" ) )
            thread [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "gas_createTrigger" ) ]]( var_0.origin, self, 5, 0.45 );

        thread _id_13936( var_0 );
    }
    else
        var_0 setscriptablepartstate( "impact", "dud" );
}

onsupportboxusedbyplayer( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 endon( "entitydeleted" );
    var_0.grenade scripts\engine\utility::_id_143BF( var_1, "explode" );
    var_0 setscriptablepartstate( "effects", "explode" );
    var_2 = getcompleteweaponname( "semtex_bolt_mp" );
    var_3 = getcompleteweaponname( "semtex_bolt_splash_mp" );
    var_2._id_121D9 = var_0.weapon;
    var_3._id_121D9 = var_0.weapon;

    if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
    {
        var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
        var_0.stuckenemyentity dodamage( 65, var_0.origin, self, undefined, "MOD_EXPLOSIVE", var_2 );
        var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
    }

    radiusdamage( var_0.origin, 160, 65, 35, self, "MOD_EXPLOSIVE", var_3 );
    wait 0.4;

    if ( !var_0 _id_140CA() )
        return;

    var_0 delete();
}

_id_13B25( var_0, var_1, var_2, var_3 )
{
    self endon( "disconnect" );
    var_0 endon( "entitydeleted" );
    var_4 = getcompleteweaponname( "thermite_bolt_mp" );
    var_4._id_121D9 = var_0.weapon;

    if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
    {
        if ( var_1 scripts\cp_mp\vehicles\vehicle::isvehicle() || isdefined( var_1.classname ) && var_1.classname == "misc_turret" )
            var_5 = 1.0;
        else
            var_5 = 0.25;

        var_6 = int( 4.5 / var_5 );

        while ( isdefined( var_1 ) && isdefined( var_0 ) && isalive( var_1 ) && var_6 > 0 )
        {
            var_1 scripts\cp_mp\utility\damage_utility::playerplunderbankcallback();
            var_1 dodamage( 5, var_0.origin, self, var_0, "MOD_FIRE", var_4, var_3 );
            var_1 scripts\cp_mp\utility\damage_utility::playerplunderbankdeposit();
            var_6--;
            wait( var_5 );
        }
    }
}

_id_13B24( var_0, var_1 )
{
    self endon( "disconnect" );
    var_0 endon( "entitydeleted" );
    var_2 = int( 18.0 );
    var_3 = getcompleteweaponname( "thermite_bolt_radius_mp" );
    var_3._id_121D9 = var_0.weapon;
    var_0._id_13B28 = var_3.basename;

    while ( var_2 > 0 )
    {
        if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
            var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::adddamagemodifier( "thermiteBoltStuck", 0, 0, ::_id_13B1C );

        var_0 radiusdamage( var_0.origin, 50, 5, 3, self, "MOD_FIRE", var_3 );

        if ( isdefined( var_0.stuckenemyentity ) && isalive( var_0.stuckenemyentity ) )
            var_0.stuckenemyentity scripts\cp_mp\utility\damage_utility::removedamagemodifier( "thermiteBoltStuck", 0 );

        var_2--;
        wait 0.25;
    }
}

_id_13B1C( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( !isdefined( var_0._id_13B28 ) || var_0._id_13B28 != "thermite_bolt_radius_mp" )
        return 1;

    if ( !isdefined( var_0.stuckenemyentity ) || var_0.stuckenemyentity != var_2 )
        return 1;

    return 0;
}

_id_13B23( var_0, var_1 )
{
    var_0 endon( "entitydeleted" );

    if ( !var_1 )
    {
        wait 4.5;

        if ( !var_0 _id_140CA() )
            return;

        var_0 setscriptablepartstate( "effects", "burnEnd" );
        wait( randomfloatrange( 0.3, 2.0 ) );

        if ( !var_0 _id_140CA() )
            return;
    }

    var_0 course_triggers_expl();
    var_0 setmodel( "weapon_wm_sn_crossbow_bolt_fire_static_dst" );
}

_id_13936( var_0 )
{
    var_0 endon( "entitydeleted" );
    wait 0.5;

    if ( !var_0 _id_140CA() )
        return;

    var_0 delete();
}

_id_13937( var_0, var_1 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( !isplayer( var_0 ) && !isagent( var_0 ) )
        return 0;

    if ( isdefined( var_0.team ) && self.team == var_0.team )
        return 0;

    if ( var_1 == "riotshield" )
        return 0;

    return 1;
}

_id_1362B( var_0, var_1, var_2, var_3 )
{
    var_4 = regroup_points( var_2 );
    var_5 = spawn( "script_model", var_0 );
    var_5 setmodel( var_4 );
    var_5.angles = vectortoangles( var_1 );
    var_5 _id_13142( var_2 );
    var_5.owner = self;
    var_5.brush = var_2;
    var_5.weapon = var_3;
    var_5.uavnoneid = 1;

    if ( _id_1330E( var_2 ) )
        var_5 = _id_11AA3( var_5 );

    var_5 thread countdownendcallback();
    _id_11AB4( var_5 );
    return var_5;
}

_id_1330E( var_0 )
{
    if ( var_0 == "bolt_default" || var_0 == "bolt_stun" )
        return 1;

    return 0;
}

_id_11AA3( var_0 )
{
    var_1 = var_0.origin + anglestoforward( var_0.angles ) * 15;
    var_2 = axistoangles( anglestoup( var_0.angles ), anglestoright( var_0.angles ), anglestoforward( var_0.angles ) );
    var_3 = spawn( "trigger_rotatable_radius", var_1, 0, 64, 79 );
    var_3.angles = var_2;
    var_3.targetname = "bolt_pickup";
    var_3 enablelinkto();
    var_3 linkto( var_0 );
    var_0._id_12357 = var_3;
    var_0 thread cosfov();
    return var_0;
}

_id_12C15( var_0 )
{
    var_0 notify( "removePickup" );

    if ( isdefined( var_0._id_12357 ) )
        var_0._id_12357 delete();
}

cosfov()
{
    self endon( "entitydeleted" );
    self endon( "removePickup" );
    wait 2;

    for (;;)
    {
        self._id_12357 waittill( "trigger", var_0 );

        if ( !isplayer( var_0 ) )
            continue;

        if ( !var_0 scripts\cp_mp\utility\player_utility::_isalive() )
            continue;

        if ( isdefined( self.stuckenemyentity ) && isalive( self.stuckenemyentity ) )
            continue;

        var_1 = register_boss_spawners( var_0 getweaponslistprimaries() );

        if ( !isdefined( var_1 ) )
            continue;

        if ( var_0 correctcodeentered( var_1 ) )
            self delete();
    }
}

register_boss_spawners( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( var_2 hasattachment( "ammo_crossbow" ) && self.brush == "bolt_default" )
            return var_2;

        if ( var_2 hasattachment( "mag_sn_t9crossbow" ) && self.brush == "bolt_default" )
            return var_2;

        if ( var_2 hasattachment( "boltstun_crossbow" ) && self.brush == "bolt_stun" )
            return var_2;
    }

    return undefined;
}

correctcodeentered( var_0 )
{
    var_1 = weaponmaxammo( var_0 );
    var_2 = self getweaponammostock( var_0 );

    if ( var_2 >= var_1 )
        return 0;

    var_3 = int( min( var_1, var_2 + 1 ) );
    self setweaponammostock( var_0, var_3 );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "hudIconType" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "hudIconType" ) ]]( "crossbowbolt" );

    return 1;
}

_id_13142( var_0 )
{
    switch ( var_0 )
    {
        case "bolt_fire":
            thread _id_13143( 5 );
            self.last_saydefuse_time = 0;
            break;
        case "bolt_explo":
            self.last_saydefuse_time = 0;
            break;
        case "bolt_stun":
            thread _id_13143( 0.5 );
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
    _id_11AB4();
}

_id_11AB4( var_0 )
{
    if ( isdefined( var_0 ) )
        var_1 = [ var_0 ];
    else
        var_1 = [];

    foreach ( var_3 in level.init_weapon_variant_spawns )
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

    level.init_weapon_variant_spawns = var_1;
}

relic_mythic_can_do_pain( var_0 )
{
    var_1 = "";

    foreach ( var_3 in var_0.attachments )
    {
        if ( issubstr( var_3, "bolt" ) )
        {
            var_1 = var_3;
            break;
        }
    }

    switch ( var_1 )
    {
        case "boltcarbon_crossbow":
            return "bolt_carbon";
        case "boltexplo_crossbow":
            return "bolt_explo";
        case "boltfire_crossbow":
            return "bolt_fire";
        case "boltstun_crossbow":
            return "bolt_stun";
        default:
            return "bolt_default";
    }
}

relic_mythic_do_pain( var_0 )
{
    switch ( var_0 )
    {
        case "bolt_carbon":
            return ::start_authentication_timer;
        case "bolt_explo":
            return ::start_bomb_vest_defusal;
        case "bolt_fire":
            return ::start_bomb_vest_defusal_sequence;
        case "bolt_stun":
            return ::start_box_set_up;
        default:
            return;
    }
}

regroup_points( var_0 )
{
    switch ( var_0 )
    {
        case "bolt_carbon":
            return "weapon_wm_sn_crossbow_bolt_carbon_static";
        case "bolt_explo":
            return "weapon_wm_sn_crossbow_bolt_explosive_static";
        case "bolt_fire":
            return "weapon_wm_sn_crossbow_bolt_fire_static";
        case "bolt_stun":
            return "weapon_wm_sn_crossbow_bolt_stun_static";
        default:
            return "weapon_wm_sn_crossbow_bolt_static";
    }
}

_id_1331F( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) && isdefined( var_3 ) )
        return 1;

    if ( !isdefined( var_0 ) )
        return 0;

    switch ( var_0 )
    {
        case "glass_solid":
        case "glass_pane":
            return 1;
    }

    if ( var_1.brush == "bolt_explo" )
        return 0;

    if ( use_trace_radius( var_2 ) )
        return 1;

    if ( use_struct( var_2 ) )
        return 1;

    switch ( var_0 )
    {
        case "asphalt_wet":
        case "asphalt_dry":
        case "riotshield":
            return 1;
        case "metal_car":
        case "metal_tank":
        case "metal_helicopter":
        case "metal_thin":
        case "metal_thick":
        case "metal_grate":
            if ( var_1.brush == "bolt_fire" )
                return 0;
            else
                return 1;
        default:
            return 0;
    }
}

_id_12AC6( var_0, var_1, var_2, var_3 )
{
    var_4 = scripts\engine\math::vector_reflect( var_2, var_1 );
    var_5 = abs( vectordot( var_2, var_1 ) );
    var_6 = scripts\engine\math::factor_value( 2300, 1000, var_5 );
    var_4 = var_4 * var_6;
    var_0 physicslaunchserver( var_3, var_4 );
}

_id_132F1( var_0 )
{
    if ( !isdefined( var_0 ) )
        return 0;

    if ( isagent( var_0 ) && var_0 trytoplaydamagesound() && !isalive( var_0 ) && !isdefined( var_0 getcorpseentity() ) )
        return 1;

    return 0;
}

_id_13309( var_0 )
{
    if ( !isdefined( var_0 ) )
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

    if ( isplayer( var_1 ) && var_0.brush != "bolt_stun" )
    {
        var_0 hidefromplayer( var_1 );

        if ( isdefined( var_0._id_12357 ) )
            var_0._id_12357 hidefromplayer( var_1 );
    }

    if ( isdefined( var_2 ) )
        var_0 linkto( var_1, var_2 );
    else
        var_0 linkto( var_1 );

    if ( get_center_loc_among_target_players( var_1 ) )
    {
        var_0.stuckenemyentity = var_1;
        var_0 thread _id_12C28( var_1 );
    }

    var_0 notsolid();
    var_0 thread courtyard_intel_sequence( var_1 );
    var_0 thread cosmeticattachment( var_1, "vehicle_deleted" );
    var_0 thread cosmeticattachment( var_1, "detonated" );
    var_0 thread cosmeticattachment( var_1, "beginC130" );
}

_id_140CA()
{
    if ( isdefined( self ) && istrue( self.uavnoneid ) )
        return 1;
    else
    {

    }
}

_id_12C28( var_0 )
{
    self endon( "entitydeleted" );
    var_0 scripts\engine\utility::_id_143A6( "entitydeleted", "death", "disconnect" );

    if ( !_id_140CA() )
        return;

    self.stuckenemyentity = undefined;

    if ( isdefined( var_0 ) && isdefined( var_0.nocorpse ) )
        self delete();
}

courtyard_intel_sequence( var_0 )
{
    self endon( "entitydeleted" );
    var_0 scripts\engine\utility::_id_143A5( "entitydeleted", "disconnect" );

    if ( !_id_140CA() )
        return;

    course_triggers_expl();
}

course_triggers_expl( var_0 )
{
    if ( !isdefined( var_0 ) )
        var_0 = ( 0, 0, 100 );

    if ( self islinked() )
        self unlink();

    if ( !isdefined( self.model ) || self.model == "tag_origin" || self.model == "" )
        return;

    self solid();
    self physicslaunchserver( self.origin, var_0 );
}

cosmeticattachment( var_0, var_1 )
{
    self endon( "entitydeleted" );
    var_0 waittill( var_1 );

    if ( !_id_140CA() )
        return;

    self delete();
}

countdownendcallback()
{
    self waittill( "entitydeleted" );

    if ( isdefined( self._id_12357 ) )
        self._id_12357 delete();

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

use_struct( var_0 )
{
    if ( !isagent( var_0 ) )
        return 0;

    if ( isdefined( var_0.agentteam ) && self.team == var_0.agentteam )
        return 1;

    return 0;
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