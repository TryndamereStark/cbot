/*
 * * * Compile_AHK SETTINGS BEGIN * * *

[AHK2EXE]
Exe_File=%In_Dir%\CBot.exe
Compression=2
[VERSION]
Set_Version_Info=1
Company_Name=Caderek Ltd
File_Description=Bot for Clash of Clans
File_Version=1.7.7.0
Inc_File_Version=0
Legal_Copyright=Caderek Ltd
Original_Filename=CBot
Product_Name=CBot
Product_Version=1.7.7.0
Language_ID=88
Charset=1
[ICONS]
Icon_1=%In_Dir%\data\ico\CBot.ico
Icon_3=%In_Dir%\data\ico\CBotSuspend.ico
Icon_4=%In_Dir%\data\ico\CBotPause.ico

* * * Compile_AHK SETTINGS END * * *
*/

SetWorkingDir, %A_ScriptDir%
SetBatchLines, -1
#NoEnv
;#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance,Force
DetectHiddenWindows,On
CoordMode, Pixel, Client
CoordMode, Mouse, Client
CoordMode, Caret, Client

curButton := "f10"

curX := 20
curY := 20
cells := cells()

Menu, tray, icon, data\ico\CBot.ico
;LADOWANIE BIBLIOTEK
#Include libs\Gdip.ahk
#Include libs\Gdip_ImageSearch.ahk
#Include libs\Gdip_PixelSearch.ahk
#Include libs\Gdip_CheckPixel.ahk
#Include libs\Gdip_Compare.ahk
#Include libs\UnixTimeStamp.ahk
#Include libs\httpRequest.ahk
#Include libs\ago.ahk
#Include libs\lva.ahk
#Include libs\uri_encode.ahk
#Include myLibs\overwrited.ahk
;LADOWANIE USTAWIEN:    
#Include myLibs\_vars.ahk
#Include myLibs\_readConfig.ahk
#Include myLibs\_writeConfig.ahk
;LADOWANIE MODULOW:
#Include modules\mod.watch.ahk
#Include modules\mod.makeArmy.ahk
#Include modules\mod.search.ahk
#Include modules\mod.attack.ahk
;LADOWANIE FUNKCJI POMOCNICZYCH:
#Include myLibs\fun.activateBS.ahk
#Include myLibs\fun.activeModule.ahk
#Include myLibs\fun.blockProVars.ahk
#Include myLibs\fun.authorization.ahk
#Include myLibs\fun.cells.ahk
#Include myLibs\fun.update.ahk
#Include myLibs\fun.hideBS.ahk
#Include myLibs\fun.multiImageSearch.ahk
#Include myLibs\fun.multiPixelSearch.ahk
#Include myLibs\fun.reloadAll.ahk
#Include myLibs\fun.initGame.ahk
#Include myLibs\fun.iniArray.ahk
#Include myLibs\fun.isOutside.ahk
#Include myLibs\fun.lightning.ahk
#Include myLibs\fun.zoomOut.ahk
#Include myLibs\fun.runGame.ahk
#Include myLibs\fun.checkAll.ahk
#Include myLibs\fun.readNumber.ahk
#Include myLibs\fun.push.ahk 
#Include myLibs\fun.writeLog.ahk
#Include myLibs\fun.writeCsv.ahk
#Include myLibs\fun.setRegister.ahk
#Include myLibs\fun.setLanguage.ahk
#Include myLibs\fun.checkPath.ahk
#Include myLibs\fun.recognizeScreen.ahk
#Include myLibs\fun.checkArmy.ahk
#Include myLibs\fun.serveCritical.ahk
#Include myLibs\fun.takeScreenshot.ahk
#Include myLibs\fun.upgrades.ahk
#Include myLibs\fun.webStats.ahk
#Include myLibs\fun.adds.ahk
;#Include tester.ahk

readGeneralConfig()
setLanguage()
authorization()
blockProVars()
readStrategyConfig()

; if !ProcessExist("ErrorsAgent.exe")
; {
    ; Run, data\ErrorsAgent.exe
; }

; if(autoUpdates = 1)
    ; update()

;LADOWANIE FUNKCJI GUI:
#Include gui\fun.setGuiVars.ahk
#Include gui\fun.guiMain.ahk
#Include gui\fun.guiBar.ahk
#Include gui\fun.guiBuildings.ahk
#Include gui\fun.guiUpgrades.ahk
#Include gui\fun.livePreview.ahk
#Include gui\_guiLabels.ahk

guiLoaded := true

startStamp := A_TickCount

checkPath()
setRegister()
initGame("first")
livePreview(livePreview, livePreviewSize)
autoFarming()
{
    global activeModule
    global txt
    global attackType
    activeModule("autofarming")
    writeLog(txt["AUTOFARMING_ON"])
	i := 0
	Loop
	{
        activeModule("autofarming_boost")
        boost()
		if(i = 0 AND checkArmy() = false)
        {
            activeModule("autofarming_start_army")
			makeArmy()
        }
        activeModule("autofarming_watch")
		watch("autofarming")
        activeModule("autofarming_army")
        makeArmy()
        activeModule("autofarming_search")
		search("autofarming")
        activeModule("autofarming_attack")
        if(attackType = "thOnly")
            thAttack()
        else
            attack()
		i++
	}
}

~LButton Up::
    WinGetClass, class, A
    if(class = "WindowsForms10.Window.8.app.0.33c0d9d" AND guiLoaded = true)
    {
        guiBar("",, "move")
        if(maximalized = 1)
            guiMain("move")
        if(buildingSetOpen = 1)
            guiBuildings("move")
        if(upgradesSetOpen = 1)
            guiUpgrades("move")
    }
    return

f1::
writeLog(TXT_PRESS_F1)
changeModeIco("f1")
watch()
return

f2::
writeLog(TXT_PRESS_F2)
changeModeIco("f2")
makeArmy()
return

f3::
writeLog(TXT_PRESS_F3)
changeModeIco("f3")
search()
return

f4::
writeLog(TXT_PRESS_F4)
changeModeIco("f4")
attack()
return

f5::
afTimeStamp := A_Now
writeLog(TXT_PRESS_F5)
changeModeIco("f5")
autoFarming()
return

f7::
; point := findClosest("190,370")
; MsgBox % point
; showLine(z3["a"], z3["b"])
autobookmarksAdds()
return

;#Include myTools\_testerLabels.ahk

f8::
autoAdds()
; changeModeIco("f9")
; ; start := A_TickCount 
; ; result := tester()
; ; stop := A_TickCount
; ; duration := (stop - start)/1000
; ; ;MsgBox % "Czas: " duration "s"
; ; guiBar("Result: " result " | Czas: " duration "s")
return

f9::pause

; f11::hideBS()

f12::takeScreenshot()

; f6::
; MsgBox %A_LineNumber%
; Return

f10::
writeLog(TXT_PRESS_F10)
reload
