// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

setupcqbpointsofinterest()
{
    level.cqbpointsofinterest = [];
    level.fnfindcqbpointsofinterest = ::findcqbpointsofinterest;
    thread gatherdynamiccqbstructs();
}

gatherdynamiccqbstructs()
{
    waittillframeend;
    var_0 = "poi";
    var_1 = scripts\engine\utility::getstructarray( var_0, "targetname" );

    foreach ( var_3 in var_1 )
        level.cqbpointsofinterest[level.cqbpointsofinterest.size] = var_3;
}

findcqbpointsofinterest()
{
    if ( isdefined( anim.findingcqbpointsofinterest ) )
        return;

    anim.findingcqbpointsofinterest = 1;
    waitframe();

    for (;;)
    {
        var_0 = level.poi_activeai;

        if ( !isdefined( var_0 ) )
        {
            waitframe();
            continue;
        }

        var_1 = [];
        var_2 = 0;

        foreach ( var_4 in var_0 )
        {
            if ( isalive( var_4 ) )
            {
                var_4.cqb_point_of_interest = var_4 findbestpoi();
                wait 0.05;
                var_2 = 1;
                continue;
            }

            var_1[var_1.size] = var_4;
        }

        foreach ( var_4 in var_1 )
            level.poi_activeai = scripts\engine\utility::array_remove( level.poi_activeai, var_4 );

        if ( !var_2 )
            wait 0.25;
    }
}

findbestpoi()
{
    var_0 = 5000;
    var_1 = isdefined( self.pathgoalpos );
    var_2 = isdefined( self.currentpoi );

    if ( !var_2 && isdefined( self.poi_firstpoint ) )
        return findfirstpoiinlink();

    if ( var_2 && isdefined( self.currentpoi.target ) || isdefined( self.nextpoi ) )
        return findnextpoiinlink( var_2 );
}

findfirstpoiinlink()
{
    if ( sighttracepassed( self geteye(), self.poi_firstpoint.origin, 0, undefined ) )
    {
        var_0 = self.poi_firstpoint;

        if ( isdefined( var_0.target ) )
            self.nextpoi = scripts\engine\utility::getstruct( var_0.target, "targetname" );

        if ( iswithinfov( var_0 ) )
        {
            return var_0;
            return;
        }

        return undefined;
        return;
    }
    else
        return undefined;
}

findnextpoiinlink( var_0 )
{
    var_1 = undefined;

    if ( var_0 )
    {
        if ( isdefined( self.currentpoi.target ) )
            self.nextpoi = scripts\engine\utility::getstruct( self.currentpoi.target, "targetname" );
        else
            self.nextpoi = undefined;
    }

    if ( isdefined( self.poi_firstpoint ) )
        self.poi_firstpoint = undefined;

    if ( var_0 && isdefined( self.currentpoi.script_time_min ) )
        var_1 = self.currentpoi.script_time_min * 1000;
    else
        var_1 = 1200;

    if ( !isdefined( self.nextpoi ) )
    {
        if ( gettime() < self.poi_starttime + var_1 && iswithinfov( self.currentpoi ) )
            return self.currentpoi;
        else
        {
            scripts\common\ai::poi_enable( 0 );
            return undefined;
        }
    }

    if ( var_0 && gettime() < self.poi_starttime + var_1 && iswithinfov( self.currentpoi ) )
        return self.currentpoi;
    else if ( !sighttracepassed( self geteye(), self.nextpoi.origin, 0, undefined ) )
        return undefined;
    else
    {
        if ( !iswithinfov( self.nextpoi ) )
        {
            if ( isdefined( self.nextpoi.target ) )
                self.nextpoi = scripts\engine\utility::getstruct( self.nextpoi.target, "targetname" );
            else
                scripts\common\ai::poi_enable( 0 );

            return undefined;
        }

        return self.nextpoi;
    }
}

iswithinfov( var_0 )
{
    if ( istrue( self.poi_disablefov ) )
        return 1;

    var_1 = anglestoforward( self.angles );
    var_2 = acos( vectordot( var_1, vectornormalize( var_0.origin - self geteye() ) ) );
    return var_2 < scripts\engine\utility::ter_op( isdefined( self.poi_fovlimit ), self.poi_fovlimit, 90 );
}
