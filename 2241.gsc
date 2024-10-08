// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

adddamagemodifier( var_0, var_1, var_2, var_3 )
{
    if ( !isdefined( var_2 ) )
        var_2 = 1;

    if ( var_2 )
    {
        if ( !isdefined( self.additivedamagemodifiers ) )
            self.additivedamagemodifiers = [];

        self.additivedamagemodifiers[var_0] = var_1;

        if ( isdefined( var_3 ) )
        {
            if ( !isdefined( self.additivedamagemodifierignorefuncs ) )
                self.additivedamagemodifierignorefuncs = [];

            self.additivedamagemodifierignorefuncs[var_0] = var_3;
        }
    }
    else
    {
        if ( !isdefined( self.multiplicativedamagemodifiers ) )
            self.multiplicativedamagemodifiers = [];

        self.multiplicativedamagemodifiers[var_0] = var_1;

        if ( isdefined( var_3 ) )
        {
            if ( !isdefined( self.multiplicativedamagemodifierignorefuncs ) )
                self.multiplicativedamagemodifierignorefuncs = [];

            self.multiplicativedamagemodifierignorefuncs[var_0] = var_3;
        }
    }
}

removedamagemodifier( var_0, var_1 )
{
    if ( !isdefined( var_1 ) )
        var_1 = 1;

    if ( var_1 )
    {
        if ( !isdefined( self.additivedamagemodifiers ) )
            return;

        self.additivedamagemodifiers[var_0] = undefined;

        if ( !isdefined( self.additivedamagemodifierignorefuncs ) )
            return;

        self.additivedamagemodifierignorefuncs[var_0] = undefined;
    }
    else
    {
        if ( !isdefined( self.multiplicativedamagemodifiers ) )
            return;

        self.multiplicativedamagemodifiers[var_0] = undefined;

        if ( !isdefined( self.multiplicativedamagemodifierignorefuncs ) )
            return;

        self.multiplicativedamagemodifierignorefuncs[var_0] = undefined;
    }
}

getdamagemodifiertotal( var_0, var_1, var_2, var_3, var_4, var_5, var_6 )
{
    var_7 = 1.0;

    if ( isdefined( self.additivedamagemodifiers ) )
    {
        foreach ( var_11, var_9 in self.additivedamagemodifiers )
        {
            var_10 = 0;

            if ( isdefined( self.additivedamagemodifierignorefuncs ) && isdefined( self.additivedamagemodifierignorefuncs[var_11] ) )
                var_10 = [[ self.additivedamagemodifierignorefuncs[var_11] ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );

            if ( !var_10 )
                var_7 = var_7 + ( var_9 - 1.0 );
        }
    }

    var_12 = 1.0;

    if ( isdefined( self.multiplicativedamagemodifiers ) )
    {
        foreach ( var_11, var_9 in self.multiplicativedamagemodifiers )
        {
            var_10 = 0;

            if ( isdefined( self.multiplicativedamagemodifierignorefuncs ) && isdefined( self.multiplicativedamagemodifierignorefuncs[var_11] ) )
                var_10 = [[ self.multiplicativedamagemodifierignorefuncs[var_11] ]]( var_0, var_1, var_2, var_3, var_4, var_5, var_6 );

            if ( !var_10 )
                var_12 = var_12 * var_9;
        }
    }

    return var_7 * var_12;
}

cleardamagemodifiers()
{
    self.additivedamagemodifiers = [];
    self.multiplicativedamagemodifiers = [];
    self.additivedamagemodifierignorefuncs = [];
    self.multiplicativedamagemodifierignorefuncs = [];
}

packdamagedata( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 )
{
    var_13 = spawnstruct();
    var_13.attacker = var_0;
    var_13.victim = var_1;
    var_13.damage = var_2;
    var_13.objweapon = var_3;
    var_13.meansofdeath = var_4;
    var_13.inflictor = var_5;
    var_13.point = var_6;
    var_13.direction_vec = var_7;
    var_13.modelname = var_8;
    var_13.partname = var_9;
    var_13.tagname = var_10;
    var_13.idflags = var_11;
    var_13.damageflags = var_11;
    var_13.eventid = var_12;

    if ( isdefined( var_13.attacker ) )
        var_13.attacker.assistedsuicide = 0;

    return var_13;
}

isstuckdamage( var_0, var_1 )
{
    if ( istrue( self.playerplunderbankcallback ) )
        return 1;

    if ( isdefined( self.stuckbygrenade ) )
    {
        if ( isdefined( var_0.inflictor ) && var_0.inflictor == self.stuckbygrenade )
        {
            if ( istrue( var_1 ) )
                return 1;
            else if ( isexplosivedamagemod( var_0.meansofdeath ) || var_0.meansofdeath == "MOD_FIRE" )
                return 1;
        }
    }

    return 0;
}

isstuckdamagekill( var_0 )
{
    if ( istrue( self.nostuckdamagekill ) )
        return 0;

    if ( !isstuckdamage( var_0, 0 ) )
        return 0;

    switch ( var_0.objweapon.basename )
    {
        case "thermite_av_mp":
        case "thermite_ap_mp":
        case "thermite_mp":
        case "molotov_mp":
            return 0;
        default:
            break;
    }

    return 1;
}

playerplunderbankcallback()
{
    self.playerplunderbankcallback = 1;
}

playerplunderbankdeposit()
{
    self.playerplunderbankcallback = undefined;
}
