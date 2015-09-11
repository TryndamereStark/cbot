#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

Loop{
    WinActivate BlueStacks App Player
    Sleep 1000
    PixelSearch, OutputVarX, OutputVarY, 430, 100, 430, 100, 0x000000 , 5
    if ErrorLevel
    {
        Send {F10}
        Sleep 5000
        Send {F7}
        Sleep 600000
    }
    Else
        Sleep 10000
}