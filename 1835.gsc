// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{

}

adddeathicon( var_0, var_1, var_2, var_3, var_4 )
{
    var_2 endon( "disconnect" );

    if ( istrue( var_2._id_133CB ) )
        return;

    if ( !level.teambased )
        return;

    if ( getdvar( "ui_hud_showdeathicons" ) == "0" )
        return;

    if ( level.hardcoremode )
        return;

    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
        return;

    if ( istrue( var_2 scripts\mp\gametypes\br_public.gsc::isplayeringulag() ) )
        return;

    var_5 = scripts\mp\utility\game::getgametype() == "br";
    var_6 = scripts\mp\utility\game::getgametype() == "brtdm";
    var_7 = var_0 scripts\mp\utility\perk::_hasperk( "specialty_silentkill" );

    if ( !var_5 && var_7 )
        return;

    var_8 = var_1.origin;
    var_8 = var_8 + ( 0, 0, 40 );
    var_2 notify( "addDeathIcon()" );
    var_2 endon( "addDeathIcon()" );

    if ( isdefined( var_2.waittill_usebutton_released_or_time_or_bomb_planted ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var_2.waittill_usebutton_released_or_time_or_bomb_planted );
        var_2.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
    }

    var_2 notify( "removed_death_icon" );
    var_9 = "hud_icon_death_spawn";
    var_10 = var_3;

    if ( var_5 )
    {
        var_11 = scripts\engine\utility::ter_op( isdefined( var_2.pers["squadMemberIndex"] ), var_2.pers["squadMemberIndex"], 0 );
        var_9 = "hud_icon_death_player" + var_11;

        if ( var_7 )
            var_10 = [ var_2 ];
        else if ( scripts\mp\menus::brking_updateteamscore() )
            var_10 = level.squaddata[var_3][var_2.squadindex].players;
        else
            var_10 = scripts\mp\utility\teams::getteamdata( var_2.team, "players" );
    }
    else if ( var_6 )
    {
        if ( var_7 )
            var_10 = [ var_2 ];
        else
            var_10 = scripts\mp\utility\teams::getteamdata( var_2.team, "players" );
    }

    var_12 = var_2.origin;
    var_13 = var_5;
    var_14 = var_5;
    var_2.waittill_usebutton_released_or_time_or_bomb_planted = var_2 scripts\cp_mp\entityheadicons::setheadicon_singleimage( var_10, var_9, undefined, 1, 0, 0, undefined, undefined, var_13, var_12, var_14 );

    if ( isdefined( var_2.waittill_usebutton_released_or_time_or_bomb_planted ) )
    {
        if ( var_5 || var_6 )
            var_2 thread setupminimapmaze( var_7 );
        else
            var_2 thread destroyslowly( var_4 );
    }
}

setupminimapmaze( var_0 )
{
    self endon( "removed_death_icon" );
    var_1 = self.team;
    var_2 = self.waittill_usebutton_released_or_time_or_bomb_planted;

    if ( !var_0 )
        setup_train_entarray_composite( var_2, var_1 );

    if ( isdefined( self ) )
        setupdamage();

    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var_2 );

    if ( isdefined( self ) )
        self.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
}

setup_train_entarray_composite( var_0, var_1 )
{
    var_2 = getdvarfloat( "death_icon_teammate_duration", 10.0 );
    var_3 = getdvarfloat( "death_icon_squadmate_duration_bonus", 0.0 );
    wait( var_2 );
    var_4 = scripts\mp\utility\teams::getfriendlyplayers( var_1 );

    foreach ( var_6 in var_4 )
    {
        if ( !isdefined( var_6 ) )
            continue;

        if ( var_3 > 0 )
        {
            if ( isdefined( self.squadindex ) && isdefined( var_6.squadindex ) && self.squadindex == var_6.squadindex )
                continue;
        }

        if ( isdefined( self ) && var_6 == self )
            continue;

        scripts\cp_mp\entityheadicons::_id_1315E( var_0, var_6 );
    }

    if ( var_3 > 0 )
    {
        wait( var_3 );
        var_4 = scripts\mp\utility\teams::getfriendlyplayers( var_1 );

        foreach ( var_6 in var_4 )
        {
            if ( !isdefined( var_6 ) )
                continue;

            if ( isdefined( self.squadindex ) && isdefined( var_6.squadindex ) && self.squadindex != var_6.squadindex )
                continue;

            if ( isdefined( self ) && var_6 == self )
                continue;

            scripts\cp_mp\entityheadicons::_id_1315E( var_0, var_6 );
        }
    }
}

setupdamage()
{
    if ( !scripts\mp\gametypes\br_public.gsc::isplayeringulag() )
    {
        var_0 = getdvarfloat( "death_icon_owner_duration", 15.0 );

        if ( !scripts\mp\utility\player::isreallyalive( self ) )
            self waittill( "spawned_player" );
        else
        {
            var_1 = gettime() - self.lastspawntime;
            var_0 = var_0 - var_1 / 1000;
        }

        if ( var_0 > 0 )
            wait( var_0 );
    }
}

destroyslowly( var_0 )
{
    self endon( "removed_death_icon" );
    var_1 = self;
    var_2 = self.waittill_usebutton_released_or_time_or_bomb_planted;
    wait( var_0 );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var_2 );

    if ( isdefined( var_1 ) )
        var_1.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
}

spawn_carriables_from_prefabs_all( var_0 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0.waittill_usebutton_released_or_time_or_bomb_planted ) )
        return;

    scripts\cp_mp\entityheadicons::_id_1315E( var_0.waittill_usebutton_released_or_time_or_bomb_planted, var_0 );
}

_id_12C01( var_0 )
{
    if ( !isdefined( var_0 ) || !isdefined( var_0.waittill_usebutton_released_or_time_or_bomb_planted ) )
        return;

    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var_0.waittill_usebutton_released_or_time_or_bomb_planted );
    var_0.waittill_usebutton_released_or_time_or_bomb_planted = undefined;
    var_0 notify( "removed_death_icon" );
}

_id_12BFD()
{
    foreach ( var_1 in level.players )
        _id_12C01( var_1 );
}

addenemydeathicon( var_0, var_1, var_2, var_3, var_4 )
{
    var_1 endon( "disconnect" );

    if ( !level.teambased )
        return;

    if ( istrue( var_1 scripts\mp\gametypes\br_public.gsc::isplayeringulag() ) )
        return;

    var_5 = var_0.origin;
    var_5 = var_5 + ( 0, 0, 40 );
    var_1 notify( "addDeathIcon()" );
    var_1 endon( "addDeathIcon()" );

    if ( !var_4 )
    {
        if ( getdvar( "ui_hud_showdeathicons" ) == "0" )
            return;

        if ( level.hardcoremode )
            return;
    }

    if ( isdefined( var_1.waittill_vo_plays ) )
    {
        scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var_1.waittill_vo_plays );
        var_1.waittill_vo_plays = undefined;
    }

    var_1 notify( "removed_enemy_death_icon" );

    if ( scripts\cp_mp\utility\game_utility::isrealismenabled() )
    {
        var_6 = "hud_realism_head_death";
        var_7 = 0;
        var_8 = 768;
        var_9 = 10;
    }
    else
    {
        var_6 = "hud_icon_death_hunter_spawn";
        var_7 = 1;
        var_8 = 768;
        var_9 = 0;
    }

    var_10 = var_1.origin;
    var_1.waittill_vo_plays = var_1 scripts\cp_mp\entityheadicons::setheadicon_singleimage( var_2, var_6, undefined, var_7, var_8, var_9, undefined, undefined, undefined, var_10 );

    if ( isdefined( var_1.waittill_vo_plays ) )
        var_1 thread destroyenemyiconslowly( var_3 );
}

destroyenemyiconslowly( var_0 )
{
    self endon( "removed_enemy_death_icon" );
    var_1 = self;
    var_2 = self.waittill_vo_plays;
    wait( var_0 );
    scripts\cp_mp\entityheadicons::setheadicon_deleteicon( var_2 );

    if ( isdefined( var_1 ) )
        var_1.waittill_vo_plays = undefined;
}
