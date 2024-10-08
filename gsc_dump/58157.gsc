// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

tr_vis_facing_dist_add_override( var_0 )
{
    if ( !isdefined( level.chopper_sound_fade_and_delete ) )
        level.chopper_sound_fade_and_delete = [];
}

_id_1403E( var_0 )
{
    self endon( "death_or_disconnect" );
    self endon( "faux_spawn" );
    self endon( "end_launcher" );
    var_1 = registeronrespawn( var_0 );
    var_2 = registerontimerexpired( var_1 );
    thread chopperexfil_introsound( var_0, var_1, var_2 );
}

handlerelicmartyrdomgas()
{
    self waittill( "end_launcher" );
    wait 6;
    self notify( "cleanupImpactWatcher" );
}

chopperexfil_introsound( var_0, var_1, var_2 )
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

        var_12 = _id_1360F( var_9, var_8, var_1, var_7 );
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

_id_1360F( var_0, var_1, var_2, var_3 )
{
    var_4 = regroup_points( var_3 );
    var_5 = spawn( "script_model", var_0 );
    var_5 setmodel( var_4 );
    var_5.angles = vectortoangles( var_1 ) + ( 90, 0, 0 );
    var_5 _id_13142( var_2 );
    var_5.owner = self;
    var_5.brush = var_2;
    var_5.weapon = var_3;
    var_5.tut_bots_forcelaststand_onspawn = 1;

    if ( _id_1330E( var_2 ) )
        var_5 = _id_11AA3( var_5 );

    var_5 thread countdownendcallback();
    _id_11AB4( var_5 );
    return var_5;
}

_id_1330E( var_0 )
{
    if ( var_0 == "bolt_default" )
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
        if ( var_2 hasattachment( "mag_me_t9ballisticknife" ) && self.brush == "bolt_default" )
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

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "weapons", "giveAmmoType" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "weapons", "giveAmmoType" ) ]]( self, "brloot_ammo_rocket", 1, 0 );

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "damage", "hudIconType" ) )
        self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "damage", "hudIconType" ) ]]( "throwingknife" );

    return 1;
}

_id_13142( var_0 )
{
    switch ( var_0 )
    {
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

    foreach ( var_3 in level.chopper_sound_fade_and_delete )
    {
        if ( !isdefined( var_3 ) )
            continue;

        if ( isdefined( var_3 ) )
        {
            if ( var_1.size >= 7 && var_3.last_saydefuse_time )
            {
                var_3 delete();
                continue;
            }

            var_1[var_1.size] = var_3;
        }
    }

    level.chopper_sound_fade_and_delete = var_1;
}

registeronrespawn( var_0 )
{
    return "bolt_default";
}

registerontimerexpired( var_0 )
{
    return;
}

regroup_points( var_0 )
{
    var_1 = 0;
    var_1 = getweaponvariantindex( var_0 );

    if ( isdefined( var_1 ) )
    {
        switch ( var_1 )
        {
            case 1:
                return "weapon_wm_special_t9ballisticknife_projectile_v2";
            default:
                break;
        }
    }

    return "weapon_wm_special_t9ballisticknife_projectile";
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

    if ( use_trace_radius( var_2 ) )
        return 1;

    if ( use_struct( var_2 ) )
        return 1;

    switch ( var_0 )
    {
        case "metal_car":
        case "metal_tank":
        case "metal_helicopter":
        case "metal_thin":
        case "metal_thick":
        case "metal_grate":
        case "riotshield":
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

    if ( isplayer( var_1 ) )
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
    if ( isdefined( self ) && istrue( self.tut_bots_forcelaststand_onspawn ) )
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

    if ( !isdefined( self.model ) || self.model == "tag_origin" )
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