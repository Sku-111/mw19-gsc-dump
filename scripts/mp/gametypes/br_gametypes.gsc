// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.disable_super_in_turret = spawnstruct();
    level.disable_super_in_turret.funcs = [];
    level.disable_super_in_turret.lmg_guys = [];
    level.disable_super_in_turret.move_ent = [];
    level.disable_super_in_turret.data = [];
    level.disable_super_in_turret.name = getdvar( "scr_br_gametype", "" );
    level.disable_super_in_turret._id_12E05 = ::_id_12E05;
    level.disable_super_in_turret.unset_relic_aggressive_melee_params = ::unset_relic_aggressive_melee_params;
    level.disable_super_in_turret.tutorial_showtext = ::tutorial_showtext;

    if ( level.disable_super_in_turret.name == "none" )
        level.disable_super_in_turret.name = "";

    if ( scripts\mp\utility\game::privatematch() )
        _id_140D3();

    switch ( level.disable_super_in_turret.name )
    {
        case "control":
            scripts\mp\gametypes\br_gametype_control.gsc::init();
            break;
        case "gold_war":
        case "dmz":
            scripts\mp\gametypes\br_gametype_dmz.gsc::init();
            break;
        case "prop":
            scripts\mp\gametypes\br_gametype_prop.gsc::init();
            break;
        case "jugg":
            scripts\mp\gametypes\br_gametype_juggernaut.gsc::init();
            break;
        case "kingslayer":
            scripts\mp\gametypes\br_gametype_kingslayer.gsc::init();
            break;
        case "mini":
            scripts\mp\gametypes\br_gametype_mini.gsc::init();
            break;
        case "mmp":
            scripts\mp\gametypes\br_gametype_mmp.gsc::init();
            break;
        case "truckwar":
            scripts\mp\gametypes\br_gametype_truckwar.gsc::init();
            break;
        case "vov":
            scripts\mp\gametypes\br_gametype_vov.gsc::init();
            break;
        case "gxp":
            scripts\mp\gametypes\br_gametype_gxp.gsc::init();
            break;
        case "zxp":
            scripts\mp\gametypes\br_gametype_zxp.gsc::init();
            break;
        case "rebirth_dbd":
        case "rebirth":
            scripts\mp\gametypes\br_gametype_rebirth.gsc::init();
            break;
        case "payload":
            scripts\mp\gametypes\br_gametype_payload.gsc::init();
            break;
        case "dbd":
            scripts\mp\gametypes\br_gametype_dbd.gsc::init();
            break;
        case "tdbd":
            scripts\mp\gametypes\br_gametype_tdbd.gsc::init();
            break;
        case "x2":
            break;
        case "reveal":
            scripts\mp\gametypes\br_gametype_reveal.gsc::init();
            break;
        case "reveal_2":
            scripts\mp\gametypes\br_gametype_reveal_2.gsc::init();
            break;
        case "bodycount":
            scripts\mp\gametypes\br_gametype_bodycount.gsc::init();
            break;
        case "treasure_hunt":
            scripts\mp\gametypes\br_gametype_treasure_hunt.gsc::init();
            break;
        case "rumble":
            scripts\mp\gametypes\br_gametype_rumble.gsc::init();
            break;
        case "rumble_invasion":
            scripts\mp\gametypes\br_gametype_rumble_invasion.gsc::init();
            break;
        case "brz":
            scripts\mp\gametypes\br_gametype_brz.gsc::init();
            break;
        case "brdov":
            scripts\mp\gametypes\br_gametype_brdov.gsc::init();
            break;
        case "ter":
            scripts\mp\gametypes\br_gametype_ter.gsc::init();
            break;
        case "lep":
            scripts\mp\gametypes\br_gametype_lep.gsc::init();
            break;
        case "rebirth_reverse":
            scripts\mp\gametypes\br_gametype_rebirth_reverse.gsc::init();
            break;
        case "blitz":
            scripts\mp\gametypes\br_gametype_blitz.gsc::init();
            break;
        case "respect":
            scripts\mp\gametypes\br_gametype_respect.gsc::init();
            break;
        case "rat_race":
            scripts\mp\gametypes\br_gametype_rat_race.gsc::init();
            break;
        case "mendota":
            scripts\mp\gametypes\br_gametype_mendota.gsc::init();
            break;
        case "olaride":
            scripts\mp\gametypes\br_gametype_olaride.gsc::init();
            break;
        case "multisquad_pve":
            scripts\mp\gametypes\br_gametype_multisquad_pve.gsc::init();
            break;
        case "":
            break;
        default:
            break;
    }
}

setup_vehicle_wave_by_player_count()
{
    exitlevel( 0 );
}

_id_140D3()
{
    if ( !getdvarint( "scr_br_pr_validate_gametypes", 1 ) )
        return;

    var_0 = getdvar( "scr_br_pr_valid_gametypes", "" );
    var_1 = getdvar( "scr_br_pr_invalid_gametypes", "" );
    var_2 = strtok( var_0, " " );
    var_3 = strtok( var_1, " " );

    foreach ( var_5 in var_2 )
    {
        if ( level.disable_super_in_turret.name == var_5 )
            return;
    }

    foreach ( var_5 in var_3 )
    {
        if ( level.disable_super_in_turret.name == var_5 )
        {
            setup_vehicle_wave_by_player_count();
            return;
        }
    }

    switch ( level.disable_super_in_turret.name )
    {
        case "dbd":
        case "rebirth_dbd":
        case "rebirth_reverse":
        case "rebirth":
        case "mini":
        case "gold_war":
        case "rat_race":
        case "dmz":
        case "":
            return;
    }

    setup_vehicle_wave_by_player_count();
}

_id_12B11( var_0, var_1 )
{
    if ( isdefined( level.disable_super_in_turret.funcs[var_0] ) )
        scripts\mp\utility\script::laststand_dogtags( "registerBrGametypeFunc already has " + var_0 + " defined." );

    level.disable_super_in_turret.funcs[var_0] = var_1;
}

_id_12E08( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    return [[ level.disable_super_in_turret.funcs[var_0] ]]( var_1, var_2, var_3, var_4, var_5, var_6 );
}

_id_12E05( var_0, var_1, var_2 )
{
    if ( isdefined( level.disable_super_in_turret.funcs[var_0] ) )
    {
        if ( isdefined( var_2 ) )
            return [[ level.disable_super_in_turret.funcs[var_0] ]]( var_1, var_2 );
        else if ( isdefined( var_1 ) )
            return [[ level.disable_super_in_turret.funcs[var_0] ]]( var_1 );
        else
            return [[ level.disable_super_in_turret.funcs[var_0] ]]();
    }
}

_id_12E06( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level.disable_super_in_turret.funcs[var_0] ) )
        return [[ level.disable_super_in_turret.funcs[var_0] ]]( var_1, var_2, var_3 );
}

_id_12E07( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( level.disable_super_in_turret.funcs[var_0] ) )
        return [[ level.disable_super_in_turret.funcs[var_0] ]]( var_1, var_2, var_3, var_4 );
}

_id_13F25( var_0 )
{
    level.disable_super_in_turret.funcs[var_0] = undefined;
}

tutorial_showtext( var_0 )
{
    return isdefined( level.disable_super_in_turret.funcs[var_0] );
}

load_sequence_3_vfx( var_0 )
{
    level.disable_super_in_turret.lmg_guys[var_0] = 1;
}

unset_relic_aggressive_melee( var_0 )
{
    return isdefined( level.disable_super_in_turret ) && istrue( level.disable_super_in_turret.lmg_guys[var_0] );
}

move_molotov_mortar( var_0 )
{
    level.disable_super_in_turret.move_ent[var_0] = 1;
}

unset_relic_aggressive_melee_params( var_0 )
{
    return isdefined( level.disable_super_in_turret ) && istrue( level.disable_super_in_turret.move_ent[var_0] );
}

_id_12B10( var_0, var_1 )
{
    level.disable_super_in_turret.data[var_0] = var_1;
}

reinforcement_manager( var_0 )
{
    return level.disable_super_in_turret.data[var_0];
}

tutorial_pullchute( var_0 )
{
    return isdefined( level.disable_super_in_turret.data[var_0] );
}
