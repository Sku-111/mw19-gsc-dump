// IW8 GSC SOURCE
// Generated by https://github.com/xensik/gsc-tool

asm_register()
{
    if ( !isdefined( anim.asmfuncs ) )
        anim.asmfuncs = [];

    if ( isdefined( anim.asmfuncs["playerasm_void"] ) )
        return;

    anim.asmfuncs["playerasm_void"] = [];
}
