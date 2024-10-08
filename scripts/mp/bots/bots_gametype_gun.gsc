// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

main()
{
    setup_callbacks();
    setup_bot_gun();
}

setup_callbacks()
{
    level.bot_funcs["gametype_think"] = ::bot_gun_think;
}

setup_bot_gun()
{

}

data_pickup_logic( var_0, var_1 )
{
    if ( isdefined( var_0 ) && var_0 != "none" )
    {
        var_2 = scripts\mp\utility\weapon::getweaponrootname( var_0 );
        var_3 = level.bot_weap_personality[var_2];
        var_4 = strtok( var_3, "| " );
        var_5 = weaponclass( var_0 );

        if ( var_5 == "pistol" )
            var_4 = [ "cqb", "run_and_gun" ];

        if ( var_4.size > 0 )
        {
            var_6 = undefined;

            if ( scripts\engine\utility::array_contains( var_4, var_1 ) )
                var_6 = var_1;
            else
                var_6 = scripts\engine\utility::random( var_4 );

            if ( self.personality != var_6 )
                scripts\mp\bots\bots_util::bot_set_personality( var_6 );
        }
    }
}

bot_gun_think()
{
    self notify( "bot_gun_think" );
    self endon( "bot_gun_think" );
    self endon( "death_or_disconnect" );
    level endon( "game_ended" );
    var_0 = self botgetdifficultysetting( "throwKnifeChance" );

    if ( var_0 < 0.25 )
        self botsetdifficultysetting( "throwKnifeChance", 0.25 );

    self botsetdifficultysetting( "allowGrenades", 1 );
    var_1 = "";
    var_2 = self.personality;
    wait 0.1;

    for (;;)
    {
        var_3 = self getcurrentweapon();

        if ( var_3.basename != "none" && !scripts\mp\utility\weapon::iskillstreakweapon( var_3 ) && var_3.basename != var_1 && !scripts\mp\utility\weapon::update_health_bar_to_player( var_3 ) )
        {
            var_1 = var_3.basename;

            if ( self botgetdifficultysetting( "advancedPersonality" ) && self botgetdifficultysetting( "strategyLevel" ) > 0 )
                data_pickup_logic( var_3.basename, var_2 );
        }

        self [[ self.personality_update_function ]]();
        wait 0.05;
    }
}