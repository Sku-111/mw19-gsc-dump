// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    deactivate_front_trigger_hurt();
}

deactivate_front_trigger_hurt()
{
    _id_131DF();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::deactivate_gas_trap;
    level.bot_funcs["should_start_cautious_approach"] = ::_id_132DF;
}

_id_131DF()
{
    scripts\mp\bots\bots_util::bot_waittill_bots_enabled();
    var_0 = 0;

    foreach ( var_2 in level.objectives )
    {
        var_2 thread scripts\mp\bots\bots_gametype_common.gsc::monitor_zone_control();
        var_3 = 0;

        if ( istrue( var_2.trigger.trigger_off ) )
        {
            var_2.trigger scripts\engine\utility::trigger_on();
            var_3 = 1;
        }

        var_2.nodes = scripts\mp\bots\bots_gametype_common.gsc::bot_get_valid_nodes_in_trigger( var_2.trigger );

        if ( var_3 )
            var_2.trigger scripts\engine\utility::trigger_off();
    }

    level.death_info_func = 1;

    if ( !var_0 )
    {
        var_5 = find_current_radio();

        if ( !isdefined( var_5 ) )
            var_5 = scripts\engine\utility::random( level.objectives );

        scripts\mp\bots\bots_gametype_common.gsc::custom_damageshield( [ var_5 ] );
        level.damagepercenthigh[var_5.trigger getentitynumber()] = 1;
        level.bot_gametype_precaching_done = 1;
        thread currlocation( var_5 );
    }
}

currlocation( var_0 )
{
    for ( var_1 = scripts\engine\utility::array_remove( level.objectives, var_0 ); var_1.size > 0; var_1 = scripts\engine\utility::array_remove( var_1, var_2 ) )
    {
        var_2 = undefined;
        var_3 = find_current_radio();

        if ( isdefined( var_3 ) && scripts\engine\utility::array_contains( var_1, var_3 ) )
            var_2 = var_3;
        else
            var_2 = scripts\engine\utility::random( var_1 );

        scripts\mp\bots\bots_gametype_common.gsc::custom_damageshield( [ var_2 ] );
        level.damagepercenthigh[var_2.trigger getentitynumber()] = 1;
    }
}

deactivate_gas_trap()
{
    self notify( "bot_hq_think" );
    self endon( "bot_hq_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );

    while ( !isdefined( level.bot_gametype_precaching_done ) )
        wait 0.05;

    self botsetflag( "separation", 0 );
    self botsetflag( "grenade_objectives", 1 );

    for (;;)
    {
        wait 0.05;

        if ( self.health <= 0 )
            continue;

        var_0 = find_current_radio();

        if ( !isdefined( var_0 ) || !istrue( var_0.active ) || !isdefined( level.damagepercenthigh[var_0.trigger getentitynumber()] ) )
        {
            custompassengerwaitfunc();
            self [[ self.personality_update_function ]]();
            continue;
        }

        var_1 = level.zone scripts\mp\gameobjects::getownerteam();

        if ( self.team != var_1 )
        {
            if ( !deactivate_gas_trap_cloud_parent( var_0 ) )
                custom_explode_mine( var_0 );

            continue;
        }

        var_2 = scripts\engine\utility::get_enemy_team( self.team );
        var_3 = level.zone.touchlist[var_2].size > 0;

        if ( var_3 )
        {
            if ( !deactivate_gas_trap_cloud_parent( var_0 ) )
                custom_explode_mine( var_0 );

            continue;
        }

        if ( !deactivate_hacked_console( var_0 ) )
        {
            if ( deactivate_gas_trap_cloud_parent( var_0 ) )
            {
                wait( randomfloat( 2 ) );
                custompassengerwaitfunc();
                continue;
            }

            deal_damage_after_time( var_0 );
        }
    }
}

find_current_radio()
{
    foreach ( var_1 in level.objectives )
    {
        if ( isdefined( level.zone ) && var_1.trigger == level.zone.trigger )
            return var_1;
    }
}

deactivate_gas_trap_cloud_parent( var_0 )
{
    if ( !scripts\mp\bots\bots_util::bot_is_capturing() )
        return 0;

    return isdefined( self.initpayloadpunish ) && self.initpayloadpunish == var_0;
}

deactivate_hacked_console( var_0 )
{
    if ( !scripts\mp\bots\bots_util::bot_is_protecting() )
        return 0;

    return isdefined( self.initpayloadpunish ) && self.initpayloadpunish == var_0;
}

custom_explode_mine( var_0 )
{
    self.initpayloadpunish = var_0;
    var_1["entrance_points_index"] = var_0.entrance_indices;
    var_1["override_origin_node"] = var_0.get_wave_targetname;
    scripts\mp\bots\bots_strategy::bot_capture_zone( var_0.trigger.origin, var_0.nodes, var_0.trigger, var_1 );
}

deal_damage_after_time( var_0 )
{
    self.initpayloadpunish = var_0;
    var_1 = length( var_0._id_14713.setplacementxpshare ) * 2;
    var_2["override_origin_node"] = var_0.get_wave_targetname;
    scripts\mp\bots\bots_strategy::bot_protect_point( var_0.get_wave_targetname.origin, var_1, var_2 );
}

custompassengerwaitfunc()
{
    if ( scripts\mp\bots\bots_util::bot_is_defending() )
        scripts\mp\bots\bots_strategy::bot_defend_stop();

    self.initpayloadpunish = undefined;
}

_id_132DF( var_0 )
{
    if ( var_0 )
    {
        var_1 = level.zone scripts\mp\gameobjects::getownerteam();

        if ( var_1 == "neutral" || var_1 == self.team )
            return 0;
    }

    return scripts\mp\bots\bots_strategy::should_start_cautious_approach_default( var_0 );
}
