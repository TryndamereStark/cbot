Gdip_CheckPixel(pBitmap, inARGB, ByRef outARGB, x, y, variations = 0)
{
    SetFormat, IntegerFast, hex
    R := "0x" SubStr(inARGB, 5, 2)
    G := "0x" SubStr(inARGB, 7, 2)
    B := "0x" SubStr(inARGB, 9, 2)
    
    outARGB := Gdip_GetPixel(pBitmap, x, y)
    
    fR := "0x" SubStr(outARGB, 5, 2)
    fG := "0x" SubStr(outARGB, 7, 2)
    fB := "0x" SubStr(outARGB, 9, 2)
    
    SetFormat, IntegerFast, d
    
    if(inARGB = outARGB)
        return true
    else if(R >= fR - variations  AND R <= fR + variations AND G >= fG - variations  AND G <= fG + variations AND B >= fB - variations  AND B <= fB + variations)
        return true
    else
        return false
}