// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

hostmigration_waitlongdurationwithpause( var_0 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hostmigration", "waitLongDurationWithPause" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hostmigration", "waitLongDurationWithPause" ) ]]( var_0 );
    else
        wait( var_0 );
}

hostmigration_waittillnotifyortimeoutpause( var_0, var_1 )
{
    if ( scripts\cp_mp\utility\script_utility::issharedfuncdefined( "hostmigration", "waittillNotifyOrTimeoutPause" ) )
        [[ scripts\cp_mp\utility\script_utility::getsharedfunc( "hostmigration", "waittillNotifyOrTimeoutPause" ) ]]( var_0, var_1 );
    else
        scripts\engine\utility::_id_143B9( var_1, var_0 );
}