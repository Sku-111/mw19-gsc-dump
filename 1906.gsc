// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

secrethunt( var_0 )
{
    while ( !istrue( game["gamestarted"] ) )
        waitframe();

    var_1 = getentarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        var_3 thread trackhiddenobj( var_1.size );
}

trackhiddenobj( var_0 )
{
    level endon( "game_ended" );
    self setcandamage( 1 );
    self.found = [];

    for (;;)
    {
        self waittill( "damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14 );

        if ( isdefined( var_10 ) )
        {
            if ( var_5 == "MOD_EXPLOSIVE" || var_5 == "MOD_GRENADE_SPLASH" )
                continue;
        }
        else if ( isdefined( var_14.streakinfo ) && scripts\mp\utility\killstreak::iskillstreak( var_14.streakinfo.streakname ) )
        {
            self.health = 5;
            continue;
        }

        if ( !isdefined( self.found[var_2.guid] ) )
        {
            self.found[var_2.guid] = 1;

            if ( !isdefined( var_2.hiddenobjcount ) )
                var_2.hiddenobjcount = 1;
            else
                var_2.hiddenobjcount++;

            iprintln( "Secret objects found: " + var_2.hiddenobjcount + " of " + var_0 );
        }

        if ( self.health <= 0 )
            break;
    }

    self delete();
}

secrethunt_debuglocations()
{
    level endon( "game_ended" );
    self endon( "death" );

    for (;;)
    {
        if ( getdvarint( "scr_debugSecretHunt", 0 ) == 1 )
        {
            self hudoutlineenable( "outlinefill_nodepth_green" );
            self.outlined = 1;
        }
        else if ( istrue( self.outlined ) )
        {
            self hudoutlinedisable();
            self.outlined = 0;
        }

        wait 1.0;
    }
}
