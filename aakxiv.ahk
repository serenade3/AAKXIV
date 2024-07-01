/*
FINAL FANTASY XIV Anti-AFK script.

{DESCRIPTION}

By default, sends a random input at random intervals between 5 and 25 minutes.

INSTRUCTIONS: Open this script file using AutoHotkey V2 and then press CTLR+S.
PAUSING/TOGGLING: Use WIN+CTLR+P to pause/toggle the script.

MODIFYING ACTIVATION BUTTON: The first line of code designates the activation button. "^s" means CTLR+S. 
You can modify this to your liking. e.g. "^k" for CTLR+K
HOTKEYS REFERENCE: https://www.autohotkey.com/docs/v2/Hotkeys.htm
KEYS REFERENCE: https://www.autohotkey.com/docs/v2/KeyList.htm

MODIFYING DELAY: Modify the millisecond values in "Random()".
Currently set to 300000 (5 minutes) and 1500000 (25 minutes)

MODIFYING BUTTON PRESSED: Modify the values in the "keys" array to adjust what keys can possibly be pressed.
KEYS REFERENCE: https://www.autohotkey.com/docs/v2/KeyList.htm

{CHANGELOG}
- v1.2 - Add logging.
- v1.1 - Allow for multiple key press possibilities. Added array to manage possible key presses.
*/
logFileName := "aiga-anti-afk.log"
Try FileDelete logFileName
^s::
{
    global
    keys := ["{Space}", "{1}", "{x}", "{LControl}"]
    programids := WinGetList("FINAL FANTASY XIV",,,)
    Loop
        {
            ranSleep := Random(300000, 1500000)
            ranSleepMinutes := MillisecondsToMinutes(ranSleep)
            input := keys[Random(1, keys.Length)]
            ControlSend(input, , "ahk_id " programids[1])
            flog "Sent " input " input"
            flog "Sleeping for roughly " Integer(ranSleepMinutes) " minutes"
            Sleep(ranSleep)
        }
    Return
}
#^p::Pause(-1)

; Convert milliseconds to minutes.
MillisecondsToMinutes(milliseconds)
{
    return milliseconds / 60000
}

; File Logging
flog(params*)
{
    logfile := logFileName
    ts := FormatTime(, "yyyy-MM-dd HH:mm:ss.") substr(A_TickCount,-3)
    ; s := A_TickCount
    ; ts := substr(s,-6,3) "." substr(s,-3)
    for ,param in params
      message .= param . " "
    FileAppend ts " " message "`n", logfile
}