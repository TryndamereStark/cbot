;ZAINICJOWANIE TABLIC:
troops := Object()
troopsPos := Object()
troops1 := Object()
troops2 := Object()
troops3 := Object()
troops4 := Object()
darkTroops1 := Object()
darkTroops2 := Object()
spells := Object()
cordTroops := Object()
cordDarkTroops := Object()
cordSpells := Object()
pix := Object()
imgVariations := Object()
boost := Object()
boostPos := Object()

modifyVariations(mainValue, modifier)
{
    newValue := mainValue + modifier
    if(newValue <= 255 AND newValue >= 0)
        finalValue := newValue
    else if(newValue > 255)
        finalValue := 255
    else
        finalValue := 0
    return finalValue
}

readGeneralConfig()
{
    Global
    path := "data\settings.ini"
       
        iniLabel := "PATHS"
        pathBlueStacks := myIniRead(path, iniLabel, "pathBlueStacks", 0)
        runPath = "%pathBlueStacks%\HD-RunApp.exe" Android com.supercell.clashofclans com.supercell.clashofclans.GameApp
        exitPath = "%pathBlueStacks%\HD-Quit.exe"
        config := myIniRead(path, iniLabel, "config", "default")
        layout := myIniRead(path, iniLabel, "layout", "default")
        
        iniLabel := "AUTHENTICATION"
        cbot_name := myIniRead(path, iniLabel, "cbot_name")
        cbot_pass := myIniRead(path, iniLabel, "cbot_pass")
        pushbullet_mail := myIniRead(path, iniLabel, "pushbullet_mail")
     
        iniLabel := "GENERAL"
        lang := myIniRead(path, iniLabel, "lang", "english")
        botMode := myIniRead(path, iniLabel, "botMode")
        adds := myIniRead(path, iniLabel, "adds")
        addsMsg := myIniRead(path, iniLabel, "addsMsg", "join us")
        livePreview := myIniRead(path, iniLabel, "livePreview")
        livePreviewSize := myIniRead(path, iniLabel, "livePreviewSize", "M")
        showTrayMsg := myIniRead(path, iniLabel, "showTrayMsg", 1)
        autoUpdates := myIniRead(path, iniLabel, "autoUpdates", 1)
        
        iniLabel := "ERRORS"
        shutdownOnCritical := myIniRead(path, iniLabel, "shutdownOnCritical")
        anotherDeviceTime := myIniRead(path, iniLabel, "anotherDeviceTime", 120)
        
        iniLabel := "NOTIFICATIONS"
        foundSong := myIniRead(path, iniLabel, "foundSong")
        pushFound := myIniRead(path, iniLabel, "pushFound")
        pushLoot := myIniRead(path, iniLabel, "pushLoot")
        pushCritical := myIniRead(path, iniLabel, "pushCritical")
        
    path := "configs\" config ".ini"

        iniLabel := "SEARCHING"
        deadBases := myIniRead(path, iniLabel, "deadBases", 1)
        deadGold := myIniRead(path, iniLabel, "deadGold", 250000)
        deadElixir := myIniRead(path, iniLabel, "deadElixir")
        deadDark := myIniRead(path, iniLabel, "deadDark")
        deadTrophies := myIniRead(path, iniLabel, "deadTrophies")
        usualBases := myIniRead(path, iniLabel, "usualBases")
        usualGold := myIniRead(path, iniLabel, "usualGold", 250000)
        usualElixir := myIniRead(path, iniLabel, "usualElixir")
        usualDark := myIniRead(path, iniLabel, "usualDark")
        usualTrophies := myIniRead(path, iniLabel, "usualTrophies")
        searchType := myIniRead(path, iniLabel, "searchType", "all")
        checkStorages := myIniRead(path, iniLabel, "checkStorages", 1)
        checkCollectors := myIniRead(path, iniLabel, "checkCollectors", 1)
        weakTH := myIniRead(path, iniLabel, "weakTH", 6)
        maxTH := myIniRead(path, iniLabel, "maxTH", 10)
        myTH := myIniRead(path, iniLabel, "myTH", 10)
        waitForSpells := myIniRead(path, iniLabel, "waitForSpells")
        waitForKing := myIniRead(path, iniLabel, "waitForKing")
        waitForQueen := myIniRead(path, iniLabel, "waitForQueen")
        thOutside := myIniRead(path, iniLabel, "thOutside")

        iniLabel := "TROOPS"
        troopsOn := myIniRead(path, iniLabel, "troopsOn", 1)
        troopsFile := myIniRead(path, iniLabel, "troopsFile", "free_1")
        request := myIniRead(path, iniLabel, "request")
        requestText := myIniRead(path, iniLabel, "requestText", "need troops")
        
        iniLabel := "LIGHTNING"
        lsOn := myIniRead(path, iniLabel, "lsOn")
        lsTarget := myIniRead(path, iniLabel, "lsTarget", "darkStorage")
        darkMin := myIniRead(path, iniLabel, "darkMin", 1000)
        mortarMin := myIniRead(path, iniLabel, "mortarMin", 1)
        adMin := myIniRead(path, iniLabel, "adMin", 1)
        
        iniLabel := "FINISH"
        oneStarMin := myIniRead(path, iniLabel, "oneStarMin", 1)
        noDamage := myIniRead(path, iniLabel, "noDamage", 1)
        noDamageTime := myIniRead(path, iniLabel, "noDamageTime", 15)
        
        iniLabel := "BOOST"
        boost[1] := boostBar1 := myIniRead(path, iniLabel, "boostBar1")
        boost[2] := boostBar2 := myIniRead(path, iniLabel, "boostBar2")
        boost[3] := boostBar3 := myIniRead(path, iniLabel, "boostBar3")
        boost[4] := boostBar4 := myIniRead(path, iniLabel, "boostBar4")
        boost[5] := boostDarkBar1 := myIniRead(path, iniLabel, "boostDarkBar1")
        boost[6] := boostDarkBar2 := myIniRead(path, iniLabel, "boostDarkBar2")
        boost[7] := boostSpells := myIniRead(path, iniLabel, "boostSpells")
        boost[8] := boostKing := myIniRead(path, iniLabel, "boostKing")
        boost[9] := boostQueen := myIniRead(path, iniLabel, "boostQueen")
        minGems := myIniRead(path, iniLabel, "minGems")
        
    path := "layouts\" layout ".ini"
    
        iniLabel := "COORDS"
        resourcesAuto := myIniRead(path, iniLabel, "resourcesAuto")
        posTH := myIniRead(path, iniLabel, "posTH")
        posBarracks1 := army[1] := boostPos[1] := troopsPos[1] := myIniRead(path, iniLabel, "posBarracks1")
        posBarracks2 := army[2] := boostPos[2] := troopsPos[2] := myIniRead(path, iniLabel, "posBarracks2")
        posBarracks3 := army[3] := boostPos[3] := troopsPos[3] := myIniRead(path, iniLabel, "posBarracks3")
        posBarracks4 := army[4] := boostPos[4] := troopsPos[4] := myIniRead(path, iniLabel, "posBarracks4")
        posDarkBarracks1 := army[5] := boostPos[5] := troopsPos[5] := myIniRead(path, iniLabel, "posDarkBarracks1")
        posDarkBarracks2 := army[6] := boostPos[6] := troopsPos[6] := myIniRead(path, iniLabel, "posDarkBarracks2")
        posSpellFactory := army[7] := boostPos[7] := troopsPos[7] := myIniRead(path, iniLabel, "posSpellFactory")
        posDarkSpellFactory := army[8] := boostPos[8] := troopsPos[8] := myIniRead(path, iniLabel, "posDarkSpellFactory")
        posKingAltar := army[9] := boostPos[9] := myIniRead(path, iniLabel, "posKingAltar")
        posQueenAltar := army[10] := boostPos[10] := myIniRead(path, iniLabel, "posQueenAltar")
        posGoldMine1 := resources[1] := myIniRead(path, iniLabel, "posGoldMine1")
        posGoldMine2 := resources[2] := myIniRead(path, iniLabel, "posGoldMine2")
        posGoldMine3 := resources[3] := myIniRead(path, iniLabel, "posGoldMine3")
        posGoldMine4 := resources[4] := myIniRead(path, iniLabel, "posGoldMine4")
        posGoldMine5 := resources[5] := myIniRead(path, iniLabel, "posGoldMine5")
        posGoldMine6 := resources[6] := myIniRead(path, iniLabel, "posGoldMine6")
        posGoldMine7 := resources[7] := myIniRead(path, iniLabel, "posGoldMine7")
        posElixirCollector1 := resources[8] := myIniRead(path, iniLabel, "posElixirCollector1")
        posElixirCollector2 := resources[9] := myIniRead(path, iniLabel, "posElixirCollector2")
        posElixirCollector3 := resources[10] := myIniRead(path, iniLabel, "posElixirCollector3")
        posElixirCollector4 := resources[11] := myIniRead(path, iniLabel, "posElixirCollector4")
        posElixirCollector5 := resources[12] := myIniRead(path, iniLabel, "posElixirCollector5")
        posElixirCollector6 := resources[13] := myIniRead(path, iniLabel, "posElixirCollector6")
        posElixirCollector7 := resources[14] := myIniRead(path, iniLabel, "posElixirCollector7")
        posDarkElixirDrill1 := resources[15] := myIniRead(path, iniLabel, "posDarkElixirDrill1")
        posDarkElixirDrill2 := resources[16] := myIniRead(path, iniLabel, "posDarkElixirDrill2")
        posDarkElixirDrill3 := resources[17] := myIniRead(path, iniLabel, "posDarkElixirDrill3")
        
        iniLabel := "UPGRADES"
        upgradesOn := myIniRead(path, iniLabel, "upgradesOn")
        upgrades := myIniRead(path, iniLabel, "upgrades")
        useGoldForWalls:= myIniRead(path, iniLabel, "useGoldForWalls")
        useElixirForWalls:= myIniRead(path, iniLabel, "useElixirForWalls")
        useElixirFirst:= myIniRead(path, iniLabel, "useElixirFirst")
        minGold := myIniRead(path, iniLabel, "minGold")
        minElixir := myIniRead(path, iniLabel, "minElixir")
        minDark := myIniRead(path, iniLabel, "minDark")
    
    path := "data\calibration.ini"
    
        iniLabel := "IMAGES"
        modifier := myIniRead(path, iniLabel, "modifier") 
        imgVariations[1] := modifyVariations(myIniRead(path, iniLabel, "trainTroops"), modifier)
        imgVariations[2] := modifyVariations(myIniRead(path, iniLabel, "next"), modifier)
        imgVariations[3] := modifyVariations(myIniRead(path, iniLabel, "emptyGoldStorage"), modifier)
        imgVariations[4] := modifyVariations(myIniRead(path, iniLabel, "townHalls"), modifier)
        imgVariations[5] := modifyVariations(myIniRead(path, iniLabel, "troops"), modifier)
        imgVariations[6] := modifyVariations(myIniRead(path, iniLabel, "returHome"), modifier)
        imgVariations[7] := modifyVariations(myIniRead(path, iniLabel, "buildingInfo"), modifier)
        imgVariations[8] := modifyVariations(myIniRead(path, iniLabel, "error"), modifier)
        imgVariations[9] := modifyVariations(myIniRead(path, iniLabel, "errorMessage"), modifier)
        imgVariations[10] := modifyVariations(myIniRead(path, iniLabel, "resourcesCollect"), modifier)
        imgVariations[11] := modifyVariations(myIniRead(path, iniLabel, "clashIco"), modifier)
        imgVariations[12] := modifyVariations(myIniRead(path, iniLabel, "fonts"), modifier)
        imgVariations[13] := modifyVariations(myIniRead(path, iniLabel, "xBig"), modifier)
        imgVariations[14] := modifyVariations(myIniRead(path, iniLabel, "emptyElixirStorage"), modifier)
        imgVariations[15] := modifyVariations(myIniRead(path, iniLabel, "emptyDarkStorage"), modifier)
        imgVariations[16] := modifyVariations(myIniRead(path, iniLabel, "shield"), modifier)
        imgVariations[17] := modifyVariations(myIniRead(path, iniLabel, "noGold"), modifier)
        imgVariations[18] := modifyVariations(myIniRead(path, iniLabel, "fullCollectors"), modifier)
        
        iniLabel := "PIXELS"
        pixVariations := myIniRead(path, iniLabel, "pixVariations")
        
        iniLabel := "CLICKS"
        clickModifier := myIniRead(path, iniLabel, "clickModifier")
        nextDelay := myIniRead(path, iniLabel, "nextDelay")
        
}

readStrategyConfig()
{
    global
    if troopsFile in free_1,free_2,free_3
        path := "strategy\" troopsFile ".ini"
    else
        path := "strategy\pro\" troopsFile ".ini"
    
    troops[1] := troops1 := iniArray(path, "BARRACKS_1")
    troops[2] := troops2 := iniArray(path, "BARRACKS_2")
    troops[3] := troops3 := iniArray(path, "BARRACKS_3")
    troops[4] := troops4 := iniArray(path, "BARRACKS_4")
    troops[5] := darkTroops1 := iniArray(path, "DARK_BARRACKS_1")
    troops[6] := darkTroops2 := iniArray(path, "DARK_BARRACKS_2")
    troops[7] := spells := iniArray(path, "SPELLS")
    troops[8] := darkSpells := iniArray(path, "DARK_SPELLS")
    
    iniLabel := "ATTACK"
    side1 := myIniRead(path, iniLabel, "side1")
    side2 := myIniRead(path, iniLabel, "side2")
    side3 := myIniRead(path, iniLabel, "side3")
    side4 := myIniRead(path, iniLabel, "side4")
    corners := myIniRead(path, iniLabel, "corners")
    useAll := myIniRead(path, iniLabel, "useAll")
}

;KOORDYNANTY JEDNOSTEK - TWORZENIE:
cordTroops["barbarian"] := cordTroops["minion"] := cordTroops["lightning"] := cordTroops["poison"] := "220, 325",
cordTroops["archer"] := cordTroops["hogRider"] := cordTroops["healing"] := cordTroops["earthquake"] := "325, 325"
cordTroops["giant"] := cordTroops["valkyrie"] := cordTroops["rage"] := cordTroops["haste"] := "430, 325"
cordTroops["goblin"] := cordTroops["golem"] := cordTroops["jump"] := "535, 325"
cordTroops["wallBreaker"] := cordTroops["witch"] := cordTroops["freeze"] := "640, 325"
cordTroops["baloon"] := cordTroops["lavaHund"] := "220, 430"
cordTroops["wizard"] := "325, 430"
cordTroops["healer"] := "430, 430"
cordTroops["dragon"] := "535, 430"
cordTroops["pekka"] := "640, 430"