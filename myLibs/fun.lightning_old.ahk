lightning(target = "drill", ByRef cellX = "", ByRef cellY = "")
{
    global thStats
    global lsDarkTH7
    global lsDarkTH8
    global lsDarkTH9
    global lsDarkTH10
    global darkMin
    global mortarMin
    global adMin
    global myTH
    global txt
    cells := cells()
    cir := circles(cells, 20, 20, 10)
    
    thInfo := multiImageSearch("data\patterns\th\th10|th9|th7|th8|th6|th5|th4.png", "60,30,806,545", imgVariations[4], ,"vertical")
    if(thInfo["hits"] > 0)
        enemyTH := SubStr(thInfo["name"], 3)
    else
        enemyTH := myTH
    
    writeLog(txt["SEARCH_START"] ": " target)
    if(target = "drill")
    {
        deAvailable := multiPixelSearch(0xff40304f, "35,140", pixVariations) ; sprawdzenie czy czarny eliksir jest dostępny
        if (deAvailable["hit"] = true)
        {
            darkElixir := readNumber(50, 127)
            if(darkElixir >= darkMin AND checkStorage("dark") = 1)
            {
                percentage := 9
                lv := thStats[enemyTH, "drill"]
                fill := [100, 50, 25, 10]
                Loop
                {
                    for i, value in fill
                    {
                        if(lsDarkTH%enemyTH%[lv,value "%"] >= darkMin)
                        {
                            path := "data\patterns\resources\drill\" lv "_" value ".png"
                            IfExist, %path%
                            {
                                writeLog(txt["SEARCHING"] ": Dark Elixir Storage, lv" lv ", " txt["FILL"] " " value "%")
                                hit := compare(path, cir, 1, 3, percentage, cellX, cellY)
                                if(hit != "no match")
                                    return hit
                            }
                        }
                    }
                    lv--
                    if(lv < 1)
                        return 0
                }
            }
        }
    }
    else if(target = "mortar" OR target = "ad")
    {
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
        }
        if(target = "mortar" or target = "drill")
            targetsNumber := 2
        Else
            targetsNumber := 1
        if(target = "drill")
            folder := "resources"
        else
            folder := "defences"
            
        percentage := 10
        
        lv := thStats[enemyTH, target]
        versions := ["", "a", "b"]
        hits := 0
        cellX := ""
        counter := 0
        Loop
        {
            for i, value in versions
            {
                path := "data\patterns\" folder "\" target "\" lv value ".png"
                IfExist, %path%
                {
                    writeLog(txt["SEARCHING"] ": " target ", lv" lv)
                    ;##############################################################################
                    hit := compare(path, cir, 1, 3, percentage, cellX, cellY, targetsNumber - hits)
                    ;##############################################################################
                    if(hit != "no match")
                    {
                        counter++
                        hits := StrSplit(trim(cellX, ",") , ",", " ")._MaxIndex()
                        if(hits = targetsNumber AND counter = 1)
                            return hit
                        else if(hits = targetsNumber)
                        {   result := result ";" hit
                            return result
                        }
                        else if(hits < targetsNumber  AND counter = 1)
                            result := hit
                        else
                            result := result ";" hit
                    }
                }
            }
            lv--
            if(lv < %target%Min AND counter = 0)
                return 0
            else if(lv < %target%Min AND counter > 0)
                return result
        }
    }
    return 0
}
