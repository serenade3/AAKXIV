/*
FINAL FANTASY XIV Anti-AFK script.

{DESCRIPTION}

By default, sends a random input at random intervals between 5 and 25 minutes.

{INSTRUCTIONS}

Open this script file using AutoHotkey V2. No further action is required afterwards.

Use CTLR+F3 to pause/unpause the script.

{MODIFYING HOTKEYS}

The lines "^F2::"  & "^F3::" designate the hotkeys to use for activation and pausing.
You can modify this to your liking. e.g. "^k" for CTLR+K

HOTKEYS REFERENCE: https://www.autohotkey.com/docs/v2/Hotkeys.htm
KEYS REFERENCE: https://www.autohotkey.com/docs/v2/KeyList.htm
*/

; === VARIABLES ===

; Autostart.
; If set to true, the functionality will activate as soon as this script is opened.
; Otherwise, you must use CTLR+F2 to activate the anti-afk functionality.
autostart := true

; Possible inputs to send to the game window. See https://www.autohotkey.com/docs/v2/KeyList.htm
keys := ["{Space}", "{1}", "{x}"]

; Define interval minimum & maximum. In milliseconds.
; By default, it is between 5 & 25 minutes.
minInterval := 300000
maxInterval := 1500000

; Define log file name.
; The log file will be created in the same directory as the script.
logFileName := "aakxiv.log"

; Activate gameplay detection.
; If activated, the script will attempt to detect if you're currently playing. If so, it will not send input.
; This is a convenience feature to avoid having to pause/unpause the script manually.
; Use "retryInterval" to set how long (in milliseconds) it will wait before attempting to send input again after gameplay is successfully detected.
; It's best to just set the retry interval as the "maxInterval".
detectGameplay := true
retryInterval := maxInterval

; === END VARIABLES ===

; Delete old log file if it exists.
Try FileDelete logFileName

; If autostart is enabled, we jump right into it.
; If not, "F2" must be pressed before the script does anything.
if autostart
{
    AAKXIV
}
else
{
    ; Hotkey - Upon pressing "CTLR+F2", activate script.
    ^F2::
    {
        AAKXIV
    }
}

; Hotkey - Upon pressing "CTLR+F3", pause script.
^F3::
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

; Core functionality.
AAKXIV(params*)
{
    global
    ; Obtain window ID.
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
                FileLog "Game window is active. Trying to detect gameplay."
                ; We read any key input here. Mouse movement or clicks aren't sufficient.
                ih := InputHook("L1", "{LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{CapsLock}{NumLock}{PrintScreen}{Pause}")
                ih.KeyOpt("{All}", "+V")
                ih.Start()
                ih.Wait(150.0) ; Spend 2 and a half minutes waiting for input to be detected.
                ih.Stop()

                ; If input is detected, we wait before trying to send input again.
                if ih.EndReason != "Stopped"
                {
                    FileLog "Gameplay detected. Script will retry after " GetReadableInterval(retryInterval)
                    Sleep(retryInterval)
                    Continue
                }
                else
                {
                    FileLog "No gameplay detected. Sending input"
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
        FileLog "Next input will be sent in roughly " GetReadableInterval(randomInterval)
        ; Sleep for the random interval.
        Sleep(randomInterval)
    }
    Return
}

; Helper Function - Get readable interval from milliseconds.
GetReadableInterval(milliseconds)
{
    if milliseconds < 60000
    {
        readableInterval := MillisecondsToSeconds(milliseconds)
        measure := "seconds"
    }
    else 
    {
        readableInterval := MillisecondsToMinutes(milliseconds)
        measure := "minutes"
    }
    return Integer(readableInterval) " " measure
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
    ts := FormatTime(, "yyyy-MM-dd HH:mm:ss")
    ; s := A_TickCount
    ; ts := substr(s,-6,3) "." substr(s,-3)
    for ,param in params
      message .= param . " "
    FileAppend ts " " message "`n", logfile
}