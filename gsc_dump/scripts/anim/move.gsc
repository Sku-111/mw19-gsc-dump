// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

mayshootwhilemoving()
{
    if ( nullweapon( self.weapon ) )
        return 0;

    var_0 = weaponclass( self.weapon );

    if ( !scripts\anim\utility_common.gsc::usingriflelikeweapon() )
        return 0;

    if ( scripts\anim\utility_common.gsc::isasniper() )
    {
        if ( !scripts\anim\utility.gsc::iscqbwalking() && self.facemotion )
            return 0;
    }

    if ( istrue( self.dontshootwhilemoving ) )
        return 0;

    return 1;
}
