// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init()
{
    initawards();
    scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback( ::onplayerspawned );
    level thread onplayerconnect();
    level thread saveaarawardsonroundswitch();
    level.givemidmatchawardfunc = ::givemidmatchaward;
}

onplayerconnect()
{
    for (;;)
    {
        level waittill( "connected", var_0 );
        var_0 thread initaarawardlist();
        var_0.awardqueue = [];
    }
}

onplayerspawned()
{
    self.awardsthislife = [];
}

initawards()
{
    initmidmatchawards();
}

initbaseaward( var_0, var_1 )
{
    level.awards[var_0] = spawnstruct();
    level.awards[var_0].type = var_1;
    var_2 = tablelookup( "mp/awardtable.csv", 1, var_0, 10 );

    if ( isdefined( var_2 ) && var_2 != "" )
        level.awards[var_0].xpscoreevent = var_2;

    var_3 = tablelookup( "mp/awardtable.csv", 1, var_0, 11 );

    if ( isdefined( var_3 ) && var_3 != "" )
        level.awards[var_0].gamescoreevent = var_3;

    var_4 = tablelookup( "mp/awardtable.csv", 1, var_0, 3 );

    if ( isdefined( var_4 ) && var_4 != "" )
        level.awards[var_0].category = var_4;

    var_5 = tablelookup( "mp/awardtable.csv", 1, var_0, 7 );

    if ( isdefined( var_5 ) && var_5 != "" )
    {
        var_6 = randomfloat( 1.0 );
        level.awards[var_0].aarpriority = float( var_5 ) + var_6;
    }
}

initbasemidmatchaward( var_0, var_1 )
{
    initbaseaward( var_0, var_1 );
}

initmidmatchaward( var_0 )
{
    initbasemidmatchaward( var_0, "midmatch" );
}

initmidmatchawards()
{
    var_0 = 0;

    for (;;)
    {
        var_1 = tablelookupbyrow( "mp/awardtable.csv", var_0, 1 );

        if ( !isdefined( var_1 ) || var_1 == "" )
            break;

        var_2 = tablelookupbyrow( "mp/awardtable.csv", var_0, 9 );

        if ( isdefined( var_2 ) && var_2 != "" )
            initmidmatchaward( var_1 );

        level.awards[var_1].id = var_0;
        var_0++;
    }
}

incplayerrecord( var_0 )
{
    var_1 = self getplayerdata( "common", "awards", var_0 );
    self setplayerdata( "common", "awards", var_0, var_1 + 1 );
}

giveaward( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7 )
{
    var_8 = undefined;

    if ( isdefined( var_6 ) && isdefined( var_6.streakinfo ) )
        var_8 = var_6.streakinfo;

    if ( !istrue( var_3 ) )
    {
        self endon( "disconnect" );
        waitframe();
        scripts\mp\utility\script::waittillslowprocessallowed();
    }

    if ( !isdefined( level.awards[var_0] ) )
        return;

    if ( isenumvaluevalid( "mp", "Awards", var_0 ) )
        addawardtoaarlist( var_0 );

    var_9 = level.awards[var_0].xpscoreevent;

    if ( isdefined( var_9 ) )
    {
        if ( isdefined( var_2 ) )
            var_10 = var_2;
        else
            var_10 = scripts\mp\rank::getscoreinfovalue( var_9 );

        scripts\mp\rank::giverankxp( var_9, var_10, var_7 );
    }

    var_11 = level.awards[var_0].gamescoreevent;

    if ( isdefined( var_11 ) )
        scripts\mp\utility\points::giveunifiedpoints( var_11, undefined, var_1, 1, var_4, var_5, var_8 );

    scripts\mp\utility\script::bufferednotify( "earned_award_buffered", var_0 );

    if ( isdefined( self.awardsthislife[var_0] ) )
        self.awardsthislife[var_0]++;
    else
        self.awardsthislife[var_0] = 1;

    scripts\common\utility::_id_13E0A( level._id_11B27, var_0 );
}

queuemidmatchaward( var_0 )
{
    self.awardqueue[self.awardqueue.size] = var_0;
    thread flushmidmatchawardqueuewhenable();
}

flushmidmatchawardqueue()
{
    foreach ( var_1 in self.awardqueue )
        givemidmatchaward( var_1 );

    self.awardqueue = [];
}

flushmidmatchawardqueuewhenable()
{
    self endon( "disconnect" );
    self notify( "flushMidMatchAwardQueueWhenAble()" );
    self endon( "flushMidMatchAwardQueueWhenAble()" );

    for (;;)
    {
        if ( !shouldqueuemidmatchaward() )
            break;

        waitframe();
    }

    thread flushmidmatchawardqueue();
}

shouldqueuemidmatchaward( var_0 )
{
    if ( level.gameended )
        return 0;

    if ( !scripts\mp\utility\player::isreallyalive( self ) )
    {
        if ( !istrue( var_0 ) || scripts\mp\utility\player::isinkillcam() )
        {
            if ( !scripts\mp\utility\player::isusingremote() )
                return 1;
        }
    }

    return 0;
}

givemidmatchaward( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8 )
{
    if ( !isplayer( self ) )
        return;

    if ( isai( self ) )
        return;

    if ( self ispcplayer() && scripts\mp\flags::gameflag( "prematch_done" ) )
        createnvidiavideo( var_0 );

    if ( shouldqueuemidmatchaward( var_3 ) )
    {
        queuemidmatchaward( var_0 );
        return;
    }

    scripts\mp\analyticslog::logevent_awardgained( var_0 );
    thread giveaward( var_0, var_1, var_2, var_4, var_5, var_6, var_7, var_8 );
}

createnvidiavideo( var_0 )
{
    var_1 = 0;

    switch ( var_0 )
    {
        case "four":
            self setclientomnvar( "nVidiaHighlights_events", 9 );
            var_1 = 1;
            break;
        case "one_shot_two_kills":
            self setclientomnvar( "nVidiaHighlights_events", 7 );
            var_1 = 1;
            break;
        case "grenade_double":
            self setclientomnvar( "nVidiaHighlights_events", 12 );
            var_1 = 1;
            break;
        case "explosive_stick":
            self setclientomnvar( "nVidiaHighlights_events", 13 );
            var_1 = 1;
            break;
        case "item_impact":
            self setclientomnvar( "nVidiaHighlights_events", 8 );
            var_1 = 1;
            break;
    }

    if ( var_1 == 0 )
    {
        if ( scripts\mp\utility\game::getgametype() == "br" )
        {
            switch ( var_0 )
            {
                case "double":
                    self setclientomnvar( "nVidiaHighlights_events", 17 );
                    break;
                case "triple":
                    self setclientomnvar( "nVidiaHighlights_events", 18 );
                    break;
                case "longshot":
                    self setclientomnvar( "nVidiaHighlights_events", 19 );
                    break;
                case "revenge":
                    self setclientomnvar( "nVidiaHighlights_events", 20 );
                    break;
                case "backstab":
                    self setclientomnvar( "nVidiaHighlights_events", 21 );
                    break;
                case "throwingknife_kill":
                    self setclientomnvar( "nVidiaHighlights_events", 22 );
                    break;
            }
        }
        else
        {
            switch ( var_0 )
            {
                case "five":
                    self setclientomnvar( "nVidiaHighlights_events", 1 );
                    break;
                case "seven":
                    self setclientomnvar( "nVidiaHighlights_events", 2 );
                    break;
                case "eight":
                    self setclientomnvar( "nVidiaHighlights_events", 3 );
                    break;
                case "streak_10":
                    self setclientomnvar( "nVidiaHighlights_events", 4 );
                    break;
                case "streak_20":
                    self setclientomnvar( "nVidiaHighlights_events", 5 );
                    break;
                case "streak_30":
                    self setclientomnvar( "nVidiaHighlights_events", 6 );
                    break;
                case "six":
                    self setclientomnvar( "nVidiaHighlights_events", 10 );
                    break;
                case "multi":
                    self setclientomnvar( "nVidiaHighlights_events", 11 );
                    break;
                case "mode_gun_melee_1st_place":
                    self setclientomnvar( "nVidiaHighlights_events", 14 );
                    break;
            }
        }
    }
}

addawardtoaarlist( var_0 )
{
    if ( !isdefined( self.aarawards ) )
    {
        self.aarawards = [];
        self.aarawardcount = 0;

        for ( var_1 = 0; var_1 < 10; var_1++ )
        {
            var_2 = spawnstruct();
            self.aarawards[var_1] = var_2;
            var_2.ref = "none";
            var_2.count = 0;
        }
    }

    foreach ( var_1, var_4 in self.aarawards )
    {
        if ( var_4.ref == var_0 )
        {
            var_4.count++;
            self setplayerdata( "common", "round", "awards", var_1, "value", var_4.count );
            return;
        }
    }

    var_5 = level.awards[var_0].aarpriority;

    for ( var_6 = 0; var_6 < self.aarawards.size; var_6++ )
    {
        var_4 = self.aarawards[var_6];

        if ( var_4.ref == "none" )
            break;

        var_7 = level.awards[var_4.ref].aarpriority;

        if ( var_5 > var_7 )
            break;
    }

    if ( var_6 >= self.aarawards.size )
        return;

    for ( var_8 = self.aarawards.size - 2; var_8 >= var_6; var_8-- )
    {
        var_9 = var_8 + 1;
        self.aarawards[var_9] = self.aarawards[var_8];
        var_4 = self.aarawards[var_9];

        if ( var_4.ref != "none" )
        {
            self setplayerdata( "common", "round", "awards", var_9, "award", var_4.ref );
            self setplayerdata( "common", "round", "awards", var_9, "value", var_4.count );
        }
    }

    var_4 = spawnstruct();
    self.aarawards[var_6] = var_4;
    var_4.ref = var_0;
    var_4.count = 1;
    self setplayerdata( "common", "round", "awards", var_6, "award", var_4.ref );
    self setplayerdata( "common", "round", "awards", var_6, "value", var_4.count );

    if ( self.aarawardcount < 10 )
    {
        self.aarawardcount++;
        self setplayerdata( "common", "round", "awardCount", self.aarawardcount );
    }

    if ( istrue( self.savedaarawards ) )
        saveaarawards();
}

initaarawardlist()
{
    self.aarawards = self.pers["aarAwards"];
    self.aarawardcount = self.pers["aarAwardCount"];

    if ( isdefined( self.aarawards ) )
        return;

    self setplayerdata( "common", "round", "awardCount", 0 );

    for ( var_0 = 0; var_0 < 10; var_0++ )
    {
        self setplayerdata( "common", "round", "awards", var_0, "award", "none" );
        self setplayerdata( "common", "round", "awards", var_0, "value", 0 );
    }
}

saveaarawardsonroundswitch()
{
    level waittill( "game_ended" );

    foreach ( var_1 in level.players )
    {
        if ( isdefined( var_1 ) && !isbot( var_1 ) )
            var_1 saveaarawards();
    }
}

saveaarawards()
{
    self.pers["aarAwards"] = self.aarawards;
    self.pers["aarAwardCount"] = self.aarawardcount;
    self.savedaarawards = 1;
}
