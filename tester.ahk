;multiImageSearch(pathSet, coordSet = "", searchSet = "", repeatSet = "", sliceSet = "", clientSet = "")
testerDDS()
{
    ;zoomOut()
    global gameRect
    global imgVariations
    coordSet := gameRect
    pathSet1 := "patterns\th\th10|th9|th7|th8|th6|th5|th4.png"
    pathSet2 := "patterns\resources\emptyGold8|emptyGold9|emptyGold10|emptyGold11.png"
    pathSet3 := "patterns\resources\emptyGold11|emptyGold10|emptyGold9|emptyGold8.png"
    pathSet4 := "patterns\defences\ad5.png"
    pathSet5 := "patterns\resources\collect.png"
    pathSet6 := "patterns\troops\barbarian.png"
  
    ;#######################################################################################
    ;testImg := multiImageSearch("patterns\interface\rearm.png", "120,620,750,627||center", imgVariations[1], "10|100", "horizontal")
    testImg := multiImageSearch("patterns\interface\anotherDevice|takeBreak.png", "160,250,710,425", imgVariations[6], , "horizontal")
    ;#######################################################################################
    if(testImg["hits"] > 0)
    {
        guiBar("Znaleziono: " testImg["name"] " | Iloœæ: " testImg["hits"] " | Wspó³rzêdne: " testImg["coords"], "success")
        myMove(testImg["coords"])
    }
    else if(testImg["hits"] = 0)
        guiBar("Nic nie znaleziono", "warning")
    else
        guiBar("Wyst¹pi³ b³ad! Nr b³êdu: " testImg["hits"], "warning")
}
testervshavsnvhjvyusbkabdsnm()
{
    ;zoomOut()
  
    ;#######################################################################################
    testPix := multiPixelSearch(0xff2b84c0, "230,30", pixVariations, repeatSet)
    ;#######################################################################################
    if(testPix["hit"] = true)
    {
        coords := StrSplit(testPix["coords"], ";")
        guiBar("Rozpoczeto zbieranie surowców.")
        for index, value in coords
        {
            myMove(value)
        }
        guiBar("Znaleziono: " testPix["color"] " | Iloœæ: " testPix["hits"] " | Wspó³rzêdne: " testPix["coords"], "success")
    }
    else
        guiBar("Nic nie znaleziono", "warning")
}
tester2()
{
    global gameRect
    pathSet1 := "patterns\th\th10|th9|th8|th7|th6|th5|th4.png"
  
    testImg := multiImageSearch(pathSet1, gameRect "|center+-1+rightBottom", "30", "100|0","vertical")
    ;standardImg()
     
}
;###################################################################################################################################################################
testesadsadasd()
{
    global pixVariations
    ;#######################################################################################
    testPix := multiPixelSearch(0xff5096e0, "0,582,868,582", pixVariations)
    ;#######################################################################################
    if(testPix["hit"] = true)
    {
        result := "Znaleziono: " testPix["color"] " | Iloœæ: " testPix["hits"] " | Wspó³rzêdne: " testPix["coords"], "success"
        myMove(testPix["coords"])
    }
    else
        result := "Nic nie znaleziono", "warning"
        return result
}
tester()
{
    global imgVariations
    ;#######################################################################################
    ;testImg := multiImageSearch("patterns\test.png", gameRect, 40, ,"vertical", "oflineScreen.ahk")
    ;testImg := multiImageSearch("patterns\resources\emptyElixir6|emptyElixir7|emptyElixir8|emptyElixir9|emptyElixir10|emptyElixir11.png", gameRect, imgVariations[14], ,"vertical")
    ;testImg := multiImageSearch("patterns\resources\emptyDark\12a|12b|12c|12d|12e|12f|12g|3456a|3456b|3456c|3456d|3456e|3456f|3456g|3456h|3456i|3456i.png", "50,30,818,545", 45) ;"50,30,818,545"
    ;testImg := multiImageSearch("data\patterns\resources\drill\6|5|4|3|2|1.png", "||center", 50,, "horizontal")
    ;testImg := multiImageSearch("data\patterns\defences\ad\8|7|6|5|4|3|2.png", "||center", 35,, "horizontal")
    ;testImg := multiImageSearch("data\patterns\resources\collector\12a|12b|12c|12d|12e|12f|12g|11a|11b|11c|11d|11e|11f|10a|10b|10c|10d|10e|10f|9a|9b|9c|9d|8a|8b|8c|8d.png", "70,20,800,570", 10)
    testImg := multiImageSearch("patterns\troops\kingAbility.png", "0,563,868,566", 35, "10|100", "horizontal")
    ;testImg := multiImageSearch("patterns\resources\emptyGold8|emptyGold9|emptyGold10|emptyGold11.png", gameRect, 35, ,"vertical", "oflineScreen.ahk")
    ;testImg := multiImageSearch("patterns\resources\emptyGold8|emptyGold9|emptyGold10|emptyGold11.png", gameRect, 35, ,"vertical")
    ;#######################################################################################
    if(testImg["hits"] > 0)
    {
        result := "Znaleziono: " testImg["name"] " | Iloœæ: " testImg["hits"] " | Wspó³rzêdne: " testImg["coords"]
        myMove(testImg["coords"])
    }
    else if(testImg["hits"] = 0)
        result := "Nic nie znaleziono |" imgVariations[18], "warning"
    else
        result := "Wyst¹pi³ b³ad! Nr b³êdu: " testImg["hits"], "warning"
    return result
}
;###################################################################################################################################################################
standardImg()
{
    Loop 100
    {
        guiBar(A_Index)
        i := 10
        Loop
        {
        if (i<4)
            break
        ImageSearch, OutputVarX, OutputVarY, 0, 0, 868, 720, *30 patterns\th\th%i%.png
        if(if ErrorLevel != 1)
            break
        i--
        }
    }
}
testerASDFWE()
{
    global scroolTroops
    scroolTroops := true
    
    troopsList := "barbarian,archer,giant,goblin,wallBreaker,baloon,wizard,healer,dragon,pekka,minion,hogRider,valkyrie,golem,witch,lavaHund,king,kingAbility,queen,queenAbility,castle,lightning,healing,rage,jump,freeze"
    
    testTroop := StrSplit(troopsList , ",", " ")
    
    for index, value in testTroop
    {
        findTroop(value)
        Sleep 1000
    }  
}
testerFFF()
{
    global gameRect
    Loop
    {
        ;#######################################################################################
        testImg := multiImageSearch("patterns\interface\xBig.png", "800,0,868,70||center", A_Index, , "vertical")
        ;#######################################################################################
        if(testImg["hits"] > 0)
        {
            guiBar("Znaleziono, variations: " A_Index, "success")
            kordy := testImg["coords"]
            myMove(kordy)
            Sleep 2000
            j := 100
            Loop
            {
                ;#######################################################################################
                testImg := multiImageSearch("patterns\interface\xBig.png", "800,0,868,70||center", j, , "vertical")
                ;#######################################################################################
                if(testImg["hits"] > 0 AND testImg["coords"] = kordy)
                {
                    guiBar("Znaleziono, variations: " j, "success")
                    myMove(testImg["coords"])
                    break
                }
                else if(testImg["hits"] = 0 OR testImg["coords"] != kordy OR j <= 0)
                {
                    guiBar("Nic nie znaleziono, variations: " j, "warning")
                    myMove(testImg["coords"])
                }
                else
                {
                    guiBar("Wyst¹pi³ b³ad! Nr b³êdu: " testImg["hits"], "error")
                    pause
                }  
                j--
            }
            break
        }
        else if(testImg["hits"] = 0)
        {
            guiBar("Nic nie znaleziono, variations: " A_Index, "warning")
        }
        else
        {
            guiBar("Wyst¹pi³ b³ad! Nr b³êdu: " testImg["hits"], "error")
            pause
        }
    }
}
testersasdsadsdasdsds()
{
    global imgVariations
    ;#######################################################################################
    testImg := multiImageSearch("patterns\troops\lightning.png", coordSet, imgVariations[5], , "horizontal")
    ;#######################################################################################
    if(testImg["hits"] > 0)
    {
        guiBar("Znaleziono, variations: " A_Index, "success")
    }
    else if(testImg["hits"] = 0)
    {
        guiBar("Nic nie znaleziono, variations: " A_Index, "warning")
    }
    else
    {
        guiBar("Wyst¹pi³ b³ad! Nr b³êdu: " testImg["hits"], "error")
        pause
    }
}
testerZZZ()
{
    Loop 1
    {
        ;#######################################################################################
        ImageSearch, OutputVarX, OutputVarY, 0, 0, 868, 720, *30 patterns\test.png
        ;#######################################################################################
        if(ErrorLevel != 1 AND ErrorLevel != 2)
        {
            guiBar(A_Index, "success")
        }
        else if(ErrorLevel = 1)
        {
            guiBar(A_Index ": Nic nie znaleziono", "warning")
        }
        else if(ErrorLevel = 2)
        {
            guiBar(A_Index ": Wyst¹pi³ b³ad!")
            pause
        }
    }
}
testerJJ()
{
    Loop 1
    {
        guibar(A_Index)
        ;searchPixel()
        ;multiPixelSearch(0xff70b0d8, "0,570,868,570", 0, 50)
        multiImageSearch("patterns\th\th10.png", gameRect, 35, "1000|0","vertical")
        ;findLoot("gold")
    }
}
testerjsdgkjfsajkkagjksg()
{
    liczba := readNumber(443, 366, "L", "right") ; czarny eliksir zdobyty
    ;liczba := readNumber(443, 327, "L", "right") ; eliksir zdobyty
    ;liczba := readNumber(443, 288, "L", "right") ; zloto zdobyte
    ;liczba := readNumber(810, 125, "S", "right") ; czarny eliksir
    ;liczba := readNumber(809, 75, "S", "right") ; eliksir
    ;liczba := readNumber(807, 24, "S", "right") ; zloto
    guiBar("Liczba wynosi: " liczba)
}
getPxColor()
{
    result := []
    ;MouseGetPos, x, y
    x := 45
    y := 570
    myMove(x "," y)
    result["coords"] := x "," y
    global wShiftX
    global wShifty
    pToken := Gdip_Startup()
    WinGet, hwnd, , BlueStacks App Player
    windowArea := Gdip_BitmapFromHWND(hwnd)
    gameArea := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, 868, 672)
    SetFormat, IntegerFast, hex
    fARGB := Gdip_GetPixel(gameArea, x, y)
    result["color"] := fARGB
    SetFormat, IntegerFast, d
    
    Gdip_DisposeImage(windowArea)
    Gdip_DisposeImage(gameArea)
    Gdip_ShutDown(pToken)
    return result
}
searchPixel()
{
    global wShiftX
    global wShifty
    pToken := Gdip_Startup()
    WinGet, hwnd, , BlueStacks App Player
    windowArea := Gdip_BitmapFromHWND(hwnd)
    gameArea := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, 868, 672)
    Gdip_DisposeImage(windowArea)
    
    result := Gdip_PixelSearch(gameArea, outX, outY, "0,570,868,570", 0xff70b0d8, 0)
    
    Gdip_DisposeImage(gameArea)
    Gdip_ShutDown(pToken)
    return result
}
testerUHAHAHA()
{
    ;hit := compare("patterns\test.png", cells[1,1], 0, 3, percentage)
    ;autoAdds()
    ; percentage := readNumber(0, 508, "XL", "center")
    ; guiBar("percentage: " percentage)
    ; autobookmarksAdds()
    ;guiUpgrades()
    
    ; guiBar("...")
    ; cells := cells()
    ; cir := circles(cells, 20, 20, 10)
    ; ls := lightning("mortar", cellX, cellY)
    ; if(ls = 0)
        ; guiBar("Nic nie znaleziono.")
    ; else
    ; {
        ; guiBar("Znaleziono!")
        ; MsgBox % ls "`n" trim(cellX, ",")
        ; hits := StrSplit(cellX , ",", " ")
        ; for index, value in hits{
            ; myMove(cir[value])
            ; sleep 2000
        ; }
    ; }
    
    pToken := Gdip_Startup()
    getPixelsFromScreen("0,0", 3, 1)
    DeleteObject(hBMoCopy)
    Gdip_Shutdown(pToken)
    
    ; KeyWait, LButton, D
    ; MouseGetPos, PosX, PosY
    ; guiBar(PosX "," PosY)
}
autobookmarksAdds()
{
    Loop
    {
        bookmarksFull = false
        showChat()
        Loop
        {
            if(bookmarksFull = true)
                break
            filterClans(phrase, A_Index)
            bookmarksFull := addBookmarks()
        }
        sendBokmarksAdds()
    }
}
sendBokmarksAdds()
{
    Loop
    {
        msg := ">>>>> visit runcbot.com - free clash of clans bot - keeps you online, trains your troops, searches villages, makes autoatacks"
        
        if(A_Index != 1)
        {
            myClick("295,55") ; clan info
            Sleep 1000
        }
        myClick("705,50") ; bookmarks
        bookmark := multiPixelSearch(0xffe8d12f, "817,97", 20, "30|100")
        noBookmarks := multiPixelSearch(0xfff8af90, "132,188", 20)
        if(noBookmarks["hit"] = true)
            break
        myClick("410,105") ; click single bookmark
        ribbon := multiPixelSearch(0xff80cdf8, "815,138", 20, "50|100")
        myClick("825,110") ; remove bookmark
        Sleep 1000
        myClick("780,310") ; join
        Sleep 1000
        alreadyInClan := multiPixelSearch(0xffff1919, "331,198", 20)
        if(alreadyInClan["hit"] = true)
        {
            leaveClan()
            continue
        }
        inviteRequest := multiPixelSearch(0xffcc4314, "390,245", 20, "20|100")
        if(inviteRequest["hit"] = true)
        {
            myClick("440,150") ; focus
            ControlSend, ahk_parent, %msg%, BlueStacks App Player
            Sleep 500
            myClick("530,230") ; send
            Sleep 1000
        }
        else
        {
            addsCbot()
            myClick("295,55") ; clan info
            Sleep 1000
            myClick("780,305") ; leave clan
            Sleep 1000
            myClick("520,400") ; leave confirm
            Sleep 1000
            myClick("295,55") ; clan info
            Sleep 1000
        }
    }
    myClick("840,40") ; close clans menu
}
leaveClan()
{
    myClick("840,40") ; close clans menu
    Sleep 1000
    myClick("295,55") ; clan info
    Sleep 1000
    myClick("780,305") ; leave clan
    Sleep 1000
    myClick("520,400") ; leave confirm
    Sleep 1000
    noClan := multiPixelSearch(0xfff06c50, "170,330", 20, "20|100")
    if(noClan["hit"] = false)
    {
        restartGame()
        showChat()
    }
    if(noClan["hit"] = true)
    {
        myClick("295,55") ; clan info
        Sleep 1000
    }
}
addBookmarks()
{
    y := 275
    Loop 7
    {
        clansList := multiPixelSearch(0xff68b010, "550,125", 20, "20|100")
        if(clansList["hit"] = true)
            myClick("410," y)
        bookmarkOn := multiPixelSearch(0xff74ccf0, "813,110", 20, "20|100")
        if(bookmarkOn["hit"] = false)
        {
            myClick("50,50")
            Sleep 500
            return true
        }
        else
            myClick("825,95")
        backVisible := multiPixelSearch(0xff50c50d, "25,55", 20, "20|100")
        if(backVisible["hit"] = true)
            myClick("50,50")
        y += 55
    }
    return false
}
filterClans(phrase, i)
{  
    Loop
    {
        err := false
        Random, lvl, 1, 5
        Random, membersMin, 25, 35
        Random, membersMax, 40, 47
       
        x := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
        
        if(i = 1)
        {
            myClick("295,55") ; clan info
            Sleep 1000
            myClick("780,215") ; show advanced
            Sleep 500
            myClick("420,370",,, membersMin-1) ; set min members
            myClick("525,370",,, 50-membersMax) ; set max members
            myClick("435,495",,, lvl-1) ; set clan level
            Sleep 1000
            myClick("820,215") ; close advanced
            Sleep 1000
        }
        Loop
        {
            myClick("250,115") ; hover
            Sleep 500
            Random, a, 1, 26
            Random, b, 1, 26
            ;Random, c, 1, 26
            phrase := x[a] x[b] ;x[c]
            ControlSend, ahk_parent, %phrase%, BlueStacks App Player
            Sleep 1000
            myClick("590,115") ; search clans button
            Sleep 500
            sevenClans := multiPixelSearch(0xffe8ce2c, "818,597", 20, "20|100")
            if(sevenClans["hit"] = true)
                break
            inClan := multiPixelSearch(0xffeb0810, "843,567", 20)
            if(inClan["hit"] = true)
            {
                myClick("295,55") ; clan info
                Sleep 1000
                myClick("780,305") ; leave clan
                Sleep 1000
                myClick("520,400") ; leave confirm
                Sleep 1000
                err := true
                break
            }    
        }
        if(err = false)
            break
    }
}
removeBookmarks()
{
    Loop
    {
        myClick("430,105") ; first bookmark
        Sleep 500
        myClick("825,115") ; remove bookmark
        Sleep 1000
        myClick("50,50") ; back
        Sleep 500
    }
}
autoAdds()
{
    showChat()
    Loop
    {
        myClick("295,55") ; clan info
        Sleep 500
        myClick("275,440") ; pierwszy klan
        Sleep 1000
        myClick("780,305") ; join clan
        Sleep 2000
        addsCbot()
        myClick("295,55") ; clan info
        Sleep 1000
        myClick("780,305") ; leave clan
        Sleep 1000
        myClick("520,400") ; leave confirm
        Sleep 1000
    }
}
addsCbot(messages = ">>> runcbot.com - completly free clash of clans bot - gain over 20 milions a day!;>>> keeps you online, trains your troops, searches villages, makes autoatacks;>>> runcbot.com - free autofarming 24/7")
{
    messages := StrSplit(messages, ";", " ")
    
    for index, message in messages
    {
        myClick("30,95") ; focus text field
        Sleep 500
        ControlSend, ahk_parent, %message%, BlueStacks App Player
        Sleep 500
        myClick("285,95") ; wyslij
        Sleep 1000
    }
}
showChat()
{
    myClick("20,350") ; chat
    Sleep 500
    myClick("225,20") ; zak³adka clan chat
    Sleep 500
    noClan := multiPixelSearch(0xfff06c50, "170,330", 20, "20|100")
    if(noClan["hit"] = false)
        leaveClan()
}
restartGame()
{   
    myClick("45,695")
    Sleep 1000
    myClick("515,400")
    backToGame2()
    return true
}
backToGame2()
{
    global imgVariations
    clashIco := multiImageSearch("patterns\interface\clashIco.png", "||center", imgVariations[9], "20|500", "horizontal")
    if(clashIco["hits"] > 0)
        myClick(clashIco["coords"])
    Else
    {
        myClick("75,145")
        Sleep 1000
        myClick("260,50")
        Sleep 500
        ControlSend, ahk_parent, clash of clans, BlueStacks App Player
        Sleep 500
        myClick("85,150")
    }
    recognizeScreen("main", , true)
}
testerasdjkbdkjabdhjavsjvdhj()
{
    if(result = true)
        MsgBox Ok
    else
        MsgBox Nie ok
}
testerhujasad()
{
    sendBokmarksAdds()
}