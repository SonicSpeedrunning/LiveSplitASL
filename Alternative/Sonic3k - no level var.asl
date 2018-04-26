state("Fusion")
{
    short level :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte zone   :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte act    :   "Fusion.exe", 0x2A52D4, 0xEE4F;
    byte reset  :   "Fusion.exe", 0x2A52D4, 0xFFFC;
    byte trigger  :   "Fusion.exe", 0x2A52D4, 0xF600; //new game is 8C
    short timebonus  :   "Fusion.exe", 0x2A52D4, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "Fusion.exe", 0x2A52D4, 0xF7D4;
}

startup
{
    settings.Add("actsplit", false, "Split on end of Act (else only on end of zone)");
}

init
{
    vars.bonus = false;
    vars.stopwatch = new Stopwatch();
}

start
{
    if (current.trigger == 0x8C) return true;
}

reset
{
    if (current.reset == 0 && old.reset != 0) return true;
}

split
{
    if (current.level != old.level)
    {
        print(String.Format("level: {0:X} zone: {1} act: {2}", current.level, current.zone, current.act));
        print(String.Format("old level: {0:X} old zone: {1} old act: {2}", old.level, old.zone, old.act));
        switch ((int)old.zone) //note: old zone/act is the one just completed!
        {
            case 0: //Angel Island
            case 1: //Hydrocity
            case 2: //Marble Garden
            case 3: //Carnival Night
            case 4: //Flying Battery
            case 5: //Icecap
            case 6: //Launch Base
            case 7: //Mushroom Hill / Blue Spheres (act code FF)
            case 8: //Sandopolis
                if (old.act == 1 || (old.act == 0 && settings["actsplit"]))
                {
                    return true;
                }
                break;
            case 9: //lava reef
                if (
                    (old.act == 0 && settings["actsplit"]) || //act 1 finish, S&T go to zone code 16 for the boss
                    (current.zone == 16 && current.act == 1) //knuckles skips boss but goes to a 2nd act area
                    )
                {
                    return true;
                }
                break;
            case 22: //lava reef boss/hidden palace
                return true;    //want to split on killing LR2 Boss and on Hidden Palace for all chars
                break;
            case 10: //Sky Sanctuary
                return true;    //S+T do Act 1, Knux Act 2, want to split in both cases
                break;
            case 11: //Death Egg
                if (old.act == 0 && settings["actsplit"]) return true; //act 1 finish, we don't split on Act 2
                break;
            case 23: //Death Egg 2 End Boss
                if (old.act == 0) return true; //Act 1 is DE Boss defeat, Act 2 is Emerald Palace for Hyper Emeralds
                break;
            case 12: //Doomsday
                return true;    //Doomsday doesn't have a second act
                break;
        }
    }
}

isLoading
{
    if (vars.bonus)
    {
        if ((current.timebonus < old.timebonus) || (current.ringbonus < old.ringbonus))
        {
            if (!vars.stopwatch.IsRunning) vars.stopwatch.Start();
            return true;
        }
        else if ((current.timebonus == 0 && old.timebonus == 0) && (current.ringbonus == 0 && old.ringbonus == 0))
        {
            vars.bonus = false;
            vars.stopwatch.Stop();
            print("held timer for " + vars.stopwatch.ElapsedMilliseconds + " ms");
            vars.stopwatch.Reset();
            return false;
        }
    }
    else if ((old.timebonus == 0) && (current.timebonus != old.timebonus)) 
    {
        vars.bonus = true;
    }
}
