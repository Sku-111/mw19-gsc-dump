// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    level.playerframeupdatecallbacks = [];
    level thread runupdates();
}

runupdates()
{
    level endon( "game_ended" );
    scripts\mp\flags::gameflagwait( "prematch_done" );

    for (;;)
    {
        foreach ( var_1 in level.players )
        {
            foreach ( var_3 in level.playerframeupdatecallbacks )
                var_1 [[ var_3 ]]();
        }

        waitframe();
    }
}

registerplayerframeupdatecallback( var_0 )
{
    level.playerframeupdatecallbacks[level.playerframeupdatecallbacks.size] = var_0;
}
