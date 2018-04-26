state("Fusion")
{
    short level :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte zone   :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte act    :   "Fusion.exe", 0x2A52D4, 0xEE4F;
    byte reset  :   "Fusion.exe", 0x2A52D4, 0xFFFC;
    byte trigger  :   "Fusion.exe", 0x2A52D4, 0xF600; //new game is 8C
    short timebonus  :   "Fusion.exe", 0x2A52D4, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "Fusion.exe", 0x2A52D4, 0xF7D4;
    short chara  :   "Fusion.exe", 0x2A52D4, 0xFF08;
    byte ending :   "Fusion.exe", 0x2A52D4, 0xEF72;
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
    byte ending :   "gens.exe", 0x40F5C, 0xEF73;
}

state("retroarch")
{
    short level :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xEE4E;
    byte zone   :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xEE4F;
    byte act    :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xEE4E;
    byte reset  :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xFFFC;
    byte trigger  :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xF601; //new game is 8C
    short timebonus  :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    short ringbonus  :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xF7D4;
    byte chara  :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xFF08;
    byte ending :   "genesis_plus_gx_libretro.dll", 0xF39900, 0xEF73;
}

startup
{
    settings.Add("actsplit", false, "Split on each Act (don't use if you zip into act 2!)");
}

init
{
    vars.bonus = false;
    vars.stopwatch = new Stopwatch();
    vars.nextzone = 0;
    vars.nextact = 1;
}

start
{
    vars.nextzone = 0;
    vars.nextact = 1;
    print(String.Format("trigger: {0:X2}",current.trigger));
    if (current.trigger == 0x8C && current.act == 0 && current.zone == 0)
    {
        print(String.Format("next split on: zone: {0} act: {1}", vars.nextzone, vars.nextact));
        return true;
    }
}

reset
{
    if (current.reset == 0 && old.reset != 0)
    {
        vars.nextzone = 0;
        vars.nextact = 1;
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
            case 2: //Marble Garden
            case 5: //Icecap
            case 6: //Launch Base
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
                    vars.nextzone = 17;
                    if (settings["actsplit"]) split = true; //Split DEZ1
                }
                break;
            case 17: //DEZ boss
                vars.nextact = 0;
                vars.nextzone = 12;
                break;
            case 12:
                split = true;
                break;
        }
    }
    if (split)
    {
        print(String.Format("level: {0:X4} zone: {1} act: {2}", current.level, current.zone, current.act));
        print(String.Format("old level: {0:X4} old zone: {1} old act: {2}", old.level, old.zone, old.act));
        print(String.Format("next split on: zone: {0} act: {1}", vars.nextzone, vars.nextact));
        return true;
    }
    if (current.ending == 255)
    {
        print("Ending routine running");
        return true;
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
