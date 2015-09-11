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
        targetPath := multiImageSearch("data\patterns\resources\drill\6|5|4|3|2|1.png", "||center", 50,, "horizontal")    
    }
    else if(target = "ad")
    {
        targetPath := "defences\ad\8|7|6|5|4|3|2.png"
        targetVariations := 35
    }
    else if(target = "mortar")
    {
        targetPath := "defences\mortar\8a|8b|7a|7b|6a|5a|5b|4a|3a|3b|2a|2b.png"
        targetVariations := 40
    }
     
    Loop
    {
        lsHit := multiImageSearch("data\patterns\" targetPath, "||center", targetVariations,, "horizontal")
        if(lsHit["hits"] > 0)
        {
            myClick(lsHit["coords"])
            Sleep 10000
        }
        else
            break
    }
    
    
    
    ; cells := cells()
    ; cir := circles(cells, 20, 20, 10)
    
    ; thInfo := multiImageSearch("data\patterns\th\th10|th9|th7|th8|th6|th5|th4.png", "60,30,806,545", imgVariations[4], ,"vertical")
    ; if(thInfo["hits"] > 0)
        ; enemyTH := SubStr(thInfo["name"], 3)
    ; else
        ; enemyTH := myTH
    
    ; writeLog(txt["SEARCH_START"] ": " target)

    ; if(target = "drill")
    ; {
        ; deAvailable := multiPixelSearch(0xff40304f, "35,140", pixVariations)
        ; if (deAvailable["hit"] = true)
        ; {
            ; darkElixir := readNumber(50, 127)
            ; if(darkElixir < darkMin OR checkStorage("dark") = 0)
                ; return 0
        ; }
        ; else
            ; return 0
    ; }
    ; if(target = "mortar" or target = "drill")
        ; targetsNumber := 2
    ; Else
        ; targetsNumber := 1
    ; if(target = "drill")
        ; folder := "resources"
    ; else
        ; folder := "defences"
        
    ; percentage := 10
    
    ; lv := thStats[enemyTH, target]
    ; versions := ["", "a", "b"]
    ; hits := 0
    ; cellX := ""
    ; counter := 0
    ; Loop
    ; {
        ; for i, value in versions
        ; {
            ; path := "data\patterns\" folder "\" target "\" lv value ".png"
            ; IfExist, %path%
            ; {
                ; writeLog(txt["SEARCHING"] ": " target ", lv" lv)
                ; ;##############################################################################
                ; hit := compare(path, cir, 1, 3, percentage, cellX, cellY, targetsNumber - hits)
                ; ;##############################################################################
                ; if(hit != "no match")
                ; {
                    ; counter++
                    ; hits := StrSplit(trim(cellX, ",") , ",", " ")._MaxIndex()
                    ; if(hits = targetsNumber AND counter = 1)
                        ; return hit
                    ; else if(hits = targetsNumber)
                    ; {   result := result ";" hit
                        ; return result
                    ; }
                    ; else if(hits < targetsNumber  AND counter = 1)
                        ; result := hit
                    ; else
                        ; result := result ";" hit
                ; }
            ; }
        ; }
        ; lv--
        ; if(lv < %target%Min AND counter = 0)
            ; return 0
        ; else if(lv < %target%Min AND counter > 0)
            ; return result
    ; }
    
    ; return 0
}
