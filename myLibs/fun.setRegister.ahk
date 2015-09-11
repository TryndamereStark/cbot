setRegister()
{
    global exitPath
    global txt
    rightWidth := 868 ; 868
    rightHeight := 720
    
    change := false
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, Width
    if(key != rightWidth)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, Width, %rightWidth%
        change := true
    }
        
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, WindowWidth
    if(key != rightWidth)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, WindowWidth, %rightWidth%
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, GuestWidth
    if(key != rightWidth)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, GuestWidth, %rightWidth%
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, Height
    if(key != rightHeight)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, Height, %rightHeight%
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, WindowHeight
    if(key != rightHeight)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, WindowHeight, %rightHeight%
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, GuestHeight
    if(key != rightHeight)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, GuestHeight, %rightHeight%
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, FullScreen
    if(key != 0)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, FullScreen, 0
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, WindowState
    if(key != 1)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, WindowState, 1
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, HideBootProgress
    if(key != 1)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, HideBootProgress, 1
        change := true
    }
    
    RegRead, key, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, Depth
    if(key != 16)
    {
        RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\BlueStacks\Guests\Android\FrameBuffer\0, Depth, 16
        change := true
    }
    
    if(change = true)
    {
        msg := txt["REGISTER_CHANGE_MSG"]
        MsgBox, 0, CBot, %msg%
        guiBar(,,"stop")
        livePreview(0)
        Run, %exitPath%
        Sleep 3000
        reload
    }
}
