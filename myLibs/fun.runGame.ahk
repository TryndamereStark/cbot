;funkcja uruchamia gr� - ma trzy tryby - normal (b�edy krytyczne wywo�uj� funkcje serveCritical) / once (nie zg�asza b�ed�w) / first (b�edy krytyczne powoduj� wy�wietlenie komunikatu, zak�ada ze uzytkownik jest przy komputerze)
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