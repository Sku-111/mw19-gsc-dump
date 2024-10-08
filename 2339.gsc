// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "death_switch", ::tryusedeathswitchfromstruct );
    level.killstreak_laststand_func = ::deathswitch_startpayloadreleasesequence;
}

tryusedeathswitch()
{
    var_0 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "death_switch", self );
    return tryusedeathswitchfromstruct( var_0 );
}

tryusedeathswitchfromstruct( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( var_0 ) )
            return 0;
    }

    level thread scripts\mp\battlechatter_mp::trysaylocalsound( self, "use_killstreak_deadman" );
    var_1 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dogesturedeploy( var_0, getcompleteweaponname( "ks_gesture_vest_mp" ) );

    if ( !istrue( var_1 ) )
        return 0;

    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( var_0 ) )
            return 0;
    }

    scripts\cp_mp\utility\killstreak_utility::playkillstreakoperatordialog( "use_" + var_0.streakname, 1 );
    scripts\common\utility::_id_13E0A( level._id_11B2A, "death_switch", self.origin );
    thread scripts\mp\hud_util::teamplayercardsplash( "used_death_switch", self );
    thread startdeathswitch( var_0 );
    return 1;
}

weapongivendeathswitch( var_0 )
{
    return 1;
}

startdeathswitch( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self iprintlnbold( "If I go down, I'm taking them with me!" );
    scripts\mp\utility\perk::giveperk( "specialty_pistoldeath" );
    self.killstreaklaststand = 1;
    self.deathswitchent = spawn( "script_model", self gettagorigin( "j_helmet" ) );
    self.deathswitchent setmodel( "ks_death_switch_mp" );
    self.deathswitchent.angles = self.angles;
    self.deathswitchent linkto( self, "j_helmet", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    thread deathswitch_loopblinkinglight();
}

deathswitch_loopblinkinglight()
{
    self endon( "disconnect" );
    self endon( "deathSwitch_release" );

    for (;;)
    {
        self.deathswitchent setscriptablepartstate( "blinking_light", "on", 0 );
        wait 0.5;
        self.deathswitchent setscriptablepartstate( "blinking_light", "off", 0 );
    }
}

debugloc()
{
    self endon( "death" );

    for (;;)
        waitframe();
}

deathswitch_startpayloadreleasesequence()
{
    var_0 = "iw8_fists_mp_ls";
    scripts\cp_mp\utility\inventory_utility::_giveweapon( var_0, undefined, undefined, 1 );
    thread scripts\mp\laststand::switchtofists( var_0 );
    self.laststandactionset = "laststand_killstreak";
    scripts\mp\playeractions::allowactionset( self.laststandactionset, 0 );
    thread deathswitch_payloadrelease( 3 );
    thread deathswitch_watchbleedout( 3 );
}

deathswitch_payloadrelease( var_0 )
{
    self endon( "payload_release" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    var_1 = 1;
    var_2 = scripts\mp\utility\weapon::_launchgrenade( "death_switch_blast_mp", self gettagorigin( "j_mainroot" ), ( 0, 0, 0 ), var_0, 1 );
    var_2 linkto( self );
    thread deathswitch_payloadreleaseondeath( var_1, var_2 );
    var_3 = 1;

    while ( var_0 > 0 )
    {
        self iprintlnbold( "Death Switch Countdown: " + var_0 );
        var_0 = var_0 - var_3;
        playsoundatpos( self.origin, "death_switch_beep" );
        wait( var_3 );
        var_3 = var_3 - 0.2;

        if ( var_3 < 0.05 )
            var_3 = 0.05;
    }

    deathswitch_payloadreleasetype( var_1, var_2 );
}

deathswitch_payloadreleaseondeath( var_0, var_1 )
{
    self endon( "payload_release" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "watch_switch_on_death" );
    self endon( "watch_switch_on_death" );
    self waittill( "death" );
    deathswitch_payloadreleasetype( var_0, var_1 );
}

deathswitch_payloadreleasetype( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
        var_1 delete();

    switch ( var_0 )
    {
        case 0:
            thread deathswitch_releaselocalexplosion();
            break;
        case 1:
            thread deathswitch_releaseartilleryexplosion();
            break;
        default:
            break;
    }

    self.killstreaklaststand = undefined;
    scripts\mp\utility\perk::removeperk( "specialty_pistoldeath" );
    self notify( "payload_release" );
}

deathswitch_releaselocalexplosion()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "deathSwitch_release" );
    self.deathswitchent setscriptablepartstate( "blinking_light", "off", 0 );
    self.deathswitchent setscriptablepartstate( "explode", "on", 0 );
    self.deathswitchent setentityowner( self );
    self.deathswitchent thread scripts\mp\utility\script::delayentdelete( 5 );
}

deathswitch_releaseartilleryexplosion()
{
    self endon( "disconnect" );
    level endon( "game_ended" );
    self notify( "deathSwitch_release" );
    var_0 = self.origin + ( 0, 0, 20000 );
    var_1 = self.origin;
    var_2 = scripts\cp_mp\utility\weapon_utility::_magicbullet( getcompleteweaponname( "death_switch_proj_mp" ), var_0, var_1, self );
    self.deathswitchent setscriptablepartstate( "blinking_light", "off", 0 );
    self.deathswitchent thread scripts\mp\utility\script::delayentdelete( 5 );
}

deathswitch_watchbleedout( var_0 )
{
    level endon( "game_ended" );
    level endon( "death_or_disconnect" );
    scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause( var_0 );
    scripts\mp\utility\damage::_suicide();
}
