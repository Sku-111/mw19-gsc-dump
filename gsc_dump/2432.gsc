// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

little_bird_mp_init()
{
    scripts\cp_mp\utility\script_utility::registersharedfunc( "little_bird", "spawnCallback", ::little_bird_mp_spawncallback );
    little_bird_mp_initspawning();
    zombiedropstags();
    scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_registeroutoftimecallback( "little_bird", scripts\cp_mp\vehicles\little_bird::little_bird_explode );

    if ( istrue( level._id_13375 ) )
        scripts\cp_mp\utility\script_utility::registersharedfunc( "little_bird", "endEnterInternal", ::zombie );
}

little_bird_mp_initspawning()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_getleveldataforvehicle( "little_bird", 1 );
    var_0.arenavday = scripts\cp_mp\vehicles\vehicle_spawn::_id_14211;
    var_0.areplayersnear = 60;

    if ( scripts\mp\utility\game::getgametype() == "arm" )
        var_0._id_12CA1 = 30;
}

zombiedropstags()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_mines::vehicle_mines_getleveldataforvehicle( "little_bird", 1 );
    var_0.frontextents = 78;
    var_0.backextents = 28;
    var_0.leftextents = 55;
    var_0.rightextents = 55;
    var_0.bottomextents = -80;
    var_0.distancetobottom = 80;
    var_0.loscheckoffset = ( 0, 0, -70 );
}

little_bird_mp_spawncallback( var_0, var_1 )
{
    var_2 = scripts\cp_mp\vehicles\little_bird::little_bird_create( var_0, var_1 );

    if ( isdefined( var_2 ) && scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_gamemodesupportsrespawn() )
        var_2.ondeathrespawn = ::little_bird_mp_ondeathrespawncallback;

    return var_2;
}

little_bird_mp_ondeathrespawncallback()
{
    thread little_bird_mp_waitandspawn();
}

little_bird_mp_waitandspawn()
{
    var_0 = scripts\cp_mp\vehicles\vehicle_tracking::getvehiclespawndata( self );
    var_1 = spawnstruct();
    scripts\cp_mp\vehicles\vehicle_tracking::copyvehiclespawndata( var_0, var_1 );
    var_1.ref = var_0.ref;
    var_1.rallypointhealth = var_0.rallypointhealth;
    var_2 = spawnstruct();
    var_3 = scripts\cp_mp\vehicles\vehicle_spawn::_id_1421C( "little_bird", var_1, var_2 );

    if ( isdefined( var_3 ) )
    {
        if ( isdefined( var_1.ref ) && istrue( level.userallypointvehicles ) && level.userallypointvehicles != 2 )
        {
            var_3.ref = var_1.ref;
            var_3.maxhealth = int( max( var_3.maxhealth, var_1.rallypointhealth ) );
            var_3.health = var_3.maxhealth;
            scripts\mp\rally_point::rallypointvehicle_activate( var_3 );
        }

        if ( istrue( level._id_13375 ) )
            scripts\mp\gametypes\arm.gsc::_id_1413A( var_3, var_3.team );
    }
}

zombie( var_0, var_1, var_2, var_3, var_4 )
{
    if ( istrue( level._id_13375 ) )
        var_0 scripts\mp\gametypes\arm.gsc::_id_141FF( var_3.team );
}