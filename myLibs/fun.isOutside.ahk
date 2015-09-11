; Funkcja oblicz parametry dla równania prostej:
line(x1, y1, x2, y2)
{
    params := Object()
    params["a"] := (y1-y2)/(x1-x2)
    params["b"] := y1-((y1-y2)/(x1-x2))*x1
    return params
}

; Parametry a i b równania prostej dla linni środkowych:
l1 := line(170, 314, 434, 115)
l2 := line(434, 115, 700, 314)
l3 := line(170, 314, 434, 510)
l4 := line(434, 510, 700, 314)

; Parametry a i b równania prostej dla linni zewnętrznych:
z1 := line(20, 310, 434, 0)
z2 := line(434, 0, 848, 310)
z3 := line(20, 310, 434, 620)
z4 := line(434, 620, 848, 310)

isOutside(coords)
{
    global l1, l2, l3, l4
    
    coord := StrSplit(coords, ",", " ")
    ;MsgBox % coords " | " coord[1] " | " coord[2]
    
    ; Obliczenie równań prostych dla kazdej linii z podanymi współrzednymi:
    sub1 := coord[2] - l1["a"] * coord[1] - l1["b"]
    sub2 := coord[2] - l2["a"] * coord[1] - l2["b"]
    sub3 := coord[2] - l3["a"] * coord[1] - l3["b"]
    sub4 := coord[2] - l4["a"] * coord[1] - l4["b"]
    
    ;MsgBox % sub1 " | " sub2 " | " sub3 " | " sub4
    
    if(sub1 < 0 OR sub2 < 0 OR sub3 > 0 OR sub4 > 0)
        return true
    else
        return false
}

spr(x, y, nr)
{
    global z1, z2, z3, z4
    result := y - z%nr%["a"] * x - z%nr%["b"]
    return result
}

calcA2(a1)
{
    return -(1/a1)
}

calcB2(a1, x, y)
{
    return y + (1 / a1) * x
}

point(x,y,nr)
{
    global z1, z2, z3, z4
    result := Object()
    
    a1 := z%nr%["a"]
    b1 := z%nr%["b"]
    a2 := calcA2(a1)
    b2 := calcB2(a1, x, y)
    
    result["x"] := (b2 - b1) / (a1 - a2)
    result["y"] := a1 * result["x"] + b1
    
    return result
}

Sqr(a)
{
    return a * a
}

findClosest(coords)
{
    coord := StrSplit(coords, ",", " ")
    x := coord[1]
    y := coord[2]
    
    point1 := point(x,y,1)
    point2 := point(x,y,2)
    point3 := point(x,y,3)
    point4 := point(x,y,4)
    
    distance1 := Sqrt(Sqr(x - point1["x"]) + Sqr(y - point1["y"]))
    distance2 := Sqrt(Sqr(x - point2["x"]) + Sqr(y - point2["y"]))
    distance3 := Sqrt(Sqr(x - point3["x"]) + Sqr(y - point3["y"]))
    distance4 := Sqrt(Sqr(x - point4["x"]) + Sqr(y - point4["y"]))
    
    closest := 1
    if(distance2 < distance1)
        closest := 2
    else if((distance3 < distance%closest%))
        closest := 3
    else if((distance4 < distance%closest%))
        closest := 4
        
    if(point%closest%["y"] > 560)
    {
        point%closest%["x"] := 370
        point%closest%["y"] := 560
    }
    result := point%closest%["x"] "," point%closest%["y"]
    return result
}

showLine(a, b)
{
    x := 0
    Loop 
    {
        if(x <= 868)
        {
            y := a * x + b
            myMove(x "," y)
        }
        x += 10
    }
}