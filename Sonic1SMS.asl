/** 
 * ASL Script for LiveSplit
 * Game: Sonic the Hedgehog (SMS)
 * Author: icy (https://www.speedrun.com/user/icy_)
 * Notes:
 *	- Only Supports "Sonic The Hedgehog (USA, Europe).sms" version of the game running in Fusion 3.64
 *	- If you experience any problems or have questions, send me a twitch whisper (https://www.twitch.tv/icy_vg)
 *	- You have to manually setup 18 splits for the auto splitter to do it's work
 *	- Splits according to SRC rules
 *	- If in LiveSplit layout settings "Game Time" is selected, the timing is RTA-TimeBonus
 *	- The "Game Time" timing method may be a bit inaccurate with deviations in the <1s range, so use with caution
 */

state("Fusion")
{
	byte level : "fusion.exe",0x002A52D8,0xD23E;
	byte state : "fusion.exe",0x002A52D8,0xD000;
	byte endBoss : "fusion.exe",0x002A52D8,0xD2D5;
	ushort timebonus : "fusion.exe",0x002A52D8,0xD213;
	byte scorescreen : "fusion.exe",0x002A52D8,0xD22C;
	byte scorescd : "fusion.exe",0x002A52D8,0xDFEA;
	byte input : "fusion.exe",0x002A52D8,0xD203;
}

state("retroarch","32bit")
{
	byte level : "genesis_plus_gx_libretro.dll",0x01AF84,0x123E;
	byte state : "genesis_plus_gx_libretro.dll",0x01AF84,0x1000;
	byte endBoss : "genesis_plus_gx_libretro.dll",0x01AF84,0x12D5;
	ushort timebonus : "genesis_plus_gx_libretro.dll",0x01AF84,0x1213;
	byte scorescreen : "genesis_plus_gx_libretro.dll",0x01AF84,0x122C;
	byte scorescd : "genesis_plus_gx_libretro.dll",0x01AF84,0x1FEA;
	byte input : "genesis_plus_gx_libretro.dll",0x01AF84,0x1203;
}

state("retroarch","64bit")
{
	byte level : "genesis_plus_gx_libretro.dll",0x24A3D0,0x123E;
	byte state : "genesis_plus_gx_libretro.dll",0x24A3D0,0x1000;
	byte endBoss : "genesis_plus_gx_libretro.dll",0x24A3D0,0x12D5;
	ushort timebonus : "genesis_plus_gx_libretro.dll",0x24A3D0,0x1213;
	byte scorescreen : "genesis_plus_gx_libretro.dll",0x24A3D0,0x122C;
	byte scorescd : "genesis_plus_gx_libretro.dll",0x24A3D0,0x1FEA;
	byte input : "genesis_plus_gx_libretro.dll",0x24A3D0,0x1203;
}


startup
{
	Action<string> DebugOutput = (text) => {
		print("[Sonic 1 SMS Autosplitter] "+text);
	};
	vars.DebugOutput = DebugOutput;
}

init
{
	if ( game.ProcessName == "retroarch" ) {
        if ( game.Is64Bit() ) {
            version = "64bit";
        } else {
            version = "32bit";
        }
    }
}

exit
{
}

update
{
	return true;
}

start
{
	
	if (old.state == 128 && current.state == 224 && current.level == 0 && current.input != 255) {
		vars.DebugOutput("Timer started");
		return true;
	}
}

split
{
	if (((current.level != old.level && current.level <= 17)
		|| (current.endBoss==89 && old.endBoss!=89 && current.level==17)) && (current.state != 0))
	{
		vars.DebugOutput(String.Format("Split Start of Level {0}", current.level));
		return true;
	}
}

isLoading
{
	return (current.timebonus >0 && current.scorescreen==27 && current.scorescd==22);
}


