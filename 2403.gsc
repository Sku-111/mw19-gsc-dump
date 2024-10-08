// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

onplayerjointeam( var_0 )
{
    thread _id_1206F( var_0 );

    if ( isdefined( level.onjointeamcallbacks ) )
    {
        foreach ( var_2 in level.onjointeamcallbacks )
            self [[ var_2 ]]( var_0 );
    }
}

registeronplayerjointeamcallback( var_0 )
{
    if ( !isdefined( level.onjointeamcallbacks ) )
        level.onjointeamcallbacks = [];

    level.onjointeamcallbacks[level.onjointeamcallbacks.size] = var_0;
}

_id_1206F( var_0 )
{
    var_0 notify( "onPlayerJoinTeamNoSpectator" );

    if ( var_0.sessionstate == "spectator" )
    {
        var_0 endon( "death_or_disconnect" );
        var_0 endon( "onPlayerJoinTeamNoSpectator" );

        while ( var_0.sessionstate == "spectator" )
            waitframe();
    }

    if ( isdefined( level._id_12045 ) )
    {
        foreach ( var_2 in level._id_12045 )
            self [[ var_2 ]]( var_0 );
    }
}

_id_12B2F( var_0 )
{
    if ( !isdefined( level._id_12045 ) )
        level._id_12045 = [];

    level._id_12045[level._id_12045.size] = var_0;
}
