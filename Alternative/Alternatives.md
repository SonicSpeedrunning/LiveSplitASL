# Alternatives
Autosplit alternatives

# Sonic 3 & Knuckles
This variant does not have an internal level counter and looks for specific changes to the current level value. This approach does not have support for resetting the emulator mid-run.


# Sonic CD 2011
This older attempt reads the current level's timer, keeps a store of any time accumulated between a death and the last checkpoint (additively, in case of multiple deaths) and then adds them to a 3rd overall timer on a level change. As there were certain cases where the timer could actually decrease, if even for a second, I decided it was not a suitable approach.