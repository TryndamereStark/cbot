takeScreenshot(outDir = "screenshots", outTitle = "", height = 672)
{
    global botMode
    global txt
    
    winName := "BlueStacks App Player"
    clientW := 868
    clientH := 720
    gameW := clientW
    gameH := height
    
    FileCreateDir, screenshots
    
    pToken := Gdip_Startup()
    WinGetPos, winX, winY, winW, winH, %winName%
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
        WinGet, hwnd, , %winName%
        windowArea := Gdip_BitmapFromHWND(hwnd)
        screenshotArea := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, gameW, gameH)
        Gdip_DisposeImage(windowArea)
    }
    else
        screenshotArea := Gdip_BitmapFromScreen(winX "|" winY "|" gameW "|" gameH)
    
    timestamp := A_YYYY "-" A_MM "-" A_DD "_" A_Hour "-" A_Min "-" A_Sec
    outPath := outDir "\" timestamp "_" outTitle ".png"
    
    Gdip_SaveBitmapToFile(screenshotArea, outPath)
    
    Gdip_DisposeImage(screenshotArea)
    Gdip_ShutDown(pToken)
    
    guiBar(txt["SCREENSHOT"], "success")
}