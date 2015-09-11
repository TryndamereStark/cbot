writeGeneralConfig()
{
    Global
    path := "data\settings.ini"
    
        iniLabel := "PATHS"
        myIniWrite(path, iniLabel, "config", config)
        myIniWrite(path, iniLabel, "layout", layout)
    
        iniLabel := "AUTHENTICATION"
        if(cbot_name != "")
            myIniWrite(path, iniLabel, "cbot_name", cbot_name)
        if(cbot_pass != "")
            myIniWrite(path, iniLabel, "cbot_pass", cbot_pass)
        if(pushbullet_mail != "")
            myIniWrite(path, iniLabel, "pushbullet_mail", pushbullet_mail)
        myIniWrite(path, iniLabel, "profile", profile)
        
        iniLabel := "GENERAL"
        myIniWrite(path, iniLabel, "lang", lang)
        myIniWrite(path, iniLabel, "botMode", botMode)
        myIniWrite(path, iniLabel, "adds", adds)
        myIniWrite(path, iniLabel, "addsMsg", addsMsg)
        myIniWrite(path, iniLabel, "livePreview", livePreview)
        myIniWrite(path, iniLabel, "livePreviewSize", livePreviewSize)
        myIniWrite(path, iniLabel, "showTrayMsg", showTrayMsg)
        myIniWrite(path, iniLabel, "autoUpdates", autoUpdates)
        
        iniLabel := "ERRORS"
        myIniWrite(path, iniLabel, "shutdownOnCritical", shutdownOnCritical)
        myIniWrite(path, iniLabel, "anotherDeviceTime", anotherDeviceTime)
        
        iniLabel := "NOTIFICATIONS"
        myIniWrite(path, iniLabel, "foundSong", foundSong)
        myIniWrite(path, iniLabel, "pushFound", pushFound)
        myIniWrite(path, iniLabel, "pushLoot", pushLoot)
        myIniWrite(path, iniLabel, "pushCritical", pushCritical)
        
    
    path := "configs\" config ".ini"

        iniLabel := "SEARCHING"
        myIniWrite(path, iniLabel, "deadBases", deadBases)
        myIniWrite(path, iniLabel, "deadGold", deadGold)
        myIniWrite(path, iniLabel, "deadElixir", deadElixir)
        myIniWrite(path, iniLabel, "deadDark", deadDark)
        myIniWrite(path, iniLabel, "deadTrophies", deadTrophies)
        myIniWrite(path, iniLabel, "usualBases", usualBases)
        myIniWrite(path, iniLabel, "usualGold", usualGold)
        myIniWrite(path, iniLabel, "usualElixir", usualElixir)
        myIniWrite(path, iniLabel, "usualDark", usualDark)
        myIniWrite(path, iniLabel, "usualTrophies", usualTrophies)
        myIniWrite(path, iniLabel, "searchType", searchType)
        myIniWrite(path, iniLabel, "checkStorages", checkStorages)
        myIniWrite(path, iniLabel, "checkCollectors", checkCollectors)
        myIniWrite(path, iniLabel, "weakTH", weakTH)
        myIniWrite(path, iniLabel, "maxTH", maxTH)
        myIniWrite(path, iniLabel, "myTH", myTH)
        myIniWrite(path, iniLabel, "waitForSpells", waitForSpells)
        myIniWrite(path, iniLabel, "waitForKing", waitForKing)
        myIniWrite(path, iniLabel, "waitForQueen", waitForQueen)
        myIniWrite(path, iniLabel, "thOutside", thOutside)

        iniLabel := "TROOPS"
        myIniWrite(path, iniLabel, "troopsOn", troopsOn)
        myIniWrite(path, iniLabel, "troopsFile", troopsFile)
        myIniWrite(path, iniLabel, "requestText", requestText)
        myIniWrite(path, iniLabel, "request", request)
        
        iniLabel := "LIGHTNING"
        myIniWrite(path, iniLabel, "lsOn", lsOn)
        myIniWrite(path, iniLabel, "lsTarget", lsTarget)
        myIniWrite(path, iniLabel, "darkMin", darkMin)
        myIniWrite(path, iniLabel, "mortarMin", mortarMin)
        myIniWrite(path, iniLabel, "adMin", adMin)
        
        iniLabel := "FINISH"
        myIniWrite(path, iniLabel, "oneStarMin", oneStarMin)
        myIniWrite(path, iniLabel, "noDamage", noDamage)
        myIniWrite(path, iniLabel, "noDamageTime", noDamageTime)
        
        iniLabel := "BOOST"
        myIniWrite(path, iniLabel, "boostBar1", boostBar1)
        myIniWrite(path, iniLabel, "boostBar2", boostBar2)
        myIniWrite(path, iniLabel, "boostBar3", boostBar3)
        myIniWrite(path, iniLabel, "boostBar4", boostBar4)
        myIniWrite(path, iniLabel, "boostDarkBar1", boostDarkBar1)
        myIniWrite(path, iniLabel, "boostDarkBar2", boostDarkBar2)
        myIniWrite(path, iniLabel, "boostSpells", boostSpells)
        myIniWrite(path, iniLabel, "boostKing", boostKing)
        myIniWrite(path, iniLabel, "boostQueen", boostQueen)
        myIniWrite(path, iniLabel, "minGems", minGems)
        
    path := "layouts\" layout ".ini"
    
        iniLabel := "COORDS"
        myIniWrite(path, iniLabel, "resourcesAuto", resourcesAuto)
        myIniWrite(path, iniLabel, "posTH", posTH)
        myIniWrite(path, iniLabel, "posBarracks1", posBarracks1)
        myIniWrite(path, iniLabel, "posBarracks2", posBarracks2)
        myIniWrite(path, iniLabel, "posBarracks3", posBarracks3)
        myIniWrite(path, iniLabel, "posBarracks4", posBarracks4)
        myIniWrite(path, iniLabel, "posDarkBarracks1", posDarkBarracks1)
        myIniWrite(path, iniLabel, "posDarkBarracks2", posDarkBarracks2)
        myIniWrite(path, iniLabel, "posSpellFactory", posSpellFactory)
        myIniWrite(path, iniLabel, "posDarkSpellFactory", posDarkSpellFactory)
        myIniWrite(path, iniLabel, "posKingAltar", posKingAltar)
        myIniWrite(path, iniLabel, "posQueenAltar", posQueenAltar)
        myIniWrite(path, iniLabel, "posGoldMine1", posGoldMine1)
        myIniWrite(path, iniLabel, "posGoldMine2", posGoldMine2)
        myIniWrite(path, iniLabel, "posGoldMine3", posGoldMine3)
        myIniWrite(path, iniLabel, "posGoldMine4", posGoldMine4)
        myIniWrite(path, iniLabel, "posGoldMine5", posGoldMine5)
        myIniWrite(path, iniLabel, "posGoldMine6", posGoldMine6)
        myIniWrite(path, iniLabel, "posGoldMine7", posGoldMine7)
        myIniWrite(path, iniLabel, "posElixirCollector1", posElixirCollector1)
        myIniWrite(path, iniLabel, "posElixirCollector2", posElixirCollector2)
        myIniWrite(path, iniLabel, "posElixirCollector3", posElixirCollector3)
        myIniWrite(path, iniLabel, "posElixirCollector4", posElixirCollector4)
        myIniWrite(path, iniLabel, "posElixirCollector5", posElixirCollector5)
        myIniWrite(path, iniLabel, "posElixirCollector6", posElixirCollector6)
        myIniWrite(path, iniLabel, "posElixirCollector7", posElixirCollector7)
        myIniWrite(path, iniLabel, "posDarkElixirDrill1", posDarkElixirDrill1)
        myIniWrite(path, iniLabel, "posDarkElixirDrill2", posDarkElixirDrill2)
        myIniWrite(path, iniLabel, "posDarkElixirDrill3", posDarkElixirDrill3)
        
        iniLabel := "UPGRADES"
        myIniWrite(path, iniLabel, "upgradesOn", upgradesOn)
        myIniWrite(path, iniLabel, "upgrades", upgrades)
        myIniWrite(path, iniLabel, "useGoldForWalls", useGoldForWalls)
        myIniWrite(path, iniLabel, "useElixirForWalls", useElixirForWalls)
        myIniWrite(path, iniLabel, "useElixirFirst", useElixirFirst)
        myIniWrite(path, iniLabel, "minGold", minGold)
        myIniWrite(path, iniLabel, "minElixir", minElixir)
        myIniWrite(path, iniLabel, "minDark", minDark)
}