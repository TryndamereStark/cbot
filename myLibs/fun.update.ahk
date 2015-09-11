update()
{
    global TXT_CONNECTION_ERROR
    IniRead, version, data/settings.ini, GENERAL, version, 0
    IniRead, updater, data/settings.ini, GENERAL, updater, 0
    
    url := "http://runcbot.com/update.html"
    bytesDownloaded := HTTPRequest(url, response)
    if(bytesDownloaded != 0)
    {
        updateInfo := StrSplit(response, ";", " ")
        ;updateInfo[1]: nr wersji na serwerze (np. 1.6)
        ;updateInfo[2]: aktualizacja Managera (yes /no)
        ;updateInfo[3]: aktualizacja CBota (yes /no)
        ;MsgBox % updateInfo[1] " | " updateInfo[2] " | " updateInfo[3]
        
        latest := updateInfo[1]
        
        if(latest != updater AND updateInfo[2] = "yes")
        {
            updateGui()
            Sleep 1000
            FileCreateDir, backup
            FileCopy, data\CBotUp.exe, backup\CBotUp.exe, 1
            UrlDownloadToFile, http://runcbot.com/download/%latest%/cbotup.exe, data\CBotUp.exe
            If !ErrorLevel
                IniWrite, %latest%, data/settings.ini, GENERAL, updater
            updateGui("destroy")
        }
        if(latest != version AND updateInfo[3] = "yes")
        {
            Run, data\CBotUp.exe
            ExitApp
        }
    }
    else
        TrayTip, CBot, %TXT_CONNECTION_ERROR%, 5, 3
}
updateGui(mode = "show")
{
    global TXT_INSTALL_UPDATE_IN_PROGRESS
    if(mode = "show")
    {
        Gui update: +LastFound +ToolWindow +AlwaysOnTop -Caption -DPIScale
        Gui update: Color, 1B1321
        Gui update: Margin, 0, 0
        WinSet, Transparent, 240
        Gui update: font, s10 cDC56D0 normal
        Gui update: Add, Picture, x180 y40, data\ico\CBotMin.png
        Gui update: Add, Text, x0 y90 w400 r1 Center, %TXT_INSTALL_UPDATE_IN_PROGRESS%
        Gui update: Show, w400 h150, CBot Preview
    }
    else if(mode = "destroy")
    {
        Gui update: Destroy
    }
}