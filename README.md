# LiveSplitASL
Autosplits for LiveSplit

# Sonic 2
for Kega Fusion and RetroArch (Genesis Plus GX Core)

RAM locations provided by the Sonic Retro wiki.

Uses https://github.com/tenebrae101/Sonic1AutoSplitter as a base, but uses "dumb logic": the timer is only interested in increasing seconds and doesn't care what the actual timer is. If the game's timer increases by a second, so does the autosplit timer - any other modification to the timer is ignored. This bypasses issues handling deaths, checkpoint respawns and a game over/continue state.

Final Split is after the screen completely fades to white.

Auto-starts when GHZ1 loads while not playing a demo.

Auto-resets on running out of lives and continues.

Splits when the timer is set to 0 without the life counter changing.

Expects a split for every Act.


# Sonic 3 & Knuckles
For Kega Fusion, Gens Rerecording Project and RetroArch (Genesis Plus GX Core)

RAM locations provided by the Sonic Retro wiki.

Expansion from the Sonic 2 Autosplit, however as this game uses Real Time - Time Bonus, the timer logic was changed.

Runs Game Time as Real Time, except it pauses during score countdown. Detected by time bonus and/or ring bonus values decreasing, pauses the timer for every frame that they decrease.

Level order is hard-coded, and the next split will not occur until the timer "sees" the next expected level. This means that resetting to skip cutscenes/game overs etc do not break, but also means that if there's a game over on act 2 of a zone, completion of act 1 will *NOT* split again - the script will already be waiting on act 2 to be completed.

The default option is to have splits Per-Zone only, but there is an option to split per-act. Due to the way S3&K runs can be exploited, per act is not favourable either - options to ignore splitting on act 1 of Marble Garden, Ice Cap and Launch Base have been added so these zones would only split once when otherwise splitting every act.

Supports all characters, but only S3&K at this time, no support for S3 or S&K only.

Splits on level load, final split is after the screen completely fades to white.

**Important** Auto-Resets on "Hard Reset" pressed - expects resets for cutscene skips to be a soft reset. Disable auto-reset if this is undesired - the previous behaviour that reset the internal state of the autosplitter now does not trigger in this condition to allow for this.

Auto-starts on AIZ1 loaded and game started flag set.


# Sonic CD 2011
For Sonic CD 2011 (Steam)

Some memory values provided by a cheat table made by CodeNameGamma.

Uses the same "dumb logic" as Sonic 2 - we only care about the timer increasing each second.

Adds the milliseconds to the Game Time on the final level.

Splits on detecting time bonus hit 0 after it was previously set.

Final split is on the final hit on the last boss.

Expects a split for every act. (Standard terminology, so 3 acts per zone)

**Known Bug:** will split on completing a Special Stage, however as the special stages are not part of any known run I feel this is a non-issue.

Currently no auto-start or auto-reset as previous implementation attempts were undesirable.
