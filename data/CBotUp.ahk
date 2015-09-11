/*
 * * * Compile_AHK SETTINGS BEGIN * * *

[AHK2EXE]
Exe_File=%In_Dir%\CBotUp.exe
[VERSION]
Set_Version_Info=1
Company_Name=Caderek Ltd
File_Description=Bot for Clash of Clans
File_Version=1.7.0.0
Inc_File_Version=0
Legal_Copyright=Caderek Ltd
Original_Filename=CBotUp
Product_Name=CBot
Product_Version=1.7.0.0
Language_ID=88
Charset=1
[ICONS]
Icon_1=%In_Dir%\ico\CBot.ico
Icon_3=%In_Dir%\ico\CBotSuspend.ico
Icon_4=%In_Dir%\ico\CBotPause.ico

* * * Compile_AHK SETTINGS END * * *
*/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include ..\libs\httpRequest.ahk
IniRead, version, settings.ini, GENERAL, version, 0
IniRead, lang, settings.ini, GENERAL, lang, 0
#Include ..\myLibs\fun.setLanguage.ahk
setLanguage()

url := "http://runcbot.com/update.html"
bytesDownloaded := HTTPRequest(url, response)
if(bytesDownloaded != 0)
{
    updateInfo := StrSplit(response, ";", " ")
    latest := updateInfo[1]
    
    if(latest != version AND updateInfo[3] = "yes")
    {
        FileCreateDir, backup
        UrlDownloadToFile, http://runcbot.com/download/%latest%/install.txt, install.txt
        If !ErrorLevel
        {
            updaterGui()
            Sleep 1000
            Loop, read, install.txt
            {
                if(A_LoopReadLine != "")
                {
                    filePath := Trim(A_LoopReadLine)
                    StringLower, filePathLow, filePath
                    StringReplace, filePathWin, filePath, `/, `\, 1
                    SplitPath, filePathWin , fileName, fileFolder
                    IfExist, %filePathWin%
                    {
                        if(fileFolder != "")
                            FileCreateDir, backup\%fileFolder%
                    }
                    FileCopy, %filePathWin%, ..\backup\%filePathWin%, 1
                    UrlDownloadToFile, http://runcbot.com/download/%latest%/%filePathLow%, %filePath%
                }
            }
            IniWrite, %latest%, settings.ini, GENERAL, version
            updaterGui("destroy")
        }
    }
}
else
    TrayTip, CBot, %TXT_CONNECTION_ERROR%, 5, 3
Run, ..\CBot.exe
ExitApp
updaterGui(mode = "show")
{
    global TXT_UPDATE_IN_PROGRESS
    if(mode = "show")
    {
        Gui updater: +LastFound +ToolWindow +AlwaysOnTop -Caption -DPIScale
        Gui updater: Color, 1B1321
        Gui updater: Margin, 0, 0
        WinSet, Transparent, 240
        Gui updater: font, s10 cDC56D0 normal
        Gui updater: Add, Picture, x180 y40, ico/CBotMin.png
        Gui updater: Add, Text, x0 y90 w400 r1 Center, %TXT_UPDATE_IN_PROGRESS%
        Gui updater: Show, w400 h150, CBot Preview
    }
    else if(mode = "destroy")
    {
        Gui updater: Destroy
    }
}