refreshGui()
{
    global
    Gui main: Submit, NoHide
    saveSettings()
    guiMain("show")
}
Goto Next

;###############################################################################
CBotMain:
    if(maximalized = 1)
    {
        maximalized := 0
        Gui main: Submit
        saveSettings()
    }
    else
    {
        guiMain("show")
        maximalized := 1
        guiBar(txt["MENU_OPEN"])
    }
    Return
   
;###############################################################################   
Refresh:
    refreshGui()
    Return
  
;###############################################################################  
ReloadConfig:
    Gui main: Submit, NoHide
    IniWrite, %config%, data\settings.ini, PATHS, config
    readGeneralConfig()
    readStrategyConfig()
    setLanguage()
    setGuiVars()
    guiMain("show")
    Return
    
;###############################################################################  
ReloadLayout:
    Gui main: Submit, NoHide
    IniWrite, %layout%, data\settings.ini, PATHS, layout
    readGeneralConfig()
    readStrategyConfig()
    setLanguage()
    setGuiVars()
    guiMain("show")
    Return

;###############################################################################
HideShow:
    if(hideGui = 1)
    {
        guiWidth := 868
        hideGui := 0
        GuiControl Bar: , hideShowIco, data\ico\hide.png
        placeGuiElement(0, 672, barPosX, barPosY)
    }
    else
    {
        guiWidth := 92
        hideGui := 1
        GuiControl Bar: , hideShowIco, data\ico\show.png
        placeGuiElement(385, 672, barPosX, barPosY)
    }
    Gui Bar: Show, W%guiWidth% H%guiHeight% X%barPosX% Y%barPosY% NA
    Return
    
;###############################################################################
uiMove:
    if(A_GuiControlEvent = "Normal")
        PostMessage, 0xA1, 2,,, A 
    Else
        WinActivate BlueStacks App Player
    Return

;###############################################################################
EditStrategy:
    IfExist, strategy\pro\%troopsFile%.ini
        Run, strategy\pro\%troopsFile%.ini
    Else
        MsgBox % txt["SELECT_STRATEGY"] "!"
    Return
    
;###############################################################################
EditStrategy1:
    IfExist, strategy\free_1.ini
        Run, strategy\free_1.ini
    Else
        MsgBox % txt["FILE_ERR"] " free_1.ini"
    Return
    
;###############################################################################
EditStrategy2:
    IfExist, strategy\free_2.ini
        Run, strategy\free_2.ini
    Else
        MsgBox % txt["FILE_ERR"] " free_2.ini"
    Return
    
;###############################################################################
EditStrategy3:
    IfExist, strategy\free_3.ini
        Run, strategy\free_3.ini
    Else
        MsgBox % txt["FILE_ERR"] " free_3.ini"
    Return

;###############################################################################
ClearLog:
    FileDelete, log\fullLog.txt
    GuiControl Main: , liveLog, 
    Return   

;###############################################################################    
LogIn:
    Gui main: Submit, NoHide
    if(cbot_name != "" AND cbot_pass != "")
    {
        saveSettings()
        authorization("manual")
    }
    if(authorized["status"] = true)
    {
        GuiControl Main: Hide, nameDescription
        GuiControl Main: Hide, passDescription
        GuiControl Main: Hide, cbot_name
        GuiControl Main: Hide, cbot_pass
        GuiControl Main: Hide, logInButton
        Gui Main: Font, s8 cFF0000 Verdana
        GuiControl Main: Text, nameTextFiled, %cbot_name%
        GuiControl Main: Text, profileTextFiled, %TXT_ACCOUNT%: %account%
        GuiControl Main: Show, nameTextFiled
        GuiControl Main: Show, profileTextFiled
        GuiControl Main: Show, logOutButton
    }
    Return
    
;###############################################################################
LogOut:
    authorized["status"] := false
    cbot_name := 0
    cbot_pass := 0
    writeGeneralConfig()
    GuiControl Main: Show, nameDescription
    GuiControl Main: Show, passDescription
    GuiControl Main: Show, cbot_name
    GuiControl Main: Show, cbot_pass
    GuiControl Main: Show, logInButton
    GuiControl Main: Hide, nameTextFiled
    GuiControl Main: Hide, profileTextFiled
    GuiControl Main: Hide, logOutButton
    Return

;###############################################################################
Www:
    Run, http://runcbot.com
    Return
        
;###############################################################################
WebsiteProPL:
    Run, http://runcbot.com/kontopro
    Return
    
;###############################################################################
WebsiteDonationsPL:
    Run, http://runcbot.com/kontopro#dotacje
    Return
    
;###############################################################################
WebsitePro:
    Run, http://runcbot.com/en/proaccount
    Return
    
;###############################################################################
WebsiteDonations:
    Run, http://runcbot.com/en/proaccount#donations
    Return
    
;###############################################################################
SetCoords:
    WinActivate, BlueStacks App Player
    guiBar(TXT_SELECT_BUILDING "...")
    KeyWait, LButton, D
    MouseGetPos, PosX, PosY
    %A_GuiControl% := PosX "," PosY
    GuiControl Buildings: Text, et%A_GuiControl%, OK
    guiBar(TXT_BUILDING_POS_ADDED " (" posTH ")")
    Return  

;###############################################################################
ClearCoords:
    for index, value in posNames
    {
        %value% := 0
        GuiControl Buildings: Text, et%value%, ?
    }
    guiBar(TXT_BUILDINGS_POS_CLEARED)
    Return 
    
;###############################################################################
SaveCoords:
    Gui Buildings: Submit
    if(resourcesRadio1 = 1)
        resourcesAuto := 1
    else
        resourcesAuto := 0
    writeGeneralConfig()
    readGeneralConfig()
    buildingSetOpen := 0
    guiBar(TXT_BUILDINGS_POS_SAVED)
    Return  

;###############################################################################
AddUpgrades:
    WinActivate, BlueStacks App Player
    Gui Upgrades: Default
    if(A_GuiControl = "addUpgrades")
        guiBar(TXT_UPGRADES_BAR1 "...")
    else
    {
        last := LV_GetCount()
        LV_Delete(last)
        guiBar(TXT_UPGRADES_BAR2 "...")
    }
    Loop
    {
        KeyWait, LButton, D
        MouseGetPos, PosX, PosY
        field := PosX "," PosY
        IfWinActive, BlueStacks App Player
            active := true
        Else
            active := false
        if(PosX >= 0 AND PosX <= 868 AND PosY >= 0 AND PosY <= 672 AND active = true)
        {
            LV_Add(, field)
            KeyWait, LButton, U
            guiBar(TXT_UPGRADES_BAR3 "... (" A_Index " " TXT_UPGRADES_BAR4 ")")
        }
        else
            break
    }
    Return
    
;###############################################################################
EndUpgrades:
    guiBar(TXT_UPGRADES_BAR5)
    Return
    
;###############################################################################
ClearUpgrades:
    Gui Upgrades: Default
    LV_Delete()
    guiBar(TXT_UPGRADES_BAR6)
    Return
    
;###############################################################################
SaveUpgrades:
    Gui Upgrades: Default
    last := LV_GetCount()
    upgrades := ""
    Loop %last%
    {
        LV_GetText(oneUpgrade, A_Index)
        if(A_Index < last)
            upgrades := upgrades oneUpgrade ";"
        else
            upgrades := upgrades oneUpgrade
    }
    writeGeneralConfig()
    readGeneralConfig()
    guiBar(TXT_UPGRADES_BAR7)
    guiUpgrades("stop")
    Return

;###############################################################################
OpenBuildingsSet:
    buildingSetOpen := 1
    maximalized := 0
    Gui main: Submit
    saveSettings()
    zoomOut()
    guiBuildings()
    Return
    
;###############################################################################
OpenUpgradesSet:
    upgradesSetOpen := 1
    maximalized := 0
    Gui main: Submit
    saveSettings()
    zoomOut()
    guiUpgrades()
    Return
  
;###############################################################################  
AddConfig:
    InputBox, config, CBot - %TXT_INPUT_CONFIG_TITLE%, %TXT_INPUT_CONFIG_DESCRIPTION%:,,250, 150
    if !ErrorLevel
    {
        GuiControl main: , config, %config%||
        refreshGui()
    }
    Return
    
;###############################################################################  
RemoveConfig:
    if(config != "default")
    {
        Gui main: Submit, NoHide
        FileDelete, configs\%config%.ini
        IniWrite, default, data\settings.ini, PATHS, config
        readGeneralConfig()
        readStrategyConfig()
        setLanguage()
        setGuiVars()
        guiMain("show")
    }
    Return
    
;###############################################################################  
AddLayout:
    InputBox, layout, CBot - %TXT_INPUT_LAYOUT_TITLE%, %TXT_INPUT_LAYOUT_DESCRIPTION%:,,250, 150
    if !ErrorLevel
    {
        GuiControl main: , layout, %layout%||
        refreshGui()
    }
    Return
    
;###############################################################################  
RemoveLayout:
    if(layout != "default")
    {
        Gui main: Submit, NoHide
        FileDelete, layouts\%layout%.ini
        IniWrite, default, data\settings.ini, PATHS, layout
        readGeneralConfig()
        readStrategyConfig()
        setLanguage()
        setGuiVars()
        guiMain("show")
    }
    Return
 
;###############################################################################  
FilesFoundBases:
    Run, log\screenshots_found
    Return

;############################################################################### 
FilesLootGained:
    Run, log\screenshots_scores
    Return

;############################################################################### 
FilesCriticalErrors:
    Run, log\screenshots_critical
    Return

;############################################################################### 
FilesCustom:
    Run, screenshots
    Return

;############################################################################### 
FilesMainFolder:
    Run, %A_ScriptDir%
    Return

;############################################################################### 
FilesFullLog:
    Run, log\fullLog.txt
    Return
    
;############################################################################### 
FilesCalibration:
    Run, data\calibration.ini
    Return

;############################################################################### 
FilesStrategies:
    Run, strategy
    Return

;############################################################################### 
FilesConfigs:
    Run, configs
    Return

;############################################################################### 
FilesLayouts:
    Run, layouts
    Return
    
;###############################################################################
ExitAll:
    Process, Close, ErrorsAgent.exe
    ExitApp
    Return
    
Next: