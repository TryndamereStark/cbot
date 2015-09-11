;*********************************************************************************************************************************************************************
;
; multiImageSearch()
;
;********************************************************************************************************************************************************************
;
; author: kap (Maciej Caderek)
; last edit: 2015-03-28 06:45
; Licensed under CC BY-SA 3.0 -> http://creativecommons.org/licenses/by-sa/3.0/
;
; Requires:
; Gdip by tic (Tariq Porter) - http://www.autohotkey.com/board/topic/29449-gdi-standard-library-145-by-tic/
;
;********************************************************************************************************************************************************************
;
;--------------------------------
; ++OPIS++
;--------------------------------
;
; Funkcja posiada dwa g³ówne mechanizmy:
; 1) Wielokrotnie wyszukuje piksel danego koloru - przydatne gdy szukany element nie jest widoczny na ekranie ca³y czas.
; 2) Wyszukuje piksel wœród ca³ego zestawu kolorów - przydatne gdy w danym punkcie mog¹ znajdowaæ siê elementy o ró¿nych kolorach
;    (odpowiednik pixelGetColor z t¹ ró¿nic¹, ¿e szuka koloru wœród kolorów zadeklarowanych przez u¿ytkownika a nie wœród wszystkich mo¿liwych)
; Oba powy¿sze machanizmy mo¿na zastosowaæ równoczeœnie.
;
;--------------------------------
; ++PARAMETRY++
;--------------------------------
;
;-> colorSet [string]:             (wymagana) zmienna okreœla œcie¿kê dostêpu do wzorca lub zestawu wzorców (aby podac zestaw wzorcow nale¿y rozdzielic nazwy plikow znakami |)
;                                 uwaga: je¿eli okreœlono zestaw wzorców to funkcja sprawdza je po kolei i koñczy dzia³anie jeœli znajdzie jeden z nich 
;                                        (kolejnosc sprawdzania zgodna z zapisem)
;
;       PRZYK£ADY
;       "0xFFFFFFFF"
;       "0xFF000000|0xFFFF00FF|0xFF00FFFF"
;
;-> coordSet [string]:            (opcjonalna) zmienna zawiera ci¹g ustawieñ wspó³rzêdnych wejœciowych i wyjœciowych
;
;       Domyœlna wartoœæ:         "0,0 | 0 | 0,0"
;       Schemat ci¹gu:            "inputCoords | tolerance | outputCoords"
;       Objaœnienie:              inputCoords      - koordynanty obszaru wyszukiwania - dozwolone jest podanie dwóch lub czterech wspó³rzêdnych:
;                                                       a) dwie wspó³rzêdne - u¿ytkownik okreœla spodziewany punkt pocz¹tkowy wyst¹pienia wzorca na ekranie,
;                                                       funkcja automatycznie ustawi jako obszar szukania dany punkt powiêkszony z ka¿dej strony o wartoœæ parametru tolerance
;                                                       b) cztery wspó³rzedne - u¿ytkownik okreœla dok³adny obszar szukania - punkt pocz¹tkowy i koñcowy   
;                                 tolerance        - rozszerzenie obszaru wyszukiwania w stosunku do wielkoœci wzorca (ma zastosowanie gdy u¿ytkownik poda dwie wspó³rzêdne w parametrze inputCords
;                                 outputCoords     - wzglêdne wobec wzorca po³o¿enie wspó³rzêdnych zwracanych przez funkcjê, dozwolone wartoœci:
;                                                    dowolny punkt wzglêdem lewego górnego rogu wzorca  - jeœli stosujemy zestaw wzorców mo¿emy podaæ odpowiadajaca mu liczbê
;                                                    par wspó³rzêdnych lub jedn¹ wspóln¹ parê wspó³rzêdnych, wspó³rzêdne oddzielamy znakami "," a poszczególne pary znakami ";"
;       
;       PRZYK£ADY
;       "50, 60"
;       "0, 0, 800, 600 | 10, 15"
;       "37,200 | 10,15 ; 13,10 ; 14,27"
;       "| ; 25,20 ; 30,50 ; ; 20,25"               uwaga: w przypadku outputCords pominiête elementy zostan¹ zast¹pione wartoœci¹ pierwszego elementu,
;                                                          jeœli pierwszy element zostanie pominiêty przyjmie on wartoœæ domyœln¹ (topLeft)
;
;-> searchSet [string]:           (opcjonalna) zmienna zawiera ci¹g standardowych ustawieñ wyszukiwania dla funkcji PixelSearch
;                                 uwaga: poni¿ej zamieszczono tylko skrótowe informacje - pe³en opis: http://ahkscript.org/docs/commands/PixelSearch.htm
;
;       Domyœlna wartoœæ:         "0 | fast"
;       Schemat ci¹gu:            "variation | instances | trans | searchDirection | lineDelim | coordDelim"
;       Objaœnienie:              variation        - liczba dopuszczalnych wariacji (odcieni) ka¿dej z wartoœci RGB - dozwolone wartoœci: 0-255
;                                 mode             - tryb wyszukiwania - dozwolone wartoœci: fast, slow, RGB
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
;       arrayName["coord"]*       - wspó³rzêdne punktu, w którym znaleziono piksel danego koloru (lub wspó³rzêdne zmodyfikowane przez parametr outputCoords)
;       arrayName["color"]*       - znaleziony kolor
;
;       *elementy oznaczone gwiazdk¹ bêd¹ dostêpne tylko jeœli funkcja zaliczy trafienie
;
;********************************************************************************************************************************************************************
;
;   UWAGA: Jeœli pozostawisz wszstkie wartoœci jako domyœlne wynik dzia³ania funkcji bêdzie podobny do zwyk³ego PixelSearch
;
;********************************************************************************************************************************************************************
;********************************************************************************************************************************************************************

;#Include libs\Gdip.ahk
;#Include libs\Gdip_ImageSearch.ahk

multiPixelSearch(colorSet, inCoords, variations = 0, repeatSet = "")
{
    global botMode
    result := [] ; zainicjowanie tablicy wyników
    
    ;##### USTAWIENIA DOMYŒLNE #####
    
    repeatMax := 1
    repeatPeriod := 500
    
    winName := "BlueStacks App Player"
    clientW := 868
    clientH := 720
    gameW := clientW
    gameH := 672
    
    ;##### WCZYTYWANIE USTAWIEÑ #####
    
    inARGBs := StrSplit(colorSet, "|", " ")
    
    if(repeatSet != "")
    {
        repeatSet := StrSplit(repeatSet, "|", " ")
        repeatSetCount := repeatSet._MaxIndex()
        if(repeatSet[1] != "")
            repeatMax := repeatSet[1]
        if(repeatSetCount > 1 AND repeatSet[2] != "")
            repeatPeriod := repeatSet[2]
    }
        
    ;##### WYSZUKIWANIE PIKSELI #####
    
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
            result["hit"] := false
            result["color"] := outARGB
            Gdip_ShutDown(pToken)
            return result
        }
        else if(i > 1)
            Sleep repeatPeriod
    
        if(botMode = 1)
        {
            WinGet, hwnd, , %winName%
            windowArea := Gdip_BitmapFromHWND(hwnd)
            gameArea := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, gameW, gameH)
            Gdip_DisposeImage(windowArea)
        }
        else
            gameArea := Gdip_BitmapFromScreen(winX "|" winY "|" gameW "|" gameH)
            
        ;Gdip_SaveBitmapToFile(gameArea, "blabla.png")
            
        for index, inARGB in inARGBs
        {  
            ;#########################################################################
            hit := Gdip_PixelSearch(gameArea, outX, outY, inCoords, inARGB, variations)
            ;#########################################################################
            if(hit = 1)
            {
                result["hit"] := true
                result["color"] := inARGB
                result["coords"] := outX "," outY
                Gdip_DisposeImage(gameArea)
                Gdip_ShutDown(pToken)
                return result
            }
                
            if(index = colors._MaxIndex())
                break
        }
        Gdip_DisposeImage(gameArea)
    }
}