state("soniccd") {}
state("RSDKv3_64") {}
state("RSDKv3") {}

init
{
    vars.HasCentisecsBug = false;
    vars.CentisecsOffset = IntPtr.Zero;
    
    // Define main watcher variable
    vars.watchers = new MemoryWatcherList();
    var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
    IntPtr ptr = scanner.Scan(new SigScanTarget("20 53 6F 6E 69 63 20 43 44"));
    if (ptr == IntPtr.Zero)
        throw new Exception();

    switch (game.ProcessName.ToLower())
    {
        case "soniccd":
            vars.CentisecsOffset = modules.First().BaseAddress + 0x804EFB;
            vars.HasCentisecsBug = true;
            vars.watchers.Add(new MemoryWatcher<byte>(vars.CentisecsOffset) { Name = "centisecs" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xE2A378) { Name = "seconds" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xF9F2F3) { Name = "mins" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xF9F294) { Name = "LevelID" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xC3E79A) { Name = "State" });
            vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0xC0721C) { Name = "DemoMode" });
            vars.watchers.Add(new MemoryWatcher<uint>(modules.First().BaseAddress + 0xE2A37C) { Name = "ZoneIndicator" });
            vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0xFC5810) { Name = "TimerIsRunning" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xC40EB8) { Name = "bhpGood" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0xC40EFC) { Name = "bhpBad" });
            break;

        case "rsdkv3_64":
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x811F64) { Name = "centisecs" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x8120A4) { Name = "seconds" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x811F68) { Name = "mins" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x80FA3C) { Name = "LevelID" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x7BA4F2) { Name = "State" });
            vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0xBA337C) { Name = "DemoMode" });
            vars.watchers.Add(new MemoryWatcher<uint>(modules.First().BaseAddress + 0x811F70) { Name = "ZoneIndicator" });
            vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0xAC0B8) { Name = "TimerIsRunning" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x7BCC10) { Name = "bhpGood" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x7BCC54) { Name = "bhpBad" });
            break;

        case "rsdkv3":
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x7EACA8) { Name = "centisecs" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x7EADE8) { Name = "seconds" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x7EACAC) { Name = "mins" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x9A2F6C) { Name = "LevelID" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x78F272) { Name = "State" });
            vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0xB7B4DC) { Name = "DemoMode" });
            vars.watchers.Add(new MemoryWatcher<uint>(modules.First().BaseAddress + 0x7EACB0) { Name = "ZoneIndicator" });
            vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0x88090) { Name = "TimerIsRunning" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x791990) { Name = "bhpGood" });
            vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x7919D4) { Name = "bhpBad" });
        break;
    }

    // Placeholder for current status variables the script needs. Prevents LiveSplit from throwing exceptions
    current.IGT = 0d;
    current.Act = 0;
    current.FinalBossHp = 0xFF;
}

startup
{
    // Basic settings
    settings.Add("centisecsBug", false, "Remove centiseconds from the timer when starting a new run");
    settings.SetToolTip("centisecsBug", "Partial mitigation of the centiseconds bug on the steam release of Sonic CD (2011).\nIf enabled, LiveSplit will automatizally set the centiseconds to 0 at the start of a new run.\nThis setting has no effect on ther releases of the game.");
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
    byte z = 0; for (byte i = 0; i < actsName.Length; i++) { for (byte j = 0; j < actsName[i].Length; j++) vars.Acts.Add(z++, i); }
    for (byte i = 0; i < actsName.Length; i++) settings.Add(i.ToString(), true, actsName[i][0], "autosplitting");

    // ZoneIndicator - dummy name for a variable that essentially tells us whether we are playing or in one of the menus
    // Used to ignore act changes outside actual gameplay
    vars.ZoneIndicator = new Dictionary<string, uint>
    {
        { "Special Stage", 0x43455053u },
        { "Title Screen", 0x4C544954u },
        { "Main Menu", 0x4E49414Du },
        { "Time Attack", 0x454D4954u },
    };

    // Functions we are gonna use in the script
    vars.Func = new ExpandoObject();
    vars.Func.StartTrigger = (Func<bool>)(() => vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator["Main Menu"] && vars.watchers["State"].Current == 7 && vars.watchers["State"].Old == 6);
    vars.Func.ResetTrigger = (Func<bool>)(() => vars.watchers["ZoneIndicator"].Current == vars.ZoneIndicator["Main Menu"] && vars.watchers["State"].Current == 2 && vars.watchers["State"].Old == 1);
    vars.Func.ResetIGTBuffers = (Action)(() => { vars.AccumulatedIGT = vars.BufferIGT = 0d; });

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
    if (timer.CurrentPhase == TimerPhase.NotRunning) vars.Func.ResetIGTBuffers();

    if (current.IGT < old.IGT)
    {
        vars.AccumulatedIGT += old.IGT - vars.BufferIGT;
        vars.BufferIGT = current.IGT;
    }

    // Reset centisecs when starting a new run
    if (settings["centisecsBug"] && vars.HasCentisecsBug && vars.Func.StartTrigger())
        game.WriteValue<byte>((IntPtr)vars.CentisecsOffset, 0);
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
    current.FinalBossHp = vars.watchers["LevelID"].Current == 68 ? vars.watchers["bhpGood"].Current
        : vars.watchers["LevelID"].Current == 69 ? vars.watchers["bhpBad"].Current
        : 0xFF;
    if (old.FinalBossHp == 1 & current.FinalBossHp == 0 && current.IGT != 0)
        return settings["20"];
}

gameTime
{
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
    return true;
}
