// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

initscriptablepart( var_0 )
{
    if ( !isdefined( self._blackboard.scriptableparts ) )
        self._blackboard.scriptableparts = [];

    if ( !isdefined( self._blackboard.scriptableparts[var_0] ) )
    {
        self._blackboard.scriptableparts[var_0] = spawnstruct();
        self._blackboard.scriptableparts[var_0].state = "normal";
    }
}

set_scriptablepartinfo( var_0, var_1 )
{
    if ( self._blackboard.scriptableparts[var_0].state == "dismember" )
        return;

    if ( self._blackboard.scriptableparts[var_0].state != "normal" && var_1 != "dismember" )
        self._blackboard.scriptableparts[var_0].state = self._blackboard.scriptableparts[var_0].state + "_both";
    else
        self._blackboard.scriptableparts[var_0].state = var_1;

    self._blackboard.scriptableparts[var_0].time = gettime();
}

set_scriptablepartstate( var_0, var_1, var_2 )
{
    self endon( "entitydeleted" );
    set_scriptablepartinfo( var_0, var_1 );

    if ( isdefined( var_2 ) )
        wait( var_2 );

    if ( isdefined( self.scriptablecleanup ) )
        return 1;

    var_3 = self._blackboard.scriptableparts[var_0].state;

    if ( isdefined( anim.dismemberheavyfx[self.unittype] ) )
    {
        if ( var_0 != "head" && var_3 != "dismember" )
        {
            if ( usedismemberfxlite( self.unittype ) )
                var_3 = var_3 + "_lite";
        }
    }

    self setscriptablepartstate( var_0, var_3 );
}

setdismemberstatefx( var_0 )
{
    var_1 = var_0 + "_dism_fx";
    var_2 = get_scriptablepartinfo( var_0 );

    if ( var_2 == "normal" )
        var_2 = "undamaged";
    else if ( issubstr( var_2, "_both" ) )
        var_2 = "dmg_both";

    if ( !isdefined( level.in_vr ) && isdefined( anim.dismemberheavyfx[self.unittype] ) )
    {
        if ( var_0 != "head" )
        {
            if ( usedismemberfxlite( self.unittype ) )
                var_2 = var_2 + "_lite";
        }
    }

    self setscriptablepartstate( var_1, var_2 );
}

usedismemberfxlite( var_0 )
{
    var_1 = [];

    for ( var_2 = 0; var_2 < anim.dismemberheavyfx[var_0].size; var_2++ )
    {
        if ( gettime() - anim.dismemberheavyfx[var_0][var_2] > 1000 )
            continue;

        var_1[var_1.size] = anim.dismemberheavyfx[var_0][var_2];
    }

    if ( var_1.size < 0 )
    {
        var_1[var_1.size] = gettime();
        anim.dismemberheavyfx[var_0] = var_1;
        return 0;
    }

    anim.dismemberheavyfx[var_0] = var_1;
    return 1;
}

get_scriptablepartinfo( var_0 )
{
    if ( !isdefined( self._blackboard.scriptableparts ) )
        return "normal";

    if ( !isdefined( self._blackboard.scriptableparts[var_0] ) )
        return "normal";

    return self._blackboard.scriptableparts[var_0].state;
}

anylegdismembered()
{
    if ( get_scriptablepartinfo( "left_leg" ) == "dismember" || get_scriptablepartinfo( "right_leg" ) == "dismember" )
        return 1;

    return 0;
}

bothlegsdismembered()
{
    if ( get_scriptablepartinfo( "left_leg" ) == "dismember" && get_scriptablepartinfo( "right_leg" ) == "dismember" )
        return 1;

    return 0;
}

anyarmdismembered()
{
    if ( get_scriptablepartinfo( "left_arm" ) == "dismember" || get_scriptablepartinfo( "right_arm" ) == "dismember" )
        return 1;

    return 0;
}

rightarmdismembered()
{
    if ( get_scriptablepartinfo( "right_arm" ) == "dismember" )
        return 1;

    return 0;
}

leftarmdismembered()
{
    if ( get_scriptablepartinfo( "left_arm" ) == "dismember" )
        return 1;

    return 0;
}

botharmsdismembered()
{
    if ( get_scriptablepartinfo( "left_arm" ) == "dismember" && get_scriptablepartinfo( "right_arm" ) == "dismember" )
        return 1;

    return 0;
}
