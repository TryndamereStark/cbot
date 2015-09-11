;funkcja aktywuje lub w razie potrzeby uruchamia aplikacje BlueStacks

initGame(mode = "normal")
{
	global runPath
    global txt
	
	IfWinExist BlueStacks App Player
	{
        activateBS()
        loadWinVars()
        if(mode = "first")
            guiBar(,, "start")
		return false
	}
	else
	{
		Run, %runPath%
        if ErrorLevel = ERROR
        {
            writeLog(txt["INIT_GAME_ERR"], "error")
            if(mode = "normal")
                serveCritical()
            else if(mode = "first")
            {
                MsgBox % txt["INIT_GAME_ERR"]
                ExitApp
            }
        }
		WinWait BlueStacks App Player
		activateBS()
        loadWinVars()
        
        if(mode = "first")
            guiBar(,, "start")
        writeLog(txt["INIT_GAME_SUCCESS"], "success")
		Sleep 2000
        writeLog(txt["RUN_GAME_WAITING"])
        
        recognizeScreen("main", , true)
            
		return true
	}
}
loadWinVars()
{
    global
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
}