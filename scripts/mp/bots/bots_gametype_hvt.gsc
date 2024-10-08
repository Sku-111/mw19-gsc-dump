// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_hvt();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_hvt_think;
}

setup_bot_hvt()
{

}

bot_hvt_think()
{
    self notify( "bot_hvt_think" );
    self endon( "bot_hvt_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}
