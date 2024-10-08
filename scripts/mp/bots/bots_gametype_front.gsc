// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_front();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_front_think;
}

setup_bot_front()
{

}

bot_front_think()
{
    self notify( "bot_front_think" );
    self endon( "bot_front_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );

    for (;;)
    {
        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}
