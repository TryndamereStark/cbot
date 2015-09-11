Gdip_PixelSearch(pBitmap, ByRef x, ByRef y, inCoords, inARGB, variations = 0)
{
    inCoords := StrSplit(inCoords, ",", " ")
    if(inCoords._MaxIndex() = 4)
    {
        x1 := inCoords[1]
        y1 := inCoords[2]
        x2 := inCoords[3]
        y2 := inCoords[4]
    }
    else if(inCoords._MaxIndex() = 2)
    {
        x1 := inCoords[1]
        y1 := inCoords[2]
        x2 := x1
        y2 := y1
    }
    else
        return -1
    
    SetFormat, IntegerFast, hex
    R := "0x" SubStr(inARGB, 5, 2)
    G := "0x" SubStr(inARGB, 7, 2)
    B := "0x" SubStr(inARGB, 9, 2)
    SetFormat, IntegerFast, d
    
    x := x1
    Loop
    {
        if(x > x2)
            return 0
        y := y1
        Loop
        {
            if(y > y2)
                break
            ;MouseMove %x%, %y%
            
            SetFormat, IntegerFast, hex
            outARGB := Gdip_GetPixel(pBitmap, x, y)
            SetFormat, IntegerFast, d
            
            if(inARGB = outARGB)
                return 1
            else
            {
                SetFormat, IntegerFast, hex
                fR := "0x" SubStr(outARGB, 5, 2)
                fG := "0x" SubStr(outARGB, 7, 2)
                fB := "0x" SubStr(outARGB, 9, 2)
                SetFormat, IntegerFast, d
                if(R >= fR - variations  AND R <= fR + variations AND G >= fG - variations  AND G <= fG + variations AND B >= fB - variations  AND B <= fB + variations)
                    return 1
            }
            y++
        }
        x++
    }
}