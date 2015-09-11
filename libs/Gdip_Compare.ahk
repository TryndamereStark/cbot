compare(imgPath, coords, arrayDepth = 2, cellSize = 2, ByRef percentage = 6, ByRef cellX = "", ByRef cellY = "", hits = 1)
{
    global disposables
    global switch
    global hBMoOrg
    global hBMoCopy
    cellW := 19
    cellH := 14.25
    hit := 0
    switch := arrayDepth
    
    pToken := Gdip_Startup()

    dibSection := getPixelsFromFile(imgPath)
    if(arrayDepth = 0)
    {
        dibSection2 := getPixelsFromScreen(coords, cellSize)
        pixels := dibSection.pBits
        pixels2 := dibSection2.pBits
        z := 0
        loop % dibSection.width * dibSection.height * 4
        {
            x := numget(pixels - 1, A_Index, "uchar") 
            y := numget(pixels2 - 1, A_Index, "uchar")
            z += abs(y - x)
        }
        result := z / (dibSection.width * dibSection.height * 3 * 255 / 100 )
        DeleteObject(hBMoOrg)
        DeleteObject(hBMoCopy)
        Gdip_Shutdown(pToken)
        
        if(result <= percentage)
        {
            percentage := result
            return 1
        }
        Else
        {
            percentage := result
            return 0
        }
    }
    else if(arrayDepth = 1)
    {
        unavailable := Trim(cellX, ",")
        for i, cell in coords
        {
            if i not in %unavailable% ; sprawdŸ czy bie¿¹cy nr komórki nie zosta³ ju¿ trafiony
            {
                dibSection2 := getPixelsFromScreen(cell, cellSize)
                pixels := dibSection.pBits
                pixels2 := dibSection2.pBits
                z := 0
                loop % dibSection.width * dibSection.height * 4
                {
                    x := numget(pixels - 1, A_Index, "uchar") 
                    y := numget(pixels2 - 1, A_Index, "uchar")
                    z += abs(y - x)
                }
                result := z / (dibSection.width * dibSection.height * 3 * 255 / 100 )
                if (result <= percentage)
                {
                    hit++ ; dodaje iloœæ trafieñ
                    if(hit = hits)
                    {
                        DeleteObject(hBMoOrg)
                        DeleteObject(hBMoCopy)
                        Gdip_Shutdown(pToken)
                    }
                    percentage := result
                    cell := StrSplit(cell, ",", " ") ; podzial wspolrzednych x,y na dwie pojedyncze x i y
                    cellX := cellX "," i
                    if(hit = 1)
                        out := cell[1] + 0.5 * cellW * cellSize "," cell[2]
                    else
                        out := out ";" cell[1] + 0.5 * cellW * cellSize "," cell[2]
                    if(hit = hits)
                        return out
                }
                DeleteObject(hBMoCopy)
            }
        }
        DeleteObject(hBMoOrg)
        DeleteObject(hBMoCopy)
        Gdip_Shutdown(pToken)
        if(hit > 0)
            return out
        else
            return "no match"
    }
    else if(arrayDepth = 2)
    {
        for i, row in coords
        {
            cellX := i
            for j, cell in row
            {
                cellY := j
                dibSection2 := getPixelsFromScreen(cell, cellSize)
                pixels := dibSection.pBits
                pixels2 := dibSection2.pBits
                z := 0
                loop % dibSection.width * dibSection.height * 4
                {
                    x := numget(pixels - 1, A_Index, "uchar") 
                    y := numget(pixels2 - 1, A_Index, "uchar")
                    z += abs(y - x)
                }
                result := z / (dibSection.width * dibSection.height * 3 * 255 / 100 )
                if (result <= percentage)
                {
                    DeleteObject(hBMoOrg)
                    DeleteObject(hBMoCopy)
                    Gdip_Shutdown(pToken)
                    percentage := result
                    return cell
                }
                DeleteObject(hBMoCopy)
            }
        }
        DeleteObject(hBMoOrg)
        DeleteObject(hBMoCopy)
        Gdip_Shutdown(pToken)
        return "no match"
    }

    Gdip_Shutdown(pToken)
    return % result
}
 
CreateDIBSection2(hDC, nW, nH, bpp = 32, ByRef pBits = "")
{
    dib := object()
    NumPut(VarSetCapacity(bi, 40, 0), bi)
    NumPut(nW, bi, 4)
    NumPut(nH, bi, 8)
    NumPut(bpp, NumPut(1, bi, 12, "UShort"), 0, "Ushort")
    NumPut(0,  bi,16)
    hbm := DllCall("gdi32\CreateDIBSection", "Uint", hDC, "Uint", &bi, "Uint", 0, "UintP", pBits, "Uint", 0, "Uint", 0)

    dib.hbm := hbm
    dib.pBits := pBits
    dib.width := nW
    dib.height := nH
    dib.bpp := bpp
    dib.header := header
    ;ReleaseDC(hDC)
    Return	dib
}
 
getPixelsFromFile(imageFile)
{
    global hBMoOrg
    global dibSection
    pBitmapFileOrg := Gdip_CreateBitmapFromFile(imageFile)
    hbmi := Gdip_CreateHBITMAPFromBitmap(pBitmapFileOrg)
    width := Gdip_GetImageWidth(pBitmapFileOrg)
    height := Gdip_GetImageHeight(pBitmapFileOrg)
     
    mDCo := CreateCompatibleDC()
    mDCi := CreateCompatibleDC()
    dibSection := CreateDIBSection2(mDCo, width, height)
    hBMoOrg := dibSection.hbm

    oBM := SelectObject(mDCo, hBMoOrg)
    iBM := SelectObject(mDCi, hbmi)

    DllCall("BitBlt", "Uint", mDCo, "int", 0, "int", 0, "int", width, "int", height, "Uint", mDCi, "int", 0, "int", 0, "Uint", 0x40000000 | 0x00CC0020)

    SelectObject(mDCo, oBM)
    DeleteDC(mDCi)
    DeleteDC(mDCo)
    Gdip_DisposeImage(pBitmapFileOrg)
    DeleteObject(hbmi)
    return dibSection
}
getPixelsFromScreen(coords, cellSize, save = 1)
{
    global botMode
    global switch
    global hBMoCopy
    coord := StrSplit(coords, ",", " ")
    
    winName := "BlueStacks App Player"
    clientW := 868
    clientH := 720
    cellW := 19
    cellH := 14.25
    coord[1] := coord[1] + 0.25 * cellW * cellSize
    coord[2] := coord[2] - 0.25 * cellH * cellSize
    imgW := cellW * 0.5 * cellSize
    imgH := cellH * 0.5 * cellSize
    
    WinGetPos, winX, winY, winW, winH, %winName%
    winBorder := (winW-clientW)/2
    if(botMode = 1)
    {
        wShiftX := winBorder + coord[1]
        wShiftY := winH - clientH - winBorder + coord[2]
    }
    else
    {
        winX := winX + winBorder + coord[1]
        winY := winY + (winH - clientH - winBorder) + coord[2]
    }
    
    if(botMode = 1)
    {
        WinGet, hwnd, , %winName%
        windowArea := Gdip_BitmapFromHWND(hwnd)
        bitmapScreen := Gdip_CloneBitmapArea(windowArea, wShiftX, wShiftY, imgW, imgH)
        Gdip_DisposeImage(windowArea)
    }
    else
        bitmapScreen := Gdip_BitmapFromScreen(winX "|" winY "|" gameW "|" gameH) 
        
    if(save = 1)
        Gdip_SaveBitmapToFile(bitmapScreen, "data\patterns\compare.png")

    
    hbmi := Gdip_CreateHBITMAPFromBitmap(bitmapScreen)
    width := Gdip_GetImageWidth(bitmapScreen)
    height := Gdip_GetImageHeight(bitmapScreen)
     
    mDCo := CreateCompatibleDC()
    mDCi := CreateCompatibleDC()
    dibSection := CreateDIBSection2(mDCo, width, height)
    hBMoCopy := dibSection.hbm

    oBM := SelectObject(mDCo, hBMoCopy)
    iBM := SelectObject(mDCi, hbmi)

    DllCall("BitBlt", "Uint", mDCo, "int", 0, "int", 0, "int", width, "int", height, "Uint", mDCi, "int", 0, "int", 0, "Uint", 0x40000000 | 0x00CC0020)

    SelectObject(mDCo, oBM)
    DeleteDC(mDCi)
    DeleteDC(mDCo)
    Gdip_DisposeImage(bitmapScreen)
    DeleteObject(hBMi)
    return dibSection
}