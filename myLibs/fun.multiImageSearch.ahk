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
; Funkcja posiada trzy g³ówne mechanizmy:
; 1) Wielokrotnie wyszukuje wzorzec - przydatne gdy szukany element nie jest widoczny na ekranie ca³y czas.
; 2) Wyszykuje element wœród ca³ego zestawu wzorców - przydatne gdy w badanym obszarze mog¹ wystêpowaæ ró¿ne elementy.
; 3) Dzieli podany wzorzec na plastry o szerokoœci 1px i wyszukuje kolejne plastry na ekranie a¿ do uzyskania trafienia
;    - przydatne gdy obraz na ekranie nie zawsze dok³adnie odpowiada zadanemu wzrorcowi.
; Wszystkie powy¿sze machanizmy mo¿na zastosowaæ równoczeœnie.
;
;--------------------------------
; ++PARAMETRY++
;--------------------------------
;
;-> pathSet [string]:             (wymagana) zmienna okreœla œcie¿kê dostêpu do wzorca lub zestawu wzorców (aby podac zestaw wzorcow nale¿y rozdzielic nazwy plikow znakami |)
;                                 uwaga: je¿eli okreœlono zestaw wzorców to funkcja sprawdza je po kolei i koñczy dzia³anie jeœli znajdzie jeden z nich 
;                                        (kolejnosc sprawdzania zgodna z zapisem)
;                                 uwaga: póki co zestaw wzorców musi znajdowaæ siê w tym samym folderze
;
;       PRZYK£ADY
;       "folder\wzorce\img.png"
;       "obrazy\img1|img2|img3|img4.png"
;       "obrazy\img1|img3|img2.png"
;
;-> coordSet [string]:            (opcjonalna) zmienna zawiera ci¹g ustawieñ wspó³rzêdnych wejœciowych i wyjœciowych
;
;       Domyœlna wartoœæ:         "0, 0, clientW, clientH | 0 | topLeft"
;       Schemat ci¹gu:            "inputCoords | tolerance | outputCoords"
;       Objaœnienie:              inputCoords      - koordynanty obszaru wyszukiwania - dozwolone jest podanie dwóch lub czterech wspó³rzêdnych:
;                                                       a) dwie wspó³rzêdne - u¿ytkownik okreœla spodziewany punkt pocz¹tkowy wyst¹pienia wzorca na ekranie,
;                                                       funkcja automatycznie ustawi jako obszar szukania prostok¹t wielkoœci wzorca powiêkszony z ka¿dej strony o wartoœæ parametru tolerance
;                                                       b) cztery wspó³rzedne - u¿ytkownik okreœla dok³adny obszar szukania - punkt pocz¹tkowy i koñcowy   
;                                 tolerance        - rozszerzenie obszaru wyszukiwania w stosunku do wielkoœci wzorca (ma zastosowanie gdy u¿ytkownik poda dwie wspó³rzêdne w parametrze inputCords
;                                 outputCoords     - wzglêdne wobec wzorca po³o¿enie wspó³rzêdnych zwracanych przez funkcjê, dozwolone wartoœci:
;                                                       a) s³owo kluczowe: topLeft, topRight, bottomLeft, bottomRight, center
;                                                       b) dowolny punkt wzglêdem lewego górnego rogu wzorca  - jeœli stosujemy zestaw wzorców mo¿emy podaæ odpowiadajaca mu liczbê
;                                                          par wspó³rzêdnych lub jedn¹ wspóln¹ parê wspó³rzêdnych, wspó³rzêdne oddzielamy znakami "," a poszczególne pary znakami ";"
;       
;       PRZYK£ADY
;       "50, 60"
;       "50, 60 | center"
;       "0, 0, 800, 600 | 10, 15"
;       "37,200 | 10,15 ; 13,10 ; 14,27"
;       "| ; 25,20 ; center ; ; 20,25"       uwaga: w przypadku outputCords pominiête elementy zostan¹ zast¹pione wartoœci¹ pierwszego elementu,
;                                                   jeœli pierwszy element zostanie pominiêty przyjmie on wartoœæ domyœln¹ (topLeft)
;
;-> searchSet [string]:           (opcjonalna) zmienna zawiera ci¹g standardowych ustawieñ wyszukiwania da funkcji Gdip_ImageSearch()
;                                 uwaga: poni¿ej zamieszczono tylko skrótowe informacje - pe³en opis w Gdip_ImageSearch.ahk
;
;       Domyœlna wartoœæ:         "0 | 1 |   | ; | ,"
;       Schemat ci¹gu:            "variation | instances | trans | searchDirection | lineDelim | coordDelim"
;       Objaœnienie:              variation        - liczba dopuszczalnych wariacji (odcieni) ka¿dej z wartoœci RGB - dozwolone wartoœci: 0-255
;                                 instances        - maksymalna liczba wyszukiwanych wzorców - dozwolone wartoœci: 0+ (0 = all)
;                                 trans            - kolor, który ma byc zast¹piony przezroczystoœci¹ - dozwolone wartoœci: 0-0xFFFFFF
;                                 lineDelim        - separator poszczególnych trafieñ - dozwolone wartoœci: dowolny znak
;                                 coordDelim       - separator poszczególnych wspó³rzêdnych - dozwolone wartoœci: dowolny znak
;       
;       PRZYK£ADY
;       "40 | 0 "                   uwaga: pominiête parametry przyjm¹ ustawienia domyœlne
;       "20 |   | 0xFFFFFF | 8"     uwaga: wszelkie spacje s¹ opcjonalne
;
;-> repeatSet [string]:           (opcjonalna) zmienna zawiera ci¹g ustawieñ powtarzania wyszukiwania wzorca
;
;       Domyœlna wartoœæ:         "1 | 500"
;       Schemat ci¹gu:            "repeatMax | repeatPeriod"
;       Objaœnienie:              repeatMax        - maksymalna liczba powtórzeñ wyszukiwania - dozwolone wartoœci: 1+
;                                 repeatPeriod     - odstêp w milisekundach pomiêdzy kolejnymi próbami wyszukania wzorca - dozwolone wartoœci: 0+
;       
;       PRZYK£ADY
;       "5"                       uwaga: pominiête parametry przyjm¹ ustawienia domyœlne
;       "20 | 1000"               uwaga: wszelkie spacje s¹ opcjonalne
;  
;-> sliceSet [string]:            (opcjonalna) zmienna zawiera ci¹g ustawieñ wyszukiwania wzorca pociêtego na plastry
;
;       Domyœlna wartoœæ:         "none | 1"
;       Schemat ci¹gu:            "sliceType | sliceHits"
;                                 sliceType        - kierunek ciêcia wzorca - dozwolone wartoœci: none, horizontal, vertical, both
;                                 sliceHits        - liczba trafieñ poszczególnych plastrów jaka jest potrzebna aby uznaæ wzorzec za dopasowany
;                                                    opcja póki co nieaktywna - przyjêta jest wartoœæ 1
;       
;       PRZYK£ADY
;       "horizontal"              uwaga: pominiête parametry przyjm¹ ustawienia domyœlne
;       "both | 3"                uwaga: wszelkie spacje s¹ opcjonalne (póki co cyfra 3 zostanie zignorowana)
;
;-> clientSet [string]:           (opcjonalna) zmienna zawiera ci¹g ustawieñ okna roboczego
;
;       Domyœlna wartoœæ:         "BlueStacks App Player | 868 | 720"
;       Schemat ci¹gu:            "winName | clientW | clientH"
;       Objaœnienie:              winName          - nazwa u¿ywanego okna
;                                 clientW          - szerokoœæ obszaru roboczego u¿ywanego okna
;                                 clientH          - wysokoœæ obszaru roboczego u¿ywanego okna
;       
;       PRZYK£ADY
;       "Window Name | 800 | 600"      
;
;
;--------------------------------
; ++ZWRACANE WARTOŒCI++
;--------------------------------
;
;   Funkcja zwraca tablicê asocjacyjn¹ zawieraj¹c¹ nastêpuj¹ce elementy:
;       
;       arrayName["hits"]         - liczba trafieñ: 1 - znaleziono wzorzec, 0 - nie znaleziono wzorca, liczba ujemna - b³¹d podczas wykonywania funkcji
;       arrayName["coord"]*       - wspó³rzêdne punktu, w którym znaleziono wzorzec (lub wspó³rzêdne zmodyfikowane przez parametr outputCoords)
;       arrayName["name"]*        - nazwa pliku (bez rozszerzenia) ze znalezionym wzorcem
;
;       *elementy oznaczone gwiazdk¹ bêd¹ dostêpne tylko jeœli funkcja zaliczy trafienie
;
;********************************************************************************************************************************************************************
;
;   UWAGA: Jeœli pozostawisz wszstkie wartoœci jako domyœlne wynik dzia³ania funkcji bêdzie podobny do zwyk³ego ImageSearch / Gdip_ImageSearch()
;
;********************************************************************************************************************************************************************
;********************************************************************************************************************************************************************

;#Include Gdip.ahk
;#Include Gdip_ImageSearch.ahk

multiImageSearch(pathSet, coordSet = "", searchSet = "", repeatSet = "", sliceSet = "", clientSet = "")
{
    global botMode
    result := [] ; zainicjowanie tablicy wyników
    
    ;##### USTAWIENIA DOMYŒLNE #####
    
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
    
    ;##### WCZYTYWANIE USTAWIEÑ #####
    
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
    Loop ; pêtla powtarza wyszukiwanie zadana iloœæ razy (lub przerywa gdy trafi)
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

            Loop ; pêtla wykonuje wyszukiwanie horyzontalne i wertykalne jeœli parametr sliceType = "both"
            {   
                if(sliceType = "both")
                {
                    sliceType := "horizontal"
                    onceAgain := true
                }
                movingCoord := 0
                Loop ; pêtla wyszukuje kolejne linie wzorca a¿ do trafienia
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
                            if(indexx = 1 OR coord[1] < lastX1 OR coord[1] > lastX2 OR coord[2] < lastY1 OR coord[2] > lastY2) ; sprawdzenie czy dany znaleziona ig³a nie nalezy do tego samego wzorca co poprzednia
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