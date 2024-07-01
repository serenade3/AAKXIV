# Anti AFK Kick AHK Script

## Description

A simple AHK script designed to prevent you from getting kicked from FFXIV for being AFK.

Use at your own risk. ;)

## Requirements

* [AutoHotkey V2](https://www.autohotkey.com/)

## How to use

Download the latest version of this and open the `aakxiv.ahk` file. While it is running, press CTLR+S to activate it.

You can press WIN+CTLR+P to pause it.

## How it works

Using AutoHotkey, it simply sends inputs to your FFXIV window every so often in a random interval between 5 and 25 minutes. It is configured to send a random input between the following:

* Left Control
* Space
* X
* 1

## Modifying the script

If you're feeling nerdy you can open the `aakxiv.ahk` file in any text editor and modify the code. It should be well documented enough for it to be easy.

You can modify the possible inputs and the interval to your liking.

## Documentation

* [AutoHotkey Keys Code Reference](https://www.autohotkey.com/docs/v2/KeyList.htm)
* [AutoHotkey HotKeys Code Reference](https://www.autohotkey.com/docs/v2/Hotkeys.htm)