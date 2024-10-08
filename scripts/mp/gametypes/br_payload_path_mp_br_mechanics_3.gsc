// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

toggle_farah_lights( var_0, var_1, var_2 )
{
    if ( level.mapname != "mp_br_mechanics" )
        return;

    if ( level.disable_super_in_turret._id_1226A != var_1 && !isdefined( level.disable_super_in_turret._id_121FD ) )
        return;

    if ( !isdefined( level.disable_super_in_turret.paths ) )
        level.disable_super_in_turret.paths = [];

    var_3 = spawnstruct();
    var_3.nodes = [];
    var_3.origin = ( 1230.03, -2493.29, -2.32313 );
    var_3.script_index = var_0;
    var_3.initchallengeandeventglobals = var_2;
    var_3.nodes[0] = var_3;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 1420.3, -2329.11, -2.28926 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 1880.23, -2130.14, -2.3435 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 2381.53, -2139.1, -2.36388 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 2477.3, -2159.69, -2.34202 );
    scripts\mp\gametypes\br_gametype_payload.gsc::_id_1318D( var_0, var_2 );
    level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}