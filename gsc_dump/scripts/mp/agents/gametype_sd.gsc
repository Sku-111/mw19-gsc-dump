// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
}

setup_callbacks()
{
    level.agent_funcs["player"]["think"] = ::agent_player_sd_think;
}

agent_player_sd_think()
{
    scripts\common\utility::allow_usability( 1 );
    thread scripts\mp\bots\bots_gametype_sd.gsc::bot_sd_think();
}
