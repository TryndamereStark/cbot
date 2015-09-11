txt := Object()
setLanguage()
{
    global
    langPath := "data\languages\" lang ".txt"
    Loop, read, %langPath%
    {
        if(A_LoopReadLine != "")
        {
            singleFound := StrSplit(A_LoopReadLine, "=", " ")
            varName := singleFound[1]
            txt[varName] := singleFound[2]
            TXT_%varName% := txt[varName]
        }
    }
}