// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

free_expendable()
{
    if ( !isdefined( self.spawner ) || !isdefined( self.script_suspend ) )
        return;

    var_0 = self.spawner;
    var_1 = spawnstruct();
    var_1.origin = self.origin;
    var_1.angles = self.angles;
    var_1.suspendtime = gettime();

    if ( isdefined( self.suspendvars ) )
        var_1.suspendvars = self.suspendvars;
    else
        var_1.suspendvars = spawnstruct();

    if ( isdefined( self.stealth ) )
    {
        var_1.stealth = spawnstruct();
        var_1.stealth.bsmstate = self.stealth.bsmstate;
        var_1.stealth.investigateevent = self.stealth.investigateevent;
    }

    if ( isdefined( self.node ) )
    {
        if ( isdefined( self.using_goto_node ) )
        {
            if ( isdefined( self.node.targetname ) )
                var_1.target = self.node.targetname;

            var_1.node = self.node;
        }

        var_1.target = self.node.targetname;
    }

    var_0.suspended_ai = var_1;

    if ( isdefined( self.script_suspend_group ) && !isdefined( self.script_free ) )
        free_groupname( self.script_suspend_group );
}

free_groupname( var_0 )
{
    if ( !isdefined( level.processfreegroupname ) )
        level.processfreegroupname = [];

    if ( isdefined( level.processfreegroupname[var_0] ) )
        return;

    level.processfreegroupname[var_0] = 1;
    var_1 = getaiarray();

    foreach ( var_3 in var_1 )
    {
        if ( var_3 == self )
            continue;

        if ( !isdefined( var_3.script_suspend_group ) )
            continue;

        if ( var_3.script_suspend_group != var_0 )
            continue;

        var_3.script_free = 1;
        var_3 free_expendable();
        var_3 delete();
    }

    level.processfreegroupname[var_0] = undefined;
}

create_weapon_in_script( var_0, var_1 )
{
    if ( !isdefined( level.fnscriptedweaponassignment ) )
    {
        self.usescriptedweapon = undefined;

        if ( !isdefined( var_0 ) )
            var_2 = isundefinedweapon();
        else if ( !isarray( var_0 ) && var_0 == "" )
            var_2 = isundefinedweapon();
        else if ( isarray( var_0 ) )
            var_2 = getcompleteweaponname( var_0[randomint( var_0.size )] );
        else
            var_2 = getcompleteweaponname( var_0 );

        if ( !nullweapon( var_2 ) )
        {
            self.scriptedweaponfailed = 1;

            if ( isdefined( var_1 ) && var_1 == "sidearm" )
                self.scriptedweaponfailed_sidearmarray = var_0;
            else
                self.scriptedweaponfailed_primaryarray = var_0;
        }

        return var_2;
    }
    else
        return [[ level.fnscriptedweaponassignment ]]( var_0, var_1 );
}