cells(area = "1,1,40,40")
{
    cell := Object()
    cellW := 9.5
    cellH := 7.125
    area := StrSplit(area, ",", " ")
    cellX := 54 + ((area[1] - 1) * cellW) + ((area[2] - 1) * cellW)
    cellY := 314 - ((area[1] - 1) * cellH) + ((area[2] - 1) * cellH)
    a := 1
    Loop
    {
        subcellX := cellX
        subcellY := cellY
        b := 1
        Loop
        {
            cell[a,b] := subcellX "," subcellY
            b++
            if(b > area[3])
                break
            subcellX += cellW
            subcellY -= cellH
        }
        a++
        if(a > area[4])
            break
        cellX += cellW
        cellY += cellH
    }
    return cell
}
circles(squareArray, startA, startB, loops)
{
    result := Object()
    n := 1
    Loop % loops
    {
        a1 := startA - (A_Index - 1)
        b1 := startB - (A_Index - 1)
        a2 := startA + 1 + (A_Index - 1)
        b2 := startB + 1 + (A_Index - 1)
        
        result[n] := squareArray[a1, b1]
        n++
        Loop % a2 - a1 - 1
        {
            result[n] := squareArray[a1 + A_Index, b1]
            n++
        }   
        result[n] := squareArray[a2, b1]
        n++
        Loop % b2 - b1 - 1
        {
            result[n] := squareArray[a2, b1 + A_Index]
            n++
        } 
        result[n] := squareArray[a2, b2]
        n++
        Loop % a2 - a1 - 1
        {
            result[n] := squareArray[a2 - A_Index, b2]
            n++
        } 
        result[n] := squareArray[a1, b2]
        n++
        Loop % b2 - b1 - 1
        {
            result[n] := squareArray[a1, b2 - A_Index]
            n++
        } 
    }
    return result
}