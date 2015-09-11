upgrades()
{
    global upgrades
    global layout
    global imgVariations
    global pixVariations
    global txt
    
    zoomOut()
    myClick("230, 70")
    Sleep 500
    
    upgrades := StrSplit(upgrades, ";", " ")
    counter := upgrades._MaxIndex()
    
    if(counter > 0)
        writeLog(txt["UPGRADES_START"])
    
    gold := 0
    elixir := 0
    dark := 0
    golixir := 0
    upgrade := Object()
    
    for index, value in upgrades
    {
        if(gold = 1 AND elixir = 1 AND dark = 1 AND golixir = 1)
            break
        myClick(value)
        Sleep 1000
        upgrade[index] := upgradeType()
        upType := upgrade[index, "type"]
        if(%upType% = 0)
        {
            if(upgrade[index] != false)
            {
                action := makeUpgrade(upgrade[index])
                if(action = true)
                {
                    upgrades.Remove(index)
                    if(upType = "golixir")
                    {
                        golixir := 0
                        gold := 0
                        elixir := 0
                    }
                    else
                        %upType% := 0  
                }
                else
                {
                    if(upType = "golixir")
                    {
                        golixir := 1
                        gold := 1
                        elixir := 1
                    }
                    else
                        %upType% := 1  
                }
            }
            else
            {
                upgrades.Remove(index)
                if(upType = "golixir")
                {
                    golixir := 1
                    gold := 1
                    elixir := 1
                }
                else
                    %upType% := 1 
                myClick("230, 70")
                Sleep 1000
            }
        }
        else
        {
            myClick("230, 70")
            Sleep 1000
        }
    }
    
    updateUpgrades := ""
    for index, value in upgrades
    {
        if(A_Index = 1)
            updateUpgrades := updateUpgrades value
        else
            updateUpgrades := updateUpgrades ";" value
    }
    upgrades := updateUpgrades
    myIniWrite("layouts\" layout ".ini", "UPGRADES", "upgrades", updateUpgrades)
    if(counter > 0)
        writeLog(txt["UPGRADES_FINISH"])
    return true
}
upgradeType()
{
    global useGoldForWalls
    global useElixirForWalls
    upgrade := Object()
    gold := 0
    elixir := 0
    dark := 0
    upgradeType := multiImageSearch("data\patterns\interface\goldUpgrade|elixirUpgrade|darkUpgrade.png", "120,560,750,575", 40, , "horizontal")
    if(upgradeType["hits"] > 0)
    {
        if(upgradeType["name"] = "goldUpgrade")
        {
            gold := 1
            bow := multiImageSearch("data\patterns\interface\bow.png", "120,588,750,604||center", 40, , "both")
            if(bow["hits"] < 1)
            {
                elixirUpgrade := multiImageSearch("data\patterns\interface\elixirUpgrade.png", "120,560,750,575", 40, , "horizontal")
                if(elixirUpgrade["hits"] > 0)
                    elixir := 1
            }
        }
        else if(upgradeType["name"] = "elixirUpgrade")
            elixir := 1
        else if(upgradeType["name"] = "darkUpgrade")
            dark := 1
    }
    if(gold = 1 AND elixir = 1 AND useGoldForWalls = 1 AND useElixirForWalls = 1)
    {
        upgrade["type"] := "golixir"
        upgrade["pos1"] := upgradeType["coords"]
        upgrade["pos2"] := elixirUpgrade["coords"]
    }
    else if(gold = 1 AND elixir = 1 AND useGoldForWalls = 1 AND useElixirForWalls = 0)
    {
        upgrade["type"] := "gold"
        upgrade["pos1"] := upgradeType["coords"]
    }
    else if(gold = 1 AND elixir = 1 AND useGoldForWalls = 0 AND useElixirForWalls = 1)
    {
        upgrade["type"] := "elixir"
        upgrade["pos1"] := elixirUpgrade["coords"]
    }
    else if(gold = 1 AND elixir = 1 AND useGoldForWalls = 0 AND useElixirForWalls = 0)
        upgrade := false
    else if(gold = 1)
    {
        upgrade["type"] := "gold"
        upgrade["pos1"] := upgradeType["coords"]
    }
    else if(elixir = 1)
    {
        upgrade["type"] := "elixir"
        upgrade["pos1"] := upgradeType["coords"]
    }
    else if(dark = 1)
    {
        upgrade["type"] := "dark"
        upgrade["pos1"] := upgradeType["coords"]
    }
    else
        upgrade := false
        
    return upgrade
}

makeUpgrade(singleUpgrade)
{
    global useElixirFirst
    global minGold
    global minElixir
    global minDark
    if(singleUpgrade["type"] = "golixir")
    {
        if(useElixirFirst = 1)
        {
            enough := checkEnough(singleUpgrade["pos2"], 2)
            if(enough = 0)
                enough := checkEnough(singleUpgrade["pos1"])
        }
        else
        {
            enough := checkEnough(singleUpgrade["pos1"])
            if(enough = 0)
                enough := checkEnough(singleUpgrade["pos2"], 2)
        }
        if(enough = 1)
            singleUpgrade["type"] = "gold"
        else
            singleUpgrade["type"] = "elixir"
    }
    else
        enough := checkEnough(singleUpgrade["pos1"])
    
    if(enough > 0)
    {
        resType := singleUpgrade["type"]
        resources := checkAmount(singleUpgrade["type"])
        myClick(singleUpgrade["pos" enough ""])
        Sleep 1000
        darkUpgrade := multiPixelSearch("0xff483858", "583,496", pixVariations)
        if(darkUpgrade["hit"] = true)
            cost := readNumber(566,484, "M", "right")
        else
            cost := readNumber(476, 476, "M", "right")
        remainder := resources - cost
        if(remainder >= min%resType%)
        {
            if(darkUpgrade["hit"] = true)
                myClick("566,484")
            else
                myClick("479,476")
            Sleep 1000
            myClick("230, 70")
            Sleep 1000
            return true
        }
        else
        {
            myClick("700,145")
            Sleep 1000
            myClick("230, 70")
            Sleep 1000
            return false
        }
    }
    else
        return false
}

checkEnough(coords, nr = 1)
{
    coords := StrSplit(coords, ",", " ") 
    notEnough := multiPixelSearch("0xFFE70A12", coords[1] - 15 ",563," coords[1] ",570", pixVariations)
    if(notEnough["hit"] = true)
        return 0
    Else
        return nr
}

checkAmount(resource)
{
    if(resource = "gold")
        result := readNumber(807, 24, "S", "right")
    else if(resource = "elixir")
        result := readNumber(810, 75, "S", "right")
    else if(resource = "dark")
    {
        darkAvailable := multiPixelSearch(0xff483856, "831,137", pixVariations)
        if (darkAvailable["hit"] = true)
            result := readNumber(810, 125, "S", "right")
        else
            result := 0
    }
    return result
}