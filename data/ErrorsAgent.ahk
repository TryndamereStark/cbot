SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
#NoTrayIcon
#NoEnv
#SingleInstance,Force
DetectHiddenWindows,On
CoordMode, Pixel, Client
CoordMode, Mouse, Client
CoordMode, Caret, Client

;LADOWANIE BIBLIOTEK
#Include ..\libs\Gdip.ahk
#Include ..\libs\Gdip_ImageSearch.ahk
#Include ..\libs\Gdip_PixelSearch.ahk
#Include ..\myLibs\overwrited.ahk
;LADOWANIE FUNKCJI:
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

recognizeScreen(name, mode = "normal", runCritical = false)
{  
    if(name = "main")
    {
        closeChat()
        if(mode = "once")
            repeatSet := ""
        else if(mode = "few")
            repeatSet := "20|100"
        else
            repeatSet := "240|1000"
            
        mainScreen := multiPixelSearch(0xff2b84c0, "230,30", 10, repeatSet) ; sprawdza czy g³ówny ekran gry jest widoczny (czy gra jest za³adowana)
        if(mainScreen["hit"] = true)
            return true
        else
            return false
    }
}

closeChat()
{
    chatVisible := multiPixelSearch(0xffd34b17, "335,375", 20) ; sprawdza czy czat jest wysuniêty
    if(chatVisible["hit"] = true)
    {
        myClick(chatVisible["coords"]) ; zamyka czat
        Sleep 500
    }
}
; funkcja sprawdza b³edy - je¿eli wystêpuj¹ to zwraca false i  próbuje za³adowaæ ekran g³ówny gry (w ostatecznoœci zamyka BlueStacks i konczy skrypt)

buyBS()
{
    dontBuy := multiImageSearch("patterns\interface\buyBS.png", "475,455,825,460", 50)
    if(dontBuy["hits"] > 0)
    {
        myClick(dontBuy["coords"])
        Sleep 10000
        return true
    }
    return false
}

enemyRaid()
{
    raid := multiImageSearch("patterns\interface\raid.png", "290,348,330,378", 50)
    if(raid["hits"] > 0)
    {
        myClick("434,500")
        Sleep 2000
        return true
    }
    return false
}

checkError()
{   
    special := false
	errorAlert := multiImageSearch("patterns\interface\error.png", "500,286|10", 20, "5|0") ; sprawdzenie czy nie ma errora
	if(errorAlert["hits"] > 0)
	{
        Loop
        {
            specialError := multiImageSearch("patterns\interface\anotherDevice|takeBreak|maintenance.png", "160,250,710,425", 50, , "horizontal")
            if(specialError["hits"] > 0)
            {
                special := true
                if(specialError["name"] = "anotherDevice")
                {
                    Sleep 120000
                    break
                }
                else if(specialError["name"] = "takeBreak" OR specialError["name"] = "maintenance")
                {
                    myClick("230, 70") ; obszar neutralny
                    Sleep 30000
                    continue
                }
            }
            else
                break
        }
        Loop 2
        {
		myClick("230, 70") ; obszar neutralny
		Sleep 500
        }
        recognizeScreen("main", , true)
        if(special = true)
            return true
        else
            return false
	}
	else
        return false
}

resume()
{
    IniRead, activeModule, temp.ini, TEMP, activeModule
    if(SubStr(activeModule, 1, 11) = "autofarming")
        Send {F5}
    else if (activeModule = "search")
        Send {F3}
    else if(activeModule = "watch")
        Send {F1}
}

Loop
{  
    Sleep 600000
    if !ProcessExist("CBot.exe")
    {
        MsgBox, 4, CBot, Exit CBot?, 10
        IfMsgBox Yes
            ExitApp
        Else
            Run, ..\Cbot.exe
        Sleep 5000
        resume()
    }    
    else if(checkError() = true OR enemyRaid() = true OR buyBS() = true)
    {
        Send {F10}
        Sleep 5000
        resume()
    }
}
        
ExitApp
