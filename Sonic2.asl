state("Fusion")
{
	byte seconds : "Fusion.exe", 0x2A52D4, 0xFE24;
	byte minutes : "Fusion.exe", 0x2A52D4, 0xFE23;
	byte lives   : "Fusion.exe", 0x2A52D4, 0xFE12;
    byte continues : "Fusion.exe", 0x2A52D4, 0xFE18;
	byte introPlaying: "Fusion.exe", 0x2A52D4, 0xFFF1;
	byte finalSplit:  "Fusion.exe", 0x2A52D4, 0xB44C;
    byte bossHP: "Fusion.exe", 0x2A52D4, 0xB461;
	byte runStart:  "Fusion.exe", 0x2A52D4, 0xFE1D;
}

start
{
	if (current.seconds == 0 && current.minutes == 0 && current.lives == 3 && current.introPlaying == 1) {
		current.demoStarted = true;
	}
	
	if (current.introPlaying == 0 && current.demoStarted == true) {
		current.demoStarted = false;
	}

	if (current.seconds == 0 && current.minutes == 0 && current.lives == 3 && current.introPlaying != 1) {
		current.totalTime = 0;
		current.levelCounter = 0;
        current.endSplitReady = 0;
		return (current.introPlaying == 0 && current.demoStarted == false && current.runStart == 1);
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
	current.levelCounter = 0;
    current.endSplitReady = 0;
	current.demoStarted = false;
}

split
{
	// Next level
	if (current.seconds == 0 && current.minutes == 0 && (old.minutes*60 + old.seconds) > 0 && current.lives == current.previousLives) {
		current.levelCounter += 1;
		return true;
		
		
	// Final split
	} else if (current.endSplitReady == 1 && current.finalSplit == 0 && current.bossHP == 0 && current.lives == current.previousLives) {
        current.endSplitReady = 0;
		return current.finalSplit == 0;
	}
}

gameTime
{
	// Reset
	if (current.lives == 0 && current.continues == 0) {
		current.totalTime = 0;
		current.addedTime = 0;
		current.levelTime = 0;
		current.previousLives = 3;
		current.demoStarted = false;
		current.levelCounter = 0;
        current.endSplitReady = 0;
	}

    //main update
    if (
        (current.seconds == (old.seconds + 1)) && (current.mins == old.mins) || 
        (current.seconds == 0 && (current.minutes == (old.minutes + 1)))
       ) {
           current.totalTime++;
       }

    //handle final level split
    if (current.levelCounter == 19 && current.endSplitReady == 0 && current.bossHP == 12) //
    {
        current.endSplitReady = 1;
    }
    
    //and reset flag on death on last boss
    if (current.endSplitReady == 1 && current.lives < old.lives)
    {
        current.endSplitReady = 2;  //the lives are decremented before the boss hp is cleared, turning this back on
    }
    
    if (current.endSplitReady == 2 && current.bossHP == 0) //reset the flag after the level has reloaded
    {
        current.endSplitReady = 0;
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