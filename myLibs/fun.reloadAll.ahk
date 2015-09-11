reloadAll()
{  
    global imgVariations
    global gameRect
    global txt
    global resourcesAuto
    global resources
    global posTH
    
    ;ZEBRANIE SUROWCÓW:
    mainScreen := recognizeScreen("main", "once")
    if(mainScreen = false)
        checkAll()
    zoomOut()
    if(resourcesAuto = 1)
    {
        resourcesIco := multiImageSearch("data\patterns\resources\collect.png", "65,0,800,550||center", imgVariations[10] "|0", , "vertical")
        if(resourcesIco["hits"] > 0)
        {
            coords := StrSplit(resourcesIco["coords"], ";")
            writeLog(txt["RESOURCES_COLLECT_START"])
            for index, value in coords
            {
                myClick(value)
            }
            Sleep 3000
            windowToClose := multiImageSearch("data\patterns\interface\xBig.png", "800,0,868,70||center", imgVariations[13], , "vertical")
            if(windowToClose["hits"] > 0)
                myClick(windowToClose["coords"])
            
            writeLog(txt["RESOURCES_COLLECT_END"], "success")
        }
        else if(resourcesIco["hits"] = 0)
            writeLog(txt["RESOURCES_COLLECT_NOTHING"], "miss")
        else
            writeLog(txt["ERROR"] " " txt["ERROR_CODE"] ": " resourcesIco["hits"], "warning")
    }
    else
    {
        writeLog(txt["RESOURCES_COLLECT_START"])
        for index, value in resources
        {
            if(value != "" AND value != 0)
                myClick(value)
        }
        writeLog(txt["RESOURCES_COLLECT_END"], "success")
    }
    ;Prze³adowanie PU£APEK
    Sleep 1000
    myClick(posTH)
    rearm := multiImageSearch("data\patterns\interface\rearm.png", "120,620,750,627||center", imgVariations[1], "10|100", "horizontal")
    if(rearm["hits"] > 0)
    {
        myClick(rearm["coords"])
        Sleep 500
        okButton := multiPixelSearch("0xffd44f1c", "400,410", pixVariations, "10|100")
        if(okButton["hit"] = true)
            myClick("520,400")
        Sleep 500
    }
    myClick("230, 70")
    Sleep 1000
    myClick(posTH)
    reloadButton := multiImageSearch("data\patterns\interface\reload.png", "120,625,750,632||center", imgVariations[1], "10|100", "horizontal")
    if(reloadButton["hits"] > 0)
    {
        myClick(reloadButton["coords"])
        Sleep 500
        okButton := multiPixelSearch("0xffd44f1c", "400,410", pixVariations, "10|100")
        if(okButton["hit"] = true)
            myClick("520,400")
        Sleep 500
    }
    myClick("230, 70")
    Sleep 1000
}