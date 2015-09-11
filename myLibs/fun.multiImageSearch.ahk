;*********************************************************************************************************************************************************************
;
; multiImageSearch()
;
;********************************************************************************************************************************************************************
;
; author: kapitalny (Maciek Caderek)
; last edit: 2015-03-28 06:45
; Licensed under CC BY-SA 3.0 -> http://creativecommons.org/licenses/by-sa/3.0/
;
; Requires:
; Gdip by tic (Tariq Porter) - http://www.autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic/
; Gdip_ImageSearch() by MasterFocus - https://github.com/MasterFocus/AutoHotkey/blob/master/Functions/Gdip_ImageSearch/Gdip_ImageSearch.ahk
;
;********************************************************************************************************************************************************************
;
;--------------------------------
; ++OPIS++
;--------------------------------
;
; Funkcja posiada trzy g��wne mechanizmy:
; 1) Wielokrotnie wyszukuje wzorzec - przydatne gdy szukany element nie jest widoczny na ekranie ca�y czas.
; 2) Wyszykuje element w�r�d ca�ego zestawu wzorc�w - przydatne gdy w badanym obszarze mog� wyst�powa� r�ne elementy.
; 3) Dzieli podany wzorzec na plastry o szeroko�ci 1px i wyszukuje kolejne plastry na ekranie a� do uzyskania trafienia
;    - przydatne gdy obraz na ekranie nie zawsze dok�adnie odpowiada zadanemu wzrorcowi.
; Wszystkie powy�sze machanizmy mo�na zastosowa� r�wnocze�nie.
;
;--------------------------------
; ++PARAMETRY++
;--------------------------------
;
;-> pathSet [string]:             (wymagana) zmienna okre�la �cie�k� dost�pu do wzorca lub zestawu wzorc�w (aby podac zestaw wzorcow nale�y rozdzielic nazwy plikow znakami |)
;                                 uwaga: je�eli okre�lono zestaw wzorc�w to funkcja sprawdza je po kolei i ko�czy dzia�anie je�li znajdzie jeden z nich 
;                                        (kolejnosc sprawdzania zgodna z zapisem)
;                                 uwaga: p�ki co zestaw wzorc�w musi znajdowa� si� w tym samym folderze
;
;       PRZYK�ADY
;       "folder\wzorce\img.png"
;       "obrazy\img1|img2|img3|img4.png"
;       "obrazy\img1|img3|img2.png"
;
;-> coordSet [string]:            (opcjonalna) zmienna zawiera ci�g ustawie� wsp�rz�dnych wej�ciowych i wyj�ciowych
;
;       Domy�lna warto��:         "0, 0, clientW, clientH | 0 | topLeft"
;       Schemat ci�gu:            "inputCoords | tolerance | outputCoords"
;       Obja�nienie:              inputCoords      - koordynanty obszaru wyszukiwania - dozwolone jest podanie dw�ch lub czterech wsp�rz�dnych:
;                                                       a) dwie wsp�rz�dne - u�ytkownik okre�la spodziewany punkt pocz�tkowy wyst�pienia wzorca na ekranie,
;                                                       funkcja automatycznie ustawi jako obszar szukania prostok�t wielko�ci wzorca powi�kszony z ka�dej strony o warto�� parametru tolerance
;                                                       b) cztery wsp�rzedne - u�ytkownik okre�la dok�adny obszar szukania - punkt pocz�tkowy i ko�cowy   
;                                 tolerance        - rozszerzenie obszaru wyszukiwania w stosunku do wielko�ci wzorca (ma zastosowanie gdy u�ytkownik poda dwie wsp�rz�dne w parametrze inputCords
;                                 outputCoords     - wzgl�dne wobec wzorca po�o�enie wsp�rz�dnych zwracanych przez funkcj�, dozwolone warto�ci:
;                                                       a) s�owo kluczowe: topLeft, topRight, bottomLeft, bottomRight, center
;                                                       b) dowolny punkt wzgl�dem lewego g�rnego rogu wzorca  - je�li stosujemy zestaw wzorc�w mo�emy poda� odpowiadajaca mu liczb�
;                                                          par wsp�rz�dnych lub jedn� wsp�ln� par� wsp�rz�dnych, wsp�rz�dne oddzielamy znakami "," a poszczeg�lne pary znakami ";"
;       
;       PRZYK�ADY
;       "50, 60"
;       "50, 60 | center"
;       "0, 0, 800, 600 | 10, 15"
;       "37,200 | 10,15 ; 13,10 ; 14,27"
;       "| ; 25,20 ; center ; ; 20,25"       uwaga: w przypadku outputCords pomini�te elementy zostan� zast�pione warto�ci� pierwszego elementu,
;                                                   je�li pierwszy element zostanie pomini�ty przyjmie on warto�� domy�ln� (topLeft)
;
;-> searchSet [string]:           (opcjonalna) zmienna zawiera ci�g standardowych ustawie� wyszukiwania da funkcji Gdip_ImageSearch()
;                                 uwaga: poni�ej zamieszczono tylko skr�towe informacje - pe�en opis w Gdip_ImageSearch.ahk
;
;       Domy�lna warto��:         "0 | 1 |   | ; | ,"
;       Schemat ci�gu:            "variation | instances | trans | searchDirection | lineDelim | coordDelim"
;       Obja�nienie:              variation        - liczba dopuszczalnych wariacji (odcieni) ka�dej z warto�ci RGB - dozwolone warto�ci: 0-255
;                                 instances        - maksymalna liczba wyszukiwanych wzorc�w - dozwolone warto�ci: 0+ (0 = all)
;                                 trans            - kolor, kt�ry ma byc zast�piony przezroczysto�ci� - dozwolone warto�ci: 0-0xFFFFFF
;                                 lineDelim        - separator poszczeg�lnych trafie� - dozwolone warto�ci: dowolny znak
;                                 coordDelim       - separator poszczeg�lnych wsp�rz�dnych - dozwolone warto�ci: dowolny znak
;       
;       PRZYK�ADY
;       "40 | 0 "                   uwaga: pomini�te parametry przyjm� ustawienia domy�lne
;       "20 |   | 0xFFFFFF | 8"     uwaga: wszelkie spacje s� opcjonalne
;
;-> repeatSet [string]:           (opcjonalna) zmienna zawiera ci�g ustawie� powtarzania wyszukiwania wzorca
;
;       Domy�lna warto��:         "1 | 500"
;       Schemat ci�gu:            "repeatMax | repeatPeriod"
;       Obja�nienie:              repeatMax        - maksymalna liczba powt�rze� wyszukiwania - dozwolone warto�ci: 1+
;                                 repeatPeriod     - odst�p w milisekundach pomi�dzy kolejnymi pr�bami wyszukania wzorca - dozwolone warto�ci: 0+
;       
;       PRZYK�ADY
;       "5"                       uwaga: pomini�te parametry przyjm� ustawienia domy�lne
;       "20 | 1000"               uwaga: wszelkie spacje s� opcjonalne
;  
;-> sliceSet [string]:            (opcjonalna) zmienna zawiera ci�g ustawie� wyszukiwania wzorca poci�tego na plastry
;
;       Domy�lna warto��:         "none | 1"
;       Schemat ci�gu:            "sliceType | sliceHits"
;                                 sliceType        - kierunek ci�cia wzorca - dozwolone warto�ci: none, horizontal, vertical, both
;                                 sliceHits        - liczba trafie� poszczeg�lnych plastr�w jaka jest potrzebna aby uzna� wzorzec za dopasowany
;                                                    opcja p�ki co nieaktywna - przyj�ta jest warto�� 1
;       
;       PRZYK�ADY
;       "horizontal"              uwaga: pomini�te parametry przyjm� ustawienia domy�lne
;       "both | 3"                uwaga: wszelkie spacje s� opcjonalne (p�ki co cyfra 3 zostanie zignorowana)
;
;-> clientSet [string]:           (opcjonalna) zmienna zawiera ci�g ustawie� okna roboczego
;
;       Domy�lna warto��:         "BlueStacks App Player | 868 | 720"
;       Schemat ci�gu:            "winName | clientW | clientH"
;       Obja�nienie:              winName          - nazwa u�ywanego okna
;                                 clientW          - szeroko�� obszaru roboczego u�ywanego okna
;                                 clientH          - wysoko�� obszaru roboczego u�ywanego okna
;       
;       PRZYK�ADY
;       "Window Name | 800 | 600"      
;
;
;--------------------------------
; ++ZWRACANE WARTO�CI++
;--------------------------------
;
;   Funkcja zwraca tablic� asocjacyjn� zawieraj�c� nast�puj�ce elementy:
;       
;       arrayName["hits"]         - liczba trafie�: 1 - znaleziono wzorzec, 0 - nie znaleziono wzorca, liczba ujemna - b��d podczas wykonywania funkcji
;       arrayName["coord"]*       - wsp�rz�dne punktu, w kt�rym znaleziono wzorzec (lub wsp�rz�dne zmodyfikowane przez parametr outputCoords)
;       arrayName["name"]*        - nazwa pliku (bez rozszerzenia) ze znalezionym wzorcem
;
;       *elementy oznaczone gwiazdk� b�d� dost�pne tylko je�li funkcja zaliczy trafienie
;
;********************************************************************************************************************************************************************
;
;   UWAGA: Je�li pozostawisz wszstkie warto�ci jako domy�lne wynik dzia�ania funkcji b�dzie podobny do zwyk�ego ImageSearch / Gdip_ImageSearch()
;
;********************************************************************************************************************************************************************
;********************************************************************************************************************************************************************

;#Include Gdip.ahk
;#Include Gdip_ImageSearch.ahk

multiImageSearch(pathSet, coordSet = "", searchSet = "", repeatSet = "", sliceSet = "", clientSet = "")
{
    global botMode
    result := [] ; zainicjowanie tablicy wynik�w
    
    ;##### USTAWIENIA DOMY�LNE #####
    
    ;botMode := normal ; normal/background
    
    variation := 0
    instances := 1
    trans := ""
    searchDirection := 1
    lineDelim := "+"
    coordDelim := ","
    
    repeatMax := 1
    repeatPeriod := 500
    
    sliceType := "none"
    sliceHits := 1
    
    winName := "BlueStacks App Player"
    clientW := 868
    clientH := 720
    gameW := clientW
    gameH := 672
    
    inputCoords := [0, 0, 0, 0]
    tolerance := 0
    outputCords := "topLeft"
    
    ;##### WCZYTYWANIE USTAWIE� #####
    
    SplitPath, pathSet, , dir, extension, nameNoExt
    imgNames := StrSplit(nameNoExt, "|", " ")
    
    if(searchSet != "")
    {
        searchSet := StrSplit(searchSet, "|", " ")
        searchSetCount := searchSet._MaxIndex()
        if(searchSet[1] != "")
            variation := searchSet[1]
        if(searchSetCount > 1 AND searchSet[2] != "")
            instances := searchSet[2]
        if(searchSetCount > 2 AND searchSet[3] != "")
            trans := searchSet[3]
        if(searchSetCount > 3 AND searchSet[4] != "")
            lineDelim := searchSet[4]
        if(searchSetCount > 4 AND searchSet[5] != "")
            coordDelim := searchSet[5]
    }
    
    if(repeatSet != "")
    {
        repeatSet := StrSplit(repeatSet, "|", " ")
        repeatSetCount := repeatSet._MaxIndex()
        if(repeatSet[1] != "")
            repeatMax := repeatSet[1]
        if(repeatSetCount > 1 AND repeatSet[2] != "")
            repeatPeriod := repeatSet[2]
    }
    
    if(sliceSet != "")
    {
        sliceSet := StrSplit(sliceSet, "|", " ")
        sliceSetCount := sliceSet._MaxIndex()
        if(sliceSet[1] != "")
            sliceType := sliceSet[1]
        if(sliceSetCount > 1 AND sliceSet[2] != "")
            sliceHits := sliceSet[2]
    }
    
    if(clientSet != "")
    {
        clientSet := StrSplit(clientSet, "|", " ")
        clientSetCount := clientSet._MaxIndex()
        if(clientSet[1] != "")
            winName := clientSet[1]
        if(clientSetCount > 1 AND clientSet[2] != "")
            clientW := clientSet[2]
        if(clientSetCount > 2 AND clientSet[3] != "")
            clientH := clientSet[3]
    }
    
    if(coordSet != "")
    {
        coordSet := StrSplit(coordSet, "|", " ")
        coordSetCount := coordSet._MaxIndex()
        if(coordSet[1] != "")
        {
            inputCoords := coordSet[1]
            inputCoords := StrSplit(inputCoords, ",", " ")
        }
        if(coordSetCount > 1 AND coordSet[2] != "")
        {
            tolerance := coordSet[2]
        }
        if(coordSetCount > 2 AND coordSet[3] != "")
        {
            outputCords := coordSet[3]
        }
    }
    outputCords := StrSplit(outputCords, ";", " ")
    
    if(inputCoords._MaxIndex() = 4)
    {
        x1 := inputCoords[1]
        y1 := inputCoords[2]
        x2 := inputCoords[3]
        y2 := inputCoords[4]
    }
    else if(inputCoords._MaxIndex() = 2)
    {
        x1 := inputCoords[1] - tolerance
        y1 := inputCoords[2] - tolerance
        subx2 := inputCoords[1] + tolerance
        suby2 := inputCoords[2] + tolerance
    }
    else
        MsgBox multiImageSearch() ERROR: line 256
        
    ;##### WYSZUKIWANIE BITMAPY #####
    
    pToken := Gdip_Startup()
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

    
    i := 0
    Loop ; p�tla powtarza wyszukiwanie zadana ilo�� razy (lub przerywa gdy trafi)
    {
        i++
        if(i > repeatMax)
        {
            result["hits"] := 0
            Gdip_ShutDown(pToken)
            return result
        }
        else if(i > 1)
            Sleep repeatPeriod
            
        if(botMode = 1)
        {
            WinGet, hwnd, , %winName%
            windowArea := Gdip_BitmapFromHWND(hwnd)
            haystack := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, gameW, gameH)
            Gdip_DisposeImage(windowArea)
        }
        else
            haystack := Gdip_BitmapFromScreen(winX "|" winY "|" gameW "|" gameH)
        ;Gdip_SaveBitmapToFile(haystack, "haystack.png")
            
        for index, imgName in imgNames
        {
            path := dir "\" imgName "." extension
            pattern := Gdip_CreateBitmapFromFile(path)
            Gdip_GetDimensions(pattern, patternW, patternH)
            if(inputCoords._MaxIndex() = 2)
            {
                x2 := subx2 + patternW
                y2 := suby2 + patternH
            }

            Loop ; p�tla wykonuje wyszukiwanie horyzontalne i wertykalne je�li parametr sliceType = "both"
            {   
                if(sliceType = "both")
                {
                    sliceType := "horizontal"
                    onceAgain := true
                }
                movingCoord := 0
                Loop ; p�tla wyszukuje kolejne linie wzorca a� do trafienia
                {
                    if(sliceType = "horizontal")
                    {
                        needleX := 0
                        needleY := movingCoord
                        endCoord := patternH
                        needleW := patternW
                        needleH := 1
                    }
                    else if(sliceType = "vertical")
                    {
                        needleX := movingCoord
                        needleY := 0
                        endCoord := patternW
                        needleW := 1
                        needleH := patternH
                    }
                    
                    if(sliceType = "horizontal" OR sliceType = "vertical")
                    {
                        if(movingCoord = endCoord)
                            break
                        needle := Gdip_CloneBitmapArea(pattern, needleX, needleY, needleW, needleH)
                    }
                    else
                        needle := pattern
                    
                    ;#########################################################################################################################################                   
                    hits := Gdip_ImageSearch(haystack, needle, coordList, x1, y1, x2, y2, variation, trans, , instances, lineDelim, coordDelim)
                    ;######################################################################################################################################### 
                    if(hits > 0)
                    {
                        if(outputCords[index] AND outputCords[index] != "")
                            outShift := outputCords[index]
                        else if(outputCords[1] != "")
                            outShift := outputCords[1]  
                        else
                            outShift := "topLeft"  

                        if(outShift = "topLeft")
                        {
                            xShift := 0
                            yShift := 0
                        }
                        else if(outShift = "center")
                        {
                            xShift := patternW / 2
                            yShift := patternH / 2
                        }
                        else if(outShift = "topRight")
                        {
                            xShift := patternW
                            yShift := 0
                        }
                        else if(outShift = "bottomLeft")
                        {
                            xShift := 0
                            yShift := patternH
                        }
                        else if(outShift = "bottomRight")
                        {
                            xShift := patternW
                            yShift := patternH
                        }
                        else
                        {
                            outShift := StrSplit(outShift, ",", " ")
                            xShift := outShift[1]
                            yShift := outShift[2]
                        }
                        
                        finalHits := 0                       
                        coordList := StrSplit(coordList, lineDelim, " ")
                        for indexx, coord in coordList
                        {
                            coord := StrSplit(coord, coordDelim, " ")
                            if(indexx = 1 OR coord[1] < lastX1 OR coord[1] > lastX2 OR coord[2] < lastY1 OR coord[2] > lastY2) ; sprawdzenie czy dany znaleziona ig�a nie nalezy do tego samego wzorca co poprzednia
                            {
                                if(sliceType = "horizontal")
                                {
                                    lastX1 := coord[1]
                                    lastY1 := coord[2] - movingCoord
                                    lastX2 := coord[1] + patternW
                                    lastY2 := coord[2] - movingCoord + patternH
                                    x := Round(coord[1] + xShift)
                                    y := Round(coord[2] - movingCoord + yShift)
                                }
                                else if(sliceType = "vertical")
                                {
                                    lastX1 := coord[1] - movingCoord
                                    lastY1 := coord[2]
                                    lastX2 := coord[1] - movingCoord + patternW
                                    lastY2 := coord[2] + patternH
                                    x := Round(coord[1] - movingCoord + xShift)
                                    y := Round(coord[2] + yShift)
                                }
                                else
                                {
                                    lastX1 := coord[1]
                                    lastY1 := coord[2]
                                    lastX2 := coord[1] + patternW
                                    lastY2 := coord[2] + patternH
                                    x := Round(coord[1] + xShift)
                                    y := Round(coord[2] + yShift)
                                }
                                if(indexx = 1)
                                    finalList := x "," y
                                else
                                    finalList := finalList ";" x "," y
                                finalHits++
                            }
                        }
                        
                        result["hits"] := finalHits
                        result["coords"] := finalList
                        result["name"] := imgName
                        Gdip_DisposeImage(pattern)
                        Gdip_DisposeImage(haystack)
                        Gdip_ShutDown(pToken)
                        
                        return result
                    }
                    else if(hits < 0)
                    {
                        result["hits"] := hits
                        Gdip_DisposeImage(pattern)
                        Gdip_DisposeImage(haystack)
                        Gdip_ShutDown(pToken)
                        return result
                    }
                    if(sliceType = "none")
                        break
                    Gdip_DisposeImage(needle)
                    movingCoord++
                }
                
                if(onceAgain = true)
                {
                    sliceType := "vertical"
                    onceAgain := false
                }
                else
                    break
            }
            Gdip_DisposeImage(pattern)         
            if(index = imgNames._MaxIndex())
                break
        }
        Gdip_DisposeImage(haystack)
    }
}