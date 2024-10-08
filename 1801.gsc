// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

init_flags()
{
    if ( !scripts\engine\utility::add_init_script( "init_flags", ::init_flags ) )
        return;

    level.flag = [];
    level.flags_lock = [];
    level.generic_index = 0;
    level.flag_struct = spawnstruct();
    level.flag_struct assign_unique_id();
}

assign_unique_id()
{
    self.unique_id = "generic" + level.generic_index;
    level.generic_index++;
}
