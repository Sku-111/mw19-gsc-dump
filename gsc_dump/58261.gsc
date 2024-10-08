// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

vehicle_damage_loadtable()
{
    if ( isdefined( level.brendingoverrideinfo ) )
        return 0;

    if ( level.script == "mp_wz_island" && scripts\mp\utility\game::round_vehicle_logic() == "olaride" )
        return 0;

    if ( level.script == "mp_wz_island" )
        return 1;

    return 0;
}

#using_animtree("script_model");

vehicle_damage_getpristinestateminhealth( var_0 )
{
    if ( !getdvarint( "scr_br_ending_placement" ) )
    {
        self._id_13CE3 = puddle_triggers();
        unloadinfiltransient( self._id_13CE3 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        var_1 = getdvarfloat( "scr_br_end_transient_wait", 7.0 );
        var_2 = 1.71429;
        level thread vehicle_damage_getpristinestatehealthadd( var_1 - var_2 );
        wait( var_1 );
    }

    vehicle_damage_getinstancedataforvehicle();
    var_3 = scripts\mp\gametypes\br_ending.gsc::_id_135CA( "lm_egy_aec_matador_01_exfil" );
    self.onpickupitem = var_3;
    vehicle_damage_getstate();
    var_4 = [ "head_mp_helicopter_crew", "j_spine4" ];
    var_5 = [ var_4 ];
    var_6 = "body_pilot_helicopter_british";
    var_7 = scripts\mp\gametypes\br_ending.gsc::_id_135CA( var_6, undefined, var_5 );
    self.max_ammo_check = var_7;
    var_8 = [ "head_mp_aus_s4_lucas_02_1a_exfil", "j_spine4" ];
    var_9 = [ var_8 ];
    var_10 = "body_mp_aus_s4_lucas_01_inctv";
    var_11 = scripts\mp\gametypes\br_ending.gsc::_id_135CA( var_10, undefined, var_9 );
    self.driver = var_11;
    var_12 = scripts\mp\gametypes\br_ending.gsc::_id_135CA( "tag_origin" );
    self.playerzombieisingas = var_12;
    self.winners = scripts\engine\utility::array_removeundefined( self.winners );

    if ( self.winners.size == 0 )
        scripts\mp\gametypes\br_ending.gsc::init_death_animations( self );

    self.gameending = scripts\mp\gametypes\br_ending.gsc::init_carepackages();
    self._id_142D0 = "mp_wz_island_exfil";

    if ( scripts\mp\utility\game::round_vehicle_logic() == "mendota" )
        self._id_142D0 = "mp_wz_island_exfil_mendota";

    level._effect["vfx_exfil2_light_orangefixture_01"] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_orangefixture_01" );
    level._effect["vfx_exfil2_light_orangefixture_02"] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_orangefixture_02" );
    level._effect["vfx_exfil2_light_windowlights"] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_windowlights" );
    level._effect["vfx_exfil2_light_dashboardlight"] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_light_dashboardlight" );

    if ( getdvarint( "scr_br_ending_6_lighting", 0 ) == 1 )
    {
        var_13 = getent( "exfil", "targetname" );
        var_13 linkto( self.onpickupitem, "tag_origin", ( 5, 1, 78.5 ), ( 0, 0, 0 ) );
    }

    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback( ::allassassin_teams );
    thread scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "exfilStart", self.winners );
    self._id_121B8 = [];
    var_14 = 0;

    if ( getdvarint( "scr_br_ending_6_binks", 1 ) == 1 )
    {
        self._id_121B8[var_14] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene1" );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_dummycamera_sh010 );
        var_14++;
    }

    self._id_121B8[var_14] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene2" );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_givescore );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_3, %wz_ch3_exfil_truck_sh010 );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_7, %wz_ch3_exfil_doorchief_sh010 );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_11, %wz_ch3_exfil_driver_sh010 );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[0], %wz_ch3_exfil_guy_01_sh010, %wz_ch3_exfil_guy_01_sh010 );

    if ( self.winners.size >= 4 )
    {
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[1], %wz_ch3_exfil_guy_02_sh010, %wz_ch3_exfil_guy_02_sh010 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[2], %wz_ch3_exfil_guy_03_sh010, %wz_ch3_exfil_guy_03_sh010 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[3], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010 );
    }
    else if ( self.winners.size >= 3 )
    {
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[1], %wz_ch3_exfil_guy_02_sh010, %wz_ch3_exfil_guy_02_sh010 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[2], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010 );
    }
    else if ( self.winners.size >= 2 )
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[1], %wz_ch3_exfil_guy_04_sh010, %wz_ch3_exfil_guy_04_sh010 );

    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh010_ext );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_field_clip( "jeepExfil_gas_wall", self.origin, self.angles );
    self._id_121B8[var_14].fxtag = "tag_origin";
    self._id_121B8[var_14].playerzombiejumpcleanup = self.playerzombieisingas;
    var_14++;
    self._id_121B8[var_14] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene3" );

    if ( self.winners.size >= 2 )
    {
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_givescoreandxp );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh011_ext );
    }
    else
    {
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_givescoreandxpatframeend );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh013_solo_ext );
    }

    var_14++;
    self._id_121B8[var_14] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene4" );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_heavyvisualcallback );
    self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_sh012_ext );
    var_14++;
    var_15 = 1;

    if ( self.winners.size >= 2 )
    {
        self._id_121B8[var_14] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene5" );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_inithitdamage );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_3, %wz_ch3_exfil_truck_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_7, %wz_ch3_exfil_doorchief_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_11, %wz_ch3_exfil_driver_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[0], %wz_ch3_exfil_guy_01_sh020, %wz_ch3_exfil_guy_01_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[1], %wz_ch3_exfil_guy_02_sh020, %wz_ch3_exfil_guy_02_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p2_sh020_int );
        var_15 = 2;
    }

    if ( self.winners.size >= 3 )
    {
        self._id_121B8[var_14 + 1] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene6" );
        self._id_121B8[var_14 + 1] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_inithitdamage_br );
        self._id_121B8[var_14 + 1] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p3_sh021_int );
        var_15 = 3;
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[2], %wz_ch3_exfil_guy_03_sh020, %wz_ch3_exfil_guy_03_sh020 );
    }

    if ( self.winners.size >= 4 )
    {
        self._id_121B8[var_14 + 2] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene7" );
        self._id_121B8[var_14 + 2] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_initmoddamage );
        self._id_121B8[var_14 + 2] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p4_sh022_int );
        var_15 = 4;
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[3], %wz_ch3_exfil_guy_04_sh020, %wz_ch3_exfil_guy_04_sh020 );
    }

    if ( var_15 > 1 )
    {
        self._id_121B8[var_14 + var_15 - 1] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene8" );
        self._id_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_isburningdown );
        self._id_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[0], %wz_ch3_exfil_guy_01_sh021, %wz_ch3_exfil_guy_01_sh021 );
        self._id_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[1], %wz_ch3_exfil_guy_02_sh021, %wz_ch3_exfil_guy_02_sh021 );
        self._id_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[2], %wz_ch3_exfil_guy_03_sh021, %wz_ch3_exfil_guy_03_sh021 );
        self._id_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[3], %wz_ch3_exfil_guy_04_sh021, %wz_ch3_exfil_guy_04_sh021 );
        self._id_121B8[var_14 + var_15 - 1] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p1_sh023_mvp_int );
    }
    else
    {
        self._id_121B8[var_14] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene9" );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::backendevent( self, ::vehicle_damage_lightvisualcallback );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_3, %wz_ch3_exfil_truck_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_7, %wz_ch3_exfil_doorchief_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_struct( var_11, %wz_ch3_exfil_driver_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::back_vector( self.winners[0], %wz_ch3_exfil_guy_01_sh020, %wz_ch3_exfil_guy_01_sh020 );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_mastercamera_p1_sh024_solo_int );
    }

    var_14 = var_14 + var_15;

    if ( getdvarint( "scr_br_ending_6_binks", 1 ) == 1 )
    {
        self._id_121B8[var_14] = scripts\mp\gametypes\br_ending.gsc::init_bomb_objective( "scene10" );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::backendevent( [], ::vehicle_damage_getmaxhealth );
        self._id_121B8[var_14] scripts\mp\gametypes\br_ending.gsc::awardstadiumblueprint( %wz_ch3_exfil_dummycamera_sh020 );
        self._id_121B8[var_14].clip_mover = 1;
    }
}

puddle_triggers()
{
    switch ( level.script )
    {
        case "mp_donetsk2":
        case "mp_donetsk":
        case "mp_kstenod":
        case "mp_don3":
        case "mp_don4":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_br_quarry":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_br_mechanics":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_wz_island":
            return "mp_infil_wz_island_ending_truck_tr";
        case "mp_br_tut2":
            return "mp_infil_wz_island_ending_truck_tr";
    }

    return undefined;
}

vehicle_damage_getmediumstatehealthratio( var_0, var_1 )
{
    var_2 = self.origin + ( 0, 0, 1000 );
    var_3 = vectornormalize( var_2 - var_1 );
    var_4 = var_2 + var_3 * 3000;
    var_5 = spawn( "script_model", var_4 );
    var_5 moveto( var_2, var_0 );
    wait( var_0 );
    var_5 delete();
}

vehicle_damage_getpristinestatehealthadd( var_0 )
{
    if ( level.defendkill.winners.size == 0 )
        return;

    if ( isnumber( var_0 ) && var_0 > 0.0 )
        wait( var_0 );

    var_1 = "br3_exfil_intro_3player";

    switch ( level.defendkill.winners.size )
    {
        case 1:
            var_1 = "br3_exfil_intro_1player";
            break;
        case 2:
            var_1 = "br3_exfil_intro_2player";
            break;
        case 3:
            var_1 = "br3_exfil_intro_3player";
            break;
        case 4:
            var_1 = "br3_exfil_intro_4player";
            break;
    }

    setmusicstate( var_1 );

    foreach ( var_3 in level.players )
        var_3 setsoundsubmix( "mp_br_exfil_fade", 4 );
}

vehicle_damage_getinstancedataforvehicle( var_0 )
{
    if ( !scripts\mp\gametypes\br_public.gsc::turret_headicon() )
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );

    var_1 = "br_exfil_ch3_jeep_intro_lr";
    var_2 = scripts\mp\utility\game::round_vehicle_logic() == "mendota";

    if ( var_2 )
        var_1 = "br_exfil_ch3_mxp_jeep_intro_lr";

    foreach ( var_4 in level.players )
        var_4 playlocalsound( var_1 );

    if ( var_2 )
        allassassin_update( "mendota_exfil_intro", 4.33, 1, 0, 1 );
    else
        allassassin_update( "mp_wz_ch3_exfil_intro", 4.33, 1, 0 );
}

vehicle_damage_getmaxhealth( var_0 )
{
    var_1 = "br_exfil_ch3_jeep_outro_lr";
    var_2 = scripts\mp\utility\game::round_vehicle_logic() == "mendota";

    if ( var_2 )
        var_1 = "br_exfil_ch3_mxp_jeep_outro_lr";

    foreach ( var_4 in level.players )
        var_4 playlocalsound( var_1 );

    if ( var_2 )
        allassassin_update( "mendota_exfil_outro", 7.37, 0, 1, 1 );
    else
        allassassin_update( "mp_wz_ch3_exfil_outro", 7.37, 0, 1 );
}

allassassin_update( var_0, var_1, var_2, var_3, var_4 )
{
    foreach ( var_6 in level.players )
    {
        if ( istrue( var_3 ) )
            var_6 setclientomnvar( "ui_world_fade", 1 );

        var_6 setclientomnvar( "ui_br_bink_overlay_state", 10 );
    }

    playcinematicforall( var_0, 1, istrue( var_4 ) );
    wait 0.1;

    if ( istrue( var_3 ) )
    {
        allies_push_up();
        allassassin_timeout_end( var_1 );
    }
}

allassassin_timeout_end( var_0, var_1 )
{
    if ( istrue( var_1 ) )
    {
        foreach ( var_3 in level.players )
            var_3 scripts\mp\gametypes\br_public.gsc::_id_1252B();
    }

    wait( var_0 );
    stopcinematicforall( 1 );

    if ( getdvarint( "scr_br_bink_overlay_log", 0 ) == 1 )
        logstring( "bnk__jeepExfil_bink_play_end()" );

    foreach ( var_3 in level.players )
    {
        if ( getdvarint( "scr_br_bink_overlay_log", 0 ) == 1 )
            logstring( "bnk_Player " + var_3.name + " ui_br_bink_overlay_state : " + var_3 calloutmarkerping_entityzoffset( "ui_br_bink_overlay_state", 0 ) );

        var_3 setclientomnvar( "ui_br_bink_overlay_state", 0 );
    }
}

allassassin_teams( var_0, var_1 )
{
    if ( var_0 == "bink_complete" )
        level notify( "bink_complete" );
}

allies_respawns( var_0, var_1 )
{
    wait( var_0 );
    setomnvarforallclients( "ui_br_bink_overlay_state", 0 );
    waitframe();
    preloadcinematicforall( var_1, 1, 0 );
}

allies_push_up()
{
    foreach ( var_1 in level.players )
        var_1 playerhide();

    if ( isdefined( level.defendkill.playerzombieisingas ) )
    {
        stopfxontag( scripts\engine\utility::getfx( "jeepExfil_gas_wall" ), level.defendkill.playerzombieisingas, "tag_origin" );
        level.defendkill.playerzombieisingas delete();
    }

    allfobtriggers();

    if ( isdefined( level.defendkill.onpickupitem ) )
        level.defendkill.onpickupitem delete();

    if ( isdefined( level.defendkill.max_ammo_check ) )
        level.defendkill.max_ammo_check delete();

    if ( isdefined( level.defendkill.driver ) )
        level.defendkill.driver delete();
}

allassassin_update_timed( var_0, var_1, var_2, var_3 )
{
    var_1 endon( var_2 + "_end" );

    for (;;)
    {
        playfxontag( var_0, var_1, var_2 );
        wait( var_3 );
    }
}

allassassin_updatewait( var_0, var_1 )
{
    var_0 notify( var_1 + "_end" );
}

allassassin_updatecircle()
{
    thread allassassin_update_timed( level._effect["vfx_exfil2_light_orangefixture_01"], level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_FRONT_FX", 0.5 );
    thread allassassin_update_timed( level._effect["vfx_exfil2_light_orangefixture_02"], level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_BACK_FX", 0.5 );
    thread allassassin_update_timed( level._effect["vfx_exfil2_light_windowlights"], level.defendkill.onpickupitem, "TAG_WINDOW_LEFT_FRONT_FX", 0.5 );
}

allfobtriggers()
{
    allassassin_updatewait( level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_FRONT_FX" );
    allassassin_updatewait( level.defendkill.onpickupitem, "TAG_CEILING_LIGHT_BACK_FX" );
    allassassin_updatewait( level.defendkill.onpickupitem, "TAG_WINDOW_LEFT_FRONT_FX" );
}

vehicle_damage_givescore( var_0 )
{
    if ( !scripts\mp\gametypes\br_public.gsc::turret_headicon() )
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );

    thread vehicle_damage_giveaward();
    thread allassassin_timeout_end( 0.15, 1 );
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 40 );
}

vehicle_damage_giveaward()
{
    if ( level.defendkill.winners.size == 0 )
        return;

    var_0 = "br_exfil_ch3_jeep_3person_lr";

    switch ( level.defendkill.winners.size )
    {
        case 1:
            var_0 = "br_exfil_ch3_jeep_1person_lr";
            break;
        case 2:
            var_0 = "br_exfil_ch3_jeep_2person_lr";
            break;
        case 3:
            var_0 = "br_exfil_ch3_jeep_3person_lr";
            break;
        case 4:
            var_0 = "br_exfil_ch3_jeep_4person_lr";
            break;
    }

    foreach ( var_2 in level.players )
        var_2 playlocalsound( var_0 );
}

vehicle_damage_givescoreandxp( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 55 );
    allassassin_updatecircle();
}

vehicle_damage_givescoreandxpatframeend( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 60 );
    allassassin_updatecircle();
}

vehicle_damage_heavyvisualcallback( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 50 );
}

vehicle_damage_inithitdamage( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 55 );
    scripts\mp\gametypes\br_ending.gsc::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
}

vehicle_damage_inithitdamage_br( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 50 );
    scripts\mp\gametypes\br_ending.gsc::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
}

vehicle_damage_initmoddamage( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 55 );
    scripts\mp\gametypes\br_ending.gsc::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
}

vehicle_damage_isburningdown( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 60 );
    scripts\mp\gametypes\br_ending.gsc::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
}

vehicle_damage_lightvisualcallback( var_0 )
{
    scripts\mp\gametypes\br_ending.gsc::brking_onplayerkilled( 65 );
    scripts\mp\gametypes\br_ending.gsc::brking_ontimelimit( 5, 20 );
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
}

vehicle_damage_loadtablecell( var_0 )
{

}

vehicle_damage_mediumvisualcallback( var_0 )
{

}

vehicle_damage_getstate()
{
    if ( !isdefined( level.br_circle ) )
        return;

    if ( !isdefined( level.br_circle.dangercircleent ) )
        return;

    level.br_circle.dangercircleent brcirclemoveto( self.origin[0], self.origin[1], 9000, 0.05 );
}

vehicle_damage_mp_init()
{
    level._effect["jeepExfil_rotorwash"] = loadfx( "vfx/iw8_br/gameplay/vfx_br_blima_rotor_infil.vfx" );
    level._effect["player_disconnect"] = loadfx( "vfx/iw8_br/gameplay/vfx_br_disconnect_player.vfx" );
    level._effect["jeepExfil_gas_wall"] = loadfx( "vfx/iw8_br/gameplay/exfil2/vfx_exfil2_gas_wall.vfx" );
}