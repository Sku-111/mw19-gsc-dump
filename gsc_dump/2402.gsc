// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

onplayerjoinsquad( var_0 )
{
    foreach ( var_2 in level.onjoinsquadcallbacks )
        self [[ var_2 ]]( var_0 );
}

registeronplayerjoinsquadcallback( var_0 )
{
    if ( !isdefined( level.onjoinsquadcallbacks ) )
        level.onjoinsquadcallbacks = [];

    level.onjoinsquadcallbacks[level.onjoinsquadcallbacks.size] = var_0;
}
