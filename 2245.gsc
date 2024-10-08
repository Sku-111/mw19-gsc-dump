// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_giveweapon( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_1 ) )
        var_1 = -1;

    if ( !isdefined( var_3 ) )
        var_3 = 0;

    self giveweapon( var_0, var_1, istrue( var_2 ), -1, var_3 );
}

_switchtoweapon( var_0 )
{
    self switchtoweapon( var_0 );
}

_switchtoweaponimmediate( var_0 )
{
    self switchtoweaponimmediate( var_0 );
}

_takeweapon( var_0, var_1 )
{
    var_2 = 0;

    if ( issameweapon( var_0 ) )
        var_2 = self gethighpriorityweapon() == var_0;
    else
        var_2 = createheadicon( self gethighpriorityweapon() ) == var_0;

    if ( var_2 )
    {
        var_3 = var_0;

        if ( !isstring( var_3 ) && issameweapon( var_0 ) )
            var_3 = createheadicon( var_0 );

        self clearhighpriorityweapon( var_0 );
    }

    self takeweapon( var_0 );
}

takeweaponwhensafe( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    for (;;)
    {
        var_1 = 0;

        if ( !iscurrentweapon( var_0 ) )
        {
            var_2 = self getweaponmeleeslot();

            if ( !nullweapon( var_2 ) && self.currentweapon == var_2 )
                var_1 = 0;
            else
                var_1 = 1;
        }

        if ( var_1 )
            break;

        waitframe();
    }

    _takeweapon( var_0 );
}

getcurrentmonitoredweaponswitchweapon()
{
    validatehighpriorityflag();
    var_0 = self gethighpriorityweapon();

    if ( nullweapon( var_0 ) )
        return undefined;

    return var_0;
}

isanymonitoredweaponswitchinprogress()
{
    return isdefined( getcurrentmonitoredweaponswitchweapon() );
}

isswitchingtoweaponwithmonitoring( var_0 )
{
    if ( isstring( var_0 ) )
        var_0 = asmdevgetallstates( var_0 );

    var_1 = getcurrentmonitoredweaponswitchweapon();
    return isdefined( var_1 ) && var_1 == var_0 && !iscurrentweapon( var_0 );
}

candomonitoredswitchtoweapon( var_0, var_1 )
{
    if ( !self hasweapon( var_0 ) )
        return 0;

    if ( !scripts\common\utility::is_weapon_allowed() )
        return 0;

    if ( !istrue( var_1 ) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed() )
        return 0;

    var_2 = getcurrentmonitoredweaponswitchweapon();

    if ( isdefined( var_2 ) )
    {
        var_3 = getweaponbasename( var_0 );
        var_4 = 0;

        if ( var_3 == "briefcase_bomb_mp" || var_3 == "briefcase_bomb_defuse_mp" || var_3 == "iw8_cyberemp_mp" || var_3 == "iw7_tdefball_mp" )
            var_4 = 1;
        else if ( weaponinventorytype( var_2 ) == "primary" )
            var_4 = 1;

        if ( !var_4 )
            return 0;
    }

    if ( iscurrentweapon( var_0 ) )
        return 0;

    return 1;
}

abortmonitoredweaponswitch( var_0 )
{
    if ( self gethighpriorityweapon() == var_0 )
        self clearhighpriorityweapon( var_0 );

    _takeweapon( var_0 );
    return;
}

domonitoredweaponswitch( var_0, var_1, var_2 )
{
    self endon( "disconnect" );
    self endon( "death" );

    if ( !isdefined( var_0 ) )
        return 0;

    if ( !candomonitoredswitchtoweapon( var_0, var_2 ) )
        return 0;

    if ( isanymonitoredweaponswitchinprogress() )
        self clearhighpriorityweapon( getcurrentmonitoredweaponswitchweapon() );

    self sethighpriorityweapon( var_0 );

    if ( istrue( var_1 ) )
        _switchtoweaponimmediate( var_0 );

    for (;;)
    {
        if ( iscurrentweapon( var_0 ) )
        {
            validatehighpriorityflag();
            return 1;
        }

        if ( !self ishighpriorityweapon( var_0 ) || !self hasweapon( var_0 ) )
            return 0;

        if ( !scripts\common\utility::is_weapon_allowed() || !istrue( var_2 ) && !scripts\common\utility::is_weapon_switch_allowed() && !scripts\common\utility::is_script_weapon_switch_allowed() )
        {
            self clearhighpriorityweapon( var_0 );
            return 0;
        }

        waitframe();
    }
}

validatehighpriorityflag()
{
    var_0 = self getcurrentweapon();

    if ( self ishighpriorityweapon( var_0 ) )
        self clearhighpriorityweapon( var_0 );
}

getridofweapon( var_0, var_1 )
{
    self endon( "death" );
    self endon( "disconnect" );

    if ( !self hasweapon( var_0 ) )
        return 0;

    if ( !iscurrentweapon( var_0 ) )
    {
        _takeweapon( var_0 );
        return 1;
    }

    while ( isanymonitoredweaponswitchinprogress() )
        waitframe();

    if ( !iscurrentweapon( var_0 ) )
    {
        _takeweapon( var_0 );
        return 1;
    }

    var_2 = domonitoredweaponswitch( self.lastdroppableweaponobj, var_1 );

    if ( isbot( self ) )
    {
        self switchtoweaponimmediate( isundefinedweapon() );
        var_2 = 1;
    }

    _takeweapon( var_0 );
    self notify( "bomb_allow_offhands" );

    if ( !var_2 )
        forcevalidweapon();

    return 1;
}

forcevalidweapon( var_0 )
{
    self endon( "death" );
    self endon( "disconnect" );

    while ( nullweapon( self getcurrentweapon() ) )
    {
        if ( self isswitchingweapon() || isanymonitoredweaponswitchinprogress() )
        {
            waitframe();
            continue;
        }

        var_1 = var_0;

        if ( istrue( self.isjuggernaut ) )
        {
            var_2 = "iw8_minigunksjugg_mp";

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "getMinigunWeapon" ) )
                var_2 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "getMinigunWeapon" ) ]]();

            if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "juggernaut", "canUseWeaponPickups" ) )
            {
                var_3 = self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "juggernaut", "canUseWeaponPickups" ) ]]();

                if ( istrue( var_3 ) )
                {
                    if ( isdefined( self.lastdroppableweaponobj ) && self hasweapon( self.lastdroppableweaponobj ) )
                        var_2 = self.lastdroppableweaponobj;
                    else
                    {
                        var_4 = getcurrentprimaryweaponsminusalt();

                        if ( var_4.size > 0 )
                            var_2 = var_4[0];
                    }
                }
            }

            var_1 = getcompleteweaponname( var_2 );
        }
        else
        {
            var_4 = getcurrentprimaryweaponsminusalt();

            if ( !isdefined( var_1 ) || !self hasweapon( var_1 ) )
            {
                if ( !isdefined( self.lastdroppableweaponobj ) || self.lastdroppableweaponobj.basename == "none" )
                    break;

                if ( self hasweapon( self.lastdroppableweaponobj ) )
                    var_1 = self.lastdroppableweaponobj;
                else if ( var_4.size > 0 )
                    var_1 = var_4[0];
            }

            if ( isdefined( var_1 ) && getweaponbasename( var_1 ) == "iw7_axe_mp" && self getweaponammoclip( var_1 ) == 0 && var_4.size == 1 )
                var_1.basename = "iw8_fists_mp";
            else if ( self hasweapon( "iw8_fists_mp" ) )
            {
                if ( var_4.size == 1 )
                    var_1 = var_4[0];
                else if ( var_4.size == 2 && ( self hasweapon( "iw8_knifestab_mp" ) || self hasweapon( "iw8_throwingknife_fire_melee_mp" ) || self hasweapon( "iw8_throwingknife_electric_melee_mp" ) || self hasweapon( "iw8_throwingknife_drill_melee_mp" ) ) )
                {
                    if ( var_4[0].basename == "iw8_fists_mp" )
                        var_1 = var_4[0];
                    else
                        var_1 = var_4[1];
                }
            }
        }

        domonitoredweaponswitch( var_1 );
        waitframe();
    }
}

iscurrentweapon( var_0 )
{
    if ( isstring( var_0 ) )
        var_0 = asmdevgetallstates( var_0 );

    return isnullweapon( self getcurrentweapon(), var_0, 1 );
}

getcurrentprimaryweaponsminusalt()
{
    var_0 = [];
    var_1 = self getweaponslistprimaries();

    foreach ( var_3 in var_1 )
    {
        if ( !var_3.isalternate )
            var_0[var_0.size] = var_3;
    }

    return var_0;
}