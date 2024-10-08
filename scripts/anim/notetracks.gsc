// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

registernotetracks()
{
    anim.notetracks["anim_movement = \"stop\""] = ::notetrackmovementstop;
    anim.notetracks["anim_movement = \"walk\""] = ::notetrackmovementwalk;
    anim.notetracks["anim_movement = \"run\""] = ::notetrackmovementrun;
    anim.notetracks["anim_movement = stop"] = ::notetrackmovementstop;
    anim.notetracks["anim_movement = walk"] = ::notetrackmovementwalk;
    anim.notetracks["anim_movement = run"] = ::notetrackmovementrun;
    anim.notetracks["anim_movement_gun_pose_override = run_gun_down"] = ::notetrackmovementgunposeoverride;
    anim.notetracks["anim_coverpose = cover_left"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = cover_right"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = cover_crouch"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = cover_stand"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = cover_left_crouch"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = cover_right_crouch"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = exposed"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = exposed_crouch"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_coverpose = prone"] = ::notetrackcoverposerequest;
    anim.notetracks["anim_aiming = 1"] = ::notetrackalertnessaiming;
    anim.notetracks["anim_aiming = 0"] = ::notetrackalertnessalert;
    anim.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual;
    anim.notetracks["anim_alertness = alert"] = ::notetrackalertnessalert;
    anim.notetracks["anim_alertness = aiming"] = ::notetrackalertnessaiming;
    anim.notetracks["gravity on"] = ::notetrackgravity;
    anim.notetracks["gravity off"] = ::notetrackgravity;
    anim.notetracks["bodyfall large"] = ::notetrackbodyfall;
    anim.notetracks["bodyfall small"] = ::notetrackbodyfall;
    anim.notetracks["code_move"] = ::notetrackcodemove;
    anim.notetracks["face_enemy"] = ::notetrackfaceenemy;
    anim.notetracks["pistol_rechamber"] = ::notetrackpistolrechamber;
    anim.notetracks["load_shell"] = ::notetrackloadshell;
    anim.notetracks["fire"] = ::notetrackfire;
    anim.notetracks["fire_spray"] = ::notetrackfirespray;
    anim.notetracks["gun_2_chest"] = ::notetrackguntochest;
    anim.notetracks["gun_2_back"] = ::notetrackguntoback;
    anim.notetracks["gun_2_right"] = ::notetrackguntoright;
    anim.notetracks["pistol_pickup"] = ::notetrackpistolpickup;
    anim.notetracks["pistol_putaway"] = ::notetrackpistolputaway;
    anim.notetracks["refill clip"] = ::notetrackrefillclip;
    anim.notetracks["reload done"] = ::notetrackrefillclip;
    anim.notetracks["ht_on"] = ::notetrackhton0;
    anim.notetracks["ht_on_0"] = ::notetrackhton0;
    anim.notetracks["ht_on_1"] = ::notetrackhton1;
    anim.notetracks["ht_off"] = ::notetrackhtoff;

    if ( isdefined( level._notetrackfx ) )
    {
        var_0 = getarraykeys( level._notetrackfx );

        foreach ( var_2 in var_0 )
            anim.notetracks[var_2] = ::customnotetrackfx;
    }
}

notetrackstopanim( var_0, var_1 )
{

}

notetrackcoverposerequest( var_0, var_1 )
{
    var_2 = strtok( var_0, " = " )[1];

    switch ( var_2 )
    {
        case "cover_left":
        case "cover_stand":
        case "cover_crouch":
        case "exposed_crouch":
        case "cover_right_crouch":
        case "cover_left_crouch":
        case "cover_right":
        case "exposed":
        case "prone":
            self.a.coverpose_request = var_2;
            break;
        default:
    }
}

notetrackmovementstop( var_0, var_1 )
{
    self.a.movement = "stop";
}

notetrackmovementwalk( var_0, var_1 )
{
    self.a.movement = "walk";
}

notetrackmovementrun( var_0, var_1 )
{
    self.a.movement = "run";
}

notetrackmovementgunposeoverride( var_0, var_1 )
{
    self.asm.movementgunposeoverride = "run_gun_down";
}

notetrackalertnessaiming( var_0, var_1 )
{

}

notetrackalertnesscasual( var_0, var_1 )
{

}

notetrackalertnessalert( var_0, var_1 )
{

}

notetrackloadshell( var_0, var_1 )
{

}

notetrackpistolrechamber( var_0, var_1 )
{

}

notetrackgravity( var_0, var_1 )
{
    if ( issubstr( var_0, "on" ) )
        self animmode( "gravity" );
    else if ( issubstr( var_0, "off" ) )
        self animmode( "nogravity" );
}

customnotetrackfx( var_0, var_1 )
{
    if ( isdefined( self.groundtype ) )
        var_2 = self.groundtype;
    else
        var_2 = "dirt";

    var_3 = undefined;

    if ( isdefined( level._notetrackfx[var_0][var_2] ) )
        var_3 = level._notetrackfx[var_0][var_2];
    else if ( isdefined( level._notetrackfx[var_0]["all"] ) )
        var_3 = level._notetrackfx[var_0]["all"];

    if ( !isdefined( var_3 ) )
        return;

    if ( isai( self ) && isdefined( var_3.fx ) )
        playfxontag( var_3.fx, self, var_3.tag );

    if ( !isdefined( var_3.sound_prefix ) && !isdefined( var_3.sound_suffix ) )
        return;

    var_4 = "" + var_3.sound_prefix + var_2 + var_3.sound_suffix;

    if ( soundexists( var_4 ) )
        self playsound( var_4 );
}

notetrackcodemove( var_0, var_1 )
{
    return "code_move";
}

notetrackfaceenemy( var_0, var_1 )
{
    self orientmode( "face enemy" );
}

notetrackbodyfall( var_0, var_1 )
{
    var_2 = "_small";

    if ( issubstr( var_0, "large" ) )
        var_2 = "_large";

    if ( isdefined( self.groundtype ) )
        var_3 = self.groundtype;
    else
        var_3 = "dirt";

    if ( var_2 == "_large" )
        self playsurfacesound( "bodyfall_torso", var_3 );
    else
        self playsurfacesound( "bodyfall_limb_small", var_3 );
}

donotetracks( var_0, var_1, var_2 )
{
    for (;;)
    {
        self waittill( var_0, var_3 );

        if ( !isdefined( var_3 ) )
            var_3 = [ "undefined" ];

        if ( !isarray( var_3 ) )
            var_3 = [ var_3 ];

        scripts\common\notetrack::validatenotetracks( var_0, var_3 );

        foreach ( var_5 in var_3 )
        {
            var_6 = handlenotetrack( var_5, var_0, var_1 );

            if ( isdefined( var_6 ) )
                return var_6;
        }
    }
}

handlenotetrack( var_0, var_1, var_2, var_3 )
{
    if ( isdefined( self.fnasm_handlenotetrack ) )
        [[ self.fnasm_handlenotetrack ]]( var_0, var_1, var_2, var_3 );
    else if ( isdefined( level._defaultnotetrackhandler ) )
        [[ level._defaultnotetrackhandler ]]( var_0, var_1, var_2, var_3 );
    else
    {

    }
}

hascustomnotetrackhandler( var_0 )
{
    var_1 = anim.notetracks[var_0];

    if ( isdefined( var_1 ) )
        return 1;

    if ( isdefined( self.customnotetrackhandler ) )
        return 1;

    return 0;
}

handlecustomnotetrackhandler( var_0, var_1, var_2, var_3 )
{
    var_4 = anim.notetracks[var_0];

    if ( isdefined( var_4 ) )
        return [[ var_4 ]]( var_0, var_1 );
    else if ( isdefined( self.customnotetrackhandler ) )
    {
        if ( isdefined( var_3 ) )
            return [[ self.customnotetrackhandler ]]( var_0, var_1, var_2, var_3 );
        else
            return [[ self.customnotetrackhandler ]]( var_0, var_1, var_2 );
    }
}

handlecommonnotetrack( var_0, var_1, var_2, var_3 )
{
    switch ( var_0 )
    {
        case "undefined":
        case "finish":
        case "end":
            return var_0;
        case "finish early":
            if ( isdefined( self.enemy ) )
                return var_0;

            break;
        case "swish small":
            thread scripts\engine\utility::play_sound_in_space( "melee_swing_small", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case "swish large":
            thread scripts\engine\utility::play_sound_in_space( "melee_swing_large", self gettagorigin( "TAG_WEAPON_RIGHT" ) );
            break;
        case "no death":
            self.a.nodeath = 1;
            break;
        case "no pain":
            self.allowpain = 0;
            break;
        case "allow pain":
            self.allowpain = 1;
            break;
        case "anim_melee = \"right\"":
        case "anim_melee = right":
            self.a.meleestate = "right";
            break;
        case "anim_melee = \"left\"":
        case "anim_melee = left":
            self.a.meleestate = "left";
            break;
        case "swap taghelmet to tagleft":
            if ( isdefined( self.hatmodel ) )
            {
                if ( isdefined( self.helmetsidemodel ) )
                {
                    self detach( self.helmetsidemodel, "TAG_HELMETSIDE" );
                    self.helmetsidemodel = undefined;
                }

                self detach( self.hatmodel, "" );
                self attach( self.hatmodel, "TAG_WEAPON_LEFT" );
                self.hatmodel = undefined;
            }

            break;
        case "break glass":
            level notify( "glass_break", self );
            break;
        case "break_glass":
            level notify( "glass_break", self );
            break;
        case "start_drift":
            if ( !self.fixednode )
                self animmode( "physics_drift" );

            break;
        default:
            return "__unhandled";
    }
}

donotetracksintercept( var_0, var_1, var_2 )
{
    for (;;)
    {
        self waittill( var_0, var_3 );

        if ( !isdefined( var_3 ) )
            var_3 = [ "undefined" ];

        if ( !isarray( var_3 ) )
            var_3 = [ var_3 ];

        scripts\common\notetrack::validatenotetracks( var_0, var_3 );
        var_4 = [[ var_1 ]]( var_3 );

        if ( isdefined( var_4 ) && var_4 )
            continue;

        var_5 = undefined;

        foreach ( var_7 in var_3 )
        {
            var_8 = handlenotetrack( var_7, var_0 );

            if ( isdefined( var_8 ) )
            {
                var_5 = var_8;
                break;
            }
        }

        if ( isdefined( var_5 ) )
            return var_5;
    }
}

donotetrackspostcallback( var_0, var_1 )
{
    for (;;)
    {
        self waittill( var_0, var_2 );

        if ( !isdefined( var_2 ) )
            var_2 = [ "undefined" ];

        if ( !isarray( var_2 ) )
            var_2 = [ var_2 ];

        scripts\common\notetrack::validatenotetracks( var_0, var_2 );
        var_3 = undefined;

        foreach ( var_5 in var_2 )
        {
            var_6 = handlenotetrack( var_5, var_0 );

            if ( isdefined( var_6 ) )
            {
                var_3 = var_6;
                break;
            }
        }

        [[ var_1 ]]( var_2 );

        if ( isdefined( var_3 ) )
            return var_3;
    }
}

donotetracksfortimeout( var_0, var_1, var_2, var_3 )
{
    donotetracks( var_0, var_2, var_3 );
}

donotetracksforever( var_0, var_1, var_2, var_3 )
{
    donotetracksforeverproc( ::donotetracks, var_0, var_1, var_2, var_3 );
}

donotetracksforeverintercept( var_0, var_1, var_2, var_3 )
{
    donotetracksforeverproc( ::donotetracksintercept, var_0, var_1, var_2, var_3 );
}

donotetracksforeverproc( var_0, var_1, var_2, var_3, var_4 )
{
    if ( isdefined( var_2 ) )
        self endon( var_2 );

    self endon( "killanimscript" );

    if ( !isdefined( var_4 ) )
        var_4 = "undefined";

    for (;;)
    {
        var_5 = gettime();
        var_6 = [[ var_0 ]]( var_1, var_3, var_4 );
        var_7 = gettime() - var_5;

        if ( var_7 < 0.05 )
        {
            var_5 = gettime();
            var_6 = [[ var_0 ]]( var_1, var_3, var_4 );
            var_7 = gettime() - var_5;

            if ( var_7 < 0.05 )
                wait( 0.05 - var_7 );
        }
    }
}

donotetrackswithtimeout( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4 thread donotetracksfortimeendnotify( var_1 );
    donotetracksfortimeproc( ::donotetracksfortimeout, var_0, var_2, var_3, var_4 );
}

donotetracksfortime( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4 thread donotetracksfortimeendnotify( var_0 );
    donotetracksfortimeproc( ::donotetracksforever, var_1, var_2, var_3, var_4 );
}

donotetracksfortimeintercept( var_0, var_1, var_2, var_3 )
{
    var_4 = spawnstruct();
    var_4 thread donotetracksfortimeendnotify( var_0 );
    donotetracksfortimeproc( ::donotetracksforeverintercept, var_1, var_2, var_3, var_4 );
}

donotetracksfortimeproc( var_0, var_1, var_2, var_3, var_4 )
{
    var_4 endon( "stop_notetracks" );
    [[ var_0 ]]( var_1, undefined, var_2, var_3 );
}

donotetracksfortimeendnotify( var_0 )
{
    wait( var_0 );
    self notify( "stop_notetracks" );
}

notetrack_prefix_handler( var_0 )
{
    return [[ level.fnnotetrackprefixhandler ]]( var_0 );
}

notetrack_prefix_handler_common( var_0 )
{
    return 0;
}

shootnotetrack()
{
    waittillframeend;

    if ( isdefined( self ) && gettime() > self.a.lastshoottime )
    {
        if ( istrue( self._blackboard.shootparams_valid ) )
            var_0 = self._blackboard.shootparams_shotsperburst == 1;
        else
            var_0 = 1;

        scripts\anim\utility_common.gsc::shootenemywrapper( var_0 );
        scripts\asm\shared\utility::decrementbulletsinclip();

        if ( weaponclass( self.weapon ) == "rocketlauncher" )
            self.rocketammo--;
    }
}

notetrackfire( var_0, var_1 )
{
    if ( isdefined( self.script ) && isdefined( anim.fire_notetrack_functions[self.script] ) )
        thread [[ anim.fire_notetrack_functions[self.script] ]]();
    else
        thread shootnotetrack();
}

notetrackfirespray( var_0, var_1 )
{
    if ( !isalive( self ) && self isbadguy() )
    {
        if ( isdefined( self.changed_team ) )
            return;

        self.changed_team = 1;
        var_2["axis"] = "team3";
        var_2["team3"] = "axis";
        self.team = var_2[self.team];
    }

    if ( !issentient( self ) )
    {
        self notify( "fire" );
        return;
    }

    if ( getqueuedspleveltransients( self.a.weaponpos["right"] ) )
        return;

    var_3 = self getmuzzlepos();
    var_4 = anglestoforward( self getmuzzleangle() );
    var_5 = 10;

    if ( isdefined( self.isrambo ) )
        var_5 = 20;

    var_6 = 0;

    if ( isalive( self.enemy ) && issentient( self.enemy ) && self canshootenemy() )
    {
        var_7 = vectornormalize( self.enemy geteye() - var_3 );

        if ( vectordot( var_4, var_7 ) > cos( var_5 ) )
            var_6 = 1;
    }

    if ( var_6 )
        scripts\anim\utility_common.gsc::shootenemywrapper();
    else
    {
        var_4 = var_4 + ( ( randomfloat( 2 ) - 1 ) * 0.1, ( randomfloat( 2 ) - 1 ) * 0.1, ( randomfloat( 2 ) - 1 ) * 0.1 );
        var_8 = var_3 + var_4 * 1000;
        self [[ anim.shootposwrapper_func ]]( var_8 );
    }

    scripts\asm\shared\utility::decrementbulletsinclip();
}

notetrackrefillclip( var_0, var_1 )
{
    scripts\anim\weaponlist.gsc::refillclip();
    self.a.needstorechamber = 0;
}

getpreferredweapon()
{
    if ( isdefined( self.wantshotgun ) && self.wantshotgun )
    {
        if ( scripts\anim\utility_common.gsc::isshotgun( self.primaryweapon ) )
            return self.primaryweapon;
        else if ( scripts\anim\utility_common.gsc::isshotgun( self.secondaryweapon ) )
            return self.secondaryweapon;
    }

    return self.primaryweapon;
}

notetrackguntochest( var_0, var_1 )
{
    if ( isdefined( self.fnplaceweaponon ) )
        self [[ self.fnplaceweaponon ]]( self.weapon, "chest" );
}

notetrackguntoback( var_0, var_1 )
{
    if ( isdefined( self.fnplaceweaponon ) )
        self [[ self.fnplaceweaponon ]]( self.weapon, "back" );

    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

notetrackpistolpickup( var_0, var_1 )
{
    if ( isdefined( self.fnplaceweaponon ) )
        self [[ self.fnplaceweaponon ]]( self.sidearm, "right" );

    self.bulletsinclip = weaponclipsize( self.weapon );
    self notify( "weapon_switch_done" );
}

notetrackpistolputaway( var_0, var_1 )
{
    if ( isdefined( self.fnplaceweaponon ) )
    {
        if ( isdefined( self.stowsidearmposition ) )
            self [[ self.fnplaceweaponon ]]( self.weapon, self.stowsidearmposition );
        else
            self [[ self.fnplaceweaponon ]]( self.weapon, "none" );
    }

    self.weapon = getpreferredweapon();
    self.bulletsinclip = weaponclipsize( self.weapon );
}

notetrackguntoright( var_0, var_1 )
{
    if ( isdefined( self.fnplaceweaponon ) )
        self [[ self.fnplaceweaponon ]]( self.weapon, "right" );

    self.bulletsinclip = weaponclipsize( self.weapon );
}

notetrackhton0( var_0, var_1 )
{
    if ( !self isinscriptedstate() )
        self enablestatelookat( 1, 0 );
}

notetrackhton1( var_0, var_1 )
{
    if ( !self isinscriptedstate() )
        self enablestatelookat( 1, 1 );
}

notetrackhtoff( var_0, var_1 )
{
    if ( !self isinscriptedstate() )
        self enablestatelookat( 0 );
}
