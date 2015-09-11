guiBuildings(mode = "start")
{
    global
    if(mode = "start")
    {
        placeGuiElement(868, 0, barPosX, barPosY)
        guiWidth := 150
        guiHeight := 720
        Gui Buildings: New
        Gui Buildings: -Caption -DPIScale +LastFound +ToolWindow +Owner%BlueStacksID%
        Gui Buildings: Color, 000000, FFFFFF
        Gui Buildings: Margin, 0, 0
        WinSet, Transparent, 255
        Gui Buildings: font, s7 cDC56D0, Verdana
        butStartY := 20
        Gui Buildings: Add, Text, x10 y10 w130 r5 cDC56D0, %TXT_LOCATION_INFO1%
        Gui Buildings: Add, Text, x10 y75 w130 r2 cDC56D0, %TXT_LOCATION_INFO2%
        Gui Buildings: Add, GroupBox, x10 y105 w130 h223 cDC56D0, %TXT_TROOPS%
        Gui Buildings: Add, Button, gSetCoords vposTH x20 y122 w90 h16, %TXT_TOWN_HALL%
        Gui Buildings: Add, Text,vetposTH x115 y123 w20 h16, % posTH != 0 AND posTH != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposSpellFactory x20 y142 w90 h16, %TXT_SPELL_FACTORY%
        Gui Buildings: Add, Text, vetposSpellFactory x115 y143 w20 h16, % posSpellFactory != 0 AND posSpellFactory != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposDarkSpellFactory x20 y162 w90 h16, %TXT_DARK_SPELL_FACTORY%
        Gui Buildings: Add, Text, vetposDarkSpellFactory x115 y163 w20 h16, % posDarkSpellFactory != 0 AND posDarkSpellFactory != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposKingAltar x20 y182 w90 h16, %TXT_KING_ALTAR%
        Gui Buildings: Add, Text, vetposKingAltar x115 y183 w20 h16, % posKingAltar != 0 AND posKingAltar != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposQueenAltar x20 y202 w90 h16, %TXT_QUEEN_ALTAR%
        Gui Buildings: Add, Text, vetposQueenAltar x115 y203 w20 h16, % posQueenAltar != 0 AND posQueenAltar != "" ? "OK" : "?"
        Gui Buildings: Add, Text, x20 y222 w90 h16, %TXT_BARRACKS%:
        Gui Buildings: Add, Button, gSetCoords vposBarracks1 x20 y242 w30 h16, 1
        Gui Buildings: Add, Text, vetposBarracks1 x55 y243 w20 h16, % posBarracks1 != 0 AND posBarracks1 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposBarracks2 x80 y242 w30 h16, 2
        Gui Buildings: Add, Text, vetposBarracks2 x115 y243 w20 h16, % posBarracks2 != 0 AND posBarracks2 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposBarracks3 x20 y262 w30 h16, 3
        Gui Buildings: Add, Text, vetposBarracks3 x55 y263 w20 h16, % posBarracks3 != 0 AND posBarracks3 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposBarracks4 x80 y262 w30 h16, 4
        Gui Buildings: Add, Text, vetposBarracks4 x115 y263 w20 h16, % posBarracks4 != 0 AND posBarracks4 != "" ? "OK" : "?"
        Gui Buildings: Add, Text, x20 y282 w90 h16, %TXT_DARK_BARRACKS%:
        Gui Buildings: Add, Button, gSetCoords vposDarkBarracks1 x20 y302 w30 h16, 1
        Gui Buildings: Add, Text, vetposDarkBarracks1 x55 y303 w20 h16, % posDarkBarracks1 != 0 AND posDarkBarracks1 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposDarkBarracks2 x80 y302 w30 h16, 2
        Gui Buildings: Add, Text, vetposDarkBarracks2 x115 y303 w20 h16, % posDarkBarracks2 != 0 AND posDarkBarracks2 != "" ? "OK" : "?"
        Gui Buildings: Add, GroupBox, x10 y335 w130 h322 cDC56D0, %TXT_RESOURCES%
        Gui Buildings: Add, Radio, x20 y351 w90 h16 Left vresourcesRadio1 Checked%resourcesRadioYes%, %TXT_AUTO%
        Gui Buildings: Add, Radio, x20 y371 w90 h16 Left vresourcesRadio2 Checked%resourcesRadioNo%, %TXT_MANUAL%:
        Gui Buildings: Add, Text, x20 y394 w90 h16, %TXT_MINES%:
        Gui Buildings: Add, Button, gSetCoords vposGoldMine1 x20 y411 w30 h16, 1
        Gui Buildings: Add, Text, vetposGoldMine1 x55 y412 w20 h16, % posGoldMine1 != 0 AND posGoldMine1 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposGoldMine2 x80 y411 w30 h16, 2
        Gui Buildings: Add, Text, vetposGoldMine2 x115 y412 w20 h16, % posGoldMine2 != 0 AND posGoldMine2 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposGoldMine3 x20 y431 w30 h16, 3
        Gui Buildings: Add, Text, vetposGoldMine3 x55 y432 w20 h16, % posGoldMine3 != 0 AND posGoldMine3 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposGoldMine4 x80 y431 w30 h16, 4
        Gui Buildings: Add, Text, vetposGoldMine4 x115 y432 w20 h16, % posGoldMine4 != 0 AND posGoldMine4 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposGoldMine5 x20 y451 w30 h16, 5
        Gui Buildings: Add, Text, vetposGoldMine5 x55 y452 w20 h16, % posGoldMine5 != 0 AND posGoldMine5 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposGoldMine6 x80 y451 w30 h16, 6
        Gui Buildings: Add, Text, vetposGoldMine6 x115 y452 w20 h16, % posGoldMine6 != 0 AND posGoldMine6 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposGoldMine7 x20 y471 w30 h16, 7
        Gui Buildings: Add, Text, vetposGoldMine7 x55 y472 w20 h16, % posGoldMine7 != 0 AND posGoldMine7 != "" ? "OK" : "?"
        Gui Buildings: Add, Text, x20 y494 w90 h16, %TXT_COLLECTORS%:
        Gui Buildings: Add, Button, gSetCoords vposElixirCollector1 x20 y511 w30 h16, 1
        Gui Buildings: Add, Text, vetposElixirCollector1 x55 y512 w20 h16, % posElixirCollector1 != 0 AND posElixirCollector1 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposElixirCollector2 x80 y511 w30 h16, 2
        Gui Buildings: Add, Text, vetposElixirCollector2 x115 y512 w20 h16, % posElixirCollector2 != 0 AND posElixirCollector2 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposElixirCollector3 x20 y531 w30 h16, 3
        Gui Buildings: Add, Text, vetposElixirCollector3 x55 y532 w20 h16, % posElixirCollector3 != 0 AND posElixirCollector3 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposElixirCollector4 x80 y531 w30 h16, 4
        Gui Buildings: Add, Text, vetposElixirCollector4 x115 y532 w20 h16, % posElixirCollector4 != 0 AND posElixirCollector4 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposElixirCollector5 x20 y551 w30 h16, 5
        Gui Buildings: Add, Text, vetposElixirCollector5 x55 y552 w20 h16, % posElixirCollector5 != 0 AND posElixirCollector5 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposElixirCollector6 x80 y551 w30 h16, 6
        Gui Buildings: Add, Text, vetposElixirCollector6 x115 y552 w20 h16, % posElixirCollector6 != 0 AND posElixirCollector6 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposElixirCollector7 x20 y571 w30 h16, 7
        Gui Buildings: Add, Text, vetposElixirCollector7 x55 y572 w20 h16, % posElixirCollector7 != 0 AND posElixirCollector7 != "" ? "OK" : "?"
        Gui Buildings: Add, Text, x20 y594 w90 h16, %TXT_DRILLS%:
        Gui Buildings: Add, Button, gSetCoords vposDarkElixirDrill1 x20 y611 w30 h16, 1
        Gui Buildings: Add, Text, vetposDarkElixirDrill1 x55 y612 w20 h16, % posDarkElixirDrill1 != 0 AND posDarkElixirDrill1 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposDarkElixirDrill2 x80 y611 w30 h16, 2
        Gui Buildings: Add, Text, vetposDarkElixirDrill2 x115 y612 w20 h16, % posDarkElixirDrill2 != 0 AND posDarkElixirDrill2 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gSetCoords vposDarkElixirDrill3 x20 y631 w30 h16, 3
        Gui Buildings: Add, Text, vetposDarkElixirDrill3 x55 y632 w20 h16, % posDarkElixirDrill3 != 0 AND posDarkElixirDrill3 != "" ? "OK" : "?"
        Gui Buildings: Add, Button, gClearCoords x10 y685 w60 h20, %TXT_CLEAR%
        Gui Buildings: Add, Button, gSaveCoords x80 y685 w60 h20, %TXT_SAVE%
        Gui Buildings: Show, W%guiWidth% H%guiHeight% X%barPosX% Y%barPosY% NA
    }
    else if(mode = "move")
    {
        placeGuiElement(868, 0, barPosX, barPosY)
        Gui Buildings: Show, X%barPosX% Y%barPosY% NA
    }
    else if(mode = "stop")
        Gui Buildings: Destroy
}