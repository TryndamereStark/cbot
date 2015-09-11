readNumber(startX, startY, size = "S", direction = "left")
{
    global imgVariations
    global botMode
    global txt
		
    if(size = "S")
    {
        ;wysokosc wyszukiwania:
        h := 14
        ;wokosci poszczegolnych cyfr:
        w0 := 12
        w1 := 6
        w2 := 9
        w3 := 10
        w4 := 11
        w5 := 10
        w6 := 11
        w7 := 9
        w8 := 11
        w9 := 10
        wspace := 4
    }
    if(size = "SM")
    {
        ;wysokosc wyszukiwania:
        h := 16
        ;wokosci poszczegolnych cyfr:
        w0 := 13
        w1 := 6
        w2 := 9
        w3 := 10
        w4 := 12
        w5 := 10
        w6 := 11
        w7 := 10
        w8 := 12
        w9 := 11
        wspace := 0
    }
    else if(size = "M")
    {
        ;wysokosc wyszukiwania:
        h := 17
        ;wokosci poszczegolnych cyfr:
        w0 := 14
        w1 := 7
        w2 := 11
        w3 := 11
        w4 := 12
        w5 := 11
        w6 := 12
        w7 := 11
        w8 := 13
        w9 := 12
        wspace := 5
    }
    else if(size = "ML")
    {
        ;wysokosc wyszukiwania:
        h := 20
        ;wokosci poszczegolnych cyfr:
        w0 := 17
        w1 := 8
        w2 := 14
        w3 := 14
        w4 := 16
        w5 := 14
        w6 := 15
        w7 := 13
        w8 := 16
        w9 := 15
        wspace := 6
    }
    else if(size = "L")
    {
        ;wysokosc wyszukiwania:
        h := 23
        ;wokosci poszczegolnych cyfr:
        w0 := 18
        w1 := 9
        w2 := 15
        w3 := 15
        w4 := 18
        w5 := 15
        w6 := 17
        w7 := 15
        w8 := 18
        w9 := 16
        wspace := 8
    }
    else if(size = "XL")
    {
        ;wysokosc wyszukiwania:
        h := 26
        ;wokosci poszczegolnych cyfr:
        w0 := 21
        w1 := 10
        w2 := 17
        w3 := 17
        w4 := 20
        w5 := 17
        w6 := 19
        w7 := 17
        w8 := 20
        w9 := 18
        wspace := 0
    }
    
    ;kolejnosc sprawdzania cyfr (niepowtarzalne wzorce cyfr sa sprawdzane w pierwszej kolejnosci):
    i0 := 2
    i1 := 4
    i2 := 5
    i3 := 6
    i4 := 8
    i5 := 9
    i6 := 3
    i7 := 0
    i8 := 7
    i9 := 1

	wynikFull := "" ; wyszukana liczba lootu
	noDigit := 0 ; liczba wyszukanych pustych przestrzeni
    pToken := Gdip_Startup()
    winName := "BlueStacks App Player"
    clientW := 868
    clientH := 720
    gameW := clientW
    gameH := 672
    WinGetPos, winX, winY, winW, winH, %winName%
    winBorder := (winW-clientW)/2
    if(botMode = 1)
    {
        wShiftX := winBorder
        wShiftY := winH-clientH-winBorder
    }
    else
    {
        winX := winX+winBorder
        winY := winY+(winH-clientH-winBorder)
    }
    if(botMode = 1)
    {
        WinGet, hwnd, , %winName%
        windowArea := Gdip_BitmapFromHWND(hwnd)
        haystack := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, gameW, gameH)
        Gdip_DisposeImage(windowArea)
    }
    else
        haystack := Gdip_BitmapFromScreen(winX "|" winY "|" gameW "|" gameH)
    carriageShift := 0
    if(direction = "center")
    {
        percent := multiImageSearch("data\patterns\numbers\percent.png", "730,508,820,535", imgVariations[12])
        if(percent["hits"] > 0)
        {
            percentCoords := StrSplit(percent["coords"], ",", " ")
            startX := percentCoords[1] - 4
        }
        else
        {
            startX := 778
        }
    }
	Loop
	{
		nr := 0
		wynik := false
		if ((direction = "left" OR direction = "right") AND noDigit > 2)
			break
        else if(direction = "center" AND noDigit > 0)
            break
		Loop
		{
			if (nr > 9)
			{
				noDigit++
                if(direction = "left")
                    carriageShift += wspace
                else if(direction = "right" OR direction = "center")
                    carriageShift -= wspace
				break
			}
			else
			{
				cyfra := i%nr%
                w := w%cyfra%
				ims++
                path := "data\patterns\numbers\" cyfra size ".png"
                
                needle := Gdip_CreateBitmapFromFile(path)
                if(direction = "left")
                    hitsNumber := Gdip_ImageSearch(haystack, needle, hits, startX + carriageShift, startY, startX + carriageShift + w, startY + h, imgVariations[12])
                else if(direction = "right" OR direction = "center")
                    hitsNumber := Gdip_ImageSearch(haystack, needle, hits, startX + carriageShift - w, startY, startX + carriageShift, startY + h, imgVariations[12])
                Gdip_DisposeImage(needle)
                if(hitsNumber > 0)
                {
					wynik := cyfra
                    if(direction = "left")
                    {
                        carriageShift += w
                        wynikFull = %wynikFull%%wynik%
                    }
                    else if(direction = "right" OR direction = "center")
                    {
                        carriageShift -= w
                        wynikFull = %wynik%%wynikFull%
                    }
					break
                }
                else if(hitsNumber < 0)
                {
                    guiBar(txt["ERROR_CODE"] ": " hitsNumber, "error")
                }

				nr++
			}
		}
	}
    Gdip_DisposeImage(haystack)
    Gdip_ShutDown(pToken)
	return wynikFull
}
