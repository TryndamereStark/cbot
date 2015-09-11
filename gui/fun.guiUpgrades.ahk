guiUpgrades(mode = "start")
{
    global
    if(mode = "start")
    {
        placeGuiElement(868, 0, barPosX, barPosY)
        guiWidth := 150
        guiHeight := 720
        Gui Upgrades: New
        Gui Upgrades: -Caption -DPIScale +LastFound +ToolWindow +Owner%BlueStacksID%
        Gui Upgrades: Color, 000000, FFFFFF
        Gui Upgrades: Margin, 0, 0
        WinSet, Transparent, 255
        Gui Upgrades: font, s7 cDC56D0, Verdana
        butStartY := 20
        Gui Upgrades: Add, Text, x10 y10 w130 r7 cDC56D0, %TXT_UPGRADES_DESCRIPTION1%
        Gui Upgrades: Add, Text, x10 y100 w130 r6 cDC56D0, %TXT_UPGRADES_DESCRIPTION2%
        Gui Upgrades: Add, Text, x10 y180 w130 r5 cDC56D0, %TXT_UPGRADES_DESCRIPTION3%
        Gui Upgrades: Add, Button, gAddUpgrades vaddUpgrades x10 y240 w130 h20, %TXT_START%
        Gui Upgrades: Add, Button, gEndUpgrades x10 y265 w130 h20, %TXT_STOP%
        Gui Upgrades: Add, Button, gAddUpgrades vundoUpgrades x10 y290 w130 h20, %TXT_UNDO%
        Gui Upgrades: Add, Text, x10 y320 w130 r1 cDC56D0 Center, %TXT_SELECTED_ITEMS%:
        Gui Upgrades: Add, ListView, x10 y340 r18 w130 cAAAAAA Background000000 vupgradesList -Hdr, upgrades
        Gui Upgrades: Default
        LV_ModifyCol(1, "90 NoSort")
        upgradeRows := StrSplit(upgrades, ";", " ")
        for index, value in upgradeRows
            LV_Add(, value)
        Gui Upgrades: Add, Button, gClearUpgrades x10 y685 w60 h20, %TXT_CLEAR%
        Gui Upgrades: Add, Button, gSaveUpgrades x80 y685 w60 h20, %TXT_SAVE%
        Gui Upgrades: Show, W%guiWidth% H%guiHeight% X%barPosX% Y%barPosY% NA
        
    }
    else if(mode = "move")
    {
        placeGuiElement(868, 0, barPosX, barPosY)
        Gui Upgrades: Show, X%barPosX% Y%barPosY% NA
    }
    else if(mode = "stop")
        Gui Upgrades: Destroy
}