// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

setmodelfromarray( var_0 )
{
    if ( !scripts\common\utility::issp() )
        self setmodel( var_0[randomint( var_0.size )] );
    else
    {
        if ( !isdefined( level.character_model_cache ) )
            level.character_model_cache = [];

        var_1 = get_least_used_model( var_0 );

        if ( !isdefined( var_1 ) )
            var_1 = var_0[randomint( var_0.size )];

        level.character_model_cache["last_used"] = var_1;
        level.character_model_cache[var_1]++;
        self setmodel( var_1 );
    }
}

get_least_used_model( var_0 )
{
    var_1 = [];
    var_2 = 999999;
    var_1[0] = 0;

    for ( var_3 = 0; var_3 < var_0.size; var_3++ )
    {
        if ( !isdefined( level.character_model_cache[var_0[var_3]] ) )
            level.character_model_cache[var_0[var_3]] = 0;

        var_4 = level.character_model_cache[var_0[var_3]];

        if ( var_4 > var_2 )
            continue;

        if ( var_4 < var_2 )
        {
            var_1 = [];
            var_2 = var_4;
        }

        var_1[var_1.size] = var_3;
    }

    var_5 = random( var_1 );
    return var_0[var_5];
}

precachemodelarray( var_0 )
{
    for ( var_1 = 0; var_1 < var_0.size; var_1++ )
        precachemodel( var_0[var_1] );
}

attachhead( var_0, var_1 )
{
    if ( !isdefined( level.character_head_index ) )
        level.character_head_index = [];

    if ( !isdefined( level.character_head_index[var_0] ) )
        level.character_head_index[var_0] = randomint( var_1.size );

    var_2 = ( level.character_head_index[var_0] + 1 ) % var_1.size;

    if ( isdefined( self.script_char_index ) )
        var_2 = self.script_char_index % var_1.size;

    level.character_head_index[var_0] = var_2;
    self attach( var_1[var_2], "", 1 );
    self.headmodel = var_1[var_2];
}

attachhat( var_0, var_1 )
{
    if ( !isdefined( level.character_hat_index ) )
        level.character_hat_index = [];

    if ( !isdefined( level.character_hat_index[var_0] ) )
        level.character_hat_index[var_0] = randomint( var_1.size );

    var_2 = ( level.character_hat_index[var_0] + 1 ) % var_1.size;
    level.character_hat_index[var_0] = var_2;
    self attach( var_1[var_2] );
    self.hatmodel = var_1[var_2];
}

new()
{
    self detachall();
    var_0 = self.anim_gunhand;

    if ( !isdefined( var_0 ) )
        return;

    self.anim_gunhand = "none";
    self [[ anim.putguninhand ]]( var_0 );
}

save()
{
    var_0["gunHand"] = self.anim_gunhand;
    var_0["gunInHand"] = self.anim_guninhand;
    var_0["model"] = self.model;
    var_0["hatModel"] = self.hatmodel;

    if ( isdefined( self.name ) )
        var_0["name"] = self.name;
    else
    {

    }

    var_1 = self getattachsize();

    for ( var_2 = 0; var_2 < var_1; var_2++ )
    {
        var_0["attach"][var_2]["model"] = self getattachmodelname( var_2 );
        var_0["attach"][var_2]["tag"] = self getattachtagname( var_2 );
    }

    return var_0;
}

load( var_0 )
{
    self detachall();
    self.anim_gunhand = var_0["gunHand"];
    self.anim_guninhand = var_0["gunInHand"];
    self setmodel( var_0["model"] );
    self.hatmodel = var_0["hatModel"];

    if ( isdefined( var_0["name"] ) )
        self.name = var_0["name"];
    else
    {

    }

    var_1 = var_0["attach"];
    var_2 = var_1.size;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
        self attach( var_1[var_3]["model"], var_1[var_3]["tag"] );
}

precache( var_0 )
{
    if ( isdefined( var_0["name"] ) )
    {

    }
    else
    {

    }

    precachemodel( var_0["model"] );
    var_1 = var_0["attach"];
    var_2 = var_1.size;

    for ( var_3 = 0; var_3 < var_2; var_3++ )
        precachemodel( var_1[var_3]["model"] );
}

get_random_character( var_0, var_1, var_2, var_3 )
{
    var_4 = undefined;

    if ( isdefined( var_3 ) )
        var_5 = strtok( var_3, "_" );
    else
        var_5 = strtok( self.classname, "_" );

    if ( !scripts\common\utility::issp() )
    {
        if ( isdefined( self.pers["modelIndex"] ) && self.pers["modelIndex"] < var_0 )
            return self.pers["modelIndex"];

        var_4 = randomint( var_0 );
        self.pers["modelIndex"] = var_4;
        return var_4;
    }
    else if ( var_5.size <= 2 )
        return randomint( var_0 );

    var_6 = "auto";

    if ( isdefined( self.script_char_index ) )
        var_4 = self.script_char_index;
    else if ( isdefined( var_1 ) )
        var_4 = get_randomly_weighted_character( var_1 );

    if ( isdefined( self.script_char_group ) )
        var_6 = "group_" + self.script_char_group;

    if ( !isdefined( level.character_index_cache ) )
        level.character_index_cache = [];

    if ( !isdefined( level.character_index_cache[var_6] ) )
        level.character_index_cache[var_6] = [];

    if ( !isdefined( var_4 ) )
    {
        var_4 = get_least_used_index( var_2, var_6 );

        if ( !isdefined( var_4 ) )
            var_4 = randomint( var_2.size );
    }

    if ( !isdefined( level.character_index_cache[var_6][var_2[var_4]] ) )
        level.character_index_cache[var_6][var_2[var_4]] = 0;

    level.character_index_cache[var_6][var_2[var_4]]++;
    return var_4;
}

get_least_used_index( var_0, var_1 )
{
    var_2 = [];
    var_3 = 999999;
    var_2[0] = 0;

    for ( var_4 = 0; var_4 < var_0.size; var_4++ )
    {
        if ( !isdefined( level.character_index_cache[var_1][var_0[var_4]] ) )
            level.character_index_cache[var_1][var_0[var_4]] = 0;

        var_5 = level.character_index_cache[var_1][var_0[var_4]];

        if ( var_5 > var_3 )
            continue;

        if ( var_5 < var_3 )
        {
            var_2 = [];
            var_3 = var_5;
        }

        var_2[var_2.size] = var_4;
    }

    return random( var_2 );
}

initialize_character_group( var_0, var_1, var_2 )
{
    for ( var_3 = 0; var_3 < var_2; var_3++ )
        level.character_index_cache[var_0][var_1][var_3] = 0;
}

get_random_weapon( var_0 )
{
    return randomint( var_0 );
}

random( var_0 )
{
    return var_0[randomint( var_0.size )];
}

get_randomly_weighted_character( var_0 )
{
    var_1 = randomfloat( 1 );

    for ( var_2 = 0; var_2 < var_0.size; var_2++ )
    {
        if ( var_1 < var_0[var_2] )
            return var_2;
    }

    return 0;
}