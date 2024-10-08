// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{

}

reflectionprobe_hide_hp()
{

}

reflectionprobe_hide_front()
{

}

gotonextspawn()
{

}

gotoprevspawn()
{

}

devaliengiveplayersmoney()
{

}

spam_points_popup()
{
    var_0 = [ "headshot", "avenger", "longshot", "posthumous", "double", "triple", "multi" ];

    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
    {
        thread scripts\mp\rank::scorepointspopup( 100 );
        thread scripts\mp\rank::scoreeventpopup( var_0[var_1] );
        wait 2.0;
    }
}

devlistinventory()
{
    var_0 = getdvar( "scr_list_inventory", "" );

    if ( var_0 != "" )
    {
        var_1 = devfindhost();

        if ( !isdefined( var_1 ) )
            return;

        var_2 = undefined;
        var_3 = undefined;
        var_4 = 0;

        if ( var_0 == "all" )
        {
            var_3 = "all weapons";
            var_2 = var_1 getweaponslistall();
        }
        else if ( var_0 == "primaryCurrent" )
        {
            var_3 = "current weapon";
            var_4 = 1;
            var_2 = [ var_1 getcurrentweapon() ];
        }
        else
        {
            var_3 = var_0 + " inventory";
            var_2 = var_1 getweaponslist( var_0 );
        }

        var_1 devprintweaponlist( var_2, var_3, var_4 );
    }
}

devprintweaponlist( var_0, var_1, var_2 )
{
    if ( isdefined( var_0 ) && var_0.size > 0 )
    {
        foreach ( var_4 in var_0 )
        {
            var_5 = self getweaponammoclip( var_4 );
            var_6 = self getweaponammostock( var_4 );
            var_7 = "  " + createheadicon( var_4 ) + " " + var_5 + "/" + var_6;

            if ( var_2 )
                iprintlnbold( var_7 );
        }
    }
    else
    {

    }
}

devgivesuperthink()
{
    for (;;)
    {
        var_0 = getdvar( "scr_givesuper", "" );

        if ( var_0 != "" )
        {
            foreach ( var_2 in level.players )
                var_2 scripts\mp\supers::givesuper( var_0, 0, 1 );
        }

        if ( getdvarint( "scr_super_short_cooldown", 0 ) != 0 )
        {
            foreach ( var_2 in level.players )
            {
                if ( isbot( var_2 ) )
                    continue;

                if ( !isdefined( var_2 scripts\mp\supers::getcurrentsuper() ) )
                    continue;

                if ( var_2 scripts\mp\supers::issupercharging() )
                    var_2 scripts\mp\supers::givesuperpoints( var_2 scripts\mp\supers::getsuperpointsneeded() * 0.25 );
            }
        }

        wait 0.25;
    }
}

devgivefieldupgradethink()
{
    for (;;)
    {
        var_0 = getdvar( "scr_givefieldUpgrade", "" );

        if ( var_0 != "" )
        {
            foreach ( var_2 in level.players )
                var_2 scripts\mp\perks\perkpackage::perkpackage_givedebug( var_0 );
        }

        wait 0.25;
    }
}

devfindhost()
{
    var_0 = undefined;

    foreach ( var_2 in level.players )
    {
        if ( var_2 ishost() )
        {
            var_0 = var_2;
            break;
        }
    }

    return var_0;
}

watchlethaldelaycancel()
{
    for (;;)
    {
        if ( getdvarint( "scr_lethalDelayCancel", 0 ) )
        {
            scripts\mp\equipment::cancellethaldelay();
            return;
        }

        wait 1.0;
    }
}

watchsuperdelaycancel()
{
    for (;;)
    {
        if ( getdvarint( "scr_superDelayCancel", 0 ) )
        {
            scripts\mp\supers::cancelsuperdelay();
            return;
        }

        wait 1.0;
    }
}

watchslowmo()
{
    for (;;)
    {
        if ( getdvar( "scr_slowmo" ) != "" )
            break;

        wait 1;
    }

    var_0 = getdvarfloat( "scr_slowmo" );
    setslowmotion( var_0, var_0, 0.0 );
    thread watchslowmo();
}

rangefinder()
{
    thread scripts\mp\rangefinder::runmprangefinder();
}
