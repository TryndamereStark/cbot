SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
#NoTrayIcon
#NoEnv
#SingleInstance,Force
DetectHiddenWindows,On
CoordMode, Pixel, Client
CoordMode, Mouse, Client
CoordMode, Caret, Client

#Include ..\libs\Gdip.ahk
#Include ..\libs\Gdip_ImageSearch.ahk
#Include ..\libs\Gdip_PixelSearch.ahk
#Include ..\myLibs\overwrited.ahk
#Include ..\myLibs\fun.multiImageSearch.ahk
#Include ..\myLibs\fun.multiPixelSearch.ahk

IniRead, botMode, settings.ini, GENERAL, botMode

winName := "BlueStacks App Player"
BlueStacksID := WinExist(winName)
clientW := 868
clientH := 720
WinGetPos, winX, winY, winW, winH, %winName%
WinGet, hwnd, , %winName%
winBorder := (winW-clientW)/2
titleBar := winH-clientH-winBorder
wShiftX := winBorder
wShiftY := titleBar
    
queenAb := 0
Loop
{
    if(queenAb = 0)
    {
        if(A_Index = 5)
            break
        queenAbility := multiImageSearch("patterns\troops\queenAbility.png", "0,564,868,567", 35, "10|100", "horizontal")
        if(queenAbility["hits"] > 0)
        {
            queenCoords := StrSplit(queenAbility["coords"] , ",", " ")
            queenCoordX := queenCoords[1] - 10
            queenCoordY := queenCoords[2] + 3
            queenAb := 1
        }
    }
    else if(queenAb = 1)
    {
        muchHealth := multiPixelSearch(0xff76f90c, queenCoordX "," queenCoordY "," queenCoordX "," queenCoordY + 3, 60)
        if(muchHealth["hit"] = false)
        {
            myClick(queenCoordX "," queenCoordY + 50)
            break
        }
    }
    Sleep 1000
}
ExitApp
