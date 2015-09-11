makeArmy(mode = "troops")
{
    global troops
    global spells
    global darkSpells
    global cordTroops
    global cordDarkTroops
    global cordSpells
    global cordDarkSpells
    global pix
    global cordSpellsCheck
    global troopsFile
    global pixVariations
    global imgVariations
    global txt
    global activeModule
    
    ;WSPÓ£RZÊDNE ZAK£ADEK W TROOPS OVERVIEW:
    troopsPos := Object()
    troopsPos[1] := "269,545"
    troopsPos[2] := "330,545"
    troopsPos[3] := "391,545"
    troopsPos[4] := "452,545"
    troopsPos[5] := "537,545"
    troopsPos[6] := "599,545"
    troopsPos[7] := "682,545"
    troopsPos[8] := "745,540"
    
    activateBS()

    mainScreen := recognizeScreen("main", "few")
    if(mainScreen = false)
        checkAll()
    zoomOut()
    myClick("230, 70") ; obszar neutralny
    Sleep 500
    
    writeLog(txt["MAKE_ARMY_START"] " (" troopsFile ").") 

    Loop
    {
        if(A_Index > 5)
        {
            writeLog(txt["BARRACKS_VIEW_ERR"], "error")
            checkAll()
        }
        myClick("40,525")
        armyOverview := multiPixelSearch(0xffb522c6, "150,556", pixVariations, "20|100")
        if(armyOverview["hit"] = true)
            break
    }
    Sleep 1000
    
    for index, value in troops
    {
        trainErr := 0
        if(value._MaxIndex() != "")
        {
            ;WYBRANIE ZAK£ADKI ########################################################################
            barracksAvailable := multiPixelSearch("0xff888070", troopsPos[index], pixVariations)
            if(barracksAvailable["hit"] = true)
            {
                writeLog("Barak dostêpny.")
                myClick(troopsPos[index]) ; otworzenie zak³adki
                multiPixelSearch("0xffe8e8e0", troopsPos[index], pixVariations, "20|100")
                Sleep 500
            }
            else
            {
                writeLog("Barak niedostêpny. Pomijam.")
                continue
            }
                
            ;TWORZENIE WOJSKA #################################################################################
            if(index < 5)
            {
                notFull := multiPixelSearch("0xfff8f929", "222,303", pixVariations, "5|100")
                maxCount := 75
            }
            else if(index < 7)
            {
                notFull := multiPixelSearch("0xff111c38", "222,303", pixVariations, "5|100")
                maxCount := 90
            }
            else if(index = 7)
            {
                notFull := multiPixelSearch("0xfff8beb4", "222,303", pixVariations, "5|100")
                maxCount := 5
            }
            else
            {
                notFull := multiPixelSearch("0xffe87826", "201,306", pixVariations, "5|100")
                maxCount := 5
            }
            if(notFull["hit"] = true)
            {
                writeLog("Wybrane koszary s¹ niepe³ne - tworzê jednostki wg strategii.")
                if(index < 7)
                    removeTroops()
                    
                troopCount := 0
                
                for index, troopType in value ; przechodzi przez tablice ustawien jednostek
                {
                    if(troopType["value"] != 0)
                    {
                        writeLog("Tworzenie jednostki: " troopType["name"])
                        if(troopType["value"] >= maxCount - troopCount OR troopType["value"] = "max") ; zabezpieczenie gdyby uzytkownik podal za duza ilosc w configu - nie wykonuje nadmiarowyh jednostek (zapobiega pustym kliknieciom)
                            troopType["value"] := maxCount - troopCount
                            
                        loop % troopType["value"]
                            myClick(cordTroops[troopType["name"]]) ; tworzenie zwyklych jednostek
                        troopCount += troopType["value"]
                        writeLog("Zakoñczono worzenie jednostki: " troopType["name"])
                    }
                    if(troopCount >= maxCount)
                        break
                }
            }
            else
                writeLog("Wybrane koszary s¹ pe³ne - zostawiam to co jest.")
        }
    }
    myClick("735,115")
    Sleep 1000
    writeLog(txt["ARMY_PRODUCTION_START"], "success",true)
}
removeTroops()
{
    writeLog("Rozpoczêto sprawdzanie nadmiarowych jednostek.")
    global imgVariations
    global txt
    Loop
    {
        troopsToRemove := multiImageSearch("data\patterns\interface\removeTroops.png", "500,169,519,187||center", imgVariations[2], , "both") ; szuka przycisku -
        if(troopsToRemove["hits"] > 0)
        {
            myClick(troopsToRemove["coords"], , , 20)
            writeLog("Usuwam nadmiarowe jednostki.")
        }
        else
        {
            writeLog("Brak nadmiarowych jednostek.")
            break
        }
        Sleep 500
    }
    writeLog("Zakoñczono sprawdzanie nadmiarowych jednostek.")
}
boost()
{
    global boost
    global boostPos
    global minGems
    global activeModule
    global txt
    global imgVariations
    
    writeLog(txt["BOOST_START"])
    for index, value in boost
    {
        if(value = 1)
        {
            darkAvailable := multiPixelSearch(0xff483856, "831,137", pixVariations)
            if (darkAvailable["hit"] = true)
                gems := readNumber(810, 174, "S", "right")
            else
                gems := readNumber(810, 125, "S", "right")
            if(gems >= minGems + 10)
            {
                Loop
                {
                    if(A_Index > 5)
                        break
                    myClick(boostPos[index]) ; klikniecie budynku
                    buildingInfo := multiImageSearch("data\patterns\interface\buildingInfo.png", "120,575,750,610||center", imgVariations[7], "10|500", "vertical")
                    if(buildingInfo["hits"] > 0)
                        break
                }
                Sleep 1000
            
                boostButton := multiImageSearch("data\patterns\interface\boost.png", "120,585,750,597||center", imgVariations[1], "5|500", "horizontal")
                if(boostButton["hits"] > 0)
                {
                    myClick(boostButton["coords"])
                    spendGemsButton := multiImageSearch("data\patterns\interface\spendGems.png", "453,375|10|center", imgVariations[1], "10|500", "vertical")
                    if(spendGemsButton["hits"] > 0)
                    {
                        myClick(spendGemsButton["coords"])
                        enterShopButton := multiImageSearch("data\patterns\interface\enterShop.png", "377,390|10|center", imgVariations[1], "5|500", "horizontal")
                        if(enterShopButton["hits"] > 0)
                            myClick("590,250")
                    }
                    Sleep 500
                    myClick("230, 70") ; obszar neutralny
                    Sleep 500
                }
                else
                {
                    myClick("230, 70") ; obszar neutralny
                    Sleep 500
                }
            }
        }
    }
    writeLog(txt["BOOST_FINISH"])
}