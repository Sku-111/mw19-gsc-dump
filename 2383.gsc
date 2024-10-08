// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

_id_138E7()
{
    level._id_120AD _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty( ::_id_138ED, level );
    level._id_120AE _calloutmarkerping_handleluinotify_acknowledgedcancel::friendlystatusdirty( ::_id_138EE, level );
}

stoppingpower_beginuse()
{
    var_0 = self.lastweaponobj;
    var_1 = isundefinedweapon();

    if ( !scripts\mp\weapons::isnormallastweapon( var_0 ) || scripts\mp\utility\weapon::ismeleeonly( var_0 ) || scripts\mp\utility\weapon::isgamemodeweapon( var_0 ) || scripts\mp\utility\weapon::issinglehitweapon( var_0.basename ) || !_id_138EA( var_0 ) || _id_138E8( var_0 ) )
    {
        if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hud", "showErrorMessage" ) )
            self [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hud", "showErrorMessage" ) ]]( "MP/SUPPORT_BOX_INCOMPAT" );

        return 0;
    }

    var_2 = stoppingpower_cancelreload();

    if ( !istrue( var_2 ) )
        return 0;

    if ( self isalternatemode( var_0 ) )
    {
        var_1 = var_0;
        var_0 = var_0 getnoaltweapon();
    }
    else
        var_1 = var_0 getaltweapon();

    var_3 = [];
    var_4 = 0;
    var_5 = 0;

    if ( !nullweapon( var_1 ) )
        var_3[var_3.size] = var_1;

    var_3[var_3.size] = var_0;

    foreach ( var_7 in var_3 )
    {
        var_8 = scripts\mp\utility\weapon::turnexfiltoside( var_7 );

        if ( isnullweapon( var_7, var_0, 0 ) )
        {
            var_9 = scripts\mp\weapons::getammooverride( var_7 );
            var_10 = var_9 * 1;

            if ( var_8 )
                var_10 = var_10 * 2;

            thread stoppingpower_givehcr( self, var_7, var_10 );

            if ( 1 )
            {
                if ( var_8 )
                {
                    var_9 = self getweaponammoclip( var_7, "left" ) + self getweaponammoclip( var_7, "right" );
                    var_4 = self getweaponammostock( var_7 );
                    var_11 = var_9 + var_4;
                    var_12 = int( min( _id_138E4( var_7, var_11 ), var_11 + var_10 ) );
                    self setweaponammostock( var_7, var_12 );
                    self setweaponammoclip( var_7, 0, "left" );
                    self setweaponammoclip( var_7, 0, "right" );
                }
                else
                {
                    var_9 = self getweaponammoclip( var_7 );
                    var_4 = self getweaponammostock( var_7 );
                    var_11 = var_9 + var_4;
                    var_13 = _id_138E4( var_7, var_11 );
                    var_14 = var_11 + var_10;
                    var_5 = int( var_14 - var_13 );
                    var_15 = int( min( var_13, var_14 ) );

                    if ( var_7.basename == "iw8_lm_dblmg_mp" )
                        self setweaponammoclip( var_7, var_9 + var_10 );
                    else
                    {
                        self setweaponammoclip( var_7, 0 );

                        if ( scripts\mp\utility\game::getgametype() == "br" )
                        {
                            var_16 = var_15 - var_4;
                            scripts\mp\gametypes\br_weapons.gsc::delay_camera_normal( var_7, var_16 );
                        }
                        else
                            self setweaponammostock( var_7, var_15 );
                    }
                }
            }
        }
    }

    thread _id_138F0( var_0, var_4, var_5 );
    return 1;
}

_id_138E4( var_0, var_1 )
{
    var_2 = var_0.maxammo;

    if ( var_1 > var_2 )
        var_2 = var_1;

    return var_2;
}

_id_138EA( var_0 )
{
    if ( !self isalternatemode( var_0 ) )
        return 1;

    var_1 = var_0.underbarrel;
    return scripts\mp\weapons::turretoverridefunc( var_1 );
}

_id_138E8( var_0 )
{
    switch ( var_0.basename )
    {
        case "iw8_lm_dblmg_mp":
        case "iw8_me_t9ballisticknife_mp":
        case "iw8_sm_t9nailgun_mp":
        case "iw8_fists_mp":
            return 1;
    }

    return 0;
}

_id_138F0( var_0, var_1, var_2 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );

    for (;;)
    {
        if ( self getcurrentprimaryweapon() != var_0 )
            break;

        var_3 = self getweaponammoclip( var_0 );

        if ( var_3 > 0 )
        {
            thread scripts\mp\hud_message::showsplash( "stopping_power_loaded" );

            if ( var_2 > 0 )
                self setweaponammostock( var_0, var_1 + var_2 );

            break;
        }

        waitframe();
    }

    if ( !scripts\mp\supers::issuperinuse() )
        waitframe();

    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "supers", "superUseFinished" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "supers", "superUseFinished" ) ]]();
}

stoppingpower_givehcr( var_0, var_1, var_2 )
{
    var_3 = init_relic_steelballs( var_0, var_1, var_2 );
    _id_138E6( var_0, var_3 );
}

init_relic_steelballs( var_0, var_1, var_2 )
{
    var_3 = spawnstruct();
    var_3.player = var_0;
    var_3.objweapon = var_1;
    var_3.rounds = var_2;
    var_3.gavehcr = 0;
    var_3.kills = 0;
    return var_3;
}

_id_138E6( var_0, var_1 )
{
    if ( !isdefined( var_0.hcrdata ) )
        var_0.hcrdata = [];

    var_2 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( var_1.objweapon );
    var_3 = var_0.hcrdata[var_2];

    if ( isdefined( var_3 ) )
        var_3 thread stoppingpower_removehcr();

    var_0.hcrdata[var_2] = var_1;
    var_1 thread stoppingpower_clearhcrondeath();
    var_1 thread _id_138E2();
    var_1 thread _id_138E3();
    var_1 thread stoppingpower_givefastreload();
    var_0 thread stoppingpower_breaksprint();
    var_1 thread stoppingpower_watchhcrweaponchange();
    var_1 thread stoppingpower_watchhcrweaponfire();
}

_id_138ED( var_0, var_1, var_2 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_1 ) )
        return;

    var_3 = var_1 _id_138E5( var_2 );

    if ( isdefined( var_3 ) )
    {
        var_4 = init_relic_steelballs( var_3.player, var_3.objweapon, var_3.rounds );
        var_0.hcrdata = var_4;
        var_3 thread stoppingpower_removehcr();
    }
}

_id_138EE( var_0, var_1, var_2 )
{
    var_3 = var_0.hcrdata;

    if ( !isdefined( var_3 ) )
        return;

    if ( !isdefined( var_3.player ) || !var_3.player hasweapon( var_3.objweapon ) )
        return;

    var_3.player = var_1;
    _id_138E6( var_1, var_3 );
}

_id_138E5( var_0 )
{
    if ( !isdefined( var_0 ) )
        return undefined;

    if ( !isdefined( self.hcrdata ) )
        return undefined;

    var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( var_0 );
    return self.hcrdata[var_1];
}

stoppingpower_cancelreload()
{
    self endon( "death_or_disconnect" );
    self cancelreload();
    wait 0.05;
    return 1;
}

stoppingpower_watchhcrweaponchange()
{
    self endon( "stoppingPower_removeHCR" );
    self.player endon( "disconnect" );

    while ( self.player hasweapon( self.objweapon ) )
    {
        if ( _id_138E9( self.player getcurrentweapon() ) )
        {
            if ( !self.gavehcr )
            {
                self.player scripts\mp\utility\perk::giveperk( "specialty_bulletdamage" );
                self.gavehcr = 1;
            }
        }
        else if ( self.gavehcr )
        {
            self.player scripts\mp\utility\perk::removeperk( "specialty_bulletdamage" );
            self.gavehcr = 0;
        }

        self.player waittill( "weapon_change" );
    }

    thread stoppingpower_removehcr();
}

stoppingpower_watchhcrweaponfire()
{
    self endon( "stoppingPower_removeHCR" );
    self.player endon( "disconnect" );

    while ( self.player hasweapon( self.objweapon ) )
    {
        self.player waittill( "weapon_fired", var_0 );

        if ( _id_138E9( var_0 ) )
        {
            self.rounds--;

            if ( self.rounds <= 0 )
                break;
        }
    }

    self.player thread _id_138EF( self.objweapon );
    thread stoppingpower_removehcr();
}

_id_138EF( var_0 )
{
    self endon( "disconnect" );

    if ( !isdefined( self ) )
        return;

    var_1 = scripts\mp\utility\weapon::getweaponrootname( var_0 );

    if ( var_1 != "iw8_sn_crossbow" )
        return;

    self.waittill_unload_complete = 1;
    scripts\engine\utility::_id_143C0( 2, "weapon_fired", "weapon_change" );
    self.waittill_unload_complete = undefined;
}

stoppingpower_removehcr()
{
    self notify( "stoppingPower_removeHCR" );

    if ( isdefined( self.player ) )
    {
        if ( self.gavehcr )
            self.player scripts\mp\utility\perk::removeperk( "specialty_bulletdamage" );

        _id_138E1();
    }
}

_id_138EB()
{
    self notify( "stoppingPower_removeHCR" );

    if ( isdefined( self.player ) )
        _id_138E1();
}

_id_138E1()
{
    if ( isdefined( self.player.hcrdata ) )
    {
        var_0 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( self.objweapon );
        var_1 = self.player.hcrdata[var_0];

        if ( var_1 == self )
            self.player.hcrdata[var_0] = undefined;

        self.player scripts\cp\vehicles\vehicle_compass_cp::_id_12032( "super_support_box", self.kills );
        scripts\mp\analyticslog::logevent_fieldupgradeexpired( self.player, level.superglobals.staticsuperdata["super_support_box"].id, self.kills, 0 );
    }
}

_id_138EC( var_0 )
{
    if ( isdefined( var_0 ) )
    {
        var_1 = scripts\mp\utility\weapon::getcompleteweaponnamenoalt( var_0 );
        var_2 = self.hcrdata[var_1];

        if ( isdefined( var_2 ) )
        {
            scripts\mp\utility\stats::incpersstat( "stoppingPowerKills", 1 );
            scripts\mp\supers::combatrecordsuperkill( "super_support_box" );
            scripts\cp\vehicles\vehicle_compass_cp::_id_12094();
            var_2.kills++;
        }
    }
}

_id_138E9( var_0 )
{
    var_1 = self.player getammotype( self.objweapon );
    var_2 = self.player getammotype( var_0 );
    var_3 = var_1 == var_2;
    return isnullweapon( var_0, self.objweapon, 1 ) && var_3;
}

stoppingpower_clearhcrondeath()
{
    self.player endon( "disconnect" );
    self endon( "stoppingPower_removeHCR" );
    self.player waittill( "death" );
    thread stoppingpower_removehcr();
}

_id_138E2()
{
    self.player endon( "disconnect" );
    self endon( "stoppingPower_removeHCR" );
    level waittill( "game_ended" );
    thread stoppingpower_removehcr();
}

_id_138E3()
{
    self.player endon( "disconnect" );
    self endon( "stoppingPower_removeHCR" );
    self.player waittill( "all_perks_cleared" );
    thread _id_138EB();
}

stoppingpower_givefastreload()
{
    self.player endon( "death_or_disconnect" );
    self.player scripts\mp\utility\perk::giveperk( "specialty_fastreload" );
    self.player scripts\engine\utility::_id_143A6( "weapon_fired", "weapon_change", "stoppingPower_removeHCR" );
    self.player scripts\mp\utility\perk::removeperk( "specialty_fastreload" );
}

stoppingpower_breaksprint()
{
    self endon( "death_or_disconnect" );
    scripts\common\utility::allow_sprint( 0 );
    wait 0.4;
    scripts\common\utility::allow_sprint( 1 );
}
