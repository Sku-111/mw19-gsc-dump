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
    var_3.origin = ( -10081.9, -23597.7, -180.058 );
    var_3.script_index = var_0;
    var_3.initchallengeandeventglobals = var_2;
    var_3.nodes[0] = var_3;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -9726.25, -23948.6, -140.217 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -9370.61, -24299.6, -115.582 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -9008.77, -24646.1, -97.9856 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -8551.99, -24851, -96.3119 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -8061.32, -24953.1, -96.3355 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -7567.74, -25040.8, -96.3754 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -7073.18, -25118.9, -95.5667 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -6574.87, -25167.1, -94.9598 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -6075.28, -25142.6, -96.2303 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -5575.9, -25179.5, -96.5961 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( -5107.98, -25266.8, -92.1658 );
    var_3.nodes[var_4].obstacle.angles = ( 270.334, 349.432, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -5083.3, -25271.4, -93.9419 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -4592.73, -25368.7, -93.0263 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -4107.47, -25492.9, -96.6948 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -3625.41, -25630.9, -106.639 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -3145.29, -25770.4, -122.616 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -2662.49, -25902, -142.936 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -2179.98, -26033.9, -156.835 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -1696.38, -26165.5, -173.948 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -1215.85, -26302.4, -208.941 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -733.596, -26439.7, -202.773 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( -274.264, -26562.8, -222.112 );
    var_3.nodes[var_4].obstacle.angles = ( 275.074, 344.993, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( -250.148, -26569.3, -224.544 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 243.945, -26647.3, -241.049 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 742.204, -26688.2, -255.869 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 1243.28, -26702.6, -269.71 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 1743.09, -26689.5, -281.433 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 2242.65, -26666.3, -288.699 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 2737.6, -26591.5, -289.218 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 3229.07, -26498.2, -293.035 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 3695.85, -26405, -290.662 );
    var_3.nodes[var_4].obstacle.angles = ( 270.195, 11.296, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 3720.19, -26400.1, -292.97 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 4214.54, -26318.8, -292.336 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 4712.56, -26272.4, -292.35 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 5210.41, -26223.2, -292.233 );
    var_3.nodes[var_4].checkpoint = 1;
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 5702.28, -26318.2, -291.446 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 6146.36, -26549.7, -284.967 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 6504.16, -26897.9, -255.661 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 6849.98, -27259.3, -217.632 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 7195.74, -27620.6, -179.851 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 7549.07, -27938.7, -154.753 );
    var_3.nodes[var_4].obstacle.angles = ( 270.738, 318.004, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 7589.48, -27975.1, -153.722 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 7733.86, -28187.4, -152.361 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 7776.58, -28741, -153.456 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 7826.6, -29440.1, -157.915 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 8011.45, -29905.7, -157.847 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 8299.89, -30312.9, -208.703 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 8609.65, -30703, -263.84 );
    var_3.nodes[var_4].obstacle = spawnstruct();
    var_3.nodes[var_4].obstacle.origin = ( 8909.49, -31070.5, -301.95 );
    var_3.nodes[var_4].obstacle.angles = ( 276.256, 309.207, 0 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 8925.28, -31089.9, -305.694 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 9293.15, -31424, -366.35 );
    var_4 = var_3.nodes.size;
    var_3.nodes[var_4] = spawnstruct();
    var_3.nodes[var_4].origin = ( 9441.13, -31548, -392.087 );
    scripts\mp\gametypes\br_gametype_payload.gsc::_id_1318D( var_0, var_2 );
    level.disable_super_in_turret.paths[level.disable_super_in_turret.paths.size] = var_3;
}