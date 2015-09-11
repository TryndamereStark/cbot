guiBar(message = "...", msgStatus = "normal", mode = "update")
{
    global
    if(mode = "start")
    {
        placeGuiElement(0, 672, barPosX, barPosY)
        guiWidth := 868
        guiHeight := 48
        Gui Bar: New
        Gui Bar: -Caption -DPIScale +LastFound +ToolWindow +Owner%BlueStacksID%
        Gui Bar: Color, 000000, FFFFFF
        Gui Bar: Margin, 0, 0
        WinSet, Transparent, 255
        Gui Bar: font, s8 cDDDDDD, Verdana
        Gui Bar: Add, Picture, gCBotMain vmainIco x4 y4, data\ico\CBotMin.png
        Gui Bar: Add, Picture, gHideShow vhideShowIco x48 y4, data\ico\hide.png
        Gui Bar: font, s8 cDC56D0, Verdana
        Gui Bar: Add, Text, vinfoLine x92 y2 w684 r1, %TXT_BAR_CONTROLS%
        Gui Bar: font, s8 cDDDDDD, Verdana
        Gui Bar: Add, Text, vliveStatus x92 y16 w684 r2, %message%
        Gui Bar: Add, Picture, vimgName x780 y4, data\ico\%curButton%.png
        Gui Bar: Add, Picture, gWww x824 y4, data\ico\www.png
        Gui Bar: Add, Picture, gExitAll x824 y26, data\ico\exit.png
        Gui Bar: Show, W%guiWidth% H%guiHeight% X%barPosX% Y%barPosY% NA
    }
    else if(mode = "move")
    {
        if(hideGui = 1)
            placeGuiElement(385, 672, barPosX, barPosY)
        else
            placeGuiElement(0, 672, barPosX, barPosY)
        Gui Bar: Show, X%barPosX% Y%barPosY% NA
    }
    else if(mode = "stop")
        Gui Bar: Destroy
    else
    {
        if(msgStatus = "miss")
            logColor := "FFD616"
        else if(msgStatus = "error")
            logColor := "FF4545"
        else if(msgStatus = "warning")
            logColor := "FF7916"
        else if(msgStatus = "success")
            logColor := "64FF45"
        else
            logColor := "DDDDDD"
                
        Gui Bar: Font, s8 c%logColor% Verdana
        GuiControl Bar: Font, liveStatus
        GuiControl Bar: Text, liveStatus, %message%
    }
}
changeModeIco(name)
{
    global curButton
    if(curButton = "f10")
    {
        path := "data\ico\" name ".png"
        GuiControl Bar: , imgName, %path%
    }
    else
        guiBar("Aby w³¹czyæ now¹ funkcjê musisz najpier zatrzymaæ bota klawiszem F10.", "warning")
}