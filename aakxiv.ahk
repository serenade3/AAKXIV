/*
FINAL FANTASY XIV Anti-AFK script.

By default, sends a Space Bar input at random intervals between 5 and 25 minutes.

INSTRUCTIONS: Open this script file using AutoHotkey V2 and then press CTLR+S.
PAUSING/TOGGLING: Use WIN+CTLR+P to pause/toggle the script.

MODIFYING ACTIVATION BUTTON: The first line of code designates the activation button. "^s" means CTLR+S. 
You can modify this to your liking. e.g. "^k" for CTLR+K
HOTKEYS REFERENCE: https://www.autohotkey.com/docs/v2/Hotkeys.htm
KEYS REFERENCE: https://www.autohotkey.com/docs/v2/KeyList.htm

MODIFYING DELAY: Modify the millisecond values in "Random()".
Currently set to 300000 (5 minutes) and 1500000 (25 minutes)

MODIFYING BUTTON PRESSED: Use your brain and modify "ControlSend" to adjust the key that is pressed. Currently set to "{Space}" for Space Bar.
KEYS REFERENCE: https://www.autohotkey.com/docs/v2/KeyList.htm
*/
^s::
{
    global
    programids := WinGetList("FINAL FANTASY XIV",,,)
    Loop
        {
            ranSleep := Random(300000, 1500000)
            ControlSend("{Space}", , "ahk_id " programids[1])
            Sleep(ranSleep)
        }
    Return
}
#^p::Pause(-1)