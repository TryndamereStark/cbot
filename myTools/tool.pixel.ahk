CoordMode, Pixel, Client
CoordMode, Mouse, Client
CoordMode, Caret, Client

pxcolor := ""
x := 0
y := 0
fpixelSearch()
{
    global pxcolor
    global x
    global y
	PixelSearch, Px, Py, x, y, x, y, pxcolor, 5, Fast
	if ErrorLevel
		MsgBox, That color was not found in the specified region.
	else
		MsgBox, A color within 5 shades of variation was found at X%Px% Y%Py%.
}
fpixelGetColor()
{
    global pxcolor
    global x
    global y
    MouseGetPos, x, y
    PixelGetColor, pxcolor, %x%, %y%
    MsgBox The color at the current cursor position (%x%x%y%) is %pxcolor%.
    WinSet, AlwaysOnTop, On, tool.pixel.ahk
}
go()
{
    MouseMove 550, 290
}

home::fpixelGetColor()
end::fpixelSearch()
Pgdn::go()