zoomOut()
{  
    global pixVariations
    Loop
    {
        blackPix := multiPixelSearch(0xff000000, "0,0", pixVariations)
        if(blackPix["hit"] = true)
        {
            if(A_Index > 1)
            myClick("230, 70")
            break
        }
        else
        {
            ControlSend, ahk_parent, ^-, BlueStacks App Player
            Sleep 1000
        }
    }
}