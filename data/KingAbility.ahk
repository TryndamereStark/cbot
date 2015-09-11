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
    
kingAb := 0
Loop
{
    if(kingAb = 0)
    {
        if(A_Index = 5)
            break
        kingAbility := multiImageSearch("patterns\troops\kingAbility.png", "0,563,868,566", 35, "10|100", "horizontal")
        if(kingAbility["hits"] > 0)
        {
            kingCoords := StrSplit(kingAbility["coords"] , ",", " ")
            kingCoordX := kingCoords[1] - 10
            kingCoordY := kingCoords[2] + 3
            kingAb := 1
        }
    }
    else if(kingAb = 1)
    {
        muchHealth := multiPixelSearch(0xff76f90c, kingCoordX "," kingCoordY "," kingCoordX "," kingCoordY + 3, 60)
        if(muchHealth["hit"] = false)
        {
            myClick(kingCoordX "," kingCoordY + 50)
            break
        }
    }
    Sleep 1000
}
ExitApp
