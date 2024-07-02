# FFXIV Anti AFK Kick AHK Script

## Description

A simple AHK script designed to prevent you from getting kicked from FFXIV for being AFK.

Use at your own risk. ;)

## Requirements

* [AutoHotkey V2](https://www.autohotkey.com/)

## [Download](https://github.com/serenadeg/AAKXIV/releases/latest)

Download the `aakxiv.ahk` file. That's all you need.

## How to use

* Download the latest version of [AutoHotkey V2](https://www.autohotkey.com/)
* Download the `aakxiv.ahk` file from the latest release
* Open the `aakxiv.ahk` file using AutoHotkey V2

### Default Hotkeys

* **CTLR+F2** - Activate script (Only used if autostart is disabled)
* **CTLR+F3** - Pause/Resume script

## How it works

Using AutoHotkey, it simply sends inputs to your FFXIV window every so often in a random interval between 5 and 25 minutes. It is configured to send a random input between the following:

* Space
* X
* 1

By default, it will try to detect if you are playing before sending inputs. If it doesn't detect any keyboard presses in roughly a minute while the game window is active, then it will send input to prevent AFK flagging.

## Log file

When using the script it will generate a `aakxiv.log` file in the same directory as the script itself. This log file will show you exactly what buttons were pressed and when.

## Modifying the script

If you're feeling nerdy you can open the `aakxiv.ahk` file in any text editor and modify the code. It should be well documented enough for it to be easy.

At the top of the file, there will be various variables you can modify. e.g. , `keys`, `detectGameplay`, etc.

### List of variables

* `autostart` - Set to `true` to automatically start the script when the `.ahk` file is opened. When set to `false`, the Anti-AFK script must be enabled using **F2**
* `keys` - Array showing which key inputs will be sent to the game window
* `minInterval` - Minimum interval between inputs (in milliseconds)
* `maxInterval` - Maximum interval between inputs (in milliseconds)
* `logFileName` - Name of the log file where information on sent inputs will be saved
* `detectGameplay` - Set to `true` to enable gameplay detection. This will automatically detect if you're currently playing and **will not** send inputs if you're active. Convenience feature to prevent having to pause/unpause manually.
* `retryInterval` - If `detectGameplay` is enabled, determines how long to wait before trying again after gameplay is detected (in milliseconds)


## Documentation

* [AutoHotkey Keys Code Reference](https://www.autohotkey.com/docs/v2/KeyList.htm)
* [AutoHotkey HotKeys Code Reference](https://www.autohotkey.com/docs/v2/Hotkeys.htm)
