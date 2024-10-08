// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.dangernotifyheight = getdvarint( "scr_br_danger_notify_height", 1000 );
    level.dangernotifyowner = getdvarint( "scr_br_danger_notify_owner", 1 );
}

playercanpickupkillstreak()
{
    return !isdefined( self.brkillstreak );
}

takekillstreakpickup( var_0 )
{
    var_1 = level.br_pickups.br_equipname[var_0.scriptablename];
    self.brkillstreak = var_1;
    playerkillstreakhud( var_1 );
    playergivetriggerweapon();
    thread playerhandlekillstreak( var_1 );
}

playerkillstreakhud( var_0 )
{
    self.brkillstreakhudlabel = scripts\mp\hud_util::createfontstring( "default", 0.75 );
    self.brkillstreakhudlabel scripts\mp\hud_util::setpoint( "CENTER", "BOTTOM LEFT", 270, -70 );
    self.brkillstreakhudlabel.label = &"MP_BR_ACTIVATE_KILLSTREAK";
    var_1 = game["killstreakTable"].tabledatabyref[var_0]["hudIcon"];
    self.brkillstreakhudicon = scripts\mp\hud_util::createicon( var_1, 30, 30 );
    self.brkillstreakhudicon scripts\mp\hud_util::setpoint( "CENTER", "BOTTOM LEFT", 270, -45 );
}

playergivetriggerweapon()
{
    self giveweapon( "super_default_mp" );
    self setweaponammoclip( "super_default_mp", 1 );
    self assignweaponoffhandspecial( "super_default_mp" );
}

playerhandlekillstreak( var_0 )
{
    self endon( "disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self waittill( "special_weapon_fired", var_1 );
        var_2 = playertriggerkillstreak();

        if ( var_2 )
        {
            playerremovekillstreak();
            return;
        }
        else
            self setweaponammoclip( "super_default_mp", 1 );
    }
}

playertriggerkillstreak()
{
    if ( !isalive( self ) )
        return 0;

    var_0 = scripts\mp\killstreaks\killstreaks::createstreakitemstruct( self.brkillstreak );
    var_1 = scripts\mp\killstreaks\killstreaks::triggerkillstreak( var_0 );
    return istrue( var_1 );
}

playerremovekillstreak()
{
    self takeweapon( "super_default_mp" );
    self.brkillstreak = undefined;

    if ( isdefined( self.brkillstreakhudlabel ) )
        self.brkillstreakhudlabel destroy();

    if ( isdefined( self.brkillstreakhudicon ) )
        self.brkillstreakhudicon destroy();
}

isbulletpenetration( var_0, var_1, var_2, var_3 )
{
    var_4 = scripts\common\utility::playersincylinder( var_0, var_1, undefined, level.dangernotifyheight );

    if ( !isdefined( var_3 ) )
        var_3 = 1;

    foreach ( var_8 in var_4 )
    {
        if ( isdefined( var_8 ) && scripts\mp\utility\player::isreallyalive( var_8 ) && ( var_8.team != self.team || level.dangernotifyowner && var_8 == self ) )
            isbrsquadleader( var_8, var_2, var_3 );
    }
}

isbrsquadleader( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( level.isbotpracticematch ) && isdefined( level.isbrgametypefuncdefined ) )
    {
        if ( isdefined( level.isbrgametypefuncdefined[var_1] ) && isdefined( level.isbrgametypefuncdefined[var_1][var_0.guid] ) && gettime() < level.isbrgametypefuncdefined[var_1][var_0.guid] )
            var_2 = 0;
        else
            level.isbrgametypefuncdefined[var_1][var_0.guid] = gettime() + level.isbotpracticematch * 1000;
    }

    if ( istrue( var_2 ) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue( var_1 ) )
    {
        var_4 = scripts\mp\gametypes\br_public.gsc::disableannouncer( self );
        var_5 = var_4 + "_enemy_" + var_1 + "_inbound";
        var_0 scripts\mp\utility\dialog::leaderdialogonplayer( var_5, "killstreak_used" );
    }

    var_6 = spawnstruct();
    var_6._id_12466 = istrue( var_2 );
    var_6._id_11ED2 = var_1;

    switch ( var_1 )
    {
        case "toma_strike":
            var_1 = 1;
            break;
        case "precision_airstrike":
            var_1 = 2;
            break;
        case "gulag_closed":
            var_1 = 3;
            break;
        case "cash_deploy_closed":
            var_1 = 4;
            break;
        case "respawn_disabled":
            var_1 = 5;
            break;
        case "lep_toma_strike":
            var_1 = 6;
            break;
        case "kenosha_strike":
            var_1 = 7;
            break;
        case "greenbay_strike":
            var_1 = 8;
            break;
        case "fafir_strike":
            var_1 = 9;
            break;
        default:
            var_1 = 0;
            break;
    }

    if ( var_1 > 0 )
    {
        var_0 setclientomnvar( "ui_br_danger_warning", var_1 );
        isbunkeraltenabled( var_0, var_3 );
    }

    var_0 scripts\mp\gametypes\br_gametypes.gsc::_id_12E05( "onKillstreakDanger", var_6 );
}

isbunkeraltenabled( var_0, var_1 )
{
    var_2 = var_0 getxuid();

    if ( !isdefined( var_1 ) )
        var_1 = 4;

    level notify( "danger_notify_start_" + var_2 );
    level thread _id_14499( var_0, var_2, "death_or_disconnect" );
    level thread _id_14499( var_0, var_2, undefined, var_1 );
}

_id_14499( var_0, var_1, var_2, var_3 )
{
    level endon( "danger_notify_start_" + var_1 );
    level endon( "danger_notify_finished_" + var_1 );
    level endon( "game_ended" );

    if ( isdefined( var_2 ) )
        var_0 waittill( var_2 );
    else if ( isdefined( var_3 ) )
        wait( var_3 );

    if ( isdefined( var_0 ) )
        var_0 setclientomnvar( "ui_br_danger_warning", 0 );

    level notify( "danger_notify_finished_" + var_1 );
}
