// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( getdvarint( "scr_br_pe_disabled", 0 ) )
        return;

    level.delayeventfired = getdvarint( "scr_br_pe_grabbag", 0 ) == 1;
    level.delayedeventtypes = [];
    level.delay_thirdpersoncamera = [];
    level.delayedunsetbettermissionrewards = getdvarint( "scr_br_pe_event_repetition_buffer", 2 );
    level.delayedshowtablets = relic_squadlink_flash_squadlink_icon( "0 0 0 0 0 0 0 0" );
    level.br_pe_active_pe_count = 0;
    all_players_within_distance2d();
    scripts\mp\gametypes\br_dev.gsc::_id_12B21( ::setup_nuke_vault_door_open );

    if ( scripts\mp\gametypes\br_publicevents_meter.gsc::ispubliceventmeterenabled() )
        level thread scripts\mp\gametypes\br_publicevents_meter.gsc::init();

    if ( _id_12932() )
    {
        if ( unset_relic_healthpacks() )
            level thread _id_12934();
        else
            level thread _id_12933();
    }
}

all_players_within_distance2d()
{
    scripts\mp\gametypes\br_publicevent_bombardment.gsc::init();
    scripts\mp\gametypes\br_publicevent_choppers.gsc::init();
    scripts\mp\gametypes\br_publicevent_firesale.gsc::init();
    scripts\mp\gametypes\br_publicevent_jailbreak.gsc::init();
    scripts\mp\gametypes\br_publicevent_juggernaut.gsc::init();
    scripts\mp\gametypes\br_publicevent_restock.gsc::init();
    scripts\mp\gametypes\br_publicevent_satellite.gsc::init();
    scripts\mp\gametypes\br_publicevent_loadoutdrop.gsc::init();
    scripts\mp\gametypes\br_publicevent_lootcratedrop.gsc::init();
    scripts\mp\gametypes\br_publicevent_auavscan.gsc::init();
    scripts\mp\gametypes\br_publicevent_armoredtruck.gsc::init();
    scripts\mp\gametypes\br_publicevent_resurgence.gsc::init();
    scripts\mp\gametypes\br_publicevent_tower.gsc::init();
    scripts\mp\gametypes\br_publicevent_fresno.gsc::init();
    scripts\mp\gametypes\br_publicevent_interception_chopper.gsc::init();
    scripts\mp\gametypes\br_publicevent_fafir.gsc::init();
    scripts\mp\gametypes\br_publicevent_outbreak.gsc::init();

    if ( unset_relic_healthpacks() )
    {
        var_0 = spawnstruct();
        var_0.weight = 0;
        _id_12B35( 0, var_0 );
    }

    _postinitevents();
}

_postinitevents()
{
    foreach ( var_2, var_1 in level.delayedeventtypes )
    {
        if ( var_1.weight <= 0.0 && !ispubliceventmeteractive( var_1 ) )
            continue;

        if ( isdefined( var_1._id_140CF ) && ![[ var_1._id_140CF ]]() )
            continue;

        if ( isdefined( var_1.postinitfunc ) )
            var_1 [[ var_1.postinitfunc ]]();
    }
}

relic_squadlink_init_vfx( var_0, var_1 )
{
    var_2 = getdvar( "scr_br_pe_" + var_0 + "_circle_event_weights", var_1 );
    var_3 = [];

    if ( var_2 != "" )
    {
        var_4 = strtok( var_2, " " );

        foreach ( var_6 in var_4 )
            var_3[var_3.size] = float( var_6 );
    }

    return var_3;
}

relic_squadlink_flash_squadlink_icon( var_0 )
{
    var_1 = getdvar( "scr_br_pe_circle_event_chances", var_0 );
    var_2 = [];

    if ( var_1 != "" )
    {
        var_3 = strtok( var_1, " " );

        foreach ( var_5 in var_3 )
            var_2[var_2.size] = float( var_5 );
    }

    return var_2;
}

_id_12B35( var_0, var_1 )
{
    if ( !isdefined( var_1.weight ) )
        var_1.active = 0;

    if ( !isdefined( var_1.weight ) )
        var_1.weight = 1.0;

    if ( unset_relic_healthpacks() )
    {
        if ( !isdefined( var_1._id_11B78 ) )
            var_1._id_11B78 = 1;

        if ( !isdefined( var_1.compass ) )
            var_1.compass = [];
    }

    level.delayedeventtypes[var_0] = var_1;
    return var_1;
}

generic_waittill_button_press()
{
    level notify( "cancel_public_event" );
    level.br_pe_active_pe_count = 0;
}

_id_12932()
{
    var_0 = getdvarint( "scr_br_pe_force_type", 0 );

    if ( var_0 != 0 )
        return 1;

    if ( scripts\mp\utility\game::updatex1stashhud() )
        return 0;

    var_1 = revive_wounded_out_handlerr();

    if ( !var_1 )
        return 0;

    var_2 = revive_wounded_out_handler();

    if ( var_2 <= 0.0 )
        return 0;

    return 1;
}

_id_132F7( var_0 )
{
    var_1 = revive_wounded_out_handler();

    if ( unset_relic_healthpacks() && isdefined( var_0 ) )
    {
        if ( isdefined( level.delayedshowtablets[var_0] ) )
            var_1 = level.delayedshowtablets[var_0];
        else
        {
            allsupportboxes( "Public event was not activated due to circle event chance not being set for circle " + var_0 );
            return 0;
        }
    }

    if ( var_1 <= 0.0 )
        return 0;

    return randomfloat( 1.0 ) <= var_1;
}

isanypubliceventcurrentlyactive()
{
    return level.br_pe_active_pe_count > 0;
}

revive_wounded_out_handlerr()
{
    return getdvarint( "scr_br_pe_count", 1 );
}

revive_wounded_out_handler()
{
    return getdvarfloat( "scr_br_pe_chance", 0.0 );
}

_id_11E05()
{
    var_0 = revive_wounded_out_handlerr();
    return var_0 != 1;
}

_id_12933()
{
    level endon( "cancel_public_event" );
    scripts\mp\flags::gameflagwait( "prematch_done" );

    if ( _id_11E05() )
    {
        var_0 = getdvarfloat( "scr_br_pe_multi_wait_min", 240 );
        var_1 = getdvarfloat( "scr_br_pe_multi_wait_max", 360 );
        var_2 = revive_wounded_out_handlerr();

        while ( var_2 )
        {
            var_3 = randomfloatrange( var_0, var_1 );
            wait( var_3 );

            if ( _id_132F7() )
            {
                give_intel_data( 1 );
                var_2--;
            }
        }
    }
    else if ( _id_132F7() )
        give_intel_data( 0 );
}

_id_140CC()
{
    var_0 = [];

    foreach ( var_3, var_2 in level.delayedeventtypes )
    {
        if ( var_2.weight <= 0.0 )
        {
            allsupportboxes( ai_ignore_all_until_goal( var_3 ) + " was invalidated due to 0 weight" );
            continue;
        }

        if ( isdefined( var_2._id_140CF ) && ![[ var_2._id_140CF ]]() )
        {
            allsupportboxes( ai_ignore_all_until_goal( var_3 ) + " was invalidated due to failing validate function" );
            continue;
        }

        allsupportboxes( ai_ignore_all_until_goal( var_3 ) + " was validated" );
        var_0[var_0.size] = var_3;
    }

    return var_0;
}

safehouse_create_loot( var_0, var_1, var_2 )
{
    var_3 = 0.0;

    foreach ( var_5 in var_0 )
    {
        var_6 = level.delayedeventtypes[var_5];
        var_7 = var_6.weight;
        var_8 = scripts\engine\utility::ter_op( var_2, var_6.pemetereventweights, var_6.guard_door_clip );

        if ( isdefined( var_1 ) && isdefined( var_8 ) && isdefined( var_8[var_1] ) )
            var_7 = var_8[var_1];

        var_3 = var_3 + var_7;
    }

    return var_3;
}

play_sound_on_pa_systems( var_0, var_1, var_2, var_3 )
{
    var_4 = 0.0;

    if ( !var_0.size )
        return 0;

    foreach ( var_6 in var_0 )
    {
        var_7 = level.delayedeventtypes[var_6];
        var_8 = var_7.weight;
        var_9 = scripts\engine\utility::ter_op( var_3, var_7.pemetereventweights, var_7.guard_door_clip );

        if ( isdefined( var_2 ) && isdefined( var_9 ) && isdefined( var_9[var_2] ) )
            var_8 = var_9[var_2];

        var_4 = var_4 + var_8;

        if ( var_1 <= var_4 )
            return var_6;
    }

    return 0;
}

give_intel_data( var_0, var_1, var_2 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 0;

    var_3 = undefined;

    if ( unset_relic_healthpacks() )
    {
        allsupportboxes( "Selecting event for circle#: " + var_1 );
        var_3 = _id_140CD( var_1, var_2 );
    }
    else
        var_3 = _id_140CC();

    if ( unset_relic_healthpacks() )
    {

    }

    var_4 = safehouse_create_loot( var_3, var_1, var_2 );
    var_5 = randomfloat( var_4 );
    var_6 = play_sound_on_pa_systems( var_3, var_5, var_1, var_2 );
    allsupportboxes( "Selected event: " + ai_ignore_all_until_goal( var_6 ) );
    var_7 = getdvarint( "scr_br_pe_force_type", 0 );

    if ( var_7 != 0 )
    {
        allsupportboxes( "Overriding selected event with: " + ai_ignore_all_until_goal( var_7 ) );
        var_6 = var_7;
    }

    level _id_12E1F( var_6, var_0, var_1, var_2 );
}

activateevent( var_0 )
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );

    if ( isdefined( var_0.attackerswaittime ) )
        var_0 [[ var_0.attackerswaittime ]]();

    level.br_pe_active_pe_count = level.br_pe_active_pe_count - 1;
    level notify( "br_pe_end" );
}

_id_12E1F( var_0, var_1, var_2, var_3 )
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );

    if ( var_0 == 0 && !unset_relic_healthpacks() )
        allsupportboxes( "No event was valid for this run." );
    else
    {
        var_4 = level.delayedeventtypes[var_0];

        if ( isdefined( var_4._id_14382 ) && !var_1 )
            var_4 [[ var_4._id_14382 ]]();

        if ( getdvarint( "scr_br_pe_enable_queueing", 1 ) > 0 )
        {
            while ( isanypubliceventcurrentlyactive() )
            {
                level scripts\engine\utility::_id_143A5( "br_pe_end", "cancel_public_event" );
                waitframe();
            }
        }

        level.br_pe_active_pe_count = level.br_pe_active_pe_count + 1;
        var_4.active = 1;
        scripts\mp\gametypes\br_analytics.gsc::devspectatetest( var_0 );

        if ( unset_relic_healthpacks() )
        {
            level.delete_after_objective_a = 1;
            allsupportboxes( "Activating Event: " + ai_ignore_all_until_goal( var_0 ) );
            level thread activateevent( var_4 );

            if ( !istrue( var_3 ) )
            {
                if ( !isdefined( level.delete_bad_trucks[var_0] ) )
                    level.delete_bad_trucks[var_0] = 0;

                level.delete_bad_trucks[var_0]++;

                if ( isdefined( var_2 ) )
                    level.delay_vehicle_to_push_explode_sequence[var_0] = var_2;
            }

            var_5 = level.delayedeventtypes[var_0].compass;
            activeparachuters( var_5 );
            level waittill( "br_circle_set" );
            neurotoxin_mask_monitor( var_0 );
            level notify( "select_new_event" );
            return;
        }

        level activateevent( var_4 );
        var_4.active = 0;
        scripts\mp\gametypes\br_analytics.gsc::devspectateloc( var_0 );
    }
}

neurotoxin_mask_monitor( var_0 )
{
    if ( upload_station_interact_used_think( var_0 ) )
    {
        var_1 = level.delayedeventtypes[var_0];

        if ( isdefined( var_1.isfeaturedisabled ) )
            var_1 [[ var_1.isfeaturedisabled ]]();

        var_1.active = 0;
        scripts\mp\gametypes\br_analytics.gsc::devspectateloc( var_0 );
    }
}

upload_station_interact_used_think( var_0 )
{
    var_1 = level.delayedeventtypes[var_0];

    if ( !isdefined( var_1 ) )
        return 0;

    return istrue( var_1.active );
}

_id_13371( var_0 )
{
    foreach ( var_2 in level.players )
        var_2 scripts\mp\hud_message::showsplash( var_0 );
}

dangercircletick( var_0, var_1 )
{
    scripts\mp\gametypes\br_publicevent_choppers.gsc::dangercircletick( var_0, var_1 );
}

resetminimappulse( var_0 )
{
    level endon( "game_ended" );

    if ( isdefined( var_0 ) )
        wait( var_0 );

    setomnvar( "ui_publicevent_minimap_pulse", 0 );
}

setup_nuke_vault_door_open( var_0, var_1 )
{

}

unset_relic_healthpacks()
{
    return istrue( level.delayeventfired );
}

_id_12934()
{
    level endon( "cancel_public_event" );
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.delete_bad_trucks = [];
    level.delay_vehicle_to_push_explode_sequence = [];
    var_0 = 0;
    var_1 = getdvarint( "scr_br_pe_max_event_count", level.br_level.br_circleradii.size - 1 );

    for ( var_2 = level.br_level.br_circleradii.size - 1; var_0 < var_2; var_0++ )
    {
        if ( var_0 == 0 )
        {
            level waittill( "br_circle_set" );
            var_3 = 5;
            var_4 = getdvarint( "scr_br_pe_initial_delay", var_3 );
            wait( var_4 );
        }
        else
        {
            if ( istrue( level.delete_after_objective_a ) )
                level waittill( "select_new_event" );
            else
                level waittill( "br_circle_set" );

            var_5 = 8;
            var_6 = getdvarint( "scr_br_pe_subsequent_delay", var_5 );
            wait( var_6 );
        }

        if ( isdefined( level.br_pe_grabbag_skipwait ) && level.br_pe_grabbag_skipwait == 0 )
            var_7 = 0;
        else
            var_7 = 1;

        var_8 = level.br_circle.circleindex;

        if ( _id_132F7( var_8 ) )
        {
            level thread give_intel_data( var_7, var_8, 0 );
            continue;
        }

        level.delete_after_objective_a = 0;
    }
}

_id_140CD( var_0, var_1 )
{
    var_2 = [];

    foreach ( var_11, var_4 in level.delayedeventtypes )
    {
        if ( var_4.weight <= 0.0 )
        {
            allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to 0 weight" );
            continue;
        }

        if ( isdefined( var_4._id_140CF ) && ![[ var_4._id_140CF ]]() )
        {
            allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to failing validate function" );
            continue;
        }

        if ( isdefined( level.delay_thirdpersoncamera ) && istrue( level.delay_thirdpersoncamera[var_11] ) )
        {
            allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to this event being on the blacklist" );
            continue;
        }

        if ( isdefined( var_4.compass ) )
        {
            var_5 = 0;

            foreach ( var_7 in var_4.compass )
            {
                if ( isdefined( level.delete_bad_trucks[var_7] ) )
                {
                    if ( level.delete_bad_trucks[var_7] > 0 )
                    {
                        var_5 = 1;
                        break;
                    }
                }
            }

            if ( var_5 )
            {
                allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to a previously run event to being on this event's blacklist" );
                continue;
            }
        }

        var_9 = scripts\engine\utility::ter_op( var_1, var_4.pemetereventweights, var_4.guard_door_clip );

        if ( isdefined( var_9 ) )
        {
            if ( isdefined( var_9[var_0] ) && var_9[var_0] <= 0 )
            {
                allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to 0 weight" );
                continue;
            }
            else if ( !isdefined( var_9[var_0] ) )
            {
                allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to missing circle event weight for circle" + var_0 );
                continue;
            }
        }

        if ( !istrue( var_1 ) )
        {
            if ( isdefined( level.delete_bad_trucks ) && isdefined( level.delete_bad_trucks[var_11] ) )
            {
                if ( isdefined( var_4._id_11B78 ) && level.delete_bad_trucks[var_11] >= var_4._id_11B78 )
                {
                    allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to already activating max times" );
                    continue;
                }
            }

            if ( isdefined( level.delay_vehicle_to_push_explode_sequence ) && isdefined( level.delay_vehicle_to_push_explode_sequence[var_11] ) )
            {
                var_10 = var_0 - level.delay_vehicle_to_push_explode_sequence[var_11];

                if ( var_10 >= level.delayedunsetbettermissionrewards + 1 )
                    level.delay_vehicle_to_push_explode_sequence[var_11] = undefined;
                else
                {
                    allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was invalidated due to being a previously ran event within the span of the event repetition buffer." );
                    continue;
                }
            }
        }

        allsupportboxes( ai_ignore_all_until_goal( var_11 ) + " was validated" );
        var_2[var_2.size] = var_11;
    }

    if ( var_2.size == 0 )
        var_2[var_2.size] = 0;

    return var_2;
}

allsupportboxes( var_0 )
{
    if ( getdvarint( "scr_br_pe_debug", 0 ) == 1 )
        logstring( "PE: " + var_0 );
}

ai_ignore_all_until_goal( var_0 )
{
    switch ( var_0 )
    {
        case 0:
            return "CONST_BR_PE_TYPE_NONE";
        case 1:
            return "CONST_BR_PE_TYPE_CHOPPERS";
        case 2:
            return "CONST_BR_PE_TYPE_FIRESALE";
        case 3:
            return "CONST_BR_PE_TYPE_JAILBREAK";
        case 4:
            return "CONST_BR_PE_TYPE_JUGGERNAUT";
        case 5:
            return "CONST_BR_PE_TYPE_BOMBARDMENT";
        case 6:
            return "CONST_BR_PE_TYPE_RESTOCK";
        case 7:
            return "CONST_BR_PE_TYPE_SATELLITE";
        case 8:
            return "CONST_BR_PE_TYPE_LOADOUTDROP";
        case 9:
            return "CONST_BR_PE_TYPE_LOOTCRATE_DROP";
        case 10:
            return "CONST_BR_PE_TYPE_AUAVSCAN";
        case 11:
            return "CONST_BR_PE_TYPE_ARMOREDTRUCK";
        case 12:
            return "CONST_BR_PE_TYPE_PLUNDER_CRATE_DROP";
        case 13:
            return "CONST_BR_PE_TYPE_WEAPON_CRATE_DROP";
        case 20:
            return "CONST_BR_PE_TYPE_MEDICAL_CRATE_DROP";
        case 14:
            return "CONST_BR_PE_TYPE_RESURGENCE";
        case 15:
            return "CONST_BR_PE_TYPE_TOWER";
        case 16:
            return "CONST_BR_PE_TYPE_FRESNO";
        case 17:
            return "CONST_BR_PE_TYPE_INTERCEPTION";
        case 18:
            return "CONST_BR_PE_TYPE_FAFIR";
        case 19:
            return "CONST_BR_PE_TYPE_OUTBREAK";
        default:
            scripts\mp\utility\script::laststand_dogtags( "No name is defined for eventType: " + var_0 );
            return "UNKNOWN_TYPE";
    }
}

activeparachuters( var_0 )
{
    foreach ( var_2 in var_0 )
    {
        if ( !isdefined( level.delay_thirdpersoncamera[var_2] ) )
            level.delay_thirdpersoncamera[var_2] = 1;
    }
}

ispubliceventmeteractive( var_0 )
{
    if ( isdefined( var_0.pemetereventweights ) )
    {
        foreach ( var_2 in var_0.pemetereventweights )
        {
            if ( var_2 > 0 )
                return 1;
        }
    }

    return 0;
}
