hideBS()
{
    ; global maximalized
    ; WinSet, AlwaysOnTop, On, BlueStacks App Player
    ; posBeforeX := 10
    ; posBeforeY := 10
    ; posAfterX := 0 ;-880
    ; posAfterY := 0
    
    ; WinActivate, BlueStacks App Player
    ; WinGetPos, winPosX, winPosY, width, height, BlueStacks App Player
    
    ; if(winPosX != posBeforeX AND winPosY != posBeforeY)
    ; {
        ; WinSet, AlwaysOnTop, On, BlueStacks App Player
        ; WinMove, BlueStacks App Player,, %posBeforeX%, %posBeforeY%
        ; WinActivate, BlueStacks App Player
        ; if(maximalized = 1)
            ; guiMain("move")
        ; guiBar(,,"move")
    ; }
    ; Else
    ; {
        ; WinSet, AlwaysOnTop, On, BlueStacks App Player
        ; WinMove, BlueStacks App Player,, %posAfterX%, %posAfterY% 
        ; WinSet, ExStyle, 0x00000008L, BlueStacks App Player
        ; WinActivate, BlueStacks App Player
        ; if(maximalized = 1)
            ; guiMain("move")
        ; guiBar(,,"move")
    ; }
}