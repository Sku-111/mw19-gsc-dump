// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    scripts\mp\killstreaks\killstreaks::registerkillstreak( "white_phosphorus", scripts\cp_mp\killstreaks\white_phosphorus::tryusewpfromstruct );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "white_phosphorus", "startMapSelectSequence", ::white_phosphorus_startmapselectsequence );
    scripts\cp_mp\utility\script_utility::registersharedfunc( "white_phosphorus", "getSelectMapPoint", ::white_phosphorus_getmapselectpoint );
}

white_phosphorus_startmapselectsequence( var_0, var_1, var_2, var_3 )
{
    scripts\mp\killstreaks\mapselect::startmapselectsequence( var_0, var_1, var_2 );
}

white_phosphorus_getmapselectpoint( var_0, var_1, var_2 )
{
    return scripts\mp\killstreaks\mapselect::getselectmappoint( var_0, var_1, var_2 );
}
