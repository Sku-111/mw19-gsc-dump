// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( !getdvarint( "scr_br_numbers_tower_enabled", 0 ) )
        return;

    scripts\engine\scriptable::scriptable_addpostinitcallback( ::scriptable_postinit );
    scripts\engine\scriptable::_id_12F5B( "numbers_tower_model", ::_id_11F32 );
    level._id_11F35 = spawnstruct();
    level._id_11F35.eliminate_drone = getdvarint( "scr_br_numbers_tower_broken", 0 );
    level._id_11F35.usable = 0;
    level._id_11F35.localangles = getdvarint( "scr_br_numbers_tower_disable_vo_sequence", 0 );
    level._id_11F35._id_1277B = getdvarint( "scr_br_numbers_tower_play_vo_sequence_once", 0 );

    if ( !level._id_11F35.eliminate_drone )
        level._id_11F35.usable = getdvarint( "scr_br_numbers_tower_usable", 0 );

    level._id_11F35._id_13C1A = [];
    level._id_11F35._id_13C19 = [];

    if ( level._id_11F35.usable )
    {
        level._id_1442D = ::maxaccesscardspawns_red;
        level._effect["numbers_tower_normal"] = loadfx( "vfx/iw8_br/gameplay/vfx_numbers_normal" );
        level._effect["numbers_tower_intense"] = loadfx( "vfx/iw8_br/gameplay/vfx_numbers_intense" );
        switch_disabled();
    }

    level thread _id_11FF3();
    level thread delay_suspend_vehicle_convoy();
}

scriptable_postinit()
{
    _id_135E7();
}

_id_11FF3()
{
    level waittill( "prematch_done" );
    scripts\mp\flags::gameflagwait( "prematch_fade_done" );

    if ( level._id_11F35.usable )
    {
        targetvehicle();
        level thread _id_14440();
        level thread _id_129F1();
    }
}

put_players_out_of_black_screen()
{
    switch ( level.mapname )
    {
        case "mp_br_mechanics":
            return ::_id_131FB;
        case "mp_don4_pm":
        case "mp_don4":
            return ::_id_131FC;
    }

    return undefined;
}

barrel_think( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4.origin = var_0;
    var_4.angles = var_1;
    var_4._id_1386F = var_3;
    var_5 = level._id_11F35._id_13C1A.size;
    var_4.id = level._id_11F35._id_13C1A.size;
    var_4.getaltbunkerkeypadindexforscriptable = var_2;
    level._id_11F35._id_13C1A[var_5] = var_4;
}

_id_131FB()
{
    barrel_think( ( 5518, 140, 0 ), ( 0, 130, 0 ), "test_0" );
    barrel_think( ( 6182, 296, 0 ), ( 0, 180, 0 ), "test_1" );
    barrel_think( ( 5806, 830, 0 ), ( 0, 210, 0 ), undefined, 1 );
}

_id_131FC()
{
    barrel_think( ( 11772, 28752, 1088 ), ( 0, 330, 0 ), undefined, 1 );
    barrel_think( ( -9860, -36372, 244 ), ( 0, 0, 0 ), "t9_ch_common_season_55_wz_event_hills" );
    barrel_think( ( -15928, 32440, -236 ), ( 0, 350, 0 ), "t9_ch_common_season_55_wz_event_airport" );
    barrel_think( ( 352, 53544, 984 ), ( 0, 195, 0 ), "t9_ch_common_season_55_wz_event_military_base" );
    barrel_think( ( 9212, 11036, -344 ), ( 0, 315, 0 ), "t9_ch_common_season_55_wz_event_tv_station" );
    barrel_think( ( -22856, -408, -344 ), ( 0, 25, 0 ), "t9_ch_common_season_55_wz_event_boneyard_supers" );
    barrel_think( ( 42708, 33764, -148 ), ( 0, 75, 0 ), "t9_ch_common_season_55_wz_event_salt_mine" );
    barrel_think( ( 48704, -10908, 40 ), ( 0, 305, 0 ), "t9_ch_common_season_55_wz_event_farmland" );
    barrel_think( ( 34752, -31764, -532 ), ( 0, 320, 0 ), "t9_ch_common_season_55_wz_event_port" );
    barrel_think( ( -22416, -16012, -288 ), ( 0, 0, 0 ), "t9_ch_common_season_55_wz_event_train_station" );
}

_id_135E7()
{
    var_0 = put_players_out_of_black_screen();

    if ( isdefined( var_0 ) )
        level thread [[ var_0 ]]();

    foreach ( var_2 in level._id_11F35._id_13C1A )
    {
        var_3 = var_2.origin;
        var_4 = var_2.angles;
        var_5 = _id_135E6( var_3, var_4 );
        var_5.id = var_2.id;
        var_5.getaltbunkerkeypadindexforscriptable = var_2.getaltbunkerkeypadindexforscriptable;
        var_5._id_1386F = var_2._id_1386F;

        if ( level._id_11F35.eliminate_drone )
            var_5 setscriptablepartstate( "numbers_tower_model", "broken" );
        else if ( istrue( var_5._id_1386F ) )
            var_5 setscriptablepartstate( "numbers_tower_model", "raised" );

        level._id_11F35._id_13C19[level._id_11F35._id_13C19.size] = var_5;
    }
}

_id_135E6( var_0, var_1 )
{
    var_2 = spawn( "script_model", var_0 );
    var_2.angles = var_1;
    var_2 setmodel( "communication_antenna_mobile_rig" );
    return var_2 getlinkedscriptableinstance();
}

targetvehicle()
{
    foreach ( var_1 in level._id_11F35._id_13C19 )
    {
        if ( tu0bakechanges( var_1 ) )
        {
            _id_11A97( var_1 );
            battle_station_combat_logic( var_1 );
        }
    }
}

battle_station_combat_logic( var_0 )
{
    var_1 = scripts\mp\objidpoolmanager::requestobjectiveid( 99 );
    var_0.objid = var_1;
    var_2 = var_0.origin + rotatevector( ( -88, 60, 85 ), var_0.angles );
    scripts\mp\objidpoolmanager::objective_add_objective( var_1, "current", var_2 );
    getbnetigrbattlepassxpmultiplier( var_1, 4500, 5000 );
    objective_setshowoncompass( var_1, 0 );
    objective_setbackground( var_1, 1 );
    objective_icon( var_1, "ui_mp_br_mapmenu_legend_mobile_broadcast" );
    _func_421( var_1, 1 );
}

_id_130F8( var_0 )
{
    if ( !isdefined( var_0.objid ) )
        return;

    objective_state( var_0.objid, "active" );
    objective_icon( var_0.objid, "ui_mp_br_mapmenu_legend_broadcast_signal" );
}

last_grenade_fire_time( var_0 )
{
    if ( !isdefined( var_0.objid ) )
        return;

    scripts\mp\objidpoolmanager::returnobjectiveid( var_0.objid );
    var_0.objid = undefined;
}

_id_11A97( var_0 )
{
    var_0 setscriptablepartstate( "numbers_tower_model", "usable" );
}

_id_11F32( var_0, var_1, var_2, var_3, var_4 )
{
    level thread _id_11FF7( var_0, var_3 );
}

_id_11FF7( var_0, var_1 )
{
    var_0 endon( "death" );
    var_2 = var_1.team;
    _id_12C3C( var_2, var_0, var_1 );
    minigun_sweep_to_loc( var_0, var_1 );
    _id_130F8( var_0 );
    _id_129EF( var_0 );
    level thread _id_12430( var_2, var_0 );
}

minigun_sweep_to_loc( var_0, var_1 )
{
    var_2 = 50;

    if ( getdvar( "scr_br_gametype" ) == "dbd" )
        var_2 = getdvarint( "scr_brdbd_towercashoverride", 25 );

    var_1 scripts\mp\gametypes\br_plunder.gsc::_id_12627( var_2 );
}

_id_129EF( var_0 )
{
    var_0 endon( "death" );
    var_0 setscriptablepartstate( "numbers_tower_model", "raising" );

    while ( var_0 getscriptablepartstate( "numbers_tower_model" ) != "raised" )
        waitframe();
}

tu0bakechanges( var_0 )
{
    return var_0 getscriptablepartstate( "numbers_tower_model" ) == "disabled";
}

tugofwar_hvt_placed( var_0 )
{
    return var_0 getscriptablepartstate( "numbers_tower_model" ) == "raised";
}

tugofwar_hvt_taken_firsttime( var_0 )
{
    return var_0 getscriptablepartstate( "numbers_tower_model" ) == "usable";
}

dangercircletick( var_0, var_1 )
{
    if ( !isdefined( level._id_11F35 ) || !istrue( level._id_11F35.usable ) )
        return;

    var_2 = 25000000;

    foreach ( var_4 in level._id_11F35._id_13C19 )
    {
        if ( !isdefined( var_4.objid ) )
            continue;

        var_5 = 5000 + var_1;
        var_6 = distance2dsquared( var_4.origin, var_0 );

        if ( var_6 > var_5 * var_5 )
            last_grenade_fire_time( var_4 );
    }
}

_id_12430( var_0, var_1 )
{
    var_2 = scripts\mp\utility\teams::getfriendlyplayers( var_0 );

    foreach ( var_4 in var_2 )
    {
        if ( isdefined( var_4 ) && !var_4 scripts\mp\gametypes\br_public.gsc::updateinstantclassswapallowedinternal() && var_4 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            level thread _id_1242F( var_4 );
            waitframe();
        }
    }
}

_id_1242F( var_0 )
{
    playfxontagforclients( level._effect["numbers_tower_normal"], var_0, "tag_origin", var_0 );
    level thread _id_12405( var_0 );
}

_id_123CF( var_0 )
{
    playfxontagforclients( level._effect["numbers_tower_intense"], var_0, "tag_origin", var_0 );
    level thread _id_12405( var_0 );
}

_id_123D1( var_0 )
{
    playfxontagforclients( level._effect["numbers_tower_intense"], var_0, "tag_origin", var_0 );
    _id_123D2( var_0 );
}

_id_12405( var_0 )
{
    var_0 endon( "death" );
    var_0 endon( "disconnect" );

    if ( _id_11F31( var_0 ) )
        return;

    level thread handlepersistentgungame( var_0 );
    _id_137E1( var_0 );
    _id_12406( var_0 );
    _id_138BE( var_0 );
    var_0 notify( "numbers_audio_end" );
}

_id_137E1( var_0 )
{
    var_0._id_11F33 = 1;
    var_0 playloopsound( "br_numbers_sfx_lp" );
    var_0 playlocalsound( "br_numbers_stinger" );
}

_id_138BE( var_0 )
{
    var_0 playlocalsound( "br_numbers_stinger" );
    wait 0.5;
    var_0 stoploopsound();
    var_0._id_11F33 = undefined;
}

_id_12406( var_0 )
{
    if ( istrue( level._id_11F35.localangles ) )
        return;

    if ( istrue( level._id_11F35._id_1277B ) && istrue( var_0._id_11F37 ) )
        return;

    var_0._id_11F37 = 1;
    wait 0.75;

    for ( var_1 = 0; var_1 < level._id_11F35.checked_missiles.size; var_1++ )
    {
        var_0 playlocalsound( level._id_11F35.checked_missiles[var_1] );
        wait 2.5;
    }
}

handlepersistentgungame( var_0 )
{
    var_0 endon( "disconnect" );
    var_0 endon( "numbers_audio_end" );
    var_0 waittill( "death" );

    if ( !isdefined( var_0 ) )
        return;

    var_0 stoploopsound();
    var_0._id_11F33 = undefined;
}

_id_123D2( var_0 )
{
    if ( _id_11F31( var_0 ) )
        return;

    var_1 = gettime();

    if ( isdefined( var_0._id_11E7A ) && var_0._id_11E7A > var_1 )
        return;

    var_0 playlocalsound( "br_numbers_stinger" );
    var_0._id_11E7A = var_1 + 5000;
}

_id_11F31( var_0 )
{
    return istrue( var_0._id_11F33 );
}

switch_disabled()
{
    level._id_11F35.checked_missiles = [];
    bankplunderextractinstantly( "dx_brm_stc_numbers_16_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_23_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_9_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_8_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_14_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_22_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_5_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_18_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_18_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_7_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_11_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_14_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_2_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_12_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_3_10" );
    bankplunderextractinstantly( "dx_brm_stc_numbers_0_10" );
}

bankplunderextractinstantly( var_0 )
{
    level._id_11F35.checked_missiles[level._id_11F35.checked_missiles.size] = var_0;
}

_id_129F1()
{
    for (;;)
    {
        foreach ( var_1 in level._id_11F35._id_13C19 )
        {
            if ( istrue( var_1._id_1386F ) || !tugofwar_hvt_placed( var_1 ) )
                continue;

            var_2 = undefined;

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "player", "getPlayersInRadius" ) )
                var_2 = [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "player", "getPlayersInRadius" ) ]]( var_1.origin, 5000 );

            foreach ( var_4 in var_2 )
            {
                if ( !isdefined( var_4 ) || var_4 scripts\mp\gametypes\br_public.gsc::updateinstantclassswapallowedinternal() || !var_4 scripts\cp_mp\utility\player_utility::_isalive() || _id_124F9( var_4, var_1 ) )
                    continue;

                _id_12C3B( var_4, var_1 );
                _id_123CF( var_4 );
                _id_12AA0( "dlog_event_br_numbers_tower_broadcast", var_4, var_1 );
                waitframe();
            }

            waitframe();
        }

        waitframe();
    }
}

_id_14440()
{
    for (;;)
    {
        var_0 = 0;

        foreach ( var_2 in level._id_11F35._id_13C19 )
        {
            if ( tugofwar_hvt_placed( var_2 ) )
                var_0++;
        }

        if ( var_0 > 0 && var_0 >= level._id_11F35._id_13C19.size )
            break;

        waitframe();
    }

    _id_12A9E( "dlog_event_br_numbers_tower_all_raised" );
    level thread _id_123D0();
}

_id_123D0()
{
    for (;;)
    {
        var_0 = gettime();

        for ( var_1 = 0; var_1 < level.players.size; var_1++ )
        {
            var_2 = level.players[var_1];

            if ( !isdefined( var_2 ) )
                continue;

            if ( isdefined( var_2._id_11E7B ) && var_2._id_11E7B > var_0 )
                continue;

            if ( isdefined( var_2._id_125E4 ) )
            {
                if ( !isdefined( var_2._id_11E7B ) )
                {
                    level thread _id_12405( var_2 );
                    _id_12A9F( "dlog_event_br_numbers_tower_gas", var_2 );
                }

                _id_123D1( var_2 );
                var_2._id_11E7B = var_0 + 2500;
                waitframe();
            }
        }

        wait 0.1;
    }
}

delay_suspend_vehicle_convoy()
{
    wait 5.0;
    scripts\mp\utility\sound::besttime( "br_event_numbers_sfx" );
}

_id_12C3C( var_0, var_1, var_2 )
{
    foreach ( var_4 in scripts\mp\utility\teams::getfriendlyplayers( var_0 ) )
    {
        if ( isdefined( var_2 ) && var_2 == var_4 )
            _id_12AA0( "dlog_event_br_numbers_tower_used", var_4, var_1 );
        else
            _id_12AA0( "dlog_event_br_numbers_tower_team_used", var_4, var_1 );

        _id_12C3B( var_4, var_1 );
    }
}

_id_12C3B( var_0, var_1 )
{
    if ( _id_124F9( var_0, var_1 ) )
        return;

    var_0 scripts\cp\vehicles\vehicle_compass_cp::_id_120A9( var_1.getaltbunkerkeypadindexforscriptable );
    var_0 _id_130AB( var_0, var_1 );
}

_id_130AB( var_0, var_1 )
{
    if ( !isdefined( var_1.id ) )
        return;

    if ( !isdefined( var_0._id_11F36 ) )
        var_0._id_11F36 = [];

    var_0._id_11F36[var_1.id] = 1;
}

_id_124F9( var_0, var_1 )
{
    return isdefined( var_1.id ) && isdefined( var_0._id_11F36 ) && istrue( var_0._id_11F36[var_1.id] );
}

maxaccesscardspawns_red()
{
    var_0 = level.audio_start_obj_room_fires;

    for ( var_1 = 3; var_0.size > 0 && var_1 > 0; var_0 = scripts\engine\utility::array_remove_index( var_0, var_2 ) )
    {
        var_1--;
        var_2 = randomint( var_0.size );
        var_0[var_2] scripts\mp\gametypes\br_warp_door.gsc::_id_13289();
    }
}

propheight()
{
    var_0 = [];
    var_1 = level._id_11F35._id_13C19;

    foreach ( var_3 in level._id_11F35._id_13C19 )
    {
        if ( tugofwar_hvt_taken_firsttime( var_3 ) && scripts\mp\gametypes\br_circle.gsc::ispointincurrentsafecircle( var_3.origin ) )
            var_0[var_0.size] = var_3;
    }

    if ( var_0.size <= 0 )
        return undefined;

    return var_0[randomint( var_0.size )];
}

_id_12A1B( var_0, var_1 )
{
    var_2 = scripts\engine\trace::ray_trace_get_all_results( var_0, var_1 );

    foreach ( var_4 in var_2 )
    {
        if ( !isdefined( var_4["entity"] ) )
            return var_4;
    }

    return var_2[var_2.size - 1];
}

_id_12A1A( var_0, var_1 )
{
    var_2 = scripts\engine\trace::ray_trace_get_all_results( var_0, var_1 );

    foreach ( var_4 in var_2 )
    {
        var_5 = var_4["entity"];

        if ( isdefined( var_5 ) && isalive( var_5 ) && isdefined( var_5.vehiclename ) )
            return var_4;
    }

    return undefined;
}

_id_12AA0( var_0, var_1, var_2 )
{
    var_3 = juggernaut_getavoidanceposition();
    var_3 = autostartcircle( var_3, "towerid", var_2.id );
    var_3 = autostructnum( var_3, var_1.origin );
    var_1 dlog_recordplayerevent( var_0, var_3 );
}

_id_12A9F( var_0, var_1 )
{
    var_2 = juggernaut_getavoidanceposition();
    var_2 = autostructnum( var_2, var_1.origin );
    var_1 dlog_recordplayerevent( var_0, var_2 );
}

_id_12A9E( var_0 )
{
    var_1 = juggernaut_getavoidanceposition();
    getentitylessscriptablearray( var_0, var_1 );
}

juggernaut_getavoidanceposition()
{
    var_0 = [];
    var_0[var_0.size] = "time_msfrommatchstart";
    var_0[var_0.size] = scripts\mp\matchdata::gettimefrommatchstart( gettime() );
    return var_0;
}

autostartcircle( var_0, var_1, var_2 )
{
    var_0[var_0.size] = var_1;
    var_0[var_0.size] = var_2;
    return var_0;
}

autostructnum( var_0, var_1 )
{
    var_0 = autostartcircle( var_0, "pos_x", var_1[0] );
    var_0 = autostartcircle( var_0, "pos_y", var_1[1] );
    var_0 = autostartcircle( var_0, "pos_z", var_1[2] );
    return var_0;
}
