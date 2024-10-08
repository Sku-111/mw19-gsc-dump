// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

allow_input_internal( var_0, var_1, var_2, var_3 )
{
    var_4 = _id_132D8();

    if ( !isdefined( self.allows ) )
        self.allows = [];

    if ( var_1 )
    {
        if ( var_4 )
        {

        }
        else
        {
            if ( !isdefined( self.allows[var_0] ) )
                self.allows[var_0] = 0;

            if ( istrue( var_3 ) )
                return 1;

            self.allows[var_0]--;

            if ( !self.allows[var_0] )
            {
                self.allows[var_0] = undefined;
                return 1;
            }
        }
    }
    else if ( var_4 )
    {

    }
    else
    {
        if ( !isdefined( self.allows[var_0] ) )
            self.allows[var_0] = 0;

        if ( istrue( var_3 ) )
            return 0;

        self.allows[var_0]++;

        if ( self.allows[var_0] == 1 )
            return 0;
    }

    return undefined;
}

is_input_allowed_internal( var_0 )
{
    if ( !isdefined( self.allows ) )
        self.allows = [];

    if ( !isdefined( self.allows ) || !isdefined( self.allows[var_0] ) || !self.allows[var_0] )
        return 1;
    else
        return 0;
}

clear_allow_info( var_0 )
{
    if ( isdefined( self.allows ) && isdefined( self.allows[var_0] ) )
        self.allows[var_0] = undefined;
}

clear_all_allow_info()
{
    if ( isdefined( self.allows ) )
    {
        foreach ( var_1 in self.allows )
            var_1 = undefined;

        self.allows = undefined;
    }

    self notify( "clearedAllows" );
}

_id_132D8()
{
    return 0;
}