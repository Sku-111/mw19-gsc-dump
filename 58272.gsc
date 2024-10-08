// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    if ( isdefined( level._id_119F9 ) )
        return;

    test_bag_pickup();
    level._effect["vfx_golden_loot_explosion_flare"] = loadfx( "vfx/iw8_br/gameplay/vfx_golden_loot_explosion_flare" );
    level._effect["vfx_br_legendary_loot_glow"] = loadfx( "vfx/iw8_br/gameplay/vfx_br_launch_code_glow" );
}

test_bag_pickup()
{
    if ( !isdefined( level._id_119F9 ) )
    {
        level._id_119F9 = spawnstruct();
        level._id_119F9.ammo_types = [];
        level._id_119F9.ammo_types["rifle"] = "brloot_ammo_762";
        level._id_119F9.ammo_types["mg"] = "brloot_ammo_762";
        level._id_119F9.ammo_types["pistol"] = "brloot_ammo_919";
        level._id_119F9.ammo_types["smg"] = "brloot_ammo_919";
        level._id_119F9.ammo_types["sniper"] = "brloot_ammo_50cal";
        level._id_119F9.ammo_types["rocketlauncher"] = "brloot_ammo_rocket";
        level._id_119F9.ammo_types["spread"] = "brloot_ammo_12g";
    }

    level._id_119F9._id_12148 = [];
    level._id_119F9._id_119FD = [];
}

_id_11A45( var_0, var_1 )
{
    if ( !isdefined( level._id_119F9 ) )
        return;

    if ( !scripts\engine\utility::array_contains_key( level._id_119F9._id_119FD, var_0 ) )
        level._id_119F9._id_119FD[var_0] = allow_hotjoining( var_0, var_1 );
    else
    {

    }
}

_id_11A47( var_0, var_1 )
{
    if ( cargo_truck_mg_cp_spawncallback( var_0 ) )
        return;

    if ( scripts\engine\utility::array_contains_key( level._id_119F9._id_119FD, var_0 ) )
        level._id_119F9._id_119FD[var_0] = var_1;
}

_id_11A44( var_0, var_1, var_2 )
{
    if ( cargo_truck_mg_cp_spawncallback( var_0 ) )
        return;

    var_3 = level._id_119F9._id_119FD[var_0];

    if ( !scripts\engine\utility::array_contains_key( var_3, var_1 ) )
    {
        level._id_119F9._id_12148[var_0][var_1] = var_2;
        level._id_119F9._id_119FD[var_0] = allow_hotjoining( var_0, level._id_119F9._id_12148[var_0] );
    }
    else
    {

    }
}

_id_11A46( var_0, var_1 )
{
    if ( cargo_truck_mg_cp_spawncallback( var_0 ) )
        return;

    var_2 = level._id_119F9._id_119FD[var_0];

    if ( scripts\engine\utility::array_contains_key( var_2, var_1 ) )
    {
        level._id_119F9._id_12148[var_0] = scripts\engine\utility::array_remove_key( level._id_119F9._id_12148[var_0], var_1 );
        level._id_119F9._id_119FD[var_0] = allow_hotjoining( var_0, level._id_119F9._id_12148[var_0] );
    }
    else
    {

    }
}

removepickup( var_0 )
{
    if ( cargo_truck_mg_cp_spawncallback( var_0 ) )
        return;

    return level._id_119F9._id_119FD[var_0];
}

loottableexist( var_0 )
{
    return scripts\engine\utility::array_contains_key( level._id_119F9._id_119FD, var_0 );
}

_id_13673( var_0, var_1, var_2, var_3, var_4 )
{
    if ( cargo_truck_mg_cp_spawncallback( var_0 ) )
        return;

    var_5 = removepickup( var_0 );
    var_6 = spawnstruct();
    var_6.ml_p3_to_safehouse_transition = randomintrange( 1, 10 );
    var_6.heightoffset = 0;
    var_6.origin = var_1;

    if ( isstring( var_3 ) )
    {

    }
    else if ( var_3 )
        playfx( scripts\engine\utility::getfx( "vfx_golden_loot_explosion_flare" ), var_1 );

    for ( var_7 = 0; var_7 < var_2; var_7++ )
    {
        var_8 = randomfloat( 1.0 );

        foreach ( var_15, var_10 in var_5 )
        {
            var_11 = var_10[2];
            var_12 = var_10[3];

            if ( var_8 >= var_11 && var_8 <= var_12 )
            {
                switch ( var_15 )
                {
                    case "nothing":
                        continue;
                    case "brloot_ammo_killer_based":
                        if ( !isdefined( var_4 ) )
                            continue;

                        if ( !isdefined( var_4["eAttacker"] ) )
                            continue;

                        var_13 = var_4["eAttacker"];
                        var_14 = undefined;

                        if ( isplayer( var_13 ) || isbot( var_13 ) || isagent( var_13 ) )
                            var_14 = weaponclass( var_4["eAttacker"] getcurrentweapon() );

                        if ( !isdefined( var_14 ) )
                            continue;

                        var_6.item = level._id_119F9.ammo_types[var_14];

                        if ( !isdefined( var_6.item ) )
                            continue;

                        break;
                    default:
                        var_6.item = var_15;
                        break;
                }

                var_6.ml_p3_to_safehouse_transition = var_6.ml_p3_to_safehouse_transition + 2;
                thread _id_13672( var_6 );
                waitframe();
            }
        }
    }
}

cargo_truck_mg_cp_spawncallback( var_0 )
{
    if ( !scripts\engine\utility::array_contains_key( level._id_119F9._id_119FD, var_0 ) )
        return 1;

    return 0;
}

_id_13672( var_0 )
{
    var_0.legendary = issubstr( var_0.item, "lege" );
    var_1 = var_0.item;
    var_2 = var_0.origin + ( 0, 0, var_0.heightoffset );
    var_3 = ( 0, 0, 0 );
    var_4 = scripts\mp\gametypes\br_lootcache.gsc::_id_11A41( var_1, var_0, var_2, var_3, 0, var_0.legendary, 0 );
    var_0.heightoffset = var_0.heightoffset + 3;
}

allow_hotjoining( var_0, var_1 )
{
    var_2 = [];
    var_3 = 0;

    foreach ( var_5 in var_1 )
        var_3 = var_3 + var_5;

    var_7 = 0;
    var_8 = getarraykeys( var_1 );
    var_9 = undefined;

    foreach ( var_14, var_5 in var_1 )
    {
        var_2[var_14] = [];
        var_11 = var_5 / var_3;

        if ( var_7 == 0 )
        {
            var_12 = 0;
            var_13 = var_11;
        }
        else
        {
            var_12 = var_9[3];
            var_13 = var_12 + var_11;
        }

        var_2[var_14] = [ var_5, var_11, var_12, var_13 ];
        var_9 = var_2[var_14];
        var_7++;
    }

    level._id_119F9._id_12148[var_0] = var_1;
    return var_2;
}