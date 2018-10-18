state("Fusion")
{
    short level :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte zone   :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte act    :   "Fusion.exe", 0x2A52D4, 0xEE4F;
    byte reset  :   "Fusion.exe", 0x2A52D4, 0xFFFC;
    byte trigger  :   "Fusion.exe", 0x2A52D4, 0xF600; //new game is 8C
    short timebonus  :   "Fusion.exe", 0x2A52D4, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "Fusion.exe", 0x2A52D4, 0xF7D4;
    byte chara  :   "Fusion.exe", 0x2A52D4, 0xFF09;
    ulong dez2end : "Fusion.exe", 0x2A52D4, 0xFC00;
    byte ddzboss : "Fusion.exe", 0x2A52D4, 0xB1E5;
    byte sszboss : "Fusion.exe", 0x2A52D4, 0xB279;
    byte delactive : "Fusion.exe", 0x2A52D4, 0xEEE5;
    byte onsaveselect : "Fusion.exe", 0x2A52D4, 0xFDB8;
}

state("gens")
{
    short level :   "gens.exe", 0x40F5C, 0xEE4E;
    byte zone   :   "gens.exe", 0x40F5C, 0xEE4F;
    byte act    :   "gens.exe", 0x40F5C, 0xEE4E;
    byte reset  :   "gens.exe", 0x40F5C, 0xFFFC;
    byte trigger  :   "gens.exe", 0x40F5C, 0xF601; //new game is 8C
    short timebonus  :   "gens.exe", 0x40F5C, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "gens.exe", 0x40F5C, 0xF7D4;
    byte chara  :   "gens.exe", 0x40F5C, 0xFF08;
    ulong dez2end : "gens.exe", 0x40F5C, 0xFC00;
    byte ddzboss : "gens.exe", 0x40F5C, 0xB1E4;
    byte sszboss : "gens.exe", 0x40F5C, 0xB278;
    byte delactive : "gens.exe", 0x40F5C, 0xEEE5;
    byte onsaveselect : "gens.exe", 0x40F5C, 0xFDB8;
}

state("retroarch")
{
    short level :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEE4E;
    byte zone   :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEE4F;
    byte act    :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEE4E;
    byte reset  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFFFC;
    byte trigger  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xF601; //new game is 8C
    short timebonus  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xF7D4;
    byte chara  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFF08;
    ulong dez2end : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFC00;
    byte ddzboss : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xB1E4;
    byte sszboss : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xB278;
    byte delactive : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEEE5;
    byte onsaveselect : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFDB8;
}

state("blastem")
{
    short level :   0x001FB410, 0x68, 0xEE4E;
    byte zone   :   0x001FB410, 0x68, 0xEE4F;
    byte act    :   0x001FB410, 0x68, 0xEE4E;
    byte reset  :   0x001FB410, 0x68, 0xFFFC;
    byte trigger  :   0x001FB410, 0x68, 0xF601; //new game is 8C
    short timebonus  :   0x001FB410, 0x68, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   0x001FB410, 0x68, 0xF7D4;
    byte chara  :   0x001FB410, 0x68, 0xFF08;
    ulong dez2end : 0x001FB410, 0x68, 0xFC00;
    byte ddzboss : 0x001FB410, 0x68, 0xB1E4;
    byte sszboss : 0x001FB410, 0x68, 0xB278;
    byte delactive : 0x001FB410, 0x68, 0xEEE5;
    byte onsaveselect : 0x001FB410, 0x68, 0xFDB8;
}


state("SEGAGameRoom")
{
    short level :   "GenesisEmuWrapper.dll", 0xB677E8, 0xEE4E;
    byte zone   :   "GenesisEmuWrapper.dll", 0xB677E8, 0xEE4F;
    byte act    :   "GenesisEmuWrapper.dll", 0xB677E8, 0xEE4E;
    byte reset  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xFFFC;
    byte trigger  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xF601; //new game is 8C
    short timebonus  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xF7D4;
    byte chara  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xFF08;
    ulong dez2end : "GenesisEmuWrapper.dll", 0xB677E8, 0xFC00;
    byte ddzboss : "GenesisEmuWrapper.dll", 0xB677E8, 0xB1E4;
    byte sszboss : "GenesisEmuWrapper.dll", 0xB677E8, 0xB278;
    byte delactive : "GenesisEmuWrapper.dll", 0xB677E8, 0xEEE5;
    byte onsaveselect : "GenesisEmuWrapper.dll", 0xB677E8, 0xFDB8;
}

state("SEGAGenesisClassics")
{
    short level :   "SEGAGenesisClassics.exe", 0x71704, 0xEE4E;
    byte zone   :   "SEGAGenesisClassics.exe", 0x71704, 0xEE4F;
    byte act    :   "SEGAGenesisClassics.exe", 0x71704, 0xEE4E;
    byte reset  :   "SEGAGenesisClassics.exe", 0x71704, 0xFFFC;
    byte trigger  :   "SEGAGenesisClassics.exe", 0x71704, 0xF601; //new game is 8C
    short timebonus  :   "SEGAGenesisClassics.exe", 0x71704, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "SEGAGenesisClassics.exe", 0x71704, 0xF7D4;
    byte chara  :   "SEGAGenesisClassics.exe", 0x71704, 0xFF08;
    ulong dez2end : "SEGAGenesisClassics.exe", 0x71704, 0xFC00;
    byte ddzboss : "SEGAGenesisClassics.exe", 0x71704, 0xB1E4;
    byte sszboss : "SEGAGenesisClassics.exe", 0x71704, 0xB278;
    byte delactive : "SEGAGenesisClassics.exe", 0x71704, 0xEEE5;
    byte onsaveselect : "SEGAGenesisClassics.exe", 0x71704, 0xFDB8;
}

startup
{
    settings.Add("actsplit", false, "Split on each Act");
    settings.SetToolTip("actsplit", "If unchecked, will only split at the end of each Zone.");
    
    settings.Add("act_mg1", false, "Ignore Marble Garden 1", "actsplit");
    settings.Add("act_ic1", false, "Ignore Ice Cap 1", "actsplit");
    settings.Add("act_lb1", false, "Ignore Launch Base 1", "actsplit");
    
    settings.SetToolTip("act_mg1", "If checked, will not split the end of the first Act. Use if you have per act splits generally but not for this zone.");
    settings.SetToolTip("act_ic1", "If checked, will not split the end of the first Act. Use if you have per act splits generally but not for this zone.");
    settings.SetToolTip("act_lb1", "If checked, will not split the end of the first Act. Use if you have per act splits generally but not for this zone.");


    Action<string> DebugOutput = (text) => {
        print("[S3K Autosplitter] "+text);
    };

    Action<ExpandoObject> DebugOutputExpando = (ExpandoObject dynamicObject) => {
            var dynamicDictionary = dynamicObject as IDictionary<string, object>;
         
            foreach(KeyValuePair<string, object> property in dynamicDictionary)
            {
                print(String.Format("[S3K Autosplitter] {0}: {1}", property.Key, property.Value.ToString()));
            }
            print("");
    };
    vars.DebugOutput = DebugOutput;
    vars.DebugOutputExpando = DebugOutputExpando;
}

init
{
    vars.bonus = false;
    vars.stopwatch = new Stopwatch();
    vars.nextzone = 0;
    vars.nextact = 1;
    vars.dez2split = false;
    vars.ddzsplit = false;
    vars.sszsplit = false; //boss is defeated twice

}

update
{
    // Stores the curent phase the timer is in, so we can use the old one on the next frame.

    current.timerPhase = timer.CurrentPhase;

    //vars.DebugOutputExpando(current);
    if(((IDictionary<String, object>)old).ContainsKey("timerPhase")) {
        if ((old.timerPhase != current.timerPhase && old.timerPhase != TimerPhase.Paused) && current.timerPhase == TimerPhase.Running)
        //pressed start run or autostarted run
        {
            vars.DebugOutput("run start detected");
            
            vars.nextzone = 0;
            vars.nextact = 1;
            vars.dez2split = false;
            vars.ddzsplit = false;
            vars.sszsplit = false;
            vars.bonus = false;
        }
    }
}

start
{
    if (current.trigger == 0x8C && current.act == 0 && current.zone == 0)
    {
        vars.DebugOutput(String.Format("next split on: zone: {0} act: {1}", vars.nextzone, vars.nextact));
        return true;
    }
}

reset
{
    // detecting memory checksum at end of RAM area being 0 - only changes if ROM is reloaded (Hard Reset)
    // or if "DEL" is selected from the save file select menu.
    if ( ( current.reset == 0 && old.reset != 0 ) || ( current.onsaveselect == 0xFF && current.delactive == 0xFF && old.delactive == 0 ) )  
    {
        return true;
    }
}

split
{
    bool split = false;
    if (current.zone == vars.nextzone && current.act == vars.nextact)
    {
        switch((int)current.zone) //current zone is the zone now loading
        {
            //next act will be same zone, act increment, next zone will be current zone + 1 act 0
            case 0: //Angel Island
            case 1: //Hydrocity
            case 8: //Sandopolis
                vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
                if (current.act == 1) //starting act 2
                {
                    vars.nextzone++; //if we just incremented next act past act 2 increment the zone
                    if (settings["actsplit"]) split = true;
                }
                else //starting act 1 of new zone
                {
                    split = true;
                }
                break;
            case 2: //Marble Garden
                vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
                if (current.act == 1) //starting act 2
                {
                    vars.nextzone++; //if we just incremented next act past act 2 increment the zone
                    if (settings["actsplit"] && !settings["act_mg1"]) split = true;
                }
                else //starting act 1 of new zone
                {
                    split = true;
                }
                break;
            case 3: //Carnival Night
                vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
                if (current.act == 1) //starting act 2
                {
                    vars.nextzone = 5; //next is Icecap
                    if (settings["actsplit"]) split = true;
                }
                else //starting act 1 of new zone
                {
                    split = true;
                }
                break;
            case 5: //Icecap
                if (settings["actsplit"] && settings["act_ic1"]) {
                    // We only have 1 split for Ice Cap, so we just wait until we get to Launch Base
                    // Before splitting.
                    // This would handle beating the boss, and also doing the boss skip.
                    vars.nextzone++;
                } else {
                    vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
                    if (current.act == 1) //starting act 2
                    {
                        vars.nextzone++; //if we just incremented next act past act 2 increment the zone
                    }
                    
                }
                split = true;
                break;
            case 6: //Launch Base
                vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
                if (current.act == 1) //starting act 2
                {
                    vars.nextzone++; //if we just incremented next act past act 2 increment the zone
                    if (settings["actsplit"] && !settings["act_lb1"]) split = true;
                }
                else //starting act 1 of new zone
                {
                    split = true;
                }
                break;
            case 7: //Mushroom Hill
                vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
                if (current.act == 1) //starting act 2
                {
                    vars.nextzone = 4; //next is FB
                    if (settings["actsplit"]) split = true;
                }
                else //starting act 1 of new zone
                {
                    split = true;
                }
                break;
            case 4: //Flying Battery
                vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
                if (vars.nextact == 0) vars.nextzone = 8; //if we just incremented next act past act 2 next zone is Sandopolis
                if (current.act == 1) //FB2 start
                {
                    vars.nextzone = 8; //next is Sandopolis
                    if (settings["actsplit"]) split = true;
                }
                else 
                {
                    split = true;   //Split MH2
                }
                break;
            case 9: //Lava Reef
                    switch ((int)current.act)
                    {
                        case 0:
                            vars.nextact = 1; //LR2
                            split = true; //Split Sandopolis 2
                            break;
                        case 1:
                            vars.nextzone = 22; //LR2Boss
                            vars.nextact = 1;// LR2Boss/HP next - but we don't care about splitting before LR2 boss so just skip that one
                            if (settings["actsplit"]) split = true; //Split LR1
                            break;
                    }
                break;
            case 22: //LR2 boss/Hidden Palace
                if (current.act == 1) //loading Hidden Palace
                {
                    if (current.chara == 3) { vars.nextact = 1; } else { vars.nextact = 0; } //Sky Sanctuary next
                    vars.nextzone = 10;
                    split = true;   //Split LR2
                }
                break;
            case 10: //Sky Sanctuary
                split = true;   //split HPZ
                switch ((int)current.chara)
                {
                    case 0:
                    case 1:
                    case 2:
                        vars.nextzone = 11; //DEZ
                        vars.nextact = 0;
                        break;
                    case 3:
                        break;
                }
                break;
            case 11: //DEZ
                if (current.act == 0) //loading DEZ
                {
                    split = true; //split SSZ
                    vars.nextact = 1;
                }
                else
                {
                    vars.nextact = 0;
                    vars.nextzone = 23;
                    if (settings["actsplit"]) split = true; //Split DEZ1
                }
                break;
            case 23: //DEZ boss
                vars.nextact = 0;
                vars.nextzone = 12;
                break;
            case 12: //Doomsday
                break; //We have already split for DE2 by detecting the whiteout
        }
    }
    
    if (!vars.dez2split && current.zone == 23 && current.act == 0) //detect fade to white on death egg 2
    {
        if ((current.dez2end == 0xEE0EEE0EEE0EEE0E && old.dez2end == 0xEE0EEE0EEE0EEE0E) ||
            (current.dez2end == 0x0EEE0EEE0EEE0EEE && old.dez2end == 0x0EEE0EEE0EEE0EEE))
        {
            vars.DebugOutput("DEZ2 Boss White Screen detected");
            vars.dez2split = true;
            split = true;
        }
    }
    
    if (current.zone == 12 && current.ddzboss == 255 && old.ddzboss == 0) //Doomsday boss detect final hit
    {
        vars.DebugOutput("Doomsday Zone Boss death detected"); //need to detect fade to white, same as DEZ2End
        vars.ddzsplit = true;
    }
    
    if (vars.ddzsplit) //detect fade to white on doomsday
    {
        if ((current.dez2end == 0xEE0EEE0EEE0EEE0E && old.dez2end == 0xEE0EEE0EEE0EEE0E) ||
            (current.dez2end == 0x0EEE0EEE0EEE0EEE && old.dez2end == 0x0EEE0EEE0EEE0EEE))
        {
            vars.DebugOutput("Doomsday White Screen detected");
            split = true;
        }
    }
    

    if (current.chara == 3 && current.zone == 10) //detect final hit on Knux Sky Sanctuary Boss
    {
        if (current.sszboss == 0 && old.sszboss == 1)
        {
            if (vars.sszsplit)
            {
                vars.DebugOutput("Knuckles Final Boss death detected");
                split = true;
            }
            else
            {
                vars.DebugOutput("Knuckles Final Boss 1st phase defeat detected");
                vars.sszsplit = true;
            }
        }
    }
    
    if (split)
    {
        vars.DebugOutput(String.Format("old level: {0:X4} old zone: {1} old act: {2}", old.level, old.zone, old.act));
        vars.DebugOutput(String.Format("level: {0:X4} zone: {1} act: {2}", current.level, current.zone, current.act));
        vars.DebugOutput(String.Format("next split on: zone: {0} act: {1}", vars.nextzone, vars.nextact));
        return true;
    }
}

isLoading
{
    
    if ( vars.bonus && current.timebonus == 0 ) {
        // If we had a bonus, and the timebonus is now 0, reset it
        vars.bonus = false;
    } else if ( !vars.bonus && current.act <= 1 && current.timebonus < old.timebonus ) {
        // if we haven't detected a bonus yet
        // check that we are in an act (sanity check)
        // then check to see if the current timebonus is less than the previous frame's one.
        }
        vars.bonus = true;
    }
    return vars.bonus;

}
