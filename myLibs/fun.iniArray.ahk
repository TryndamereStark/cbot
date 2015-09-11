;funkcja zczytuje wszystkie zmienne dla danej etykiety do tablicy: result[i, "name"] oraz result[i, "value"]
iniArray(iniPath, iniLabel, iniDefault = 0)
{
    iniVars := Object()
    start := false
    
    i := 1
    Loop, Read, %iniPath%
    {
        line := Trim(A_LoopReadLine, " ")
        if(SubStr(line, 1, 1) != ";" AND line != "")
        {
            if(SubStr(line, 1, 1) = "[" AND start = false)
            {
                StringGetPos, pos, line, %iniLabel%,, 1
                if ErrorLevel
                    continue
                else
                    start := true
            }
            else if(SubStr(line, 1, 1) = "[" AND start = true)
                break
            else if(SubStr(line, 1, 1) = "[")
                continue
            else if(start = true)
            {
                singleVar := StrSplit(line, "=", " ")
                iniVars[i, "name"] := singleVar[1]
                if(singleVar[2] != "")
                    iniVars[i, "value"] := singleVar[2]
                else
                    iniVars[i, "value"] := iniDefault
                i++
            }
        }
    }
    return iniVars
}
