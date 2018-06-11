state("Fusion") //converts to big-endian
{
	byte seconds : "Fusion.exe", 0x2A52D4, 0xFE24;
	byte minutes : "Fusion.exe", 0x2A52D4, 0xFE23;
	byte lives   : "Fusion.exe", 0x2A52D4, 0xFE12;
    byte continues : "Fusion.exe", 0x2A52D4, 0xFE18;
    byte zone   : "Fusion.exe", 0x2A52D4, 0xFE10;
    byte act    : "Fusion.exe", 0x2A52D4, 0xFE11;
    byte trigger  : "Fusion.exe", 0x2A52D4, 0xF600; //new game is 8C, cutscene plays on 0x20
}

state("gens")   //little endian
{
	byte seconds : "gens.exe", 0x40F5C, 0xFE25;
	byte minutes : "gens.exe", 0x40F5C, 0xFE22;
	byte lives   : "gens.exe", 0x40F5C, 0xFE13;
    byte continues : "gens.exe", 0x40F5C, 0xFE19;
    byte zone : "gens.exe", 0x40F5C, 0xFE11;
    byte act : "gens.exe", 0x40F5C, 0xFE10;
    byte trigger  : "gens.exe", 0x40F5C, 0xF601; //new game is 8C, cutscene plays on 0x20
}

state("retroarch")  //little endian
{
	byte seconds : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE25;
	byte minutes : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE22;
	byte lives   : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE13;
    byte continues : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE19;
    byte zone : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE11;
    byte act : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE10;
    byte trigger  : "genesis_plus_gx_libretro.dll", 0xF39900, 0xF601; //new game is 8C, cutscene plays on 0x20
}

state("SEGAGameRoom")  //little endian
{
	byte seconds : "GenesisEmuWrapper.dll", 0xB677E8, 0xFE25;
	byte minutes : "GenesisEmuWrapper.dll", 0xB677E8, 0xFE22;
	byte lives   : "GenesisEmuWrapper.dll", 0xB677E8, 0xFE13;
    byte continues : "GenesisEmuWrapper.dll", 0xB677E8, 0xFE19;
    byte zone : "GenesisEmuWrapper.dll", 0xB677E8, 0xFE11;
    byte act : "GenesisEmuWrapper.dll", 0xB677E8, 0xFE10;
    byte trigger  : "GenesisEmuWrapper.dll", 0xB677E8, 0xF601; //new game is 8C, cutscene plays on 0x20
}

state("SEGAGenesisClassics")  //little endian
{
	byte seconds : "SEGAGenesisClassics.exe", 0x71704, 0xFE25;
	byte minutes : "SEGAGenesisClassics.exe", 0x71704, 0xFE22;
	byte lives   : "SEGAGenesisClassics.exe", 0x71704, 0xFE13;
    byte continues : "SEGAGenesisClassics.exe", 0x71704, 0xFE19;
    byte zone : "SEGAGenesisClassics.exe", 0x71704, 0xFE11;
    byte act : "SEGAGenesisClassics.exe", 0x71704, 0xFE10;
    byte trigger  : "SEGAGenesisClassics.exe", 0x71704, 0xF601; //new game is 8C, cutscene plays on 0x20
}

start
{
	return (current.trigger == 0x8C && current.act == 0 && current.zone == 0);
}

update
{
    // Stores the curent phase the timer is in, so we can use the old one on the next frame.
	current.timerPhase = timer.CurrentPhase;
    
    if ((old.timerPhase != current.timerPhase && old.timerPhase != TimerPhase.Paused) && current.timerPhase == TimerPhase.Running)
    //pressed start run or autostarted run
    {
        print("run start detected");
        
        current.totalTime = 0;
        vars.pause = false;
    }
}

reset
{
	return (current.lives == 0 && current.continues == 0);
}

init
{
	current.totalTime = 0;
    vars.pause = false;
    vars.actsplits = new bool[][]
    {
        new bool[] {true, true, true}, // 0 - Green Hill Zone
        new bool[] {true, true, true, true}, // 1 - Labyrinth Zone
        new bool[] {true, true, true}, // 2 - Marble Zone
        new bool[] {true, true, true}, // 3 - Star Light Zone
        new bool[] {true, true, true}, // 4 - Spring Yard Zone
        new bool[] {true, true, true} // 5 - Scrap Brain Zone
    };
}

split
{
    if ((current.act != old.act || current.zone != old.zone) &&
        vars.actsplits[current.zone][current.act] && vars.actsplits[old.zone][old.act]) //act changed or zone changed, and both new and old levels are in the split list
    {
        if(current.act == 2 && current.zone == 5) vars.pause = true; //the timer keeps counting for 3 seconds at the start of final zone, as SB3 doesn't pause the timer
        return true;
    }
    
    // Final split
    return current.trigger == 0x18;
}

gameTime
{
    //main update
    if (!vars.pause)
    {
        if (
            (current.seconds == (old.seconds + 1)) && (current.minutes == old.minutes) || 
            (current.seconds == 0 && (current.minutes == (old.minutes + 1)))
            ) 
        {
            current.totalTime++;
        }
    }
    else if (current.seconds == 0 && current.minutes == 0) vars.pause = false; //unpause timer once game time has reset
	return TimeSpan.FromSeconds(current.totalTime);
}

isLoading
{
	return true;
}