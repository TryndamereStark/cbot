AutoItSetOption ("MouseCoordMode", 2)
AutoItSetOption ("PixelCoordMode", 2)

AdlibRegister ( "watchCursor", 100 )

While 1
    Sleep(100)
WEnd

Func watchCursor()
$coords = MouseGetPos()
ToolTip($coords[0] & 'x' & $coords[1])
EndFunc