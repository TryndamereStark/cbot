Right::
curX++
myMove(cells[curY,curX])
return

Left::
curX--
myMove(cells[curY,curX])
return

Up::
curY--
myMove(cells[curY,curX])
return

Down::
curY++
myMove(cells[curY,curX])
return

Numpad1::
compare("patterns\test.png", cells[curY,curX], 0, 1, 10)
guiBar("Zapisano element", "success")
return

Numpad2:: 
compare("patterns\test.png", cells[curY,curX], 0, 2, 10)
guiBar("Zapisano element", "success")
return

Numpad3::
compare("patterns\test.png", cells[curY,curX], 0, 3, 10)
guiBar("Zapisano element", "success")
return