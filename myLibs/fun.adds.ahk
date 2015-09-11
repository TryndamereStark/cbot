adds(messages = "Join us!")
{
    messages := StrSplit(messages, ";", " ")
    
    myClick("20,350")
    Sleep 500
    myClick("75,30")
    Sleep 500
    for index, message in messages
    {
        myClick("50,65") ; focus text field
        Sleep 500
        ;clipboard := message
        ControlSend, ahk_parent, %message%, BlueStacks App Player
        Sleep 1000
        myClick("285,65") ; wyslij
        Sleep 2000
    }
    myClick("335,350")
    Sleep 1000
    clearCache()
}
clearCache()
{
    global imgVariations
    
    myClick("45,695")
    Sleep 1000
    myClick("515,400")
    Loop 20
    {
        settingsIco := multiImageSearch("data\patterns\interface\settings.png", "||center", imgVariations[9], , "horizontal")
        if(settingsIco["hits"] > 0)
        {
            myClick(settingsIco["coords"])
            break
        }
        cacheIco := multiImageSearch("data\patterns\interface\cache.png", "150,375,210,435||center", imgVariations[9], , "vertical")
        if(cacheIco["hits"] > 0)
        {
            myClick(cacheIco["coords"])
            break
        }
        Sleep 500
    }
    if(settingsIco["hits"] > 0)
    {
        advancedIco := multiImageSearch("data\patterns\interface\advanced.png", "0,620,50,670||center", imgVariations[9], "20|500", "horizontal")
        if(advancedIco["hits"] > 0)
            myClick(advancedIco["coords"])
        memoryIco := multiImageSearch("data\patterns\interface\memory.png", "150,120,190,160||center", imgVariations[9], "20|500", "vertical")
        if(memoryIco["hits"] > 0)
            myClick(memoryIco["coords"])
        cacheIco := multiImageSearch("data\patterns\interface\cache.png", "150,375,210,435||center", imgVariations[9], "20|500", "vertical")
        if(cacheIco["hits"] > 0)
            myClick(cacheIco["coords"])
        else
        {
            backToGame()
            return false
        }
    }
    cacheConfirm := multiImageSearch("data\patterns\interface\cacheConfirm.png", "160,315,700,335", imgVariations[9], "20|500", "horizontal")
    if(cacheConfirm["hits"] > 0)
        myClick("570,415")
    Else
    {
        backToGame()
        return false
    }
    backToGame()
    return true
}
backToGame()
{
    global runPath
    global botMode
    
    if(botMode = 1)
    {
        global imgVariations
        
        Sleep 2000
        myClick("125,695")
        clashIco := multiImageSearch("data\patterns\interface\clashIco.png", "||center", imgVariations[9], "20|500", "horizontal")
        if(clashIco["hits"] > 0)
            myClick(clashIco["coords"])
        Else
        {
            myClick("75,145")
            Sleep 1000
            myClick("260,50")
            Sleep 500
            ControlSend, ahk_parent, clash of clans, BlueStacks App Player
            Sleep 500
            myClick("85,150")
        }
    }
    else
        Run, %runPath%
    recognizeScreen("main", , true)
}