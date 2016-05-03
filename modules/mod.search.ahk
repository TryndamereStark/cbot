search(mode = "normal")
{
    global gameRect
    global pixVariations
    global imgVariations
    global searchCount
    global targetID
    global weakTH
    global maxTH
    global txt
    global enemyTH
    global deadBases
    global deadGold
    global deadElixir
    global deadDark
    global deadTrophies
    global usualBases
    global usualGold
    global usualElixir
    global usualDark
    global usualTrophies
    global searchType
    global freezeMsg
    global freezeCounter
    global thOutside
    global attackType
    global thCoords
    global nextDelay
    
    if(searchType = "all")
        typeDisplay := txt["SEARCH_ALL"]
    else if(searchType = "any")
        typeDisplay := txt["SEARCH_ANY"]
    else
        typeDisplay := txt["SEARCH_SUM"]
    
    if(mode = "normal")
        activeModule("search")
    else if(mode = "autofarming")
        activeModule("autofarming_search")
	
    SEARCH_START:
	searchStart()
    deadMessage := ""
    if(deadBases = 1)
    {
        if(deadGold > 0)
            deadMessage := deadMessage txt["GOLD"] "=" deadGold ", "
        if(deadElixir > 0)
            deadMessage := deadMessage txt["ELIXIR"] "=" deadElixir ", "
        if(deadDark > 0)
            deadMessage := deadMessage txt["DARK"] "=" deadDark ", "
        if(deadTrophies > 0)
            deadMessage := deadMessage txt["TROPHIES"] "=" deadTrophies
        deadMessage := trim(deadMessage, ", ")
        deadMessage := txt["DEAD_BASES"] ": " deadMessage " | "
    }
    
    usualMessage := ""
    if(usualBases = 1)
    {
        if(usualGold > 0)
            usualMessage := usualMessage txt["GOLD"] "=" usualGold ", "
        if(usualElixir > 0)
            usualMessage := usualMessage txt["ELIXIR"] "=" usualElixir ", "
        if(usualDark > 0)
            usualMessage := usualMessage txt["DARK"] "=" usualDark ", "
        if(usualTrophies > 0)
            usualMessage := usualMessage txt["TROPHIES"] "=" usualTrophies
        usualMessage := trim(usualMessage, ", ")
        usualMessage := txt["USUAL_BASES"] ": " usualMessage " | "
    }
    
    writeLog(txt["SEARCH_START"] " (" mode ") | " deadMessage usualMessage txt["SEARCH_TYPE"] ": " typeDisplay,, true)

	i := 1
	Loop
	{
        searchCount++
        finish := true ; zainicjowanie zmiennej do ktorej jest przypisywana funkcja found()
        forced := false ; zainicjowanie zmiennej obs³uguj¹cej b³¹d przycisku next gdy aktywny jest modul search
        
        enemyLoaded := multiPixelSearch(0xffdc58d0, "35,110", pixVariations, "60|500") ; sprawdzenie czy wioska sie zaladowala
        
        if(deadBases = 1 OR usualBases = 1)
        {
            match := match()
            message := ""
            if(match["gold"] > 0)
                message := message txt["GOLD"] ": " match["gold"] ", "
            if(match["elixir"] > 0)
                message := message txt["ELIXIR"] ": " match["elixir"] ", "
            if(match["dark"] > 0)
                message := message txt["DARK"] ": " match["dark"] ", "
            if(match["trophies"] > 0)
                message := message txt["TROPHIES"] ": " match["trophies"] ", "
            if(match["total"] > 0 AND ((match["gold"] * match["elixir"]) > 0 OR (match["gold"] * match["dark"]) > 0 OR (match["dark"] * match["elixir"]) > 0))
                message := message txt["SUM"] ": " match["total"] ", "
            if(match["enemyTH"] > 0)
                message := message txt["ENEMY_TH"] ": " match["enemyTH"] ", "
            if(match["deadBase"] > 0)
                message := message txt["DEAD_BASE"] ": " match["deadBase"]
            message := trim(message, ", ")
            
            if(freezeMsg != message)
            {
                freezeMsg := message
                freezeCounter := 0
            }
            else
                freezeCounter++
                
            if(freezeCounter > 5)
                Reload
        }
                
        if((deadBases = 1 OR usualBases = 1) AND match["hit"] = 1)
        {
            attackType := "normal"
            targetID := A_Now
            writeCsv("found", targetID ";" match["gold"] ";"  match["elixir"] ";" match["dark"] ";" match["enemyTH"] ";" match["deadBase"] ";" searchCount ";no")
            finish := found(mode, message)
            if(finish = true)
                break
        }
        else if(thOutside = 1 AND checkTHOutside())
        {
            attackType := "thOnly"
            message := txt["TH_ONLY_FOUND"]
            finish := found(mode, message)
            if(finish = true)
                break
        }
        
        FORCED_MATCH:
        if(forced = true)
        {
            forced := false
            targetID := A_Now
            writeCsv("found", targetID ";" match["gold"] ";" match["elixir"] ";" match["dark"] ";" match["enemyTH"] ";" match["deadBase"] ";" searchCount ";yes")
            finish := found(mode, message, true)
            if(finish = true)
                break
        }
        
        if(finish = true AND (deadBases = 1 OR usualBases = 1))
            logMessage := txt["NOT_MATCH"] " " message ", " txt["SEARCHES"] ": " searchCount ; zmienna finish moze przybrac forme false tylko w module search
        else if(finish = true AND thOutside = 1)
            logMessage := txt["TH_ONLY_MISS"] ", " txt["SEARCHES"] ": " searchCount
        else  
            logMessage := txt["SKIPPED_BY_USER"] " " message
        writeLog(logMessage, "miss")
		
		checkFreeze(amount)
        allOk := checkAll()
        if(allOk = false)
            Goto SEARCH_START
            
        nextButton := multiImageSearch("data\patterns\interface\next.png", "738,509|5", imgVariations[2], "10|500", "vertical") ; sprawdzenie czy jest widoczny przycisk next
        if(nextButton["hits"] < 1 AND activeModule = "autofarming")
            break
        else if(nextButton["hits"] < 1)
        {
            forced := true
            Goto FORCED_MATCH
        }  
        Sleep nextDelay * 1000
		myClick("740,492", 100) ; klikniecie next
        Sleep 1000 ; czas na zasloniecie biezacego widoku oblokami
        noGold := checkNoGold("after")
        if(noGold = true)
            Goto SEARCH_START
        i++
	}
}
searchStart()
{  
    global txt
    
    Loop
    {
        activateBS()
        zoomOut()
        global imgVariations

        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["ATTACK_MENU_ERR"]) 
                break
            }
            myClick("60,610") ; klikniêcie attack
            atackMenu := multiPixelSearch("0xfff88288", "816,19", pixVariations, "10|100")
            if(atackMenu["hit"] = true)
                break
        }
        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["FIND_MARCH_BUTTON_ERR"]) 
                break
            }
            myClick("230,510") ; klikniecie Find a Match
            Loop
            {
                firstEnemy := multiPixelSearch("0xffee5058", "25,508", pixVariations)
                probShield := multiPixelSearch("0xfff0bb68", "292,380", pixVariations)
                probNoGold := multiPixelSearch("0xffd0ec78", "373,373", pixVariations)
                if(firstEnemy["hit"] = true OR probShield["hit"] = true OR probNoGold["hit"] = true OR A_Index > 10)
                {
                    findMatchClicked := true
                    break
                }
                else
                    findMatchClicked := false
                Sleep 100
            }
            if(findMatchClicked = true)
                break
        }

        shield := multiImageSearch("data\patterns\interface\shield.png", "491,385|5|center", imgVariations[16], "5|100", "vertical") ; sprawdza czy nie trzeba wy³aczyæ tarczy
        if(shield["hits"] > 0)
        {
            Loop
            {
                if(A_Index > 5)
                {
                    writeLog(txt["SHIELD_CHECK_ERR"])  
                    break
                }
                myClick(shield["coords"]) ; wy³¹czenie tarczy
                Loop
                {
                    firstEnemy := multiPixelSearch("0xffee5058", "25,508", pixVariations)
                    probNoGold := multiPixelSearch("0xffd0ec78", "373,373", pixVariations)
                    if(firstEnemy["hit"] = true OR probNoGold["hit"] = true OR A_Index > 10)
                    {
                        removeShieldClicked := true
                        break
                    }
                    else
                        removeShieldClicked := false
                    Sleep 100
                }
                if(removeShieldClicked = true)
                    break
            }
            writeLog(txt["SHILD_OFF"], "warning")
        }
        noGold := checkNoGold()
        if(noGold = false)
            break
    }
}
found(mode, message, forced = false)
{
    global foundSong
    global searchCount
    global txt
    global account
    global pushFound
    
    FileCreateDir, log\screenshots_found
    
    if(forced = false)
    {
        userMessage := txt["ENEMY_FOUND"] " " txt["IS_IT_OK"]
        logMessage := txt["ENEMY_FOUND"] " " message ", " txt["SEARCHES"] ": " searchCount
        msgStatus := "success"
        if(pushFound = 1 AND account = "PRO")
            push(uri_encode(txt["ENEMY_FOUND"]), uri_encode(message))
    }
    else
    {
        userMessage := txt["ERROR"] " " txt["NEXT_BUTTON_ERR"] " " txt["FIGHT_START_QUERY"]
        logMessage := txt["ERROR"] " " txt["NEXT_BUTTON_ERR"] " " txt["DECISION"]
        msgStatus := "warning"
        if(pushFound = 1 AND account = "PRO")
            push(uri_encode(txt["PUSH_SEARCHING_ERR"]), uri_encode(txt["PUSH_DECISION_ERR"]))
    }
    
    writeLog(logMessage, msgStatus, true)
    
    if(forced = true)
        outTitle := "forced"
    takeScreenshot("log\screenshots_found", outTitle)
    
    searchCount := 0 ; wyzerowanie licznika wyszukiwañ
    
    SoundPlay, sound/found.wav , wait
    if(mode = "normal")
    {
        WinActivate BlueStacks App Player
        if(foundSong = 1)
        {
            SoundPlay, sound/foundN.mp3
            MsgBox, 4, CBot, %userMessage%, 120
            SoundPlay none.mp3
            IfMsgBox No
                return false
            Else
                return true
        }
        else
        {
            Secs := 120
            SetTimer, BEEP, 300
            MsgBox, 4, CBot, %userMessage%, 120
            SetTimer, BEEP, Off
            IfMsgBox No
                return false
            Else
                return true

            BEEP:
            SoundBeep, 500, 200
            Return
        }
    }
    else
    {
        SoundPlay, sound/foundAF.wav , wait
        return true
    }
}
checkNoGold(mode = "before")
{
    global imgVariations
    global txt
    
    if(mode = "before")
        repeatSet := "5|100"
    else
        repeatSet := ""
    noGold := multiImageSearch("data\patterns\interface\noGold.png", "451,373|5|center", imgVariations[17], repeatSet, "vertical") ; sprawdza czy nie ma komunikatu o braku zlota
    if(noGold["hits"] > 0)
    {
        writeLog(txt["NO_GOLD"], "warning")
        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["NO_GOLD_MSG_ERR"]) 
                break
            }
            myClick("590,250", 200) ; zamkniecie komunikatu
            Loop 10
            {
                probNoGold := multiPixelSearch("0xffd0ec78", "373,373", pixVariations)
                if(probNoGold["hit"] = false)
                    break
                Sleep 100
            }
            if(probNoGold["hit"] = false)
                break
        }
        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["RETURN_ERR"]) 
                break
            }
            if(mode = "before")
            {
                myClick("830,30", 200) ; zamkniêcie okna ataku
                Loop 10
                {
                    atackMenu := multiPixelSearch("0xfff88288", "816,19", pixVariations)
                    if(atackMenu["hit"] = false)
                        break
                    Sleep 100
                }
                if(atackMenu["hit"] = false)
                    break
            }
            else
            {
                myClick("70,530", 200) ; klikniêcie end batle
                Loop 10
                {
                    firstEnemy := multiPixelSearch("0xffee5058", "25,508", pixVariations)
                    if(firstEnemy["hit"] = false)
                        break
                    Sleep 100
                }
                if(firstEnemy["hit"] = false)
                    break
            }
        }
        mainScreen := recognizeScreen("main", , true)
        if(mainScreen = false)
            checkAll()
        watch("limited", 30)
        return true
    }
    else
        return false
}
match()
{
    global weakTH
    global maxTH
    global myTH
    global txt
    global imgVariations
    
    amount := getAmount()
    amount["deadBase"] := txt["NO"]
    
    thInfo := multiImageSearch("data\patterns\th\th10|th9|th7|th8|th6|th5|th4.png", "60,30,806,545", imgVariations[4], ,"vertical")
    if(thInfo["hits"] > 0)
        amount["enemyTH"] := SubStr(thInfo["name"], 3)
    else
        amount["enemyTH"] := "?"
        
    if(amount["enemyTH"] > maxTH OR (amount["enemyTH"] = "?" AND maxTH < myTH + 1))
    {
        amount["hit"] := 0
        return amount
    }
        
    if(amount["enemyTH"] <= weakTH AND amount["enemyTH"] != "?" AND amount["dead"] = 1)
    {
        amount["deadBase"] := txt["YES"]
        amount["hit"] := 1
        return amount
    }
    
    if(amount["dead"] = 0 AND amount["usual"] = 0)
        amount["hit"] := 0
    else if(amount["usual"] = 1)
        amount["hit"] := 1
    else
    {
        emptyGoldStorage := 1
        emptyElixirStorage := 1
        emptyDarkStorage := 1
        if(amount["gold"] > 0)
            emptyGoldStorage := checkStorage("gold")
        if(amount["elixir"] > 0)
            emptyElixirStorage := checkStorage("elixir")
        if(amount["dark"] > 0)
            emptyDarkStorage := checkStorage("dark")
        
        if(emptyGoldStorage + emptyElixirStorage + emptyDarkStorage = 3)
        {
            amount["deadBase"] := txt["YES"]
            amount["hit"] := 1
        }
        else
            amount["hit"] := 0
    }
    return amount
}
checkTHOutside()
{
    global txt
    global imgVariations
    global thCoords
    
    thInfo := multiImageSearch("data\patterns\th\th10|th9|th7|th8|th6|th5|th4.png", "60,30,806,545||center", imgVariations[4], ,"vertical")
    if(thInfo["hits"] > 0)
    {
        thCoords := thInfo["coords"]
        return isOutside(thInfo["coords"])
    }
    return false
}
checkStorage(storageType)
{
    global imgVariations
    global checkStorages
    global checkCollectors
    empty := Object()
    storage := 1
    collector := 1
    
    if(storageType = "gold")
    {
        if(checkStorages = 1)
        {
            checkStorage := multiImageSearch("data\patterns\resources\emptyGold8|emptyGold9|emptyGold10|emptyGold11.png", gameRect, imgVariations[3], ,"vertical")
            if(checkStorage["hits"] > 0)
                storage := 1
            else
                storage := 0
        }
        if(checkCollectors = 1)
        {
            checkCollector := multiImageSearch("data\patterns\resources\collector\1.png", "", imgVariations[5])
            if(checkCollector["hits"] > 0)
                collector := 0
            else
                collector := 1
        }
        if(storage + collector = 2)
            result := 1
        else
            result := 0
    }
    else if(storageType = "elixir")
    {
        if(checkStorages = 1)
        {
            checkStorage := multiImageSearch("data\patterns\resources\emptyElixir6|emptyElixir7|emptyElixir8|emptyElixir9|emptyElixir10|emptyElixir11.png", gameRect, imgVariations[14], ,"vertical")
            if(checkStorage["hits"] > 0)
                storage := 1
            else
                storage := 0
        }
        if(checkCollectors = 1)
        {
            checkCollector := multiImageSearch("data\patterns\resources\collector\1.png", "", imgVariations[5])
            if(checkCollector["hits"] > 0)
                collector := 0
            else
                collector := 1
        }
        if(storage + collector = 2)
            result := 1
        else
            result := 0
    }
    else if(storageType = "dark")
    {
        empty := multiImageSearch("data\patterns\resources\emptyDark\12a|12b|12c|12d|12e|12f|12g|3456a|3456b|3456c|3456d|3456e|3456f|3456g|3456h|3456i|3456i.png", "50,30,818,545", imgVariations[15])
        if(empty["hits"] > 0)
            result := 1
        else
            result := 0
    }
    ; if(result = 0)
        ; writeLog("Storages and collectors: not dead")
    ; else if(result = 1)
        ; writeLog("Storages and collectors: dead")
    ; else
        ; writeLog("Storages and collectors: error")
    return result
}
getAmount()
{
    global deadBases
    global deadGold
    global deadElixir
    global deadDark
    global deadTrophies
    global usualBases
    global usualGold
    global usualElixir
    global usualDark
    global usualTrophies
    global searchType
    result := Object()
    
    searchGold := false
    searchElixir := false
    searchDark := false
    searchTrophies := false
    
    if(deadBases = 1)
    {
        if(deadGold > 0)
            searchGold := true
        if(deadElixir > 0)
            searchElixir := true
        if(deadDark > 0)
            searchDark := true
        if(deadTrophies > 0)
            searchTrophies := true
    }
    if(usualBases = 1)
    {
        if(usualGold > 0)
            searchGold := true
        if(usualElixir > 0)
            searchElixir := true
        if(usualDark > 0)
            searchDark := true
        if(usualTrophies > 0)
            searchTrophies := true
    }
    
    if(searchType = "sum" OR searchType = "any")
    {
        result["gold"] := 0
        result["elixir"] := 0
        result["dark"] := 0
        result["trophies"] := 0
        if(searchGold = true)
            result["gold"] := getSingle("gold")
        if(searchElixir = true)
            result["elixir"] := getSingle("elixir")
        if(searchDark = true)
            result["dark"] := getSingle("dark")
        if(searchTrophies = true)
            result["trophies"] := getSingle("trophies")
    }
    else
    {
        result["gold"] := 0
        result["elixir"] := 0
        result["dark"] := 0
        result["trophies"] := 0
        
        Loop 1
        {
            if(searchGold = true)
            {
                result["gold"] := getSingle("gold")
                if(result["gold"] < deadGold AND result["gold"] < usualGold)
                    break
            }
            if(searchElixir = true)
            {
                result["elixir"] := getSingle("elixir")
                if(result["elixir"] < deadElixir AND result["elixir"] < usualElixir)
                    break
            }
            if(searchDark = true)
            {
                result["dark"] := getSingle("dark")
                if(result["dark"] < deadDark AND result["dark"] < usualDark)
                    break
            }
            if(searchTrophies = true)
            {
                result["trophies"] := getSingle("trophies")
                if(result["trophies"] < deadTrophies AND result["trophies"] < usualTrophies)
                    break
            }
        }        
    }
    
    deadTotal := deadGold + deadElixir + deadDark * 100
    usualTotal := usualGold + usualElixir + usualDark * 100
    result["total"] := result["gold"] + result["elixir"] + result["dark"] * 100
    
    result["dead"] := 0
    result["usual"] := 0
    
    if(searchType = "sum")
    {
        if(deadBases = 1 AND result["total"] >= deadTotal AND result["trophies"] >= deadTrophies)
            result["dead"] := 1
        if(usualBases = 1 AND result["total"] >= usualTotal AND result["trophies"] >= usualTrophies)
            result["usual"] := 1
    }
    else if(searchType = "any")
    {
        if(deadBases = 1 AND result["trophies"] >= deadTrophies AND ((result["gold"] >= deadGold AND result["gold"] > 0) OR (result["elixir"] >= deadElixir AND result["elixir"] > 0) OR (result["dark"] >= deadDark AND result["dark"] > 0)))
            result["dead"] := 1
        if(usualBases = 1 AND result["trophies"] >= usualTrophies AND ((result["gold"] >= usualGold AND result["gold"] > 0) OR (result["elixir"] >= usualElixir AND result["elixir"] > 0) OR (result["dark"] >= usualDark AND result["dark"] > 0)))
            result["usual"] := 1
    }
    else
    {
        if(deadBases = 1 AND result["gold"] >= deadGold AND result["elixir"] >= deadElixir AND result["dark"] >= deadDark AND result["trophies"] >= deadTrophies)
            result["dead"] := 1
        if(usualBases = 1 AND result["gold"] >= usualGold AND result["elixir"] >= usualElixir AND result["dark"] >= usualDark AND result["trophies"] >= usualTrophies)
            result["usual"] := 1
    }
    
    return result    
}
getSingle(resource)
{
    global deadGold
    global deadElixir
    global deadDark
    global deadTrophies
    global usualGold
    global usualElixir
    global usualDark
    global usualTrophies
    
    if(resource = "dark" OR resource = "trophies")
        deAvailable := multiPixelSearch(0xff483858, "35,140", pixVariations) ; sprawdzenie czy czarny eliksir jest dostêpny
    
    if(resource = "gold")
    {
        if(deadGold > 0 OR usualGold > 0)
            result := readNumber(50, 71)
        else
            result := 0
    }
    else if(resource = "elixir")
    {
        if(deadElixir > 0 OR usualElixir > 0)
            result := readNumber(49, 100)
        else
            result := 0
    }
    else if(resource = "dark")
    {
        if (deAvailable["hit"] = true)
        {
            if(deadDark > 0 OR usualDark > 0)
                result := readNumber(49, 128)
            else
                result := 0
        }
        else
            result := 0
    }
    else if(resource = "trophies")
    {
        if (deAvailable["hit"] = true)
        {
            if(deadTrophies > 0 OR usualTrophies > 0)
                result := readNumber(50, 171, "SM")
            else
                result := 0
        }
        else
        {
            if(deadTrophies > 0 OR usualTrophies > 0)
                result := readNumber(50, 140, "SM")
            else
                result := 0
        }
    }
    
    return result
}