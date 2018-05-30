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
    byte zone : "gens.exe", 0x40F5C, 0xFE10;
    byte act : "gens.exe", 0x40F5C, 0xFE11;
    byte trigger  : "gens.exe", 0x40F5C, 0xF601; //new game is 8C, cutscene plays on 0x20
}

state("retroarch")  //little endian
{
	byte seconds : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE25;
	byte minutes : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE22;
	byte lives   : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE13;
    byte continues : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE19;
    byte zone : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE10;
    byte act : "genesis_plus_gx_libretro.dll", 0xF39900, 0xFE11;
    byte trigger  : "genesis_plus_gx_libretro.dll", 0xF39900, 0xF601; //new game is 8C, cutscene plays on 0x20
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
        current.previousLives = 3;
    }
}

reset
{
	return (current.lives == 0 && current.continues == 0);
}

init
{
	current.totalTime = 0;
	current.previousLives = 3;
}

split
{
	// Next level
	if (current.seconds == 0 && current.minutes == 0 && (old.minutes*60 + old.seconds) > 0 && current.lives == current.previousLives) {
		return true;
	}
    
    // Final split
    return current.trigger == 0x20;
}

gameTime
{
	// Reset
	if (current.lives == 0 && current.continues == 0) {
		current.previousLives = 3;
	}

    //main update
    if (
        (current.seconds == (old.seconds + 1)) && (current.minutes == old.minutes) || 
        (current.seconds == 0 && (current.minutes == (old.minutes + 1)))
       ) {
           current.totalTime++;
       }

	// Update extra lives
	if (current.lives > current.previousLives) {
		current.previousLives = current.lives;
	}
    if (current.lives < current.previousLives && current.minutes == 0 && current.seconds == 1) {//update prevlives after death
        current.previousLives = current.lives;
	}

	return TimeSpan.FromSeconds(current.totalTime);
}

isLoading
{
	return true;
}