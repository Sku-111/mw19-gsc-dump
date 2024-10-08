// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

registercrankedtimerdvar( var_0, var_1 )
{
    scripts\mp\utility\dvars::registerwatchdvarint( "crankedBombTimer", var_1 );
}

setcrankeddvarfordev()
{

}

makeplayercranked( var_0 )
{
    scripts\mp\utility\dialog::leaderdialogonplayer( var_0 );
    setcrankedplayerbombtimer( "kill" );
    self.cranked = 1;
    scripts\mp\utility\perk::giveperk( "specialty_fastreload" );
    scripts\mp\utility\perk::giveperk( "specialty_quickdraw" );
    scripts\mp\utility\perk::giveperk( "specialty_fastoffhand" );
    scripts\mp\utility\perk::giveperk( "specialty_fastsprintrecovery" );
    scripts\mp\utility\perk::giveperk( "specialty_marathon" );
    scripts\mp\utility\perk::giveperk( "specialty_quickswap" );
    scripts\mp\utility\perk::giveperk( "specialty_stalker" );
    scripts\mp\utility\perk::giveperk( "specialty_sprintfire" );
    self.movespeedscaler = 1.2;
    scripts\mp\weapons::updatemovespeedscale();
}

oncranked( var_0, var_1, var_2 )
{
    if ( isdefined( var_0 ) )
        var_0 thread cleanupcrankedplayertimer();

    if ( isdefined( var_1.cranked ) )
    {
        var_3 = "kill_cranked";
        var_1 thread scripts\mp\rank::scoreeventpopup( "time_added" );
        var_1 thread oncrankedkill( var_3 );

        if ( !istrue( scripts\cp_mp\utility\game_utility::isrealismenabled() ) )
            var_1 playsoundtoplayer( "mp_cranked_splash", var_1 );
    }
    else if ( scripts\mp\utility\player::isreallyalive( var_1 ) )
    {
        var_1 makeplayercranked( "begin_cranked" );
        var_1 thread scripts\mp\rank::scoreeventpopup( "begin_cranked" );

        if ( !istrue( scripts\cp_mp\utility\game_utility::isrealismenabled() ) )
            var_1 playsoundtoplayer( "mp_cranked_start_splash", var_1 );
    }

    if ( isdefined( var_0 ) && isdefined( var_0.attackers ) && !isdefined( level.assists_disabled ) )
    {
        foreach ( var_5 in var_0.attackers )
        {
            if ( !isdefined( scripts\mp\utility\damage::_validateattacker( var_5 ) ) )
                continue;

            if ( var_5 == var_1 )
                continue;

            if ( var_0 == var_5 )
                continue;

            if ( !isdefined( var_5.cranked ) )
                continue;

            var_5 thread oncrankedassist( "assist_cranked" );
            var_5 thread scripts\mp\rank::scoreeventpopup( "assist_cranked" );
            var_5 thread scripts\mp\rank::scoreeventpopup( "time_added" );

            if ( !istrue( scripts\cp_mp\utility\game_utility::isrealismenabled() ) )
                var_5 playsoundtoplayer( "mp_cranked_splash", var_5 );
        }
    }
}

_id_1200C( var_0 )
{
    if ( self == var_0 )
        return;

    setcrankedplayerbombtimer( "hit" );
}

cleanupcrankedplayertimer()
{
    self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
    self.cranked = undefined;
    self.cranked_end_time = undefined;
    thread waitthenstopcrankedbombtimer();
}

waitthenstopcrankedbombtimer()
{
    waitframe();
    self notify( "stop_cranked" );
}

oncrankedkill( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );

    while ( !isdefined( self.pers ) )
        waitframe();

    setcrankedplayerbombtimer( "kill" );
}

oncrankedassist( var_0 )
{
    level endon( "game_ended" );
    self endon( "disconnect" );
    setcrankedplayerbombtimer( "assist" );
}

setcrankedplayerbombtimer( var_0 )
{
    var_1 = level.crankedbombtimer;
    var_2 = 0;

    if ( scripts\mp\utility\game::getgametype() == "conf" || scripts\mp\utility\game::getgametype() == "grind" )
        var_2 = 1;

    if ( var_0 == "hit" )
    {
        var_1 = int( ( self.cranked_end_time - gettime() ) / 1000 + 1 );

        if ( var_1 > level.crankedbombtimer )
            var_1 = level.crankedbombtimer;
    }
    else if ( var_0 == "assist" )
    {
        if ( var_2 )
            var_1 = int( min( ( self.cranked_end_time - gettime() ) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer ) );
        else
            var_1 = int( min( ( self.cranked_end_time - gettime() ) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer ) );
    }
    else if ( var_0 == "friendly_tag" )
        var_1 = int( min( ( self.cranked_end_time - gettime() ) / 1000 + level.crankedbombtimer * 0.25, level.crankedbombtimer ) );
    else if ( var_2 )
    {
        if ( isdefined( self.cranked ) && self.cranked && isdefined( self.cranked_end_time ) )
            var_1 = int( min( ( self.cranked_end_time - gettime() ) / 1000 + level.crankedbombtimer * 0.5, level.crankedbombtimer ) );
        else
            var_1 = int( var_1 * 0.5 );
    }
    else
        var_1 = level.crankedbombtimer;

    var_3 = var_1 * 1000 + gettime();
    self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", var_3 );
    self.cranked_end_time = var_3;
    thread watchcrankedplayerhostmigration();
    thread watchcrankedbombtimer( var_1 );
    thread watchcrankedendgame();
}

watchcrankedplayerhostmigration()
{
    self notify( "watchCrankedHostMigration" );
    self endon( "watchCrankedHostMigration" );
    level endon( "game_ended" );
    self endon( "death_or_disconnect" );
    self endon( "stop_cranked" );
    level waittill( "host_migration_begin" );
    var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();

    if ( var_0 > 0 )
        self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time + var_0 );
    else
        self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", self.cranked_end_time );
}

watchcrankedendgame()
{
    self notify( "watchEndGame" );
    self endon( "watchEndGame" );
    self endon( "death_or_disconnect" );
    self endon( "stop_cranked" );

    for (;;)
    {
        if ( game["state"] == "postgame" || level.gameended )
        {
            self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );
            break;
        }

        wait 0.1;
    }
}

watchcrankedbombtimer( var_0 )
{
    self notify( "watchBombTimer" );
    self endon( "watchBombTimer" );
    self endon( "disconnect" );
    level endon( "game_ended" );
    self endon( "stop_cranked" );
    thread infectparachuteheightoffset( var_0 );
    var_1 = 5;
    var_2 = var_0 - var_1 - 1;

    if ( var_2 > 0 )
    {
        scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate( var_2 );
        scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate( 1.0 );
    }

    while ( var_1 > 0 )
    {
        self playsoundtoplayer( "ui_mp_cranked_timer", self );
        scripts\mp\hostmigration::waitlongdurationwithgameendtimeupdate( 1.0 );
        var_1--;
    }

    if ( isdefined( self ) && scripts\mp\utility\player::isreallyalive( self ) && scripts\mp\utility\game::getgametype() != "tdef" )
    {
        self playsound( "vest_expl_trans" );
        var_3 = self.origin + ( 0, 0, 32 );
        playfx( level._effect["cranked_explode"], var_3 );
        scripts\mp\utility\damage::_suicide();
        self radiusdamage( var_3, 256, 200, 100, self, "MOD_EXPLOSIVE", "bomb_site_mp" );
        self setclientomnvar( "ui_cranked_bomb_timer_end_milliseconds", 0 );

        if ( scripts\cp_mp\utility\player_utility::_isalive() )
            self dodamage( self.maxhealth, var_3, self, undefined, "MOD_EXPLOSIVE", "bomb_site_mp" );
    }
}

infectparachuteheightoffset( var_0 )
{
    self endon( "death" );
    self notify( "refreshCrankedUIProgress" );
    self endon( "refreshCrankedUIProgress" );
    var_1 = 0;
    var_2 = 0;

    if ( var_0 != level.crankedbombtimer )
        var_1 = level.crankedbombtimer - var_0;

    while ( isalive( self ) )
    {
        var_1 = var_1 + 0.05;
        var_3 = clamp( 1.0 - var_1 / level.crankedbombtimer, 0.0, 1.0 );
        self setclientomnvar( "ui_cranked_bomb_timer", var_3 );
        wait 0.05;
    }
}