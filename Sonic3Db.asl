state("retroarch", "32bit") {}
state("retroarch", "64bit") {}
state("Fusion") {}
state("gens") {}
state("SEGAGameRoom") {}
state("SEGAGenesisClassics") {}

startup
{
    Action<string> DebugOutput = (text) => {
        print("[S3D Autosplitter] "+text);
    };

    Action<ExpandoObject> DebugOutputExpando = (ExpandoObject dynamicObject) => {
            var dynamicDictionary = dynamicObject as IDictionary<string, object>;
         
            foreach(KeyValuePair<string, object> property in dynamicDictionary)
            {
                print(String.Format("[S3D Autosplitter] {0}: {1}", property.Key, property.Value.ToString()));
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
    vars.gameactive = true;
    refreshRate = 60;
}

init
{
    if ( game.ProcessName == "retroarch" ) {
        if ( game.Is64Bit() ) {
            version = "64bit";
        } else {
            version = "32bit";
        }
    }
 

    long memoryOffset;
    IntPtr baseAddress;
    long genOffset = 0;
    baseAddress = modules.First().BaseAddress;
    bool isBigEndian = false;
    vars.segagenesisclassics = false;
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
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0x067F : 0x067E ) ) { Name = "level" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xF749 : 0xF749 ) ) { Name = "ingame" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xD189 : 0xD188 ) ) { Name = "ppboss" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0x0BA9 : 0x0BA9 ) ) { Name = "ffboss" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0x06A3 : 0x06A3 ) ) { Name = "emeralds" },
        new MemoryWatcher<byte>(  (IntPtr)memoryOffset + ( isBigEndian ? 0xF770 : 0xF770 ) ) { Name = "active" },

    };
    vars.isBigEndian = isBigEndian;

}

update
{
    vars.watchers.UpdateAll(game);
    
    current.timerPhase = timer.CurrentPhase;

    if(((IDictionary<String, object>)old).ContainsKey("timerPhase")) {
        if ((old.timerPhase != current.timerPhase && old.timerPhase != TimerPhase.Paused) && current.timerPhase == TimerPhase.Running)
        //pressed start run or autostarted run
        {
            vars.DebugOutput("run start detected");
        }
    }

    if ( vars.watchers["emeralds"].Current != vars.watchers["emeralds"].Old ) {
        vars.DebugOutput(String.Format("Emeralds: {0}", vars.watchers["emeralds"].Current));
    }

}

start
{
    
    if (
        (  vars.watchers["ingame"].Current == 1 && vars.watchers["ingame"].Old == 0 && vars.watchers["level"].Current == 0 ) 
    ) {
        return true;
    }
}

reset
{
    if (vars.watchers["ingame"].Current == 0 && vars.watchers["ingame"].Old == 1 && vars.watchers["level"].Current == 0) {
        return true;
    }

}

split
{
    if ( vars.watchers["level"].Current == 21 ) {
        vars.DebugOutput(String.Format("Emeralds: {0}", vars.watchers["emeralds"].Current));
    }
    return ( 
        ( vars.watchers["level"].Current > 1 && vars.watchers["level"].Current == (vars.watchers["level"].Old + 1) ) || // Level Change
        ( vars.watchers["level"].Current == 21 && vars.watchers["emeralds"].Current < 7 && vars.watchers["ppboss"].Old == 224 && vars.watchers["ppboss"].Current == 128) || // Panic Puppet Boss Destroyed
        ( vars.watchers["level"].Current == 22 && vars.watchers["ffboss"].Old == 1 && vars.watchers["ffboss"].Current == 0) // Final Fight Boss
    );
}

