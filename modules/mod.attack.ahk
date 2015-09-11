attack()
{
    global troopsOn
    global lsOn
    global lsTarget
    
    if(((lsOn = 1 AND lsTarget != "drill") OR (troopsOn = 0 AND lsOn = 1 AND lsTarget = "drill")) AND findTroop("lightning") = true)
    {
        lsAttack(lsTarget)
    }
    if(troopsOn = 1)
        troopsAttack()
}
thAttack()
{
    global thCoords
    global imgVariations
    global pixVariations
    global txt
    
    troops := ["queen", "king", "archer", "barbarian", "minion"]
    
    writeLog(txt["TH_ONLY_ATTACK"])
    for index, troop in troops
    {
        Loop
        {
            isAvailable := findTroop(troop)
            if(isAvailable = true)
            {
                if(troop = "queen" OR troop = "king")
                {
                    myClick(findClosest(thCoords))
                }
                else
                {
                    Random, iterations, 10, 20
                    Loop %iterations%
                        myClick(findClosest(thCoords))
                }
                Loop 5
                {
                    oneStar := multiPixelSearch("0xffc0c6c0", "720,536", pixVariations)
                    if(oneStar["hit"] = true)
                    {
                        Loop
                        {
                            if(A_Index > 5)
                            {
                                writeLog(txt["CANT_VERIFY_END_BATTLE"]) 
                                break
                            }
                            myClick("70,535")
                            confirmBattleEnd := multiImageSearch("data\patterns\interface\confirmBattleEnd.png", "495,393|5|center", imgVariations[6], "20|100", "horizontal")
                            if(confirmBattleEnd["hits"] > 0)
                                break
                        }
                        Loop
                        {
                            if(A_Index > 5)
                            {
                                writeLog(txt["CANT_VERIFY_CONFIRM_END_BATTLE"])
                                break
                            }
                            Sleep 500
                            myClick(confirmBattleEnd["coords"])
                            homeButton := multiImageSearch("data\patterns\interface\home.png", "392,532|5|center", imgVariations[6], "20|100", "horizontal")
                            if(homeButton["hits"] > 0)
                            {
                                goHome()
                                return true
                            }
                        }
                    }
                    homeButton := multiImageSearch("data\patterns\interface\home.png", "392,532|5|center", imgVariations[6], "20|100", "horizontal")
                    if(homeButton["hits"] > 0)
                    {
                        goHome()
                        return true
                    }
                    Sleep 1000
                }
                homeButton := multiImageSearch("data\patterns\interface\home.png", "392,532|5|center", imgVariations[6], "20|100", "horizontal")
                if(homeButton["hits"] > 0)
                {
                    goHome()
                    return true
                }
            }
            else
                break
        }
    }
}
lsAttack(target)
{
    global troopsOn
    global darkMin
    global txt
    global pixVariations
    global imgVariations
    global lsCount
    
    if(target = "drill")
    {
        deAvailable := multiPixelSearch(0xff40304f, "35,140", pixVariations)    
        if (deAvailable["hit"] = true)
        {
            darkElixir := readNumber(50, 127)
            if(darkElixir < darkMin OR checkStorage("dark") = 0)
                return 0
        }
        else
            return 0
        targetPath := "resources\drill\6|5|4|3|2|1.png"
        targetVariations := 50
        minSpells := 1
        
    }
    else if(target = "ad")
    {
        targetPath := "defences\ad\8|7|6|5|4|3|2.png"
        targetVariations := 35
        minSpells := 3
    }
    else if(target = "mortar")
    {
        targetPath := "defences\mortar\8a|8b|7a|7b|6a|5a|5b|4a|3a|3b|2a|2b.png"
        targetVariations := 50
        minSpells := 2
    }
    
    if(lsCount < minSpells)
        return 0
        
    writeLog(txt["LIGHTNING_ATTACK_START"])
     
    Loop
    {
        lsHit := multiImageSearch("data\patterns\" targetPath, "||center", targetVariations,, "horizontal")
        if(lsHit["hits"] > 0)
        {
            if(A_Index = 1)
                myClick(lsHit["coords"], 500,, minSpells)
            else
                myClick(lsHit["coords"])
            if(findTroop("lightning") = false AND target != "drill" AND troopsOn = 1)
            {
                writeLog(txt["LIGHTNING_NO_SPELL"])
                break
            }
            Sleep 10000
        }
        else
        {
            writeLog(txt["LIGHTNING_NO_BUILDING"])
            break
        }
        if(findTroop("lightning") = false AND (target = "drill" OR troopsOn = 0))
        {
            writeLog(txt["LIGHTNING_NO_SPELL"])
            break
        }
    }
    writeLog(txt["LIGHTNING_ATTACK_FINISH"])
    return 1
}
troopsAttack()
{
    global side1
    global side2
    global side3
    global side4
    global corners
    global useAll
    global scroolTroops
    global imgVariations
    global pixVariations
    global searchCount
    global txt
    global lsOn
    global lsTarget 
    global lsCount
    global oneStarMin 
    global noDamage
    global noDamageTime
    
    line1 := StrSplit(side1 , "/", " `t")
    line2 := StrSplit(side2 , "/", " `t")
    line3 := StrSplit(side3 , "/", " `t")
    line4 := StrSplit(side4 , "/", " `t")
    
    count1 := line1._MaxIndex()
    count2 := line2._MaxIndex()
    count3 := line3._MaxIndex()
    count4 := line4._MaxIndex()
    
    maxCount := 0
    if(count1 > maxCount)
        maxCount := count1
    if(count2 > maxCount)
        maxCount := count2
    if(count3 > maxCount)
        maxCount := count3
    if(count4 > maxCount)
        maxCount := count4
        
    zoomout()
    writeLog(txt["ATTACK_STARTED"])
        
    ;G£ÓWNY ATAK:
    
    Loop %maxCount%
    {
        if(line1[A_Index] != 0)
        {
            sendLine(line1[A_Index], 220, 155, 207, 143)
            checkResult := checkHomeAndErrors()
            if(checkResult = "home")
            {
                goHome()
                return true
            }
            else if(checkResult = "end")
                return false
        }
        if(line2[A_Index] != 0)
        {
            sendLine(line2[A_Index], 650, 155, 207, -143)
            checkResult := checkHomeAndErrors()
            if(checkResult = "home")
            {
                goHome()
                return true
            }
            else if(checkResult = "end")
                return false
        }
        if(line3[A_Index] != 0)
        {
            sendLine(line3[A_Index], 195, 435, 175, -126)
            checkResult := checkHomeAndErrors()
            if(checkResult = "home")
            {
                goHome()
                return true
            }
            else if(checkResult = "end")
                return false
        }
        if(line4[A_Index] != 0)
        {
            sendLine(line4[A_Index], 675, 435, 175, 126)
            checkResult := checkHomeAndErrors()
            if(checkResult = "home")
            {
                goHome()
                return true
            }
            else if(checkResult = "end")
                return false
        }
    }
    
    if(useAll > 0)
    {
        Sleep 500 
        if(useAll = 2)
            sendOthers(660, 140, 153, -105)
        else if(useAll = 3)
            sendOthers(230, 470, 153, -105)
        else if(useAll = 4)
            sendOthers(660, 470, 153, 105)
        else
            sendOthers(230, 140, 153, 105)
        writeLog(txt["OTHER_UNITS_SEND"])        
    }  
    
    finish := waitForFinish()
    if(finish = 1)
    {
        goHome()
        return true
    }
    else if(finish = 0)
        return false
    
    ;ATAK LS NA DRILLE:
    
    if(lsOn = 1 AND lsTarget = "drill" AND findTroop("lightning") = true)
        lsAttack("drill")
        
    ;ZAKOÑCZENIE ATAKU:
        
    else if(oneStarMin = 1 AND noDamage = 1 AND finish = 2)
        finish := waitForFinish(, true)
    else if(oneStarMin = 1 AND noDamage = 1 AND finish = 3)
        finish := waitForFinish(,, true)
    else if(oneStarMin = 0 AND noDamage = 0)
        finish := waitForFinish(false)
    else if(oneStarMin = 0 AND noDamage = 1 AND finish = 2)
        finish := waitForFinish(, true)
    
    if(finish = 0)
        return false
    
    
	;POWRÓT DO WIOSKI:
	
	allOk := checkAll()
	if(allOk = false)
    {
        writeLog(txt["ATTACK_INTERRUPTED"], "warning")
        return false
    }
    checkResult := checkHomeAndErrors()
    if(checkResult = "home")
    {
        goHome()
        return true
    }
    else if(checkResult = "end")
        return false

    endBattle := multiImageSearch("data\patterns\interface\endBattle.png", "64,529|5|center", imgVariations[6], "20|100", "horizontal")
    if(endBattle["hits"] > 0)
    {
        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["CANT_VERIFY_END_BATTLE"]) 
                break
            }
            myClick(endBattle["coords"])
            confirmBattleEnd := multiImageSearch("data\patterns\interface\confirmBattleEnd.png", "495,393|5|center", imgVariations[6], "20|100", "horizontal")
            if(confirmBattleEnd["hits"] > 0)
                break
        }
        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["CANT_VERIFY_CONFIRM_END_BATTLE"])
                break
            }
            Sleep 500
            myClick(confirmBattleEnd["coords"])
            homeButton := multiImageSearch("data\patterns\interface\home.png", "392,532|5|center", imgVariations[6], "20|100", "horizontal")
            if(homeButton["hits"] > 0)
                break
        }
    }
    surrender := multiImageSearch("data\patterns\interface\surrender.png", "47,530|5|center", imgVariations[6], "20|100", "horizontal")
    if(surrender["hits"] > 0)
    {
        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["CANT_VERIFY_CONFIRM_END_BATTLE"]) 
                break
            }
            myClick(surrender["coords"])
            confirmBattleEnd := multiImageSearch("data\patterns\interface\confirmBattleEnd.png", "495,393|5|center", imgVariations[6], "20|100", "horizontal")
            if(confirmBattleEnd["hits"] > 0)
                break
        }
        Loop
        {
            if(A_Index > 5)
            {
                writeLog(txt["CANT_VERIFY_CONFIRM_END_BATTLE"]) 
                break
            }
            Sleep 500
            myClick(confirmBattleEnd["coords"])
            homeButton := multiImageSearch("data\patterns\interface\home.png", "392,532|5|center", imgVariations[6], "20|100", "horizontal")
            if(homeButton["hits"] > 0)
                break
        }
    }
    goHome()
    return true
}
waitForFinish(fullMode = true, skipStars = false, skipPercentage = false)
{
    global oneStarMin 
    global noDamage
    global noDamageTime
    global txt
    global pixVariations
    
    percentage := -1
    result := 0
    writeLog(txt["WAITING_FOR_ATTACK_END"])
    Loop
    {
        allOk := checkAll()
        if(allOk = false)
        {
            writeLog(txt["ATTACK_INTERRUPTED"], "warning")
            return 0
        }
        checkResult := checkHomeAndErrors()
        if(checkResult = "home")
            return 1
        else if(checkResult = "end")
            return 0
            
        if(fullMode = true)
        { 
            if(oneStarMin = 1 AND skipStars = false)
            {
                oneStar := multiPixelSearch("0xffc0c6c0", "720,536", pixVariations)
                if(oneStar["hit"] = true)
                    result += 2
            }
                
            if((Mod(A_Index, noDamageTime) = 0 OR A_Index = 1) AND skipPercentage = false)
            {
                curPercentage := readNumber(834, 527, "ML", "right")
                if(percentage = curPercentage)
                    result += 3

                percentage := curPercentage
            }
            if(result > 0)
                return result
        }
        
        Sleep 1000
    }
}
goHome()
{
    global txt
    global cbot_name
    global pixVariations
    
    Sleep 3000
    FileCreateDir, log\screenshots_scores
    takeScreenshot("log\screenshots_scores")
    attackSummation()
    Loop
    {
        if(A_Index > 5)
        {
            writeLog(txt["RETURN_ERR"]) 
            break
        }
        Sleep 500
        myClick("430,550", 200) ; klikniecie return home
        Loop 10
        {
            backHome := multiPixelSearch("0xffffffff", "398,535", pixVariations)
            if(backHome["hit"] = false)
                break
            Sleep 100
        }
        if(backHome["hit"] = false)
            break
    }
    mainScreen := recognizeScreen("main", , true)
    if(cbot_name != 0 AND cbot_name != "")
        checkCurrentStats()
}
findTroop(troopName) ; funkcja szuka jednostki na pasku ataku - jesli znajdzie zaznacza ja i zwraca true, jesli nie znajdzie zwraca false
{
    global imgVariations
    global pixVariations
    global botMode
    global txt
    
    activateBS()
    
    guiBar("Szukam: " troopName)
    if(troopName = "castle")
        coordSet := "0,653,868,658||center"
    else
        coordSet := "0,612,868,632||center"

    Loop
    {
        troopExist := multiImageSearch("data\patterns\troops\" troopName ".png", coordSet, imgVariations[5], , "horizontal")
        if(troopExist["hits"] > 0)
        {
            writeLog(txt["UNIT_SELECTED"] ": " troopName, "success")
            myClick(troopExist["coords"])
            Sleep 100
            if(troopName = "king")
            {
                writeLog("Waiting for King ability")
                Sleep 1000
                Run, data\KingAbility.exe
                Sleep 1000
            }
            else if(troopName = "queen")
            {
                Sleep 1000
                writeLog("Waiting for Queen ability")
                Run, data\QueenAbility.exe
                Sleep 1000
            }
            return true
        }
        else
        {
            writeLog(txt["UNIT_NOT_FOUND"] ": " troopName, "warning")
            return false
        }
    }
}
sendLine(line, centerX, centerY, edgeX, edgeY)
{
    global troopsFile
    global txt
    global imgVariations
    global pixVariations
    troopsList := "barbarian,archer,giant,goblin,wallBreaker,baloon,wizard,healer,dragon,pekka,minion,hogRider,valkyrie,golem,witch,lavaHund,king,queen,castle,lightning,healing,rage,jump,freeze,poison,earthquake,haste"
        
    ;PARSOWANIE POJEDYNCZEJ LINII (sk³adaj¹cej siê z jednego lub kilku sk³adów - rodzajów wojska):
    
    squad := StrSplit(line , "+", " `t")
    
    for index, value in squad ; przetwarza wszystkie jednostki po kolei
    {
        params := StrSplit(value , ",", " `t")
        i := 0
        for indexx, param in params ; przetwarza ustawienia danej jednostki
        {
            i++
            if(i = 1)
            {   
                unitsNumber := 1
                formation := "spread"
                
                if(param = "wait")
                    wait := true
                else
                {
                    wait := false
                    if param in %troopsList%
                    {
                        if(findTroop(param) != true) ; jeœli nie znaleziono danej jednostki program zakoñczy pêtle
                        {
                            troop := false
                            break
                        }
                        Else
                            troop := true
                    }
                    else
                    {
                        logMessage := txt["WRONG_UNIT_NAME"] ": " param "- " txt["CHECK_FILE"] troopsFile ".ini (" txt["FOLDER"] " strategy)"
                        writeLog(logMessage, "error")
                        troop := false
                        break
                    }
                }
            }
            else if(i = 2)
            {
                if param is integer
                    unitsNumber := param
                else
                {
                    logMessage = txt["WRONG_UNITS_NUMBER"] ": " param "- " txt["CHECK_FILE"] troopsFile ".ini (" txt["FOLDER"] " `"strategy`")"
                    writeLog(logMessage, "error")
                    unitsNumber := 1
                }
            }
            else if(i = 3)
            {
                if param in wide,spread,group,point,corners
                    formation := param
                else
                {
                    logMessage = txt["WRONG_FORMATION_NAME"] ": " param "- " txt["CHECK_FILE"] troopsFile ".ini (" txt["FOLDER"] " `"strategy`")"
                    writeLog(logMessage, "error")
                    formation := "spread"
                }
            }            
        }
        if(troop = false)
            continue
            
        ;PRZEBIEG ATAKU (POJEDYNCZY SQUAD):
            
        if(wait = true)
            Sleep unitsNumber * 1000
        else
        {
            if(formation = "point")
            {
                Loop %unitsNumber%
                    myClick(centerX "," centerY)
            }
            else if(formation = "corners")
            {
                spaceX := (edgeX / unitsNumber)
                spaceY := (edgeY / unitsNumber)
                i := 0
                Loop %unitsNumber%
                {
                    i++
                    if(mod(i, 2) = 0)
                    {
                        Random, mods, -20, 20
                        Random, timeRand, 20, 100
                        rWaveX := (centerX - edgeX + (i / 2) * spaceX) + mods
                        rWaveY := (centerY + edgeY - (i / 2) * spaceY) + mods
                        myClick(rWaveX "," rWaveY, timeRand)
                    }
                    else
                    {
                        Random, mods, -20, 20
                        Random, timeRand, 20, 100
                        lWaveX := (centerX + edgeX - ((i-1) / 2) * spaceX) + mods
                        lWaveY := (centerY - edgeY + ((i-1) / 2) * spaceY) + mods
                        myClick(lWaveX "," lWaveY, timeRand)
                    }
                }
            }
            else
            {
                if(formation = "spread")
                {
                    spaceX := (edgeX / unitsNumber)
                    spaceY := (edgeY / unitsNumber)
                }
                else if(formation = "wide")
                {
                    spaceX := (edgeX*2 / unitsNumber)
                    spaceY := (edgeY*2 / unitsNumber)
                }
                else if(formation = "group")
                {
                    spaceX := ((edgeX / 3) / unitsNumber)
                    spaceY := ((edgeY / 3) / unitsNumber)
                }
                i := 0
                Loop %unitsNumber%
                {
                    i++
                    if(mod(i, 2) = 0)
                    {
                        Random, mods, -20, 20
                        Random, timeRand, 20, 100
                        rWaveX := (centerX + (i / 2) * spaceX) + mods
                        rWaveY := (centerY - (i / 2) * spaceY) + mods
                        myClick(rWaveX "," rWaveY, timeRand)
                    }
                    else
                    {
                        Random, mods, -20, 20
                        Random, timeRand, 20, 100
                        lWaveX := (centerX - ((i-1) / 2) * spaceX) + mods
                        lWaveY := (centerY + ((i-1) / 2) * spaceY) + mods
                        myClick(lWaveX "," lWaveY, timeRand)
                    }
                }
            }
        }
    }
}
sendOthers(centerX, centerY, edgeX, edgeY)
{
    global troopsFile
    global txt
    global imgVariations
    global pixVariations
    troopsList := "barbarian,archer,giant,goblin,wallBreaker,baloon,wizard,healer,dragon,pekka,minion,hogRider,valkyrie,golem,witch,lavaHund"
        
    ;PARSOWANIE POJEDYNCZEJ LINII (sk³adaj¹cej siê z jednego lub kilku sk³adów - rodzajów wojska):
    
    unit := StrSplit(troopsList , ",", " ")
    
    Loop 2
    {
        for index, value in unit ; przetwarza wszystkie jednostki po kolei
        {
            params := StrSplit(value , ",", " `t")
                
            if(findTroop(value) != true) ; jeœli nie znaleziono danej jednostki program przejdzie do kolejnej jednostki
                continue
                
            ;PRZEBIEG ATAKU (POJEDYNCZY SQUAD):
              
            spaceX := (edgeX / unitsNumber)
            spaceY := (edgeY / unitsNumber)
            unitsNumber := 10

            i := 0
            Loop %unitsNumber%
            {
                i++
                if(mod(i, 2) = 0)
                {
                    Random, mods, -20, 20
                    Random, timeRand, 20, 100
                    rWaveX := (centerX + (i / 2) * spaceX) + mods
                    rWaveY := (centerY - (i / 2) * spaceY) + mods
                    myClick(rWaveX "," rWaveY, timeRand)
                }
                else
                {
                    Random, mods, -20, 20
                    Random, timeRand, 20, 100
                    lWaveX := (centerX - ((i-1) / 2) * spaceX) + mods
                    lWaveY := (centerY + ((i-1) / 2) * spaceY) + mods
                    myClick(lWaveX "," lWaveY, timeRand)
                }
            }
        }
    }
}
checkHomeAndErrors()
{
    global imgVariations
    global txt
    
    homeButton := multiImageSearch("data\patterns\interface\home.png", "392,532|5|center", imgVariations[6], , "horizontal")
    if(homeButton["hits"] > 0)
    {
        writeLog(txt["ATTACK_FINISHED"], "success", true)
        return "home"
    }
	allOk := checkAll()
	if(allOk = false)
    {
        writeLog(txt["ATTACK_INTERRUPTED"], "warning")
        return "end"
    }
    return true
}
attackSummation()
{
    global pixVariations
    global targetID
    global txt
    global account
    global pushLoot
    global cbot_name
    
    if(targetID = "")
        targetID := A_Now
    
    lootedGold := readNumber(443, 288, "L", "right")
    lootedElixir := readNumber(443, 327, "L", "right")
    deDrop := multiPixelSearch(0xff483855, "466,383", pixVariations)
    if(deDrop["hit"] = true)
        lootedDarkEliksir := readNumber(443, 366, "L", "right")
    else
        lootedDarkEliksir := 0
    lootedTotal := lootedGold + lootedElixir + lootedDarkEliksir * 100
    writeLog(txt["LOOT_GAINED"] ": " txt["GOLD"] " = " lootedGold ", " txt["ELIXIR"] " = " lootedElixir ", " txt["DARK"] " = " lootedDarkEliksir ", " txt["SUM"] " = " lootedTotal, "success", true)
    if(pushLoot = 1 AND account = "PRO")
        push(uri_encode(txt["LOOT_GAINED"] ":"), uri_encode(txt["GOLD"] " = " lootedGold ", " txt["ELIXIR"] " = " lootedElixir ", " txt["DARK"] " = " lootedDarkEliksir ", " txt["SUM"] " = " lootedTotal))
    if(cbot_name != 0 AND cbot_name != "")
        sendLoot(lootedGold, lootedElixir, lootedDarkEliksir, lootedTotal)
    writeCsv("loot", targetID ";" lootedGold ";" lootedElixir ";" lootedDarkEliksir ";" lootedTotal)
    writeCsv("currentSession", targetID ";" lootedGold ";" lootedElixir ";" lootedDarkEliksir ";" lootedTotal)
    targetID := ""
}
checkCurrentStats()
{
    global imgVariations
    global pixVariations
    zoomOut()
    thInfo := multiImageSearch("data\patterns\th\th10|th9|th7|th8|th6|th5|th4.png", "60,30,806,545", imgVariations[4], ,"vertical")
    if(thInfo["hits"] > 0)
        thLevel := SubStr(thInfo["name"], 3)
    else
        thLevel := "?"
    trophies := readNumber(72, 76, "S")
    gold := readNumber(807, 24, "S", "right")
    elixir := readNumber(810, 75, "S", "right")
    darkAvailable := multiPixelSearch(0xff483856, "831,137", pixVariations)
    if (darkAvailable["hit"] = true)
    {
        dark := readNumber(810, 125, "S", "right")
        gems := readNumber(810, 174, "S", "right")
    }
    else
    {
        dark := 0
        gems := readNumber(810, 125, "S", "right")
    }
    sendCurrentStats(gold, elixir, dark, trophies, thLevel)
}