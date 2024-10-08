// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( !getdvarint( "scr_br_gxp_phones", 1 ) )
        return;

    scripts\engine\scriptable::_id_12F5B( "gxp_telephone", ::buy_menu_closed );
    level thread toggle_safehouse_doors();
}

toggle_safehouse_doors()
{
    waittillframeend;
    scripts\mp\flags::gameflagwait( "prematch_done" );
    level.setheadicon_removeclientfrommask = [];
    level.setcodenumber = [];
    level.setdragonsbreathcorpseflare = [];
    level.setexfiltimer = [];
    level.setgun = [];
    level.disable_super_in_turret.setfaketispawnpoint = getdvarint( "scr_br_gxp_phone_max_total_spawns", 74 );
    level.disable_super_in_turret.setextrascore4 = getdvarint( "scr_br_gxp_phone_max_spawns_per_location", 3 );
    level.disable_super_in_turret.setdragonsbreathburning = getdvarint( "scr_br_gxp_phone_max_generic_location_spawns", 23 );
    level.disable_super_in_turret.setdeleteabletimer = getdvarint( "scr_br_gxp_phone_max_control_room_spawns", 12 );
    level.disable_super_in_turret.setdropbagdelay = getdvarint( "scr_br_gxp_phone_generic_vo_chance", 45 );
    level.disable_super_in_turret.setextractspawninstances = getdvarint( "scr_br_gxp_phone_location_vo_chance", 45 );
    level.disable_super_in_turret.sethasrespawntokenextrainfo = getdvarint( "scr_br_gxp_phone_operator_vo_chance", 10 );
    level.disable_super_in_turret.setincomingcallback = level.disable_super_in_turret.setdropbagdelay + level.disable_super_in_turret.setextractspawninstances + level.disable_super_in_turret.sethasrespawntokenextrainfo;
    level.disable_super_in_turret.sethistorydestination = getdvarint( "scr_br_gxp_phone_start_delay_min", 20 );
    level.disable_super_in_turret.setherodropscriptable = getdvarint( "scr_br_gxp_phone_start_delay_max", 21 );
    level.disable_super_in_turret.setgameendflagsandnotifies = getdvarint( "scr_br_gxp_phone_next_delay_min", 5 );
    level.disable_super_in_turret.setfirsthistorydestination = getdvarint( "scr_br_gxp_phone_next_delay_max", 15 );
    level.disable_super_in_turret.setheadicon_addclienttomask = getdvarint( "scr_br_gxp_phone_ring_phones_min", 10 );
    level.disable_super_in_turret.sethasselfrevivetokenextrainfo = getdvarint( "scr_br_gxp_phone_ring_phones_max", 15 );

    switch ( level.mapname )
    {
        case "mp_br_mechanics":
            tire_repair_start_air_stop_sfx();
            tire_repair_start_enter_foley_sfx();
            break;
        case "mp_don4_pm":
        case "mp_don4":
            tire_repair_start_exit_foley_sfx();
            break;
    }

    toggle_safehouse_settings();
    level thread topteam();
}

tire_repair_start_air_stop_sfx()
{

}

tire_repair_start_exit_foley_sfx()
{
    battle_tracks_playbattletrackstoalloccupants( "airport", ( -22374.9, 19917.6, -160 ), ( 0, 115, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "airport", ( -17061.8, 19968.1, -355.661 ), ( 0, 17, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "array", ( 26960.8, 20389.6, 1379.32 ), ( 0, 30, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "boneyard", ( -25173.4, -12244.5, 107.339 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "boneyard", ( -28156.3, -17991.5, -171.661 ), ( 0, 295, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "boneyard", ( -27298, -2456.58, -243.15 ), ( 0, 345, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "downtown", ( 24937.1, -14516.3, -155.991 ), ( 0, 340, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "downtown", ( 19984.7, -23085.9, -144 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "downtown", ( 15022.6, -6416.76, -410 ), ( 0, 15, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "factory", ( -4509.41, 6606.26, -155.491 ), ( 0, 160, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "farmland", ( 46111.3, -9402.01, 325.089 ), ( 0, 30, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "farmland", ( 55401, -15242.8, -371.951 ), ( 0, 55, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "farmland", ( 46442.1, -22670.5, -263.051 ), ( 0, 130, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "hospital", ( 7421.45, -8370.11, -36.0004 ), ( 0, 187, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "hospital", ( 8052.45, -9700.34, -239.901 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "hospital", ( 10335.8, -11269.7, -240.401 ), ( 0, 240, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "lumber", ( 54360.5, 4446.3, 211.214 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "lumber", ( 49128.9, 2579.8, 123.339 ), ( 0, 167, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "lumber", ( 50568.3, 91.5719, 171.214 ), ( 0, 340, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "military_base", ( 5521.67, 51545.2, 1092.36 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "military_base", ( 3255.25, 47791.2, 1321.08 ), ( 0, 10, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "military_base", ( 982.65, 45684.8, 1488 ), ( 0, 335, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "mine", ( 33229.7, 40102.1, 880.339 ), ( 0, 160, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "mine", ( 30807, 40093.7, 880.339 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "mine", ( 27322.3, 35157.4, 896.339 ), ( 0, 100, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "port", ( 29918.5, -27964.8, -518.681 ), ( 0, 260, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "port", ( 37287.1, -26747.4, -473.991 ), ( 0, 75, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "port", ( 37872.6, -15071.6, -514 ), ( 0, 330, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "stadium", ( 26464.4, 411.112, -75.4279 ), ( 0, 150, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "storage", ( -25574.9, 7085.18, -260 ), ( 0, 170, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "summit", ( -23818.5, 52700.6, 2698 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "summit", ( -26594.8, 51998.5, 2892 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "summit", ( -29124.4, 48592.4, 2559.34 ), ( 0, 40, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "superstore", ( -14476.3, 7570.5, -349.96 ), ( 0, 80, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "superstore", ( -11087.9, 7419.82, -347.428 ), ( 0, 7, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "train", ( -10431.4, -12430.3, 60.5927 ), ( 0, 40, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "train", ( -14157.8, -11729, -91.4333 ), ( 0, 180, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "tv_station", ( 15380.1, 17751.4, 187.84 ), ( 0, 10, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "tv_station", ( 11801.4, 18815.1, 208.002 ), ( 0, 215, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( -36658.9, -12385.2, -62 ), ( 0, 65, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( -15256.3, -41109.1, 604 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( -1217.01, -24365.2, -59.0882 ), ( 0, 25, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( -26463.4, 9405.66, -259.907 ), ( 0, 30, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( -22885.2, 35034.7, 256 ), ( 0, 180, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( 2152.61, 29778.3, 216.912 ), ( 0, 195, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( -7197.45, 57362.9, 1053 ), ( 0, 180, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( 29759.8, 36364, 694.412 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( 44514.4, 13862.6, -310.657 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( 52722.6, 1686.83, 25.4118 ), ( 0, 0, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( 52526.3, -17890.5, -484.907 ), ( 0, 170, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "control_room", ( -8668.4, 5080.99, -289.588 ), ( 0, 255, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 52251.4, -41466.1, 1768 ), ( 0, 200, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 24048.2, -28547.4, -351.5 ), ( 0, 100, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 9708.17, -23992.4, -186.428 ), ( 0, 190, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 1974.23, -24919.1, -213.011 ), ( 0, 275, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -3849.26, -21679.3, -192.661 ), ( 0, 290, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -12042.1, -28767.7, 48 ), ( 0, 285, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -16742.9, -21605.8, -212.757 ), ( 0, 300, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -24362.7, -28695.5, -58 ), ( 0, 255, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -4972.35, -3137.29, -241.978 ), ( 0, 10, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -11587.7, -4366.5, -125.278 ), ( 0, 295, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -19873.9, -2683.02, -271.998 ), ( 0, 200, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -35384, -7120.79, -172.661 ), ( 0, 25, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 14780.5, 5898.52, -259.067 ), ( 0, 180, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 22434.6, 10911.9, -409.951 ), ( 0, 180, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 46502.1, 19969.1, -308.278 ), ( 0, 200, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 39186.1, 15674.1, -271.978 ), ( 0, 45, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 10702.4, 12800.7, -282 ), ( 0, 90, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 5179.14, 24678.2, 62.3032 ), ( 0, 250, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -1369.85, 30080.8, -38 ), ( 0, 70, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -24187.7, 35781.3, 375 ), ( 0, 65, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -13242.5, 45519.5, 1836 ), ( 0, 100, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( -14262, 58661.4, 2200.05 ), ( 0, 50, 0 ) );
    battle_tracks_playbattletrackstoalloccupants( "generic", ( 14551.2, 36655.2, 1493.32 ), ( 0, 100, 0 ) );
}

tire_repair_start_enter_foley_sfx()
{
    battle_tracks_playerinlisteningzone( "dx_bra_gfac_red_phone_ghost_general" );
    battle_tracks_stoptogglethink( "test", "dx_bra_gfac_red_phone_airport" );
    battle_tracks_stoptogglethink( "test2", "dx_bra_gfac_red_phone_array" );
    battle_tracks_toggleonstate( "t9adler_western", "dx_bra_gfac_red_phone_adler" );
}

toggle_safehouse_settings()
{
    battle_tracks_playerinlisteningzone( "dx_bra_gfac_red_phone_ghost_general" );
    battle_tracks_stoptogglethink( "airport", "dx_bra_gfac_red_phone_airport" );
    battle_tracks_stoptogglethink( "array", "dx_bra_gfac_red_phone_array" );
    battle_tracks_stoptogglethink( "boneyard", "dx_bra_gfac_red_phone_boneyard" );
    battle_tracks_stoptogglethink( "control_room", "dx_bra_gfac_red_phone_control_room" );
    battle_tracks_stoptogglethink( "downtown", "dx_bra_gfac_red_phone_downtown" );
    battle_tracks_stoptogglethink( "factory", "dx_bra_gfac_red_phone_factory" );
    battle_tracks_stoptogglethink( "farmland", "dx_bra_gfac_red_phone_farmland" );
    battle_tracks_stoptogglethink( "hospital", "dx_bra_gfac_red_phone_hospital" );
    battle_tracks_stoptogglethink( "lumber", "dx_bra_gfac_red_phone_lumber" );
    battle_tracks_stoptogglethink( "military_base", "dx_bra_gfac_red_phone_military_base" );
    battle_tracks_stoptogglethink( "mine", "dx_bra_gfac_red_phone_mine" );
    battle_tracks_stoptogglethink( "port", "dx_bra_gfac_red_phone_port" );
    battle_tracks_stoptogglethink( "stadium", "dx_bra_gfac_red_phone_stadium" );
    battle_tracks_stoptogglethink( "storage", "dx_bra_gfac_red_phone_storage" );
    battle_tracks_stoptogglethink( "summit", "dx_bra_gfac_red_phone_summit" );
    battle_tracks_stoptogglethink( "superstore", "dx_bra_gfac_red_phone_superstore" );
    battle_tracks_stoptogglethink( "train", "dx_bra_gfac_red_phone_train" );
    battle_tracks_stoptogglethink( "tv_station", "dx_bra_gfac_red_phone_tv_station" );
    battle_tracks_toggleonstate( "t9adler_western", "dx_bra_gfac_red_phone_adler" );
    battle_tracks_toggleonstate( "alex_western", "dx_bra_gfac_red_phone_alex" );
    battle_tracks_toggleonstate( "alice_western", "dx_bra_gfac_red_phone_alice" );
    battle_tracks_toggleonstate( "t9spetsnaz_eastern", "dx_bra_gfac_red_phone_antonov" );
    battle_tracks_toggleonstate( "azur_eastern", "dx_bra_gfac_red_phone_azur" );
    battle_tracks_toggleonstate( "t9navyseal_western", "dx_bra_gfac_red_phone_baker" );
    battle_tracks_toggleonstate( "bale_eastern", "dx_bra_gfac_red_phone_bale" );
    battle_tracks_toggleonstate( "t9west_western", "dx_bra_gfac_red_phone_beck" );
    battle_tracks_toggleonstate( "t9west_western", "dx_bra_gfac_red_phone_bomber" );
    battle_tracks_toggleonstate( "t9bulldozer_western", "dx_bra_gfac_red_phone_bulldozer" );
    battle_tracks_toggleonstate( "charly_western", "dx_bra_gfac_red_phone_charly" );
    battle_tracks_toggleonstate( "t9esports_western", "dx_bra_gfac_red_phone_competitor" );
    battle_tracks_toggleonstate( "dday_western", "dx_bra_gfac_red_phone_day" );
    battle_tracks_toggleonstate( "domino_western", "dx_bra_gfac_red_phone_domino" );
    battle_tracks_toggleonstate( "farah_western", "dx_bra_gfac_red_phone_farah" );
    battle_tracks_toggleonstate( "t9cub_eastern", "dx_bra_gfac_red_phone_garcia" );
    battle_tracks_toggleonstate( "kyle_western", "dx_bra_gfac_red_phone_gaz" );
    battle_tracks_toggleonstate( "ghost_western", "dx_bra_gfac_red_phone_ghost" );
    battle_tracks_toggleonstate( "t9ghostface_western", "dx_bra_gfac_red_phone_ghostface" );
    battle_tracks_toggleonstate( "golem_western", "dx_bra_gfac_red_phone_golem" );
    battle_tracks_toggleonstate( "griggs_western", "dx_bra_gfac_red_phone_griggs" );
    battle_tracks_toggleonstate( "grinch_eastern", "dx_bra_gfac_red_phone_grinch" );
    battle_tracks_toggleonstate( "t9hudson_western", "dx_bra_gfac_red_phone_hudson" );
    battle_tracks_toggleonstate( "t9st1_western", "dx_bra_gfac_red_phone_hunter" );
    battle_tracks_toggleonstate( "iskra_eastern", "dx_bra_gfac_red_phone_iskra" );
    battle_tracks_toggleonstate( "t9kingsley_western", "dx_bra_gfac_red_phone_kingsley" );
    battle_tracks_toggleonstate( "t9kitsune_western", "dx_bra_gfac_red_phone_kitsune" );
    battle_tracks_toggleonstate( "t9sas_western", "dx_bra_gfac_red_phone_knight" );
    battle_tracks_toggleonstate( "kreuger_eastern", "dx_bra_gfac_red_phone_krueger" );
    battle_tracks_toggleonstate( "lerch_eastern", "dx_bra_gfac_red_phone_lerch" );
    battle_tracks_toggleonstate( "metalghost_eastern", "dx_bra_gfac_red_phone_mace" );
    battle_tracks_toggleonstate( "zedra_western", "dx_bra_gfac_red_phone_mara" );
    battle_tracks_toggleonstate( "t9mason_western", "dx_bra_gfac_red_phone_mason" );
    battle_tracks_toggleonstate( "t9maxis_western", "dx_bra_gfac_red_phone_maxis" );
    battle_tracks_toggleonstate( "t9mcclane_western", "dx_bra_gfac_red_phone_mcclane" );
    battle_tracks_toggleonstate( "minotavr_eastern", "dx_bra_gfac_red_phone_minotaur" );
    battle_tracks_toggleonstate( "morte_western", "dx_bra_gfac_red_phone_morte" );
    battle_tracks_toggleonstate( "t9serpent_western", "dx_bra_gfac_red_phone_naga" );
    battle_tracks_toggleonstate( "nikolai_eastern", "dx_bra_gfac_red_phone_nikolai" );
    battle_tracks_toggleonstate( "spetsnaz_eastern", "dx_bra_gfac_red_phone_nikto" );
    battle_tracks_toggleonstate( "otter_western", "dx_bra_gfac_red_phone_otter" );
    battle_tracks_toggleonstate( "t9mi6_western", "dx_bra_gfac_red_phone_park" );
    battle_tracks_toggleonstate( "t9kgb_eastern", "dx_bra_gfac_red_phone_portnova" );
    battle_tracks_toggleonstate( "t9st5_western", "dx_bra_gfac_red_phone_powers" );
    battle_tracks_toggleonstate( "price_western", "dx_bra_gfac_red_phone_price" );
    battle_tracks_toggleonstate( "raines_western", "dx_bra_gfac_red_phone_raines" );
    battle_tracks_toggleonstate( "t9rambo_western", "dx_bra_gfac_red_phone_rambo" );
    battle_tracks_toggleonstate( "t9smuggler_western", "dx_bra_gfac_red_phone_rivas" );
    battle_tracks_toggleonstate( "rodion_eastern", "dx_bra_gfac_red_phone_rodion" );
    battle_tracks_toggleonstate( "ronin_western", "dx_bra_gfac_red_phone_ronin" );
    battle_tracks_toggleonstate( "roze_eastern", "dx_bra_gfac_red_phone_roze" );
    battle_tracks_toggleonstate( "t9quicksand_western", "dx_bra_gfac_red_phone_salah" );
    battle_tracks_toggleonstate( "default_eastern", "dx_bra_gfac_red_phone_sim" );
    battle_tracks_toggleonstate( "default_western", "dx_bra_gfac_red_phone_sim" );
    battle_tracks_toggleonstate( "t9cia_western", "dx_bra_gfac_red_phone_sims" );
    battle_tracks_toggleonstate( "soap_western", "dx_bra_gfac_red_phone_soap" );
    battle_tracks_toggleonstate( "t9st4_western", "dx_bra_gfac_red_phone_song" );
    battle_tracks_toggleonstate( "sparks_western", "dx_bra_gfac_red_phone_sparks" );
    battle_tracks_toggleonstate( "t9stitch_eastern", "dx_bra_gfac_red_phone_stitch" );
    battle_tracks_toggleonstate( "t9st3_western", "dx_bra_gfac_red_phone_stone" );
    battle_tracks_toggleonstate( "t9surge_western", "dx_bra_gfac_red_phone_stryker" );
    battle_tracks_toggleonstate( "syd_eastern", "dx_bra_gfac_red_phone_syd" );
    battle_tracks_toggleonstate( "crowfoot_western", "dx_bra_gfac_red_phone_talon" );
    battle_tracks_toggleonstate( "murphy_western", "dx_bra_gfac_red_phone_thorne" );
    battle_tracks_toggleonstate( "t9st2_western", "dx_bra_gfac_red_phone_vargas" );
    battle_tracks_toggleonstate( "velikan_eastern", "dx_bra_gfac_red_phone_velikan" );
    battle_tracks_toggleonstate( "t9weaver_western", "dx_bra_gfac_red_phone_weaver" );
    battle_tracks_toggleonstate( "t9deltaforce_western", "dx_bra_gfac_red_phone_wolf" );
    battle_tracks_toggleonstate( "t9woods_western", "dx_bra_gfac_red_phone_woods" );
    battle_tracks_toggleonstate( "t9wraith_western", "dx_bra_gfac_red_phone_wraith" );
    battle_tracks_toggleonstate( "wyatt_western", "dx_bra_gfac_red_phone_wyatt" );
    battle_tracks_toggleonstate( "yegor_eastern", "dx_bra_gfac_red_phone_yegor" );
    battle_tracks_toggleonstate( "zane_eastern", "dx_bra_gfac_red_phone_zane" );
    battle_tracks_toggleonstate( "t9zeyna_western", "dx_bra_gfac_red_phone_zeyna" );
}

topteam()
{
    var_0 = level.disable_super_in_turret.setextrascore4;
    var_1 = level.disable_super_in_turret.setdragonsbreathburning;
    var_2 = level.disable_super_in_turret.setdeleteabletimer;

    if ( var_0 <= 0 && var_1 <= 0 && var_2 <= 0 )
        return;

    if ( !isdefined( level.setcodenumber ) )
        return;

    var_3 = level.disable_super_in_turret.setfaketispawnpoint;

    if ( var_3 <= 0 )
        return;

    var_4 = getarraykeys( level.setcodenumber );
    var_4 = scripts\engine\utility::array_randomize( var_4 );
    var_5 = [];
    var_6 = 0;

    for ( var_7 = 0; var_6 < var_3 && var_7 < var_4.size; var_7++ )
    {
        var_8 = var_4[var_7 % var_4.size];

        if ( var_8 == "generic" )
            var_9 = int( min( level.setcodenumber[var_8].size, var_1 ) );
        else if ( var_8 == "control_room" )
            var_9 = int( min( level.setcodenumber[var_8].size, var_2 ) );
        else
            var_9 = int( min( level.setcodenumber[var_8].size, var_0 ) );

        if ( var_9 <= 0 )
            continue;

        var_10 = randomintrange( 0, var_9 + 1 );
        var_11 = int( min( var_3 - var_6, var_9 ) );
        var_5[var_8] = var_11;
        var_6 = var_6 + var_11;
    }

    for ( var_7 = 0; var_6 < var_3 && var_7 < var_4.size; var_7++ )
    {
        var_8 = var_4[var_7 % var_4.size];

        if ( var_5[var_8] < level.setcodenumber[var_8].size )
        {
            var_11 = int( min( var_3 - var_6, level.setcodenumber[var_8].size - var_5[var_8] ) );
            var_5[var_8] = var_5[var_8] + var_11;
            var_6 = var_6 + var_11;
        }
    }

    foreach ( var_17, var_13 in var_5 )
    {
        var_14 = level.setcodenumber[var_17];

        if ( !isarray( var_14 ) )
            continue;

        var_15 = scripts\engine\utility::array_randomize( var_14 );

        if ( var_17 == "generic" )
            var_16 = var_1;
        else if ( var_17 == "control_room" )
            var_16 = var_2;
        else
            var_16 = var_0;

        for ( var_7 = 0; var_7 < var_15.size && var_7 < var_16; var_7++ )
            _id_1367C( var_15[var_7].origin, var_15[var_7].angles, var_17 );
    }

    level.setcodenumber = [];
    level thread _id_14003();
}

battle_tracks_playerinlisteningzone( var_0 )
{
    level.setdragonsbreathcorpseflare[level.setdragonsbreathcorpseflare.size] = var_0;
}

battle_tracks_stoptogglethink( var_0, var_1 )
{
    if ( !isarray( level.setexfiltimer[var_0] ) )
        level.setexfiltimer[var_0] = [];

    var_2 = level.setexfiltimer[var_0].size;
    level.setexfiltimer[var_0][var_2] = var_1;
}

battle_tracks_toggleonstate( var_0, var_1 )
{
    if ( !isarray( level.setgun[var_0] ) )
        level.setgun[var_0] = [];

    var_2 = level.setgun[var_0].size;
    level.setgun[var_0][var_2] = var_1;
}

battle_tracks_playbattletrackstoalloccupants( var_0, var_1, var_2 )
{
    if ( !isdefined( level.setcodenumber[var_0] ) )
        level.setcodenumber[var_0] = [];

    var_3 = level.setcodenumber[var_0].size;

    if ( !isdefined( var_2 ) )
        var_2 = ( 0, 0, 0 );

    var_4 = spawnstruct();
    var_4.origin = var_1;
    var_4.angles = var_2;
    level.setcodenumber[var_0][var_3] = var_4;
}

_id_1367C( var_0, var_1, var_2 )
{
    if ( !isdefined( var_1 ) )
        var_1 = ( 0, 0, 0 );

    var_3 = ( 0, 0, 48 );
    var_4 = scripts\engine\trace::ray_trace( var_0 + var_3, var_0 - var_3 );
    var_5 = easepower( "gxp_telephone", var_4["position"], var_1 );
    var_5.location = var_2;
    level.setheadicon_removeclientfrommask[level.setheadicon_removeclientfrommask.size] = var_5;
}

loadout_updateglobalclassgamemode( var_0 )
{
    foreach ( var_2 in level.setheadicon_removeclientfrommask )
        var_2 disablescriptableplayeruse( var_0 );
}

move_to_new_node( var_0 )
{
    foreach ( var_2 in level.setheadicon_removeclientfrommask )
        var_2 enablescriptableplayeruse( var_0 );
}

update_track_timer( var_0 )
{
    if ( !isdefined( level.br_circle ) || !isdefined( level.br_circle.dangercircleent ) )
        return 0;

    var_1 = scripts\mp\gametypes\br_circle.gsc::getdangercircleorigin();
    var_2 = scripts\mp\gametypes\br_circle.gsc::getdangercircleradius();
    var_3 = var_2 * var_2;

    if ( distance2dsquared( var_0, var_1 ) > var_3 )
        return 1;
    else
        return 0;
}

_id_14003()
{
    if ( level.setheadicon_removeclientfrommask.size <= 0 )
        return;

    var_0 = scripts\engine\utility::array_randomize( level.setheadicon_removeclientfrommask );
    wait( randomfloatrange( level.disable_super_in_turret.sethistorydestination, level.disable_super_in_turret.setherodropscriptable ) );

    for (;;)
    {
        var_1 = 1;

        if ( level.disable_super_in_turret.setheadicon_addclienttomask == level.disable_super_in_turret.sethasselfrevivetokenextrainfo )
            var_2 = level.disable_super_in_turret.setheadicon_addclienttomask;
        else
            var_2 = randomintrange( level.disable_super_in_turret.setheadicon_addclienttomask, level.disable_super_in_turret.sethasselfrevivetokenextrainfo );

        var_2 = min( var_2, var_0.size );
        var_3 = 0;

        foreach ( var_5 in var_0 )
        {
            var_3++;

            if ( !update_track_timer( var_5.origin ) )
            {
                var_1 = 0;
                thread _id_12D48( var_5 );
            }

            if ( var_3 >= var_2 )
            {
                wait( randomfloatrange( level.disable_super_in_turret.setgameendflagsandnotifies, level.disable_super_in_turret.setfirsthistorydestination ) );
                var_3 = 0;
            }
        }

        if ( var_1 )
            break;

        waitframe();
    }
}

loadout_updateglobalclass( var_0 )
{
    foreach ( var_2 in level.players )
    {
        if ( var_2 scripts\mp\gametypes\br_public.gsc::_id_125EC() )
            var_0 disablescriptableplayeruse( var_2 );
    }
}

_id_12D48( var_0 )
{
    var_0 setscriptablepartstate( "gxp_telephone", "ring" );
    loadout_updateglobalclass( var_0 );
    _id_12D44( var_0 );
}

_id_12D44( var_0 )
{
    var_0 endon( "answer" );
    wait 30;
    var_0 setscriptablepartstate( "gxp_telephone", "off" );
}

buy_menu_closed( var_0, var_1, var_2, var_3, var_4 )
{
    scripts\mp\gametypes\br_gametype_gxp_challenges.gsc::_id_11FD2( var_3 );
    thread add_ai_rider_to_decho( var_0, var_1, var_2, var_3 );
}

add_ai_rider_to_decho( var_0, var_1, var_2, var_3, var_4 )
{
    var_0 notify( "answer" );
    var_0 setscriptablepartstate( "gxp_telephone", "answer" );
    var_5 = "dx_brm_rugn_military_good_10";
    wait 2;
    var_6 = _id_12779( var_0.location, var_3 );
    wait( 1 + var_6 );
    var_0 setscriptablepartstate( "gxp_telephone", "hangup" );
}

_id_12779( var_0, var_1 )
{
    var_2 = 0;
    var_3 = undefined;
    var_4 = randomintrange( 0, level.disable_super_in_turret.setincomingcallback );

    if ( var_4 < level.disable_super_in_turret.sethasrespawntokenextrainfo )
    {
        var_5 = var_1 scripts\mp\teams::lookupcurrentoperator( var_1.team );
        var_6 = level.setgun[var_5];

        if ( isarray( var_6 ) && var_6.size > 0 )
            var_3 = var_6[randomintrange( 0, var_6.size )];
    }
    else if ( var_4 < level.disable_super_in_turret.sethasrespawntokenextrainfo + level.disable_super_in_turret.setextractspawninstances || level.setdragonsbreathcorpseflare.size <= 0 )
    {
        var_7 = level.setexfiltimer[var_0];

        if ( isarray( var_7 ) && var_7.size > 0 )
            var_3 = var_7[randomintrange( 0, var_7.size )];
    }

    if ( !isdefined( var_3 ) )
    {
        if ( level.setdragonsbreathcorpseflare.size > 0 )
            var_3 = level.setdragonsbreathcorpseflare[randomintrange( 0, level.setdragonsbreathcorpseflare.size )];
    }

    if ( isdefined( var_3 ) )
    {
        var_1 playsoundtoplayer( var_3, var_1 );
        var_2 = lookupsoundlength( var_3 ) / 1000;
    }

    return var_2;
}