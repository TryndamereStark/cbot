checkArmy()
{
    global imgVariations
    global pixVariations
    global txt
    global troopsOn
    global lsOn
    global waitForSpells
    
    myClick("40,525")
    armyOverview := multiPixelSearch(0xffb522c6, "150,556", pixVariations, "20|100")
    if(armyOverview["hit"] = true)
    {
        troopsReady := true
        spellsReady := true
        
        if(troopsOn = 1)
            troopsReady := checkUnits("troops")
        if((lsOn = 1 AND troopsOn = 0) OR waitForSpells = 1)
            spellsReady := checkUnits("spells")
            
        myClick("735,115")
        Sleep 1000
    }
    
    if(troopsReady = true AND spellsReady = true)
        return true
    else
        return false
}