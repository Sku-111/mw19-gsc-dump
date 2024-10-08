// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

toggle_farah_lights( var_0, var_1, var_2 )
{
    if ( level.mapname != "mp_don4" )
        return;

    if ( level.disable_super_in_turret._id_1226A != var_1 && !isdefined( level.disable_super_in_turret._id_121FD ) )
        return;

    if ( !isdefined( level.disable_super_in_turret.paths ) )
        level.disable_super_in_turret.paths = [];

    var_3 = spawnstruct();
    var_3.nodes = [];
    var_3.origin = ( 41533, -10007.8, 208.177 );
    var_3.script_index = var_0;
    var_3.initchallengeandeventglobals = var_2;
    var_3.nodes[0] = var_3;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41398.1, -10492.5, 181.153 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41271.5, -10978, 139.523 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41232, -11476.9, 108.941 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41271.5, -11980.2, 104.504 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41333.4, -12475.9, 63.514 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41431.4, -12965.7, 7.3724 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41564.9, -13445.9, -53.2172 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41774.4, -13900.1, -115.402 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42023, -14333.1, -179.529 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42335, -14723.3, -244.435 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 42587.6, -15017.3, -294.734 );
    var_3.nodes[var_4].obstacle.angles = ( 367.447, 310.665, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42660.5, -15102.2, -310.114 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43004.1, -15464.9, -375.539 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43336.9, -15837.3, -439.397 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43609, -16256.1, -476.194 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43791, -16723.4, -490.986 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43893, -17215.6, -506.975 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43858.4, -17716, -532.525 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43757.4, -18208.6, -552.415 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43712.7, -18709.6, -556.459 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43655.5, -19211.3, -552.743 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 43390, -19634.9, -563.584 );
    var_3.nodes[var_4].obstacle.angles = ( 361.285, 237.913, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43389.6, -19635.4, -565.122 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 43053.7, -20011.4, -570.72 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42695.2, -20364.7, -570.591 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 42320.9, -20702.5, -569.873 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41943.1, -21030.5, -569.238 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41572.5, -21372.5, -568.556 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 41184.9, -21688.4, -565.401 );
    var_3.nodes[var_4].obstacle.angles = ( 360.095, 219.192, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 41184.2, -21689.1, -567.755 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 40822.8, -22035, -566.796 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 40446.3, -22368.8, -565.993 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 40251.5, -22532.2, -563.013 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 40064.7, -22694.4, -562.334 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 39698.9, -23037, -561.513 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 39335.4, -23382.6, -566.021 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 38983.5, -23743, -566.537 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 38620.8, -24091.8, -567.051 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 38253.7, -24437.1, -566.148 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37911.9, -24807.8, -567.433 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 37556.5, -25159.6, -565.219 );
    var_3.nodes[var_4].obstacle.angles = ( 360.009, 224.711, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37553.6, -25162.5, -567.503 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 37188.5, -25510, -567.548 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 36822.4, -25853.2, -567.706 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 36453, -26197, -567.787 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 36080.5, -26533.9, -567.859 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 35707.1, -26867, -567.787 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 35334, -27199.8, -565.627 );
    var_3.nodes[var_4].obstacle.angles = ( 360, 221.731, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 35330.5, -27202.9, -567.987 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 34959.7, -27539.9, -567.971 );
    scripts\mp\gametypes\br_gametype_payload.gsc::_id_1318D( var_0, var_2 );
    level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}