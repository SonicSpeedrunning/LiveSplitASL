state("soniccd") {}
state("RSDKv3_64") {}
state("RSDKv3") {}
state("RSDKv3_HW") {}
state("Sonic CD") {}
state("Sonic CD_64") {}

init
{
    if (modules.First().ModuleMemorySize == 0x1090000)
        version = "Retail (Steam)";
    else
        version = "Decompilation (" + (game.Is64Bit() ? "64" : "32") + " bit)";

    // Define main watcher variable
    vars.watchers = new MemoryWatcherList();
    var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
    IntPtr ptr = scanner.Scan(new SigScanTarget("20 53 6F 6E 69 63 20 43 44"));
    if (ptr == IntPtr.Zero)
        throw new Exception();

    // Placeholder for current status variables the script needs. Prevents LiveSplit from throwing exceptions
    current.IGT = 0d;
    current.Act = 0xFF;
    current.FinalBossHp = 0xFF;
    vars.HasCentisecsBug = false;
    vars.CentisecsOffset = IntPtr.Zero;
    
    // Retail steam version is unlikely to ever change. No point in using sigscanning here
    if (version == "Retail (Steam)")
    {
        vars.CentisecsOffset = modules.First().BaseAddress + 0x804EFB;
        vars.HasCentisecsBug = true;
        vars.watchers.Add(new MemoryWatcher<uint>(modules.First().BaseAddress + 0xE2A37C) { Name = "ZoneIndicator" });
        vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0xC0721C) { Name = "DemoMode" });
        vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xC3E79A) { Name = "State" });
        vars.watchers.Add(new MemoryWatcher<int> (modules.First().BaseAddress + 0xC3DEFC) { Name = "TimeBonus" });
        vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xC40EB8) { Name = "bhpGood" });
        vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xC40EFC) { Name = "bhpBad" });
        vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xF9F294) { Name = "LevelID" });
        vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0xFC5810) { Name = "TimerIsRunning" });
        vars.watchers.Add(new MemoryWatcher<byte>(vars.CentisecsOffset)                   { Name = "centisecs" });
        vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xE2A378) { Name = "seconds" });
        vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xF9F2F3) { Name = "mins" });
        return;
    }
    
    // Decompilation (RSDKv3)
    // At the time of writing (March 3rd, 2022), sigscanning works for all versions of the decompilation.
    if (version.Contains("Decompilation"))
    {
        Func<int, int, int, bool, IntPtr> pointerPath;

        switch (game.Is64Bit())
        {
            case true:
                ptr = scanner.Scan(new SigScanTarget(7, "41 8B C6 4D 8D B4 24") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) });
                if (ptr == IntPtr.Zero)
                    throw new Exception();
                vars.watchers.Add(new MemoryWatcher<uint>(ptr) { Name = "ZoneIndicator" });

                ptr = scanner.Scan(new SigScanTarget(4, "41 8B 8C 8A ???????? 49 03 CA") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) });
                if (ptr == IntPtr.Zero)
                    throw new Exception();
                pointerPath = (int offset1, int offset2, int offset3, bool absolute) =>
                {
                    int tempOffset = game.ReadValue<int>(ptr + offset1);
                    IntPtr tempOffset2 = modules.First().BaseAddress + tempOffset + offset2;
                    if (absolute)
                        return modules.First().BaseAddress + game.ReadValue<int>(tempOffset2) + offset3;
                    else
                        return tempOffset2 + 0x4 + game.ReadValue<int>(tempOffset2) + offset3;
                };
                vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 11,  7, 0x1AC,  true )) { Name = "DemoMode" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 19, 10, 0x10B2, false)) { Name = "State" });
                vars.watchers.Add(new MemoryWatcher<int> (pointerPath(0x4 * 37, 10, 0x814,  false)) { Name = "TimeBonus" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 32, 10, 0x37D0, false)) { Name = "bhpGood" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 32, 10, 0x3814, false)) { Name = "bhpBad" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120, 2, 0,      false)) { Name = "LevelID" });
                vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 121, 3, 0,      false)) { Name = "TimerIsRunning" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 122, 2, 0,      false)) { Name = "centisecs" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 123, 2, 0,      false)) { Name = "seconds" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 124, 2, 0,      false)) { Name = "mins" });
                break;

            case false:
                ptr = scanner.Scan(new SigScanTarget(2, "0F 85 ???????? 8A 88") { OnFound = (p, s, addr) => addr + p.ReadValue<int>(addr) + 0x4 + 0x2 });
                if (ptr == IntPtr.Zero)
                    throw new Exception();
                vars.watchers.Add(new MemoryWatcher<uint>((IntPtr)game.ReadValue<int>(ptr)) { Name = "ZoneIndicator" });

                ptr = scanner.Scan(new SigScanTarget(3, "FF 24 85 ???????? A1") { OnFound = (p, s, addr) => (IntPtr)p.ReadValue<int>(addr) });
                if (ptr == IntPtr.Zero)
                    throw new Exception();
                pointerPath = (int offset1, int offset2, int offset3, bool absolute) => (IntPtr)new DeepPointer(ptr + offset1, offset2).Deref<int>(game) + offset3;
                vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 11,  0x3, 0x1AC,  true)) { Name = "DemoMode" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 19,  0xB, 0x1078, true)) { Name = "State" });
                vars.watchers.Add(new MemoryWatcher<int> (pointerPath(0x4 * 25,  0xA, 0x7F8,  true)) { Name = "TimeBonus" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 32,  0xA, 0x37C8, true)) { Name = "bhpGood" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 32,  0xA, 0x380C, true)) { Name = "bhpBad" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120, 0x1, 0,      true)) { Name = "LevelID" });
                vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 121, 0x3, 0,      true)) { Name = "TimerIsRunning" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 122, 0x1, 0,      true)) { Name = "centisecs" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 123, 0x1, 0,      true)) { Name = "seconds" });
                vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 124, 0x1, 0,      true)) { Name = "mins" });
                break;
        }
        return;
    }

    // In case of future versions of the game remember to add the code before this line
    throw new Exception("Game unknown!");
}

startup
{
    // Basic settings
    settings.Add("centisecsBug", false, "Remove centiseconds from the timer when starting a new run");
    settings.SetToolTip("centisecsBug", "Partial mitigation of the centiseconds bug on the steam release of Sonic CD (2011).\nIf enabled, LiveSplit will automatizally set the centiseconds to 0 at the start of a new run.\nThis setting has no effect on any other release of the game.");
    settings.Add("RTA-TB", false, "Use All Time Stones timing rules");
    settings.SetToolTip("RTA-TB", "If enabled, LiveSplit's behaviour will be changed in order to reflect the different\ntiming rules used in the \"All Time Stones\" category:\n• RTA-TB (Time Bonus) will be used as Game Time instead of IGT\n• The final split will occur after the screen fades to white in Metallic Madness 3");
    settings.Add("autosplitting", true, "Autosplitting");

    string[][] actsName = {
        new string[] { "Palmtree Panic Act 1", "Palmtree Panic Act 1 - Past", "Palmtree Panic Act 1 - Good Future", "Palmtree Panic Act 1 - Bad Future" },
        new string[] { "Palmtree Panic Act 2", "Palmtree Panic Act 2 - Past", "Palmtree Panic Act 2 - Good Future", "Palmtree Panic Act 2 - Bad Future" },
        new string[] { "Palmtree Panic Act 3", "Palmtree Panic act 3 - Bad Future" },
        new string[] { "Collision Chaos Act 1", "Collision Chaos Act 1 - Past", "Collision Chaos Act 1 - Good Future", "Collision Chaos Act 1 - Bad Future" },
        new string[] { "Collision Chaos Act 2", "Collision Chaos Act 2 - Past", "Collision Chaos Act 2 - Good Future", "Collision Chaos Act 2 - Bad Future" },
        new string[] { "Collision Chaos Act 3", "Collision Chaos Act 3 - Bad Future"},
        new string[] { "Tidal Tempest Act 1", "Tidal Tempest Act 1 - Past", "Tidal Tempest Act 1 - Good Future", "Tidal Tempest Act 1 - Bad Future" },
        new string[] { "Tidal Tempest Act 2", "Tidal Tempest Act 2 - Past", "Tidal Tempest Act 2 - Good Future", "Tidal Tempest Act 2 - Bad Future" },
        new string[] { "Tidal Tempest Act 3", "Tidal Tempest Act 3 - Bad Future"},
        new string[] { "Quartz Quadrant Act 1", "Quartz Quadrant Act 1 - Past", "Quartz Quadrant Act 1 - Good Future", "Quartz Quadrant Act 1 - Bad Future" },
        new string[] { "Quartz Quadrant Act 2", "Quartz Quadrant Act 2 - Past", "Quartz Quadrant Act 2 - Good Future", "Quartz Quadrant Act 2 - Bad Future" },
        new string[] { "Quartz Quadrant Act 3", "Quartz Quadrant Act 3 - Bad Future" },
        new string[] { "Wacky Workbench Act 1", "Wacky Workbench Act 1 - Past", "Wacky Workbench Act 1 - Good Future", "Wacky Workbench Act 1 - Bad Future" },
        new string[] { "Wacky Workbench Act 2", "Wacky Workbench Act 2 - Past", "Wacky Workbench Act 2 - Good Future", "Wacky Workbench Act 2 - Bad Future" },
        new string[] { "Wacky Workbench Act 3", "Wacky Workbench Act 3 - Bad Future" },
        new string[] { "Stardust Speedway Act 1", "Stardust Speedway Act 1 - Past", "Stardust Speedway Act 1 - Good Future", "Stardust Speedway Act 1 - Bad Future" },
        new string[] { "Stardust Speedway Act 2", "Stardust Speedway Act 2 - Past", "Stardust Speedway Act 2 - Good Future", "Stardust Speedway Act 2 - Bad Future" },
        new string[] { "Stardust Speedway Act 3", "Stardust Speedway Act 3 - Bad Future" },
        new string[] { "Metallic Madness Act 1", "Metallic Madness Act 1 - Past", "Metallic Madness Act 1 - Good Future", "Metallic Madness Act 1 - Bad Future" },
        new string[] { "Metallic Madness Act 2", "Metallic Madness Act 2 - Past", "Metallic Madness Act 2 - Good Future", "Metallic Madness Act 2 - Bad Future" },
        new string[] { "Metallic Madness Act 3", "Metallic Madness Act 3 - Bad Future" }
    };
    vars.Acts = new Dictionary<byte, byte>();
    byte z = 0;
    for (byte i = 0; i < actsName.Length; i++)
    {
        for (byte j = 0; j < actsName[i].Length; j++)
            vars.Acts.Add(z++, i);
        settings.Add(i.ToString(), true, actsName[i][0], "autosplitting");
    }

    // ZoneIndicator - dummy name for a variable that essentially tells us whether we are playing or in one of the menus
    // Used to ignore act changes outside actual gameplay
    vars.ZoneIndicator = new Dictionary<string, uint>
    {
        { "Special Stage", 0x43455053u },
        { "Title Screen",  0x4C544954u },
        { "Main Menu",     0x4E49414Du },
        { "Time Attack",   0x454D4954u },
    };

    // Setting up a time bonus start value for RTA-TB timing method
    vars.TimeBonusStartValue = 0;

    // Functions we are gonna use in the script
    vars.Func = new ExpandoObject();
    vars.Func.StartTrigger = (Func<bool>)(() => vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator["Main Menu"] && vars.watchers["State"].Current == 7 && vars.watchers["State"].Old == 6);
    vars.Func.ResetTrigger = (Func<bool>)(() => vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator["Main Menu"] && vars.watchers["State"].Current == 5 && vars.watchers["State"].Changed);
    vars.Func.ResetIGTBuffers = (Action)(() => { vars.AccumulatedIGT = vars.BufferIGT = 0d; });
    vars.Func.IsInTimeBonus = (Func<bool>)(() => vars.TimeBonusStartValue != 0 && vars.watchers["TimeBonus"].Current != vars.TimeBonusStartValue);
    vars.Func.FindFinalBossHp = (Func<int>)(() => vars.watchers["LevelID"].Current == 68 ? vars.watchers["bhpGood"].Current : vars.watchers["LevelID"].Current == 69 ? vars.watchers["bhpBad"].Current : 0xFF);

    // Reset the IGT variables to generate them. Avoid throwing an exception later
    vars.Func.ResetIGTBuffers();
}

update
{
    // Update watchers
    vars.watchers.UpdateAll(game);

    // IGT definition
    // Must be 0 in Demo Mode
    // Must be 0 if the run has not started
    // Must not consider centisecs in case you are running a version of the game with the centisecs bug
    current.IGT = vars.watchers["DemoMode"].Current || vars.watchers["DemoMode"].Old || timer.CurrentPhase == TimerPhase.NotRunning ? 0d
        : !vars.watchers["TimerIsRunning"].Old && !vars.watchers["TimerIsRunning"].Current ? old.IGT
        : (double)vars.watchers["mins"].Current * 60 + (double)vars.watchers["seconds"].Current + (vars.HasCentisecsBug ? 0 : (double)vars.watchers["centisecs"].Current / 100 );
    
    // Reset the buffer IGT variables when the timer is stopped
    if (timer.CurrentPhase == TimerPhase.NotRunning)
        vars.Func.ResetIGTBuffers();

    if (current.IGT < old.IGT)
    {
        vars.AccumulatedIGT += old.IGT - vars.BufferIGT;
        vars.BufferIGT = current.IGT;
    }

    // Reset centisecs when starting a new run
    if (settings["centisecsBug"] && vars.HasCentisecsBug && vars.Func.StartTrigger())
        game.WriteValue<byte>((IntPtr)vars.CentisecsOffset, 0);

    // Time Bonus start value
    if (vars.watchers["TimeBonus"].Old == 0 && vars.watchers["TimeBonus"].Changed)
        vars.TimeBonusStartValue = vars.watchers["TimeBonus"].Current;
    else if (vars.watchers["TimeBonus"].Current == 0)
        vars.TimeBonusStartValue = 0;
}

split
{
    // If you're not inside a stage, there's no point in continuing
    foreach (var entry in vars.ZoneIndicator)
    {
        if (vars.watchers["ZoneIndicator"].Current == entry.Value)
            return false;
    }

    // Define current Act
    try { current.Act = vars.Acts[vars.watchers["LevelID"].Current]; } catch { current.Act = 0; }

    // Trigger a split when progressing loading a new stage
    if (current.Act == old.Act + 1)
        return settings[old.Act.ToString()];

    // Final boss split
    current.FinalBossHp = vars.Func.FindFinalBossHp();
    if (!settings["RTA-TB"] && old.FinalBossHp == 1 & current.FinalBossHp == 0 && current.IGT != 0)
        return settings["20"];
    // Final boss split in RTA-TB
    else if (settings["RTA-TB"] && old.Act == 20 && vars.watchers["LevelID"].Current == 1)
        return settings["20"];
}

gameTime
{
    if (!settings["RTA-TB"])
        return TimeSpan.FromSeconds(current.IGT + vars.AccumulatedIGT - vars.BufferIGT + (vars.HasCentisecsBug ? (double)vars.watchers["centisecs"].Current / 60 : 0));
}

start
{
    return vars.Func.StartTrigger();
}

reset
{
    return vars.Func.ResetTrigger();
}

isLoading
{
	return settings["RTA-TB"] ? vars.Func.IsInTimeBonus() : true;
}
