livePreview(action = 1, size = "M")
{
    if(action = 0)
    {
        Gui live: Destroy
    }
    else
    {
        global titleBar
        global curButton
        zoom := 0.25
        SysGet, winBorder, 32, 33
        WinGetPos,,,, tbH, ahk_class Shell_TrayWnd
        if(size = "XL")
            zoom := 0.6
        else if(size = "L")
            zoom := 0.4
        else if(size = "S")
            zoom := 0.15
        else
            zoom := 0.25
        liveW := 868 * zoom
        liveH := 672 * zoom
        liveX := A_ScreenWidth - liveW
        liveY := A_ScreenHeight - liveH - tbH

        WinGet,source,Id,BlueStacks App Player
        Gui live: +LastFound +ToolWindow +AlwaysOnTop -Caption -DPIScale
        Gui live: Add, Picture, GuiMove w%liveW% h%liveH% x0 y0
        Gui live: Show, w%liveW% h%liveH% x%liveX% y%liveY%, CBot Preview
        WinGet,target,Id,CBot Preview
        DetectHiddenWindows,On

        VarSetCapacity(thumbnail,4,0)
        hr1:=DllCall("dwmapi.dll\DwmRegisterThumbnail","UInt",target,"UInt",source,"UInt",&thumbnail)
        thumbnail:=NumGet(thumbnail)

        dwFlags:=0X1 | 0x2 | 0x10
        opacity:=150
        fVisible:=1
        fSourceClientAreaOnly:=1

        WinGetPos,wx,wy,ww,wh,ahk_id %target%

        VarSetCapacity(dskThumbProps,45,0)
        
        NumPut(dwFlags,dskThumbProps,0,"UInt")
        NumPut(0,dskThumbProps,4,"Int")
        NumPut(0,dskThumbProps,8,"Int")
        NumPut(ww,dskThumbProps,12,"Int")
        NumPut(wh,dskThumbProps,16,"Int")
        NumPut(0,dskThumbProps,20,"Int")
        NumPut(0,dskThumbProps,24,"Int")
        NumPut(ww/zoom,dskThumbProps,28,"Int")
        NumPut(wh/zoom,dskThumbProps,32,"Int")
        NumPut(opacity,dskThumbProps,36,"UChar")
        NumPut(fVisible,dskThumbProps,37,"Int")
        NumPut(fSourceClientAreaOnly,dskThumbProps,41,"Int")
        hr2:=DllCall("dwmapi.dll\DwmUpdateThumbnailProperties","UInt",thumbnail,"UInt",&dskThumbProps)
    }
    WinActivate, BlueStacks App Player
}