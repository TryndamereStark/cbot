; funkcja sprawdza b³edy - je¿eli wystêpuj¹ to zwraca false i  próbuje za³adowaæ ekran g³ówny gry (w ostatecznoœci zamyka BlueStacks i konczy skrypt)
checkAll()
{
    buy := buyBS()
    defence := defence()
    enemyRaid := enemyRaid()
	appOut := initGame()
	gameOut := runGame("once")
	gameError := checkError()
	if (appOut = true OR gameOut = true OR gameError = true OR buy = true OR defence = true OR enemyRaid = true)
		return false
	else
		return true
}
buyBS()
{
    global imgVariations
    dontBuy := multiImageSearch("data\patterns\interface\buyBS.png", "475,455,825,460", imgVariations[6])
    if(dontBuy["hits"] > 0)
    {
        myClick(dontBuy["coords"])
        Sleep 10000
        return true
    }
    return false
}
defence()
{
    global imgVariations
    defence := multiImageSearch("data\patterns\interface\defence.png", "770,380,800,403", imgVariations[6])
    if(defence["hits"] > 0)
    {
        recognizeScreen("main")
        return true
    }
    return false
}
enemyRaid()
{
    global imgVariations
    raid := multiImageSearch("data\patterns\interface\raid.png", "290,348,330,378", imgVariations[6])
    if(raid["hits"] > 0)
    {
        myClick("434,500")
        Sleep 2000
        return true
    }
    return false
}
checkError()
{
    global anotherDeviceTime
    global imgVariations
    global txt
    
	errorAlert := multiImageSearch("data\patterns\interface\error.png", "500,286|10", imgVariations[8], "5|0") ; sprawdzenie czy nie ma errora
	if(errorAlert["hits"] > 0)
	{
        Loop
        {
            specialError := multiImageSearch("data\patterns\interface\anotherDevice|takeBreak|maintenance.png", "160,250,710,425", imgVariations[6], , "horizontal")
            if(specialError["hits"] > 0)
            {
                if(specialError["name"] = "anotherDevice")
                {
                    writeLog(txt["ANOTHER_DEVICE"] " " anotherDeviceTime txt["SECOND"], "warning")
                    Loop %anotherDeviceTime%
                    {
                        guiBar(txt["ANOTHER_DEVICE"] " " anotherDeviceTime - A_Index txt["SECOND"], "warning")
                        Sleep 1000
                    }
                    break
                }
                else if(specialError["name"] = "takeBreak" OR specialError["name"] = "maintenance")
                {
                    if(specialError["name"] = "takeBreak")
                        writeLog(txt["TAKE_A_BREAK"], "warning")
                    else if(specialError["name"] = "maintenance")
                        writeLog(txt["MAINTENANCE_BREAK"], "warning")
                    myClick("230, 70") ; obszar neutralny
                    Sleep 30000
                    continue
                }
            }
            else if(A_Index = 1)
            {
                writeLog(txt["CONNECTION_LOST"], "warning")
                break
            }
            else
                break
        }
        Loop 2
        {
		myClick("230, 70") ; obszar neutralny
        Sleep 500
        }
		zoomOut()
		Sleep 500
        recognizeScreen("main", , true)
		return true
	}
	else
        return false
}
checkFreeze(currentLoot)
{
    global freezeSame
    global freezeLoot
    global pixVariations
    global txt
    
    if(freezeLoot != "")
    {
        if(currentLoot != freezeLoot)
        {
            freezeSame := 0
            freezeLoot := currentLoot
        }
        else
            freezeSame++
    }
    else
    {
        freezeLoot := currentLoot
    }
    if(freezeSame > 5)
    {
        writeLog(txt["GAME_CRASHED"])
        serveCritical()
    }
}