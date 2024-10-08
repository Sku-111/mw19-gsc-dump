// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

equipmentinteract_init()
{
    level.useobjs = [];
    scripts\engine\scriptable::_id_12F5B( "hack_usable", ::numrequireddestinations );
    thread _updateuseobjs();
}

numrequireddestinations( var_0, var_1, var_2, var_3, var_4 )
{
    numsiegeflags( var_0.entity, var_3 );
}

numsiegeflags( var_0, var_1 )
{
    var_2 = var_0;
    var_2.isbeingused = 1;

    if ( isdefined( var_1 ) )
    {
        var_1.iscapturingcrate = 0;
        var_1.ishacking = 1;
        var_1 thread _deployhacktablet( var_2, 0 );
    }
}

_updateuseobjs()
{
    level endon( "game_ended" );

    for (;;)
    {
        wait 0.2;

        foreach ( var_1 in level.useobjs )
        {
            if ( !isdefined( var_1 ) )
                continue;

            var_2 = scripts\common\utility::playersnear( var_1.origin, 300 );

            foreach ( var_4 in var_2 )
            {
                if ( !istrue( scripts\cp_mp\utility\player_utility::playersareenemies( var_4, var_1.owner ) ) || istrue( var_1.isbeingused ) || !var_4 scripts\mp\utility\perk::_hasperk( "specialty_hack" ) || var_4 scripts\cp_mp\emp_debuff::is_empd() || level.gameended )
                {
                    var_1 disablescriptableplayeruse( var_4 );
                    continue;
                }

                var_1 enablescriptableplayeruse( var_4 );
            }
        }
    }
}

remoteinteractsetup( var_0, var_1, var_2 )
{
    if ( isdefined( var_2 ) || var_2 )
        thread _hacksetup( var_0 );
}

_hacksetup( var_0 )
{
    level.useobjs[self getentitynumber()] = self;
    self setscriptablepartstate( "hack_usable", "on" );

    foreach ( var_2 in level.players )
        self disablescriptableplayeruse( var_2 );
}

_processusethink( var_0 )
{
    level endon( "game_ended" );
    var_0 endon( "death" );
    var_0 endon( "mine_triggered" );
    self endon( "death_or_disconnect" );
    self endon( "emp_started" );
    var_1 = ( getdvarfloat( "perk_hack_equipment_time", 3.0 ) - getdvarfloat( "perk_hack_equipment_success_time", 0.5 ) ) * 1000;
    var_2 = gettime() + var_1;

    while ( var_2 > gettime() )
    {
        if ( !self usebuttonpressed() )
            return 0;

        waitframe();
    }

    return 1;
}

_startusethink( var_0, var_1 )
{
    var_0.isbeingused = 1;
    self.iscapturingcrate = 1;
    self.ishacking = 1;
    var_1.interactstate = 0;
    self notify( "interact_started" );
    var_2 = istrue( _processusethink( var_0 ) );

    if ( var_2 )
        var_1.interactstate = 2;
    else
        self notify( "interact_cancelled" );

    self notify( "interact_finished" );

    if ( isdefined( var_0 ) )
        var_0.isbeingused = 0;

    if ( isdefined( self ) )
    {
        self.iscapturingcrate = 0;
        self.ishacking = undefined;

        if ( !istrue( var_2 ) )
            return;

        if ( isdefined( var_0 ) )
            var_0 scripts\mp\equipment::hackequipment( self );
    }
}

_deployhacktablet( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_2 = getcompleteweaponname( "ks_remote_hack_mp" );
    var_3 = scripts\cp_mp\utility\killstreak_utility::createstreakinfo( "", self );
    var_3.interactstate = var_1;
    thread _updatehackomnvars( var_0, var_1 );
    var_4 = scripts\cp_mp\killstreaks\killstreakdeploy::switchtodeployweapon( var_2, var_3, ::_waituntilinteractfinished, ::allowednormaldemeanor, undefined, undefined, ::_ontabletputaway );

    if ( istrue( var_4 ) && isdefined( var_0 ) )
        thread _startusethink( var_0, var_3 );
    else
    {
        self notify( "interact_cancelled" );

        if ( isdefined( var_0 ) )
            var_0.isbeingused = 0;
    }
}

_updatehackomnvars( var_0, var_1 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    var_2 = -1;

    if ( isdefined( var_0.equipmentref ) )
        var_2 = scripts\mp\equipment::getequipmenttableinfo( var_0.equipmentref ).id;
    else if ( isdefined( var_0.streakinfo ) )
    {
        var_2 = scripts\mp\utility\killstreak::getkillstreakindex( var_0.streakinfo.streakname );
        var_2 = var_2 + 100;
    }

    self setclientomnvar( "ui_hack_index", var_2 );
    self playlocalsound( "iw8_eod_tablet_ui" );
    _updatehackprogressomnvar( var_0 );

    if ( var_1 == 2 )
    {
        self setclientomnvar( "ui_hack_progress", 1 );
        var_3 = getdvarfloat( "perk_hack_equipment_success_time", 0.5 );
        wait( var_3 );
    }
    else
    {
        self stoplocalsound( "iw8_eod_tablet_ui" );
        self setclientomnvar( "ui_hack_progress", 0 );
    }

    wait 0.1;
    self setclientomnvar( "ui_hack_index", 0 );
}

_updatehackprogressomnvar( var_0 )
{
    self endon( "interact_cancelled" );
    self waittill( "interact_started" );
    var_1 = 1000.0;
    var_2 = 500.0;
    var_3 = getdvarfloat( "perk_hack_equipment_time", 3.0 ) * 1000;
    var_4 = getdvarfloat( "perk_hack_equipment_success_time", 0.5 ) * 1000;
    var_5 = var_3 - var_1 - var_4;
    var_6 = gettime() + var_3 + var_2;
    var_7 = gettime() + var_1;

    for (;;)
    {
        var_8 = ( gettime() - var_7 ) / var_5;
        var_8 = clamp( var_8, 0, 1 );
        self setclientomnvar( "ui_hack_progress", var_8 );
        wait 0.05;

        if ( gettime() > var_6 )
            break;
    }
}

allowednormaldemeanor( var_0, var_1 )
{
    _toggletabletallows( 1 );
    thread addtolittlebirdmglist();
    thread addspecialistbonus( var_0 );
    return 1;
}

addspecialistbonus( var_0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    var_0 endon( "deploy_weapon_switch_ended" );

    for (;;)
    {
        if ( !self usebuttonpressed() )
            break;

        waitframe();
    }

    self notify( "cancel_all_killstreak_deployments" );
}

_ontabletputaway( var_0 )
{
    self notify( "tabletPutAway" );
}

_waituntilinteractfinished( var_0 )
{
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "interact_cancelled" );

    if ( var_0.interactstate != 0 )
        return;

    self waittill( "interact_finished" );

    if ( var_0.interactstate == 2 )
    {
        var_1 = getdvarfloat( "perk_hack_equipment_success_time", 0.5 );
        wait( var_1 );
    }
}

addtolittlebirdmglist()
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    scripts\engine\utility::_id_143A5( "death", "tabletPutAway" );
    _toggletabletallows( 0 );
}

_toggletabletallows( var_0 )
{
    scripts\mp\utility\player::_freezelookcontrols( var_0 );

    if ( isalive( self ) )
    {
        scripts\common\utility::allow_movement( !var_0 );
        scripts\common\utility::allow_jump( !var_0 );
        scripts\common\utility::allow_usability( !var_0 );
        scripts\common\utility::allow_melee( !var_0 );
        scripts\common\utility::allow_offhand_weapons( !var_0 );
    }
}
