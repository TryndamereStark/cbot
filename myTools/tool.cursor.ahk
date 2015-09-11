CoordMode, Pixel, Client
CoordMode, Mouse, Client
CoordMode, Caret, Client

#Persistent
SetTimer, WatchCursor, 100
return

WatchCursor:
MouseGetPos, xpos, ypos 
ToolTip, %xpos%x%ypos%
return