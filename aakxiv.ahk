/*
FINAL FANTASY XIV Anti-AFK script.

{DESCRIPTION}

By default, sends a random input at random intervals between 5 and 25 minutes.

{INSTRUCTIONS}

Open this script file using AutoHotkey V2 and then press F2.

Use F3 to pause/unpause the script.

{MODIFYING HOTKEYS}

The lines "F2::"  & "F3::" designates the hotkey to use for activation and pausing.
You can modify this to your liking. e.g. "^k" for CTLR+K

HOTKEYS REFERENCE: https://www.autohotkey.com/docs/v2/Hotkeys.htm
KEYS REFERENCE: https://www.autohotkey.com/docs/v2/KeyList.htm
*/

; === VARIABLES ===
; Possible input presses. See https://www.autohotkey.com/docs/v2/KeyList.htm
keys := ["{Space}", "{1}", "{x}"]

; Define interval minimum & maximum. In MILLISECONDS.
; By default, it is between 5 & 25 minutes.
minInterval := 300000
maxInterval := 1500000

; Define log file name and delete existing log if exists.
logFileName := "aakxiv.log"

; Activate gameplay detection.
; If activated, the script will attempt to detect if you're currently playing. If so, it will not send input.
; This is a convenience feature to avoid having to pause/unpause it manually.
; Use "retryInterval" to set how long (in minutes) it will take to attempt to send input again after gameplay is successfully detected.
detectGameplay = false
retryInterval = 5

; === END VARIABLES ===

; Delete old log file if it exists.
Try FileDelete logFileName

; Hotkey - Upon pressing "F2", activate script.
F2::
{
    global
    ; Obtain program ID.
    programids := WinGetList("FINAL FANTASY XIV",,,)
    windowId := programids[1]

    ; Core loop.
    Loop
    {
        ; Gameplay detection logic.
        if detectGameplay 
        {
            ; If the game window is active, attempt to detect gameplay.
            if WinActive("ahk_id " windowId)
            {
                ; We read any key input here. Mouse movement or clicks aren't sufficient.
                ih := InputHook(, "{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}")
                ih.KeyOpt("{All}", "+V")
                ih.Start()
                ih.Wait(5.0) ; Spend 5 seconds waiting for input to be detected.
                ih.Stop()

                ; If input is detected, we wait before trying to send input again.
                if ih.Input != ""
                {
                    FileLog "Gameplay detected. Script will retry after " retryInterval " minutes"
                    Sleep(1000 * 60 * retryInterval)
                    Continue
                } 
            }
        }

        ; Get a random interval and a random key to press.
        randomInterval := Random(minInterval, maxInterval)
        input := keys[Random(1, keys.Length)]
            
        ; Press the key.
        ControlSend(input, , "ahk_id " windowId)

        ; File logging.
        FileLog "Sent " input " input"
        if randomInterval < 60000
        {
            readableInterval := MillisecondsToSeconds(randomInterval)
            measure := "seconds"
        }
        else 
        {
            readableInterval := MillisecondsToMinutes(randomInterval)
            measure := "minutes"
        }
        FileLog "Sleeping for roughly " Integer(readableInterval) " " measure

        ; Sleep for the random interval.
        Sleep(randomInterval)
    }
    Return
}

; Hotkey - Upon pressing "F3", pause script.
F3::
{
    if A_IsPaused = 1
    {
        FileLog "Unpausing script"
    }
    else
    {
        FileLog "Pausing script"
    }
    Pause(-1)
}

; Helper Function - Convert milliseconds to seconds.
MillisecondsToSeconds(milliseconds)
{
    return milliseconds / 1000
}

; Helper Function - Convert milliseconds to minutes.
MillisecondsToMinutes(milliseconds)
{
    return milliseconds / 60000
}

; Helper Function - File Logging
FileLog(params*)
{
    logfile := logFileName
    ts := FormatTime(, "yyyy-MM-dd HH:mm:ss.") substr(A_TickCount,-3)
    ; s := A_TickCount
    ; ts := substr(s,-6,3) "." substr(s,-3)
    for ,param in params
      message .= param . " "
    FileAppend ts " " message "`n", logfile
}