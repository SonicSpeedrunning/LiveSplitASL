state("Fusion")
{
    ushort level :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte zone   :   "Fusion.exe", 0x2A52D4, 0xEE4E;
    byte act    :   "Fusion.exe", 0x2A52D4, 0xEE4F;
    byte reset  :   "Fusion.exe", 0x2A52D4, 0xFFFC;
    byte trigger  :   "Fusion.exe", 0x2A52D4, 0xF600; //new game is 8C
    ushort timebonus  :   "Fusion.exe", 0x2A52D4, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    ushort scoretally  :   "Fusion.exe", 0x2A52D4, 0xFE28;
    byte chara  :   "Fusion.exe", 0x2A52D4, 0xFF09;
    ulong dez2end : "Fusion.exe", 0x2A52D4, 0xFC00;
    byte ddzboss : "Fusion.exe", 0x2A52D4, 0xB1E5;
    byte sszboss : "Fusion.exe", 0x2A52D4, 0xB279;
    byte delactive : "Fusion.exe", 0x2A52D4, 0xEEE5;

    byte savefile : "Fusion.exe", 0x2A52D4, 0xEF4A;
    byte savefilezone : "Fusion.exe", 0x2A52D4, 0xFDEA;
    ushort waterlevel : "Fusion.exe", 0x2A52D4, 0xF647;
    byte centiseconds : "Fusion.exe", 0x2A52D4, 0xFE24;
}

state("gens")
{
    ushort level :   "gens.exe", 0x40F5C, 0xEE4E;
    byte zone   :   "gens.exe", 0x40F5C, 0xEE4F;
    byte act    :   "gens.exe", 0x40F5C, 0xEE4E;
    byte reset  :   "gens.exe", 0x40F5C, 0xFFFC;
    byte trigger  :   "gens.exe", 0x40F5C, 0xF601; //new game is 8C
    ushort timebonus  :   "gens.exe", 0x40F5C, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    ushort scoretally  :   "gens.exe", 0x40F5C, 0xFE28;
    byte chara  :   "gens.exe", 0x40F5C, 0xFF08;
    ulong dez2end : "gens.exe", 0x40F5C, 0xFC00;
    byte ddzboss : "gens.exe", 0x40F5C, 0xB1E4;
    byte sszboss : "gens.exe", 0x40F5C, 0xB278;
    byte delactive : "gens.exe", 0x40F5C, 0xEEE5;

    byte savefile : "gens.exe", 0x40F5C, 0xEF4A;
    byte savefilezone : "gens.exe", 0x40F5C, 0xFDEA;
    ushort waterlevel : "gens.exe", 0x40F5C, 0xF647;
    byte centiseconds : "gens.exe", 0x40F5C, 0xFE24;
}

state("retroarch", "32bit")
{
    ushort level :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEE4E;
    byte zone   :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEE4F;
    byte act    :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEE4E;
    byte reset  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFFFC;
    byte trigger  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xF601; //new game is 8C
    ushort timebonus  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    ushort scoretally  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFE28;
    byte chara  :   "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFF08;
    ulong dez2end : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFC00;
    byte ddzboss : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xB1E4;
    byte sszboss : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xB278;
    byte delactive : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEEE5;

    byte savefile : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xEF4A;
    byte savefilezone : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFDEA;
    ushort waterlevel : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xF647;
    byte centiseconds : "genesis_plus_gx_libretro.dll", 0x01AF84, 0xFE24;
}

state("retroarch", "64bit")
{
    ushort level :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xEE4E;
    byte zone   :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xEE4F;
    byte act    :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xEE4E;
    byte reset  :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xFFFC;
    byte trigger  :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xF601; //new game is 8C
    ushort timebonus  :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    ushort scoretally  :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xFE28;
    byte chara  :   "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xFF08;
    ulong dez2end : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xFC00;
    byte ddzboss : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xB1E4;
    byte sszboss : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xB278;
    byte delactive : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xEEE5;

    byte savefile : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xEF4A;
    byte savefilezone : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xFDEA;
    ushort waterlevel : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xF647;
    byte centiseconds : "genesis_plus_gx_libretro.dll", 0x24A3D0, 0xFE24;
}

state("blastem")
{
    ushort level :   0x001FB410, 0x68, 0xEE4E;
    byte zone   :   0x001FB410, 0x68, 0xEE4F;
    byte act    :   0x001FB410, 0x68, 0xEE4E;
    byte reset  :   0x001FB410, 0x68, 0xFFFC;
    byte trigger  :   0x001FB410, 0x68, 0xF601; //new game is 8C
    ushort timebonus  :   0x001FB410, 0x68, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    ushort scoretally  :   0x001FB410, 0x68, 0xFE28;
    byte chara  :   0x001FB410, 0x68, 0xFF08;
    ulong dez2end : 0x001FB410, 0x68, 0xFC00;
    byte ddzboss : 0x001FB410, 0x68, 0xB1E4;
    byte sszboss : 0x001FB410, 0x68, 0xB278;
    byte delactive : 0x001FB410, 0x68, 0xEEE5;

    byte savefile : 0x001FB410, 0x68, 0xEF4A;
    byte savefilezone : 0x001FB410, 0x68, 0xFDEA;
    ushort waterlevel : 0x001FB410, 0x68, 0xF647;
    byte centiseconds : 0x001FB410, 0x68, 0xFE24;
}


state("SEGAGameRoom")
{
    ushort level :   "GenesisEmuWrapper.dll", 0xB677E8, 0xEE4E;
    byte zone   :   "GenesisEmuWrapper.dll", 0xB677E8, 0xEE4F;
    byte act    :   "GenesisEmuWrapper.dll", 0xB677E8, 0xEE4E;
    byte reset  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xFFFC;
    byte trigger  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xF601; //new game is 8C
    ushort timebonus  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    ushort scoretally  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xFE28;
    byte chara  :   "GenesisEmuWrapper.dll", 0xB677E8, 0xFF08;
    ulong dez2end : "GenesisEmuWrapper.dll", 0xB677E8, 0xFC00;
    byte ddzboss : "GenesisEmuWrapper.dll", 0xB677E8, 0xB1E4;
    byte sszboss : "GenesisEmuWrapper.dll", 0xB677E8, 0xB278;
    byte delactive : "GenesisEmuWrapper.dll", 0xB677E8, 0xEEE5;

    byte savefile : "GenesisEmuWrapper.dll", 0xB677E8, 0xEF4A;
    byte savefilezone : "GenesisEmuWrapper.dll", 0xB677E8, 0xFDEA;
    ushort waterlevel : "GenesisEmuWrapper.dll", 0xB677E8, 0xF647;
    byte centiseconds : "GenesisEmuWrapper.dll", 0xB677E8, 0xFE24;
}

state("SEGAGenesisClassics")
{
    ushort level :   "SEGAGenesisClassics.exe", 0x71704, 0xEE4E;
    byte zone   :   "SEGAGenesisClassics.exe", 0x71704, 0xEE4F;
    byte act    :   "SEGAGenesisClassics.exe", 0x71704, 0xEE4E;
    byte reset  :   "SEGAGenesisClassics.exe", 0x71704, 0xFFFC;
    byte trigger  :   "SEGAGenesisClassics.exe", 0x71704, 0xF601; //new game is 8C
    ushort timebonus  :   "SEGAGenesisClassics.exe", 0x71704, 0xF7D2; //Bonus - 1st byte counts down in 10s (0A Hex), 2nd byte is how many times to loop the first from FF to 00
    ushort scoretally  :   "SEGAGenesisClassics.exe", 0x71704, 0xFE28;
    byte chara  :   "SEGAGenesisClassics.exe", 0x71704, 0xFF08;
    ulong dez2end : "SEGAGenesisClassics.exe", 0x71704, 0xFC00;
    byte ddzboss : "SEGAGenesisClassics.exe", 0x71704, 0xB1E4;
    byte sszboss : "SEGAGenesisClassics.exe", 0x71704, 0xB278;
    byte delactive : "SEGAGenesisClassics.exe", 0x71704, 0xEEE5;

    byte savefile : "SEGAGenesisClassics.exe", 0x71704, 0xEF4A;
    byte savefilezone : "SEGAGenesisClassics.exe", 0x71704, 0xFDEA;
    ushort waterlevel : "SEGAGenesisClassics.exe", 0x71704, 0xF647;
    byte centiseconds : "SEGAGenesisClassics.exe", 0x71704, 0xFE24;
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
    vars.savefile = 255;
    vars.processingzone = false;
    vars.skipsAct1Split = false;
    if ( game.ProcessName == "retroarch" ) {
        if ( game.Is64Bit() ) {
            version = "64bit";
        } else {
            version = "32bit";
        }
    }
    vars.nextzonemap = false;
}


update
{
    // Stores the curent phase the timer is in, so we can use the old one on the next frame.

    current.timerPhase = timer.CurrentPhase;

    // Water Level is 16 for levels without water, and another value for those with
    // it is always 0 after a reset upto and including the save select menu
    // centiseconds is reset to 0 upon accessing the save select menu as well, and starts as soon as the game starts
    // we use old.centiseconds to prevent flukes of them being 0.
    current.inMenu = ( current.waterlevel == 0 && current.centiseconds == 0 && old.centiseconds == 0 );

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
            vars.savefile = current.savefile;
            vars.skipsAct1Split = !settings["actsplit"];
            
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
    if ( 
        ( current.reset == 0 && old.reset != 0 ) || 
        ( current.inMenu == true
            && ( 
                ( current.savefile == 9 && current.delactive == 0xFF && old.delactive == 0 ) ||
                ( 
                    current.savefile == vars.savefile && 
                    (vars.nextact + vars.nextzone) <= 1 && 
                    old.savefilezone == 255 && 
                    current.savefilezone == 0 )
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
    const byte ACT_2 = 2;

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

    if ( old.zone != current.zone && settings["actsplit"] ) {
        vars.skipsAct1Split = ( 
            ( current.zone == MARBLE_GARDEN && settings["act_mg1"] ) || 
            ( current.zone == ICE_CAP && settings["act_ic1"] ) ||
            ( current.zone == LAUNCH_BASE && settings["act_lb1"] )
        );
    }

    if (!vars.processingzone && current.zone != DOOMSDAY && current.zone == vars.nextzone && current.act == vars.nextact)
    {
        vars.processingzone = true;
        vars.nextact = 1 - vars.nextact; //1-1 is 0, 1-0 is 1 - toggles between act 1 and 2
        if (current.act == ACT_2) //starting act 2
        {
            vars.nextzone = vars.nextzonemap[current.zone]; //if we just incremented next act past act 2 increment the zone
            if ( current.zone == LAVA_REEF || ( current.zone == LRB_HIDDEN_PALACE && current.chara == KNUCKLES ) ) {
                // LR2 -> HP = 22-1 and HP -> SS2 for Knux
                vars.nextact = ACT_2; 
            } 
            if (!vars.skipsAct1Split || current.zone == LRB_HIDDEN_PALACE) split = true;
        }
        else //starting act 1 of new zone
        {
            if ( 
                // Handle IC boss skip
                ( current.zone == ICE_CAP && vars.skipsAct1Split ) ||
                ( current.zone == SKY_SANCTUARY ) ||
                ( current.zone == LRB_HIDDEN_PALACE )
            ) {  
                vars.nextzone = vars.nextzonemap[current.zone];
                vars.nextact = ACT_1;
            }
            if ( current.zone < LRB_HIDDEN_PALACE ) {
                split = true;
            }
        }
        vars.processingzone = false;
    }
    
    if (!vars.dez2split && current.zone == DEATH_EGG_BOSS && current.act == 0) //detect fade to white on death egg 2
    {
        if ((current.dez2end == 0xEE0EEE0EEE0EEE0E && old.dez2end == 0xEE0EEE0EEE0EEE0E) ||
            (current.dez2end == 0x0EEE0EEE0EEE0EEE && old.dez2end == 0x0EEE0EEE0EEE0EEE))
        {
            vars.DebugOutput("DEZ2 Boss White Screen detected");
            vars.dez2split = true;
            split = true;
        }
    }
    
    if (current.zone == DOOMSDAY && current.ddzboss == 255 && old.ddzboss == 0) //Doomsday boss detect final hit
    {
        vars.DebugOutput("Doomsday Zone Boss death detected"); //need to detect fade to white, same as DEZ2End
        vars.ddzsplit = true;
    }
    
    if (vars.ddzsplit || vars.sszsplit) //detect fade to white on doomsday
    {
        if ((current.dez2end == 0xEE0EEE0EEE0EEE0E && old.dez2end == 0xEE0EEE0EEE0EEE0E) ||
            (current.dez2end == 0x0EEE0EEE0EEE0EEE && old.dez2end == 0x0EEE0EEE0EEE0EEE))
        {
            vars.DebugOutput("Doomsday/SS White Screen detected");
            split = true;
        }
    }
    

    if (current.chara == KNUCKLES && current.zone == SKY_SANCTUARY) //detect final hit on Knux Sky Sanctuary Boss
    {
        if (current.sszboss == 0 && old.sszboss == 1)
        {
            vars.DebugOutput("Knuckles Final Boss 1st phase defeat detected");
            vars.sszsplit = true;
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
    if ( vars.bonus && old.timebonus == 0 ) {
        // If we had a bonus, and the previous frame's timebonus is now 0, reset it
        vars.bonus = false;
    } else if ( !vars.bonus && current.act <= 1 && current.timebonus < old.timebonus && current.scoretally > old.scoretally ) {
        // if we haven't detected a bonus yet
        // check that we are in an act (sanity check)
        // then check to see if the current timebonus is less than the previous frame's one.
        vars.DebugOutput(String.Format("Detected Bonus decrease: {0} from: {1}", current.timebonus, old.timebonus));
        vars.bonus = true;
    }
    return vars.bonus;
}