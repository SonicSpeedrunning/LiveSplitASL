
state("soniccd")
{
    byte seconds : "soniccd.exe", 0xE2A378;
    byte mins : "soniccd.exe", 0xF9F2F3;
	int timeBonus : "soniccd.exe", 0xC3DEFC;
    int ringBonus : "soniccd.exe", 0xC3DF00;
    int lives : "soniccd.exe", 0xC0709C;
    byte cpSecs : "soniccd.exe", 0xC070C4;
    byte cpMins : "soniccd.exe", 0xC070C8;
    byte cpActive : "soniccd.exe", 0xC070CC;
    byte trGame : "soniccd.exe", 0x111E8CE;
}

startup
{
    //to see debug messages, get DbgView from https://live.sysinternals.com/files/DebugView.zip
    settings.Add("debug", false, null, null);
}

init
{
    if (settings["debug"]) {
        print("reset detected");
    }
    vars.split = false;
    vars.time = new TimeSpan(0);
    vars.addedTime = new TimeSpan(0);
    vars.prevLevelTime = new TimeSpan(0);
}

update
{
    //onDeath
    if (current.lives == old.lives - 1) { //player died
        if (settings["debug"]) {
            print("OnDeath: current addedTime: " + vars.addedTime.ToString());
        }
        if (current.cpActive != 0) { //we're respawning at a checkpoint, so we need to account for the time between passing the cp and the current time
            vars.addedTime += (TimeSpan.FromSeconds((current.mins * 60) + current.seconds) - TimeSpan.FromSeconds((current.cpMins * 60) + current.cpSecs)); 
        }
        else { //respawning at the start of a level and the game time will be 0, just add the current game time
            vars.addedTime += TimeSpan.FromSeconds((current.mins * 60) + current.seconds); 
        }
        if (settings["debug"]) {
            print("OnDeath: current time: " + current.mins + ":" + current.seconds + "; addedTime: " + vars.addedTime.ToString());
        }
    }

    //clean up on a game over
    if (current.lives == 0) { 
        if (settings["debug"]) {
            print("reset detected");
        }
        vars.time = new TimeSpan(0);
        vars.addedTime = new TimeSpan(0);
        vars.prevLevelTime = new TimeSpan(0);
    }
    
    //end of level score count done, time to split
    if (current.timeBonus == 0 && old.timeBonus > 0) {
        vars.prevLevelTime = vars.addedTime + TimeSpan.FromSeconds((current.mins * 60) + current.seconds);
        vars.split = true;
    }  
    
    //add and reset prev level recorded time to overall time
    //this is so there isn't a moment where the current stage's time is added to the clock while the game time hasn't reset
    if (current.mins == 0 && current.seconds == 0 && vars.prevLevelTime != TimeSpan.Zero) {
        if (settings["debug"]) {
            print("new level detected");
        }
        vars.time += vars.prevLevelTime;
        vars.prevLevelTime = new TimeSpan(0);
        vars.addedTime = new TimeSpan(0);
    }
    
	return true;
}

gameTime
{
    //our saved tally of the overall run + any extra time from deaths this level + the current game time
    return vars.time + vars.addedTime + TimeSpan.FromSeconds((current.mins * 60) + current.seconds);
}

isLoading
{
    //stop the timer counting in real time, we're updating the clock manually
	return true;
}

split
{
    if (vars.split) {
        vars.split = false;
        return true;
    }
    
    //detect the load of BadEnding.ogv or GoodEnding.ogv
    if (((current.trGame == 0x42) && !(old.trGame == 0x42)) || ((current.trGame == 0x47) && !(old.trGame == 0x47))) {
        if (settings["debug"]) {
            print("end game");
        }
        return true;
    }
    
    return false;
}

start
{
    //detect the unload of Opening.ogv
   if (!(current.trGame == 0x4F) && (old.trGame == 0x4F)) {
       if (settings["debug"]) {
            print("new game started");
       }
       vars.split = false;
       vars.time = new TimeSpan(0);
       vars.addedTime = new TimeSpan(0);
       vars.prevLevelTime = new TimeSpan(0);
       return true;
   }
}
 
 