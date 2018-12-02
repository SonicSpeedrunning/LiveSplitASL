state("retroarch", "32bit") {}
state("retroarch", "64bit") {}
state("Fusion") {}
state("gens") {}
state("blastem") {}
state("SEGAGameRoom") {}
state("SEGAGenesisClassics") {}

startup
{

    settings.Add("actsplit", false, "Split on each Act");
    settings.SetToolTip("actsplit", "If unchecked, will only split at the end of each Zone.");
    
    settings.Add("act_mg1", false, "Ignore Marble Garden 1", "actsplit");
    settings.Add("act_ic1", false, "Ignore Ice Cap 1", "actsplit");
    settings.Add("act_lb1", false, "Ignore Launch Base 1", "actsplit");

    settings.Add("hard_reset", true, "Reset timer on Hard Reset?");
    
    settings.SetToolTip("act_mg1", "If checked, will not split the end of the first Act. Use if you have per act splits generally but not for this zone.");
    settings.SetToolTip("act_ic1", "If checked, will not split the end of the first Act. Use if you have per act splits generally but not for this zone.");
    settings.SetToolTip("act_lb1", "If checked, will not split the end of the first Act. Use if you have per act splits generally but not for this zone.");

    settings.SetToolTip("hard_reset", "If checked, a hard reset will reset the timer.");

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

    Func<ushort,ushort> SwapEndianness = (ushort value) => {
        var b1 = (value >> 0) & 0xff;
        var b2 = (value >> 8) & 0xff;

        return (ushort) (b1 << 8 | b2 << 0);
    };
    vars.SwapEndianness = SwapEndianness;
    vars.DebugOutput = DebugOutput;
    vars.DebugOutputExpando = DebugOutputExpando;
    refreshRate = 60;
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
    vars.savefile = 255;
    vars.processingzone = false;
    vars.skipsAct1Split = false;
    vars.gameshortname = "";
    if ( game.ProcessName == "retroarch" ) {
        if ( game.Is64Bit() ) {
            version = "64bit";
        } else {
            version = "32bit";
        }
    }
    vars.nextzonemap = false;


    long memoryOffset;
    IntPtr baseAddress;
    long genOffset = 0;
    baseAddress = modules.First().BaseAddress;
    bool isBigEndian = false;
    switch ( game.ProcessName.ToLower() ) {
        case "retroarch":
            long gpgxOffset = 0x01AF84;
            if ( game.Is64Bit() ) {
                gpgxOffset = 0x24A3D0;
            }
            baseAddress = modules.Where(m => m.ModuleName == "genesis_plus_gx_libretro.dll").First().BaseAddress;
            genOffset = gpgxOffset;
            break;
        case "gens":
            genOffset = 0x40F5C;
            break;
        case "fusion":
            genOffset = 0x2A52D4;
            isBigEndian = true;
            break;
        case "segagameroom":
            baseAddress = modules.Where(m => m.ModuleName == "GenesisEmuWrapper.dll").First().BaseAddress;
            genOffset = 0xB677E8;
            break;
        case "segagenesisclassics":
            genOffset = 0x71704;
            break;

    }
    memoryOffset = memory.ReadValue<int>(IntPtr.Add(baseAddress, (int)genOffset) );

    vars.watchers = new MemoryWatcherList
    {
        new MemoryWatcher<ushort>((IntPtr)memoryOffset + 0xEE4E ) { Name = "level" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xEE4E : 0xEE4F ) ) { Name = "zone" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xEE4F : 0xEE4E ) ) { Name = "act" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + 0xFFFC ) { Name = "reset" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xF600 : 0xF601 ) ) { Name = "trigger" },
        new MemoryWatcher<ushort>((IntPtr)memoryOffset + 0xF7D2 ) { Name = "timebonus" },
        new MemoryWatcher<ushort>((IntPtr)memoryOffset + 0xFE28 ) { Name = "scoretally" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xFF09 : 0xFF08 ) ) { Name = "chara" },
        new MemoryWatcher<ulong>( (IntPtr)memoryOffset + 0xFC00) { Name = "dez2end" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xB1E5 : 0xB1E4 ) ) { Name = "ddzboss" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xB279 : 0xB278 ) ) { Name = "sszboss" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xEEE4 : 0xEEE5 ) ) { Name = "delactive" },

        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xEF4B : 0xEF4A ) ) { Name = "savefile" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xFDEB : 0xFDEA ) ) { Name = "savefilezone" },
        new MemoryWatcher<ushort>((IntPtr)memoryOffset + ( isBigEndian ? 0xF648 : 0xF647 ) ) { Name = "waterlevel" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xFE25 : 0xFE24 ) ) { Name = "centiseconds" },
    };
    vars.isBigEndian = isBigEndian;
    string gamename = memory.ReadString(IntPtr.Add((IntPtr)memoryOffset, (int)0xFFFC ),4);
    

    switch (gamename) {
        case "SM&K": // Big-E
        case "MSK&": // Little-E
            vars.gameshortname = "S3K";
            vars.DebugOutput("S3K Loaded");
            break;
        default:
            throw new NullReferenceException (String.Format("Game {0} not supported.", gamename ));
    }
}

update
{
    // Stores the curent phase the timer is in, so we can use the old one on the next frame.
    vars.watchers.UpdateAll(game);
    current.timerPhase = timer.CurrentPhase;

    // Water Level is 16 for levels without water, and another value for those with
    // it is always 0 after a reset upto and including the save select menu
    // centiseconds is reset to 0 upon accessing the save select menu as well, and starts as soon as the game starts
    // we use old.centiseconds to prevent flukes of them being 0.
    current.inMenu = ( vars.watchers["waterlevel"].Current == 0 && vars.watchers["centiseconds"].Current == 0 && vars.watchers["centiseconds"].Old == 0 );
    current.scoretally = vars.watchers["scoretally"].Current;
    current.timebonus = vars.watchers["timebonus"].Current;
    if ( vars.isBigEndian ) {
        current.scoretally = vars.SwapEndianness(vars.watchers["scoretally"].Current);
        current.timebonus  = vars.SwapEndianness(vars.watchers["timebonus"].Current);
    }
    
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
            vars.savefile = vars.watchers["savefile"].Current;
            vars.skipsAct1Split = !settings["actsplit"];
            
        }
    }

}

start
{
    if (vars.watchers["trigger"].Current == 0x8C && vars.watchers["act"].Current == 0 && vars.watchers["zone"].Current == 0)
    {
        vars.DebugOutput(String.Format("next split on: zone: {0} act: {1}", vars.nextzone, vars.nextact));
        return true;
    }
}

reset
{
    // detecting memory checksum at end of RAM area being 0 - only changes if ROM is reloaded (Hard Reset)
    // or if "DEL" is selected from the save file select menu.
    if ( 
        ( settings["hard_reset"] && vars.watchers["reset"].Current == 0 && vars.watchers["reset"].Old != 0 ) || 
        ( current.inMenu == true
            && ( 
                ( vars.watchers["savefile"].Current == 9 && vars.watchers["delactive"].Current == 0xFF && vars.watchers["delactive"].Old == 0 ) ||
                ( 
                    vars.watchers["savefile"].Current == vars.savefile && 
                    (vars.nextact + vars.nextzone) <= 1 && 
                    vars.watchers["savefilezone"].Old == 255 && 
                    vars.watchers["savefilezone"].Current == 0 )
            )
        ) 
    ) {
        return true;
    }
}

split
{
    bool split = false;

    const byte ACT_1 = 0;
    const byte ACT_2 = 1;
    const byte ACT_3 = 2;

    const byte SONIC_AND_TAILS = 0;
    const byte SONIC = 1;
    const byte TAILS = 2;
    const byte KNUCKLES = 3;

    /* S3K levels */
    const byte ANGEL_ISLAND      = 0;
    const byte HYDROCITY         = 1;
    const byte MARBLE_GARDEN     = 2;
    const byte CARNIVAL_NIGHT    = 3;
    const byte ICE_CAP           = 5;
    const byte LAUNCH_BASE       = 6;
    const byte MUSHROOM_HILL     = 7;
    const byte FLYING_BATTERY    = 4;
    const byte SANDOPOLIS        = 8;
    const byte LAVA_REEF         = 9;
    const byte SKY_SANCTUARY     = 10;
    const byte DEATH_EGG         = 11;
    const byte DOOMSDAY          = 12;
    const byte LRB_HIDDEN_PALACE = 22;
    const byte DEATH_EGG_BOSS    = 23;

    if (!vars.nextzonemap.GetType().IsArray) {
        vars.nextzonemap = new byte[] { 
        /*  0 ANGEL_ISLAND      -> */ HYDROCITY, 
        /*  1 HYDROCITY         -> */ MARBLE_GARDEN, 
        /*  2 MARBLE_GARDEN     -> */ CARNIVAL_NIGHT, 
        /*  3 CARNIVAL_NIGHT    -> */ ICE_CAP, 
        /*  4 FLYING_BATTERY    -> */ SANDOPOLIS, 
        /*  5 ICE_CAP           -> */ LAUNCH_BASE, 
        /*  6 LAUNCH_BASE       -> */ MUSHROOM_HILL, 
        /*  7 MUSHROOM_HILL     -> */ FLYING_BATTERY, 
        /*  8 SANDOPOLIS        -> */ LAVA_REEF, 
        /*  9 LAVA_REEF         -> */ LRB_HIDDEN_PALACE, 
        /* 10 SKY_SANCTUARY     -> */ DEATH_EGG, 
        /* 11 DEATH_EGG         -> */ DEATH_EGG_BOSS,
        /* 12 DOOMSDAY          -> */ 0,
        /* 13,14,15,16,17,18,19,20,21 */ 0,0,0,0,0,0,0,0,0,
        /* 22 LRB_HIDDEN_PALACE -> */ SKY_SANCTUARY,
        /* 23 DEATH_EGG_BOSS    -> */ DOOMSDAY
        };
    }

    if ( vars.watchers["zone"].Old != vars.watchers["zone"].Current && settings["actsplit"] ) {
        vars.skipsAct1Split = ( 
            ( vars.watchers["zone"].Current == MARBLE_GARDEN && settings["act_mg1"] ) || 
            ( vars.watchers["zone"].Current == ICE_CAP && settings["act_ic1"] ) ||
            ( vars.watchers["zone"].Current == LAUNCH_BASE && settings["act_lb1"] )
        );
    }

    if (
        !vars.processingzone && 
        vars.watchers["zone"].Current != DOOMSDAY && 
        /* Make doubly sure we are in the correct zone */
        vars.watchers["zone"].Current == vars.nextzone && vars.watchers["zone"].Old == vars.nextzone &&
        vars.watchers["act"].Current == vars.nextact && vars.watchers["act"].Old == vars.nextact 
    ) {
        vars.processingzone = true;
        

        switch ( (int)vars.watchers["act"].Current ) {
            // This is AFTER a level change.
            case ACT_1:
                vars.nextact = ACT_2;
                if ( 
                    // Handle IC boss skip and single act zones.
                    ( vars.watchers["zone"].Current == ICE_CAP && vars.skipsAct1Split ) ||
                    ( vars.watchers["zone"].Current == SKY_SANCTUARY ) ||
                    ( vars.watchers["zone"].Current == LRB_HIDDEN_PALACE )
                ) {  
                    vars.nextzone = vars.nextzonemap[vars.watchers["zone"].Current];
                    vars.nextact = ACT_1;
                }
                split = ( vars.watchers["zone"].Current < LRB_HIDDEN_PALACE );
                break;
            case ACT_2:
                // next split is generally Act 1 of next zone
                vars.nextzone = vars.nextzonemap[vars.watchers["zone"].Current];
                vars.nextact = ACT_1;
                if ( vars.watchers["zone"].Current == LAVA_REEF || 
                    ( vars.watchers["zone"].Current == LRB_HIDDEN_PALACE && vars.watchers["chara"].Current == KNUCKLES ) 
                ) {
                    // LR2 -> HP = 22-1 and HP -> SS2 for Knux
                    vars.nextact = ACT_2; 
                }
                // If we're not skipping the act 1 split, or we entered Hidden Palace
                split = ( !vars.skipsAct1Split || vars.watchers["zone"].Current == LRB_HIDDEN_PALACE );

                break;
        }

        vars.processingzone = false;
    }
    
    if (!vars.dez2split && vars.watchers["zone"].Current == DEATH_EGG_BOSS && vars.watchers["act"].Current == ACT_1) //detect fade to white on death egg 2
    {
        if ((vars.watchers["dez2end"].Current == 0xEE0EEE0EEE0EEE0E && vars.watchers["dez2end"].Old == 0xEE0EEE0EEE0EEE0E) ||
            (vars.watchers["dez2end"].Current == 0x0EEE0EEE0EEE0EEE && vars.watchers["dez2end"].Old == 0x0EEE0EEE0EEE0EEE))
        {
            vars.DebugOutput("DEZ2 Boss White Screen detected");
            vars.dez2split = true;
            split = true;
        }
    }
    
    if (vars.watchers["zone"].Current == DOOMSDAY && vars.watchers["ddzboss"].Current == 255 && vars.watchers["ddzboss"].Old == 0) //Doomsday boss detect final hit
    {
        vars.DebugOutput("Doomsday Zone Boss death detected"); //need to detect fade to white, same as DEZ2End
        vars.ddzsplit = true;
    }
    
    if (vars.ddzsplit || vars.sszsplit) //detect fade to white on doomsday
    {
        if ((vars.watchers["dez2end"].Current == 0xEE0EEE0EEE0EEE0E && vars.watchers["dez2end"].Old == 0xEE0EEE0EEE0EEE0E) ||
            (vars.watchers["dez2end"].Current == 0x0EEE0EEE0EEE0EEE && vars.watchers["dez2end"].Old == 0x0EEE0EEE0EEE0EEE))
        {
            vars.DebugOutput("Doomsday/SS White Screen detected");
            split = true;
        }
    }
    

    if (vars.watchers["chara"].Current == KNUCKLES && vars.watchers["zone"].Current == SKY_SANCTUARY) //detect final hit on Knux Sky Sanctuary Boss
    {
        if (vars.watchers["sszboss"].Current == 0 && vars.watchers["sszboss"].Old == 1)
        {
            vars.DebugOutput("Knuckles Final Boss 1st phase defeat detected");
            vars.sszsplit = true;
        }
    }
    
    if (split)
    {
        vars.DebugOutput(String.Format("old level: {0:X4} old zone: {1} old act: {2}", vars.watchers["level"].Old, vars.watchers["zone"].Old, vars.watchers["act"].Old));
        vars.DebugOutput(String.Format("level: {0:X4} zone: {1} act: {2}", vars.watchers["level"].Current, vars.watchers["zone"].Current, vars.watchers["act"].Current));
        vars.DebugOutput(String.Format("next split on: zone: {0} act: {1}", vars.nextzone, vars.nextact));
        return true;
    }
}

isLoading
{
    if ( vars.bonus && old.timebonus == 0 ) {
        // If we had a bonus, and the previous frame's timebonus is now 0, reset it
        vars.bonus = false;
    } else if ( !vars.bonus && vars.watchers["act"].Current <= 1 && current.timebonus < old.timebonus && current.scoretally > old.scoretally ) {
        // if we haven't detected a bonus yet
        // check that we are in an act (sanity check)
        // then check to see if the current timebonus is less than the previous frame's one.
        vars.DebugOutput(String.Format("Detected Bonus decrease: {0} from: {1}", current.timebonus, old.timebonus));
        vars.bonus = true;
    }
    return vars.bonus;
}


gameTime
{
    /* Ready for supporting S1 and S2, 
    so for S3K we just return what the GameTime currently is */
    return TimeSpan.FromMilliseconds(timer.CurrentTime.GameTime.Value.TotalMilliseconds);
}