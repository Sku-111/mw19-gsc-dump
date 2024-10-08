// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

thermite_used( var_0, var_1 )
{
    if ( isdefined( var_1 ) )
    {
        var_2 = var_0;
        var_0 = scripts\mp\utility\weapon::_launchgrenade( "thermite_mp", var_2.origin, ( 0, 0, 0 ) );
        scripts\mp\weapons::grenadeinitialize( var_0, getcompleteweaponname( "thermite_mp" ) );
        var_0.see_equipment_dist = var_2;
        var_0.angles = var_2.angles;
        var_0.see_killstreak_dist = self getcurrentweapon();
        var_0 linkto( var_2 );
        var_0.exploding = 1;
        var_0 setscriptablepartstate( "visibility", "hide", 0 );
    }

    if ( isdefined( level.playimpactfx ) )
        [[ level.playimpactfx ]]( var_0, self );

    var_0 thread thermite_watchdisowned();
    var_0 thread _id_13B21();
    var_0 thread thermite_watchstuck( var_1 );
}

thermite_watchstuck( var_0 )
{
    self endon( "death" );
    var_1 = undefined;

    if ( istrue( var_0 ) )
    {
        var_2 = _id_13B20();

        if ( !istrue( var_2 ) )
        {
            thread thermite_delete();
            return;
        }

        if ( isdefined( self.see_equipment_dist ) )
            self.see_equipment_dist delete();
    }
    else
    {
        self waittill( "missile_stuck", var_1, var_3, var_4 );
        self.surfacetype = var_4;
    }

    if ( isdefined( level._id_132A4 ) && [[ level._id_132A4.make_control_station_interaction ]]( self ) )
    {
        if ( isdefined( level._id_132A4 ) && isdefined( level._id_132A4.setupmission ) )
        {
            [[ level._id_132A4.setupmission ]]( self );
            return;
        }
    }

    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );

    if ( !istrue( var_0 ) )
    {
        if ( isdefined( var_1 ) && isplayer( var_1 ) )
            thread scripts\mp\weapons::grenadestuckto( self, var_1 );
    }

    var_5 = self.weapon_object;

    if ( isdefined( self.see_killstreak_dist ) )
        var_5._id_121D9 = self.see_killstreak_dist;

    thread _id_13B22();
    self setscriptablepartstate( "effects", "impact", 0 );
    _id_13B1D( var_5 );

    if ( !istrue( level.iscacprimaryweapongroup ) )
        self.dangerzoneid = scripts\mp\spawnlogic::addspawndangerzone( self.origin, 175, 175, self.owner.team, 100, self.owner, 1, self, 1 );

    wait 0.5;
    var_6 = getcompleteweaponname( "thermite_av_mp" );
    var_7 = getcompleteweaponname( "thermite_ap_mp" );

    if ( isdefined( self.see_killstreak_dist ) )
    {
        var_6._id_121D9 = self.see_killstreak_dist;
        var_7._id_121D9 = self.see_killstreak_dist;
    }

    var_8 = 1;

    while ( var_8 <= 10 )
    {
        var_9 = var_8 + 1;

        if ( scripts\engine\utility::mod( var_9, 2 ) > 0 )
            _id_13B1D( var_6 );
        else
            _id_13B1D( var_7 );

        var_8 = var_9;
        wait 0.5;
    }

    thread thermite_destroy();
}

_id_13B20()
{
    self.see_equipment_dist endon( "death" );
    self.owner endon( "disconnect" );
    self.owner endon( "joined_team" );
    self.owner endon( "joined_spectators" );
    self.see_equipment_dist waittill( "missile_stuck", var_0, var_1, var_2, var_3, var_4, var_5 );
    self.see_equipment_dist.surfacetype = var_2;

    if ( isdefined( var_0 ) )
    {
        if ( isplayer( var_0 ) || isagent( var_0 ) )
        {
            if ( var_0 scripts\cp_mp\utility\player_utility::_isalive() )
            {
                if ( isplayer( var_0 ) )
                    thread scripts\mp\weapons::grenadestuckto( self, var_0 );

                if ( isdefined( var_1 ) )
                    self linkto( var_0, var_1 );
                else
                    self linkto( var_0, "j_spine4", ( 0, 0, 0 ) );
            }
        }
        else if ( isdefined( var_1 ) )
            self linkto( var_0, var_1 );
        else
            self linkto( var_0 );
    }

    return 1;
}

_id_13B22()
{
    self endon( "death" );
    var_0 = self getlinkedparent();

    while ( isdefined( var_0 ) )
        self waittill( "missile_stuck", var_0 );

    self.badplace = createnavbadplacebybounds( self.origin, ( 125, 125, 125 ), ( 0, 0, 0 ) );
}

_id_13B1D( var_0 )
{
    var_1 = 125;
    var_2 = 25;
    var_3 = 10;
    var_4 = "MOD_FIRE";

    if ( var_0.basename == "thermite_mp" )
    {
        var_1 = 125;
        var_2 = 40;
        var_3 = 40;
    }

    var_5 = self.stuckenemyentity;

    if ( isdefined( var_5 ) )
    {
        if ( isplayer( var_5 ) && var_5 scripts\cp_mp\utility\player_utility::_isalive() )
        {
            if ( isdefined( level._id_132A4 ) && [[ level._id_132A4.getheliflyheight ]]( var_5 ) )
            {
                thread thermite_destroy();
                return;
            }

            var_5 dodamage( var_2, self.origin, self.owner, self, var_4, var_0 );
            var_5 scripts\cp_mp\utility\damage_utility::adddamagemodifier( "thermiteStuck", 0, 0, ::_id_13B1C );
        }
        else
            var_5 = undefined;
    }

    self radiusdamage( self.origin, var_1, var_2, var_3, self.owner, var_4, var_0 );

    if ( isdefined( var_5 ) )
        var_5 scripts\cp_mp\utility\damage_utility::removedamagemodifier( "thermiteStuck", 0 );
}

_id_13B1C( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    if ( !isdefined( var_0 ) )
        return 1;

    if ( !isdefined( var_0.weapon_name ) || var_0.weapon_name != "thermite_mp" )
        return 1;

    if ( !isdefined( var_0.stuckenemyentity ) || var_0.stuckenemyentity != var_2 )
        return 1;

    return 0;
}

thermite_watchdisowned()
{
    self endon( "death" );
    self.owner scripts\engine\utility::_id_143A6( "joined_team", "joined_spectators", "disconnect" );
    thread thermite_destroy();
}

_id_13B21()
{
    self endon( "death" );
    level waittill( "br_prematchEnded" );
    thread thermite_destroy();
}

thermite_destroy()
{
    thread thermite_delete( 5 );
    self setscriptablepartstate( "effects", "burnEnd", 0 );
}

thermite_delete( var_0 )
{
    self notify( "death" );
    self.exploding = 1;

    if ( isdefined( self.dangerzoneid ) )
    {
        scripts\mp\spawnlogic::removespawndangerzone( self.dangerzoneid );
        self.dangerzoneid = undefined;
    }

    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
        self.badplace = undefined;
    }

    self forcehidegrenadehudwarning( 1 );

    if ( isdefined( var_0 ) )
        wait( var_0 );

    if ( isdefined( self ) )
        self delete();
}

thermite_onplayerdamaged( var_0 )
{
    if ( var_0.meansofdeath == "MOD_IMPACT" )
        return 1;

    var_0.victim.lastburntime = gettime();
    var_0.victim thread scripts\mp\weapons::enableburnfxfortime( 0.6 );
    return 1;
}
