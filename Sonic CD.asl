
state("soniccd")
{
    byte millisecs : "soniccd.exe", 0xF9F2F0;
    byte seconds : "soniccd.exe", 0xE2A378;
    byte mins : "soniccd.exe", 0xF9F2F3;
	int timeBonus : "soniccd.exe", 0xC3DEFC;
    int ringBonus : "soniccd.exe", 0xC3DF00;
    byte levelID : "soniccd.exe", 0xF9F294;
    byte bhpGood : "soniccd.exe", 0xC40EB8;
    byte bhpBad : "soniccd.exe", 0xC40EFC;
}

startup
{
    //to see debug messages, get DbgView from https://live.sysinternals.com/files/DebugView.zip
    settings.Add("debug", false, null, null);
}

init
{
    if (settings["debug"]) {
        print("init detected");
    }
    vars.time = new TimeSpan(0);
    vars.ms = new TimeSpan(0);
    vars.boss = 0;
}

update
{
    // Stores the curent phase the timer is in, so we can use the old one on the next frame.
	current.timerPhase = timer.CurrentPhase;

    // Reset some variables when the timer is started
	if ((old.timerPhase != current.timerPhase && old.timerPhase != TimerPhase.Paused) && current.timerPhase == TimerPhase.Running) {
        if (settings["debug"]) {
            print("run start detected");
        }
        vars.time = new TimeSpan(0);
        vars.ms = new TimeSpan(0);
        vars.boss = 0; 
    }
    
    //add seconds
    if (
        (current.seconds == (old.seconds + 1)) && (current.mins == old.mins) || 
        (current.seconds == 0 && (current.mins == (old.mins + 1)))
       ) {
           vars.time = vars.time.Add(TimeSpan.FromSeconds(1));
    }
    
    if (current.levelID == 68 || current.levelID == 69)
    {
        vars.ms = TimeSpan.FromMilliseconds(current.millisecs * 10);
    }
    
	return true;
}

gameTime
{
    //our saved tally of the overall run + any extra time from deaths this level + the current game time
    return vars.time.Add(vars.ms);
}

isLoading
{
    //stop the timer counting in real time, we're updating the clock manually
	return true;
}

split
{
    if (current.timeBonus == 0 && old.timeBonus > 0) {
        if (settings["debug"]) {
            print("splitting - current time: " + vars.time.ToString());
        }
        return true;
    }
    
    if (current.levelID == 68 || current.levelID == 69)
    {
        if (vars.boss == 0) {
            if (current.bhpGood == 4 && old.bhpGood == 0)
            {
                if (settings["debug"]) {
                    print("good future boss detected");
                }
                vars.boss = 1;
            }
            if (current.bhpBad == 4 && old.bhpBad == 0)
            {
                if (settings["debug"]) {
                    print("bad future boss detected");
                }
                vars.boss = 2;
            }
        }
            
        if (vars.boss == 1) { //good future
            if (current.bhpGood == 0 && old.bhpGood == 1) { 
                if (settings["debug"]) {
                    print("final split - boss death detected");
                }
                return true; 
            }
        }
            
        if (vars.boss == 2) { //bad future
            if (current.bhpBad == 0 && old.bhpBad == 1) { 
                if (settings["debug"]) {
                    print("final split - boss death detected");
                }
                return true;
            }
        }
    }
        
    return false;
}
