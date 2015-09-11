;ZESTAW NADPISANYCH FUNKCJI WBUDOWANYCH
;##############################################################################################################################################################################

myMove(coords)
{
    StringSplit, coord, coords , `,, %A_Space%
    MouseMove coord1, coord2
}

;##############################################################################################################################################################################

myClick(coords = "", interval = 20, options = "NA", clickCount = 1)
{
    global winName
    global wShiftX
    global wShiftY
    global clickModifier
    if(interval + clickModifier >= 0)
        interval :=  interval + clickModifier
    else
        interval := 0
    
    if(coords != "")
    {
        coord := StrSplit(coords, ",", " ")
        coord1 := coord[1] + wShiftX
        coord2 := coord[2] + wShiftY
        SetControlDelay -1
		Loop %clickCount%
		{
			ControlClick, x%coord1% y%coord2%, %winName%,,, 1, options
			Sleep interval
		}
    }
    else
        ControlClick, , %winName%
}

;##############################################################################################################################################################################

myIniRead(iniPath, iniLabel, iniKey, iniDefault = 0)
{
    IniRead, arrElement, %iniPath%, %iniLabel%, %iniKey%, %iniDefault%
    return arrElement
}

;##############################################################################################################################################################################

myIniWrite(iniPath, iniLabel, iniKey, iniValue)
{
    IniWrite, %iniValue%, %iniPath%, %iniLabel%, %iniKey%
    return arrElement
}

;##############################################################################################################################################################################

myMsgBox(msg, title = "CBot", options = 0, timeout = 2147483)
{
    MsgBox, 4, %title%, %msg%, %timeout%
}

;##############################################################################################################################################################################

Gdip_PixelGetColor(x, y)
{
    pToken := Gdip_Startup()
    WinGetPos, winX, winY, winW, winH, BlueStacks App Player
    winBorder := (winW-clientW)/2
    if(botMode = 1)
    {
        wShiftX := winBorder
        wShiftY := winH-clientH-winBorder
    }
    else
    {
        winX := winX+winBorder
        winY := winY+(winH-clientH-winBorder)
    }
    if(botMode = 1)
    {
        WinGet, hwnd, , BlueStacks App Player
        windowArea := Gdip_BitmapFromHWND(hwnd)
        gameArea := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, gameW, gameH)
        Gdip_DisposeImage(windowArea)
    }
    else
        gameArea := Gdip_BitmapFromScreen(winX "|" winY "|" gameW "|" gameH)
    
    ;#######################################
    outARGB := Gdip_GetPixel(gameArea, x, y)
    ;#######################################

    
    Gdip_DisposeImage(gameArea)
    Gdip_ShutDown(pToken)
    return outARGB
}

;##############################################################################################################################################################################

duration(sec)
{
    hour := floor(sec / ( 60 * 60 ))
    minute := floor((sec - hour * 60 * 60) / 60)
    result := ""
    if(hour != 0)
        result := result hour "h "
    result := result minute "m"
    return result
}

;##############################################################################################################################################################################

ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}