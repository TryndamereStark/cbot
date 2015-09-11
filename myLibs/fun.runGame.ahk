;funkcja uruchamia grê - ma trzy tryby - normal (b³edy krytyczne wywo³uj¹ funkcje serveCritical) / once (nie zg³asza b³edów) / first (b³edy krytyczne powoduj¹ wyœwietlenie komunikatu, zak³ada ze uzytkownik jest przy komputerze)
runGame(mode = "normal")
{
    global imgVariations
    global txt
    activateBS()
    
    if(mode = "once")
        clashIco := multiImageSearch("data\patterns\interface\clashIco.png", "0,60,868,190||center", imgVariations[11], , "vertical") ; wyszukanie ikony gry w BlueStacks    
    else if(mode = "normal")
        clashIco := multiImageSearch("data\patterns\interface\clashIco.png", "0,60,868,190||center", imgVariations[11], "100|1000", "vertical") ; wyszukanie ikony gry w BlueStacks
        
    if(clashIco["hits"] > 0)
    {
        myClick(clashIco["coords"])
        if(mode = "once")
            writeLog(txt["GAME_OFF"], "warning")   
        writeLog(txt["INIT_GAME_SUCCESS"], "success")
        recognizeScreen("main", , true)  
        return true
    }
    else if(clashIco["hits"] = 0 AND mode = "normal")
    {
        writeLog(txt["GAME_ICO_ERR"], "warning")
        myClick("75, 120")
        sleep 1000
        Send clash of clans
        sleep 1000
        myClick("75, 120")
        recognizeScreen("main", , true)  
        return true
    }
}