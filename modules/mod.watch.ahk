;funkcja zbiera zasoby z kopalni oraz (docelowo) prze³adowywuje pu³apki
watch(mode = "normal", repeat = 1)
{
    global activeModule
    global adds
    global addsMsg
    global txt
    global upgradesOn
    global lsCount
    global troopsOn
    global lsOn
    global request
    global waitForSpells
    global waitForKing
    global waitForQueen
    global pixVariations
    global imgVariations
    
    activateBS()
    
    if(mode = "normal")
        activeModule("watch")
    else if(mode = "autofarming" OR mode = "limited")
        activeModule("autofarming_watch")
    
    writeLog(txt["WATCH_ON"] " (" mode ")")
	
	Loop
	{
        mainScreen := recognizeScreen("main", "few")
        if(mainScreen = false)
            checkAll()
        zoomOut()
        myClick("230, 70", 100) ; obszar neutralny
         
		if(mode = "limited" AND A_Index > repeat) 
            break
		
		if(mode = "autofarming")
		{    
            myClick("40,525")
            armyOverview := multiPixelSearch(0xffb522c6, "150,556", pixVariations, "20|100")
            if(armyOverview["hit"] = true)
            {
                troopsReady := true
                spellsReady := true
                castleReady := true
                kingReady := true
                queenReady := true
                
                if(troopsOn = 1)
                    troopsReady := checkUnits("troops")
                if(waitForSpells = 1)
                    spellsReady := checkUnits("spells")
                if(waitForKing = 1)
                    kingReady := checkUnits("king")
                if(waitForQueen = 1)
                    queenReady := checkUnits("queen")
                    
                castleReady := checkUnits("castle")
                
                lsVisable := multiPixelSearch(0xff0b41e8, "173,460", pixVariations)
                if(lsVisable["hit"] = true)
                {
                    lsCounter := multiImageSearch("data\patterns\numbers\x1|x2|x3|x4|x5.png", "165,415,187,430", imgVariations[12])
                    if(lsCounter["hits"] > 0)
                        lsCount := SubStr(lsCounter["name"], 2)
                    else
                        lsCount := 0
                }
                
                if(request = 1)
                    requestTroops(1)
                myClick("735,115")
                Sleep 1000
            }
            ; guiBar("troopsReady: " troopsReady " | spellsReady: " spellsReady " | kingReady: " kingReady " | queenReady: " queenReady)
            ; pause
            if(troopsReady = true AND spellsReady = true AND kingReady = true AND queenReady = true)
            {
                writeLog(txt["ARMY_READY"], "success", true)
                break
            }
            else
                writeLog(txt["ARMY_NOT_READY"], "miss")
		}
        else
        {
            if(request = 1 AND A_Index = 1)
                requestTroops()
        }

        reloadAll()
        if(upgradesOn = 1 AND A_Index = 1)
            upgrades()
        if(adds = 1)
        {
            writeLog(txt["ANNOUNCEMENTS_START"])
            adds(addsMsg)
            zoomOut()
            myClick("230, 70", 100)
        }
        
		myClick("80,305") ; klikniecie koszarow aby nie rozlaczylo gry
        if(mode = "normal")
            writeLog(txt["VILLAGE_OK"])
        if(mode = "limited")
            writeLog(txt["GOLD_FOR_SEARCHING"])
        Sleep 10000
	}
}
checkUnits(name)
{
    global waitForKing
    global waitForQueen
    global posKingAltar
    global posQueenAltar
    global imgVariations
    global pixVariations
    
    if(name = "troops")
    {
        result := multiPixelSearch(0xff92c232, "150,144", pixVariations)
        if(result["hit"] = true)
            return true
    }
    else if(name = "castle")
    {
        result := multiPixelSearch(0xff92c232, "150,266", pixVariations)
        if(result["hit"] = true)
            return true
    }
    else if(name = "spells")
    {
        result := multiPixelSearch(0xff92c232, "150,392", pixVariations)
        if(result["hit"] = true)
            return true
    }
    else if(name = "king")
    {
        result := multiPixelSearch(0xff91c030, "455,392", pixVariations)
        if(result["hit"] = true)
            return true
        result := multiPixelSearch(0xffc74048, "505,485", pixVariations)
        if(result["hit"] = true)
            return true
        return false
    }
    else if(name = "queen")
    {
        result := multiPixelSearch(0xff91c030, "455,392", pixVariations)
        if(result["hit"] = true)
            return true
        result := multiPixelSearch(0xff602ce0, "487,435", pixVariations)
        if(result["hit"] = true)
            return true
        result := multiPixelSearch(0xff602ce0, "550,435", pixVariations)
        if(result["hit"] = true)
            return true
        return false
    }
    return false
}
requestTroops(overview = 0)
{
    global pixVariations
    global requestText
    
    if(overview = 0)
    {
        myClick("40,525")
        armyOverview := multiPixelSearch(0xffb522c6, "150,556", pixVariations, "20|100")
    }
    
    if(overview = 1 OR armyOverview["hit"] = true)
    {
        requestButton := multiPixelSearch(0xff83c420, "643,343", pixVariations)
        if(requestButton["hit"] = true)
        {
            myClick("675,330")
            requestForm := multiPixelSearch(0xffcc4314, "390,245", pixVariations, "20|100")
            if(requestForm["hit"] = true)
            {
                Sleep 500
                myClick("434,150")
                Sleep 500
                ControlSend, ahk_parent, >>> %requestText%, BlueStacks App Player
                Sleep 1000
                myClick("530,230") ; wyslij
                Sleep 1000
            }
        }
        requestClosed := multiPixelSearch(0xff5f5450, "434,130", pixVariations, "20|100")
    }
    
    if(overview = 0)
    {
        myClick("735,115")
        Sleep 1000
    }
}