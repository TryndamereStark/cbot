writeLog(message, msgStatus = "normal", trayMsg = false)
{
    global showTrayMsg
    global liveLog
    global maximalized
    
    guiBar(message, msgStatus)
    if(trayMsg = true AND showTrayMsg = 1)
    {
        if(msgStatus = "error")
            TrayTip, CBot, %message%, 5, 3
        else if(msgStatus = "warning")
            TrayTip, CBot, %message%, 5, 2
        else if(msgStatus = "success")
            TrayTip, CBot, %message%, 5, 1
        else
            TrayTip, CBot, %message%, 5
    }
    
    ;Uzupelnienie nazw statusow spacjami tak aby wszystkie statusy mialy taka sama dlugosc (lepiej wyglada w logu)
    if(msgStatus = "error")
        msgStatus := "error  "
    else if(msgStatus = "normal")
        msgStatus := "normal "
    else if(msgStatus = "miss")
        msgStatus := "miss   "
        
    FileCreateDir, log
    logRecord := A_YYYY "-" A_MM "-" A_DD " " A_Hour ":" A_Min ":" A_Sec " | " msgStatus " | " message "`n"
    FileAppend , %logRecord%, log/fullLog.txt
    liveLog := logRecord liveLog
    if(maximalized = 1)
        GuiControl main: , logEdit, %liveLog%
}