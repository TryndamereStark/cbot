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
; Funkcja posiada dwa g��wne mechanizmy:
; 1) Wielokrotnie wyszukuje piksel danego koloru - przydatne gdy szukany element nie jest widoczny na ekranie ca�y czas.
; 2) Wyszukuje piksel w�r�d ca�ego zestawu kolor�w - przydatne gdy w danym punkcie mog� znajdowa� si� elementy o r�nych kolorach
;    (odpowiednik pixelGetColor z t� r�nic�, �e szuka koloru w�r�d kolor�w zadeklarowanych przez u�ytkownika a nie w�r�d wszystkich mo�liwych)
; Oba powy�sze machanizmy mo�na zastosowa� r�wnocze�nie.
;
;--------------------------------
; ++PARAMETRY++
;--------------------------------
;
;-> colorSet [string]:             (wymagana) zmienna okre�la �cie�k� dost�pu do wzorca lub zestawu wzorc�w (aby podac zestaw wzorcow nale�y rozdzielic nazwy plikow znakami |)
;                                 uwaga: je�eli okre�lono zestaw wzorc�w to funkcja sprawdza je po kolei i ko�czy dzia�anie je�li znajdzie jeden z nich 
;                                        (kolejnosc sprawdzania zgodna z zapisem)
;
;       PRZYK�ADY
;       "0xFFFFFFFF"
;       "0xFF000000|0xFFFF00FF|0xFF00FFFF"
;
;-> coordSet [string]:            (opcjonalna) zmienna zawiera ci�g ustawie� wsp�rz�dnych wej�ciowych i wyj�ciowych
;
;       Domy�lna warto��:         "0,0 | 0 | 0,0"
;       Schemat ci�gu:            "inputCoords | tolerance | outputCoords"
;       Obja�nienie:              inputCoords      - koordynanty obszaru wyszukiwania - dozwolone jest podanie dw�ch lub czterech wsp�rz�dnych:
;                                                       a) dwie wsp�rz�dne - u�ytkownik okre�la spodziewany punkt pocz�tkowy wyst�pienia wzorca na ekranie,
;                                                       funkcja automatycznie ustawi jako obszar szukania dany punkt powi�kszony z ka�dej strony o warto�� parametru tolerance
;                                                       b) cztery wsp�rzedne - u�ytkownik okre�la dok�adny obszar szukania - punkt pocz�tkowy i ko�cowy   
;                                 tolerance        - rozszerzenie obszaru wyszukiwania w stosunku do wielko�ci wzorca (ma zastosowanie gdy u�ytkownik poda dwie wsp�rz�dne w parametrze inputCords
;                                 outputCoords     - wzgl�dne wobec wzorca po�o�enie wsp�rz�dnych zwracanych przez funkcj�, dozwolone warto�ci:
;                                                    dowolny punkt wzgl�dem lewego g�rnego rogu wzorca  - je�li stosujemy zestaw wzorc�w mo�emy poda� odpowiadajaca mu liczb�
;                                                    par wsp�rz�dnych lub jedn� wsp�ln� par� wsp�rz�dnych, wsp�rz�dne oddzielamy znakami "," a poszczeg�lne pary znakami ";"
;       
;       PRZYK�ADY
;       "50, 60"
;       "0, 0, 800, 600 | 10, 15"
;       "37,200 | 10,15 ; 13,10 ; 14,27"
;       "| ; 25,20 ; 30,50 ; ; 20,25"               uwaga: w przypadku outputCords pomini�te elementy zostan� zast�pione warto�ci� pierwszego elementu,
;                                                          je�li pierwszy element zostanie pomini�ty przyjmie on warto�� domy�ln� (topLeft)
;
;-> searchSet [string]:           (opcjonalna) zmienna zawiera ci�g standardowych ustawie� wyszukiwania dla funkcji PixelSearch
;                                 uwaga: poni�ej zamieszczono tylko skr�towe informacje - pe�en opis: http://ahkscript.org/docs/commands/PixelSearch.htm
;
;       Domy�lna warto��:         "0 | fast"
;       Schemat ci�gu:            "variation | instances | trans | searchDirection | lineDelim | coordDelim"
;       Obja�nienie:              variation        - liczba dopuszczalnych wariacji (odcieni) ka�dej z warto�ci RGB - dozwolone warto�ci: 0-255
;                                 mode             - tryb wyszukiwania - dozwolone warto�ci: fast, slow, RGB
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
;       arrayName["coord"]*       - wsp�rz�dne punktu, w kt�rym znaleziono piksel danego koloru (lub wsp�rz�dne zmodyfikowane przez parametr outputCoords)
;       arrayName["color"]*       - znaleziony kolor
;
;       *elementy oznaczone gwiazdk� b�d� dost�pne tylko je�li funkcja zaliczy trafienie
;
;********************************************************************************************************************************************************************
;
;   UWAGA: Je�li pozostawisz wszstkie warto�ci jako domy�lne wynik dzia�ania funkcji b�dzie podobny do zwyk�ego PixelSearch
;
;********************************************************************************************************************************************************************
;********************************************************************************************************************************************************************

;#Include libs\Gdip.ahk
;#Include libs\Gdip_ImageSearch.ahk

multiPixelSearch(colorSet, inCoords, variations = 0, repeatSet = "")
{
    global botMode
    result := [] ; zainicjowanie tablicy wynik�w
    
    ;##### USTAWIENIA DOMY�LNE #####
    
    repeatMax := 1
    repeatPeriod := 500
    
    winName := "BlueStacks App Player"
    clientW := 868
    clientH := 720
    gameW := clientW
    gameH := 672
    
    ;##### WCZYTYWANIE USTAWIE� #####
    
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
    Loop ; p�tla powtarza wyszukiwanie zadana ilo�� razy (lub przerywa gdy trafi)
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