// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    var_0 = spawnstruct();
    var_0.weight = getdvarfloat( "scr_br_pe_restock_weight", 0 );
    var_0._id_140CF = ::_id_140CF;
    var_0._id_14382 = ::_id_14382;
    var_0.attackerswaittime = ::attackerswaittime;
    var_0.isfeaturedisabled = ::isfeaturedisabled;
    var_0.postinitfunc = ::postinitfunc;
    var_0._id_11B78 = getdvarint( "scr_br_pe_restock_max_times", 2 );
    var_0.guard_door_clip = scripts\mp\gametypes\br_publicevents.gsc::relic_squadlink_init_vfx( "restock", "0    0   5   5           10  15  15  13" );
    var_0.pemetereventweights = scripts\mp\gametypes\br_publicevents_meter.gsc::getdvarpemetereventweights( "restock" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_12B35( 6, var_0 );
}

postinitfunc()
{
    game["dialog"]["power_up_field_resupply"] = "power_up_field_resupply";
    level._id_12129 = [];
}

_id_140CF()
{
    return 1;
}

_id_14382()
{
    level endon( "game_ended" );
    level endon( "cancel_public_event" );
}

attackerswaittime()
{
    level endon( "game_ended" );
    scripts\mp\gametypes\br_publicevents.gsc::_id_13371( "br_pe_restock_start" );
    scripts\mp\gametypes\br_public.gsc::brleaderdialog( "power_up_field_resupply", 1 );

    foreach ( var_1 in level._id_12129 )
    {
        if ( var_1.type == "br_reusable_loot_cache" )
        {
            var_1 setscriptablepartstate( "body", "vfx9" );
            var_2 = getdvarint( "scr_reusable_cache_loot_sets", 3 );
            var_1.intel_collected = ( var_1.intel_collected + 1 ) % var_2;
            var_1 notify( "closed" );
            var_3 = "closing";
        }
        else
            var_3 = "set_to_closed";

        var_1 setscriptablepartstate( "body", var_3 );
    }
}

isfeaturedisabled()
{

}

_id_12CC0()
{
    level endon( "game_ended" );
    self endon( "death" );

    switch ( self.type )
    {
        case "br_loot_cache_reddoor":
        case "br_loot_cache_rogue":
        case "br_reusable_loot_cache":
        case "br_loot_cache":
        case "br_loot_cache_lege":
            level._id_12129[level._id_12129.size] = self;
            break;
        default:
            return;
    }
}

use_dropkit_marker()
{
    return istrue( level.delayeventfired ) && getdvarfloat( "scr_br_pe_restock_weight", 0 ) || istrue( level.delete_crate_objectives );
}

_id_12C00()
{
    if ( scripts\engine\utility::array_contains( level._id_12129, self ) )
        level._id_12129 = scripts\engine\utility::array_remove( level._id_12129, self );
}