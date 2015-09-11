recognizeScreen(name, mode = "normal", runCritical = false)
{  
    global pixVariations
    global txt
    
    if(name = "main")
    {
        closeChat()
        if(mode = "once")
            repeatSet := ""
        else if(mode = "few")
            repeatSet := "20|100"
        else
            repeatSet := "240|1000"
            
        mainScreen := multiPixelSearch(0xff2b84c0, "230,30", pixVariations, repeatSet) ; sprawdza czy g³ówny ekran gry jest widoczny (czy gra jest za³adowana)
        if(mainScreen["hit"] = true)
        {
            if(mode != "once")
                writeLog(txt["MAIN_SCREEN_LOADED"], "success")
            return true
        }
        else
        {
            writeLog(txt["MAIN_SCREEN_ERR"], "error")
            serveCritical()
            return false
        }
    }
}
;FUNKCJE POMOCNICZE:
closeChat()
{
    global pixVariations
    chatVisible := multiPixelSearch(0xffd34b17, "335,375", pixVariations) ; sprawdza czy czat jest wysuniêty
    if(chatVisible["hit"] = true)
    {
        myClick(chatVisible["coords"]) ; zamyka czat
        Sleep 500
    }
}