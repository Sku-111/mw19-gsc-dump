// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\mp\playeractions::registeractionset( "throwback_marker", [ "usability", "gesture" ] );
}

throwbackmarker_trythrowbackmarker( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = ::throwbackmarker_weapongiven;
    var_9 = ::throwbackmarker_weaponswitchended;
    var_10 = ::throwbackmarker_weaponfired;
    var_11 = ::throwbackmarker_weapontaken;
    var_0.throwbackmarker_weapondetonatefunc = var_1;
    var_0.throwbackmarker_weapongivenfunc = var_3;
    var_0.throwbackmarker_weaponswitchendedfunc = var_4;
    var_0.throwbackmarker_weaponfiredfunc = var_5;
    var_0.throwbackmarker_weapontakenfunc = var_7;
    var_12 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dothrowbackmarkerdeploy( var_0, var_2, var_8, var_9, var_10, var_6, var_11 );

    if ( !istrue( var_12 ) )
        return 0;

    return 1;
}

throwbackmarker_weapongiven( var_0 )
{
    var_1 = 1;

    if ( isdefined( var_0.throwbackmarker_weapongivenfunc ) )
        var_1 = level [[ var_0.throwbackmarker_weapongivenfunc ]]( var_0 );

    return var_1;
}

throwbackmarker_weaponswitchended( var_0, var_1 )
{
    if ( istrue( var_1 ) )
        thread throwbackmarker_watchplayerweapon( var_0 );

    if ( isdefined( var_0.throwbackmarker_weaponswitchendedfunc ) )
        level thread [[ var_0.throwbackmarker_weaponswitchendedfunc ]]( var_0, var_1 );
}

throwbackmarker_watchplayerweapon( var_0 )
{
    self endon( "disconnect" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
    var_1 = scripts\engine\utility::_id_143AD( "cancel_deploy", "weapon_switch_started" );

    if ( !isdefined( var_1 ) )
        return;

    var_0 notify( "killstreak_finished_with_deploy_weapon" );
}

throwbackmarker_weaponfired( var_0, var_1, var_2 )
{
    var_3 = "success";
    level thread throwbackmarker_watchdetonate( var_0, var_2, self );
    level thread throwbackmarker_watchthrowback( var_0, var_2 );

    if ( isdefined( var_0.throwbackmarker_weaponfiredfunc ) )
        var_3 = [[ var_0.throwbackmarker_weaponfiredfunc ]]( var_0, var_1, var_2 );

    return var_3;
}

throwbackmarker_watchdetonate( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    var_1 endon( "trigger" );
    var_1 waittill( "explode", var_3 );

    if ( isdefined( var_0.throwbackmarker_weapondetonatefunc ) )
        [[ var_0.throwbackmarker_weapondetonatefunc ]]( var_0, var_3, var_2 );
}

throwbackmarker_watchthrowback( var_0, var_1 )
{
    var_1 endon( "fired_off" );
    var_1 waittill( "trigger", var_2 );
    var_2 endon( "death_or_disconnect" );
    var_2 waittill( "grenade_fire", var_3, var_4 );
    level thread throwbackmarker_watchdetonate( var_0, var_3, var_2 );
    level thread throwbackmarker_watchthrowback( var_0, var_3 );
    var_2 thread throwbackmarker_takeweapon( var_4 );
}

throwbackmarker_takeweapon( var_0 )
{
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_1 = 0;

    while ( var_1 < 5 )
    {
        if ( self hasweapon( var_0 ) )
            scripts\cp_mp\utility\inventory_utility::_takeweapon( var_0 );
        else
            var_1 = var_1 + 1;

        wait 0.05;
    }
}

throwbackmarker_weapontaken( var_0 )
{
    if ( isdefined( var_0.throwbackmarker_weapontakenfunc ) )
        [[ var_0.throwbackmarker_weapontakenfunc ]]( var_0 );
}