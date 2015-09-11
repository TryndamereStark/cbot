serveCritical()
{
    global criticalCount
    global shutdownOnCritical
    global txt
    global account
    global pushCritical
    
    errors := checkAll()
    mainScreen := recognizeScreen("main", "few")
    if(mainScreen = false)
    {
        FileCreateDir, log\screenshots_critical
        takeScreenshot("log\screenshots_critical")
        if(pushCritical = 1 AND account = "PRO")
            push(uri_encode(txt["CRITICAL_ERR"]), uri_encode(txt["PUSH_CRITICAL_ERR"]))
        
        if(criticalCount > 2)
        {
            writeLog(txt["CRITICAL_ERR"] " " txt["APP_EXIT_INFO"], "error")
            
            if(shutdownOnCritical = 1)
            {
                guiMain("stop")
                guiBar("stop")
                WinKill BlueStacks App Player
                writeLog(txt["SHUTDOWN_TRY"], "warning")
                Secs := 60
                SetTimer, COUNTDOWN_SHUTDOWN, 1000
                title := "CBot - " txt["REMAINING"] " " Secs " " txt["SECOND"]
                msg := txt["SHUTDOWN_INFO"]
                MsgBox, 1, %title%, %msg%., %Secs%
                SetTimer, COUNTDOWN_SHUTDOWN, Off

                IfMsgBox Cancel
                {
                    writeLog(txt["SHUTDOWN_CANCEL"])
                    ExitApp
                }
                else
                {
                    writeLog(txt["SHUTDOWN_START"], "warning")
                    Shutdown, 1
                }

                COUNTDOWN_SHUTDOWN:
                Secs -= 1
                if(Mod(Secs, 5) = 0 OR Secs < 5)
                    SoundBeep
                title := "CBot - " txt["REMAINING"] " " Secs " " txt["SECOND"]
                WinSetTitle, CBot,, %title%
                Return
            }
            
            ExitApp
        }
        else
        {
            writeLog(txt["CRITICAL_ERR"] " " txt["INIT_BS_RESTART"], "error")
            
            writeLog(txt["BS_RESTART_TRY"], "warning")
            Secs := 60
            SetTimer, COUNTDOWN_RESTART, 1000
            title := "CBot - " txt["REMAINING"] " " Secs " " txt["SECOND"]
            msg := txt["BS_RESTART_MSG"]
            MsgBox, 1, %title%, %msg%, %Secs%
            SetTimer, COUNTDOWN_RESTART, Off

            IfMsgBox Cancel
            {
                writeLog(txt["BS_RESTART_CANCEL"])
            }
            else
            {
                writeLog(txt["BS_RESTART_START"], "warning")
                criticalCount++
                guiMain("stop")
                guiBar("stop")
                WinKill BlueStacks App Player
                Sleep 5000
                initGame("first")
                guiBar(,,"start")
                Sleep 1000
                resume()
            }

            COUNTDOWN_RESTART:
            Secs -= 1
            if(Mod(Secs, 5) = 0 OR Secs < 5)
                SoundBeep
            title := "CBot - " txt["REMAINING"] " " Secs " " txt["SECOND"]
            WinSetTitle, CBot,, %title%
            Return
        }
    }
}
resume()
{
    global activeModule
    if(SubStr(activeModule, 1, 11) = "autofarming")
    {
        writeLog(txt["AUTOFARMING_RESUMED"])
        autoFarming()
    }
    else if (activeModule = "search")
    {
        writeLog(txt["SEARCHING_RESUMED"])
        search()
    }
    else if(activeModule = "watch")
    {
        writeLog(txt["WATCH_RESUMED"])
        watch()
    }
}