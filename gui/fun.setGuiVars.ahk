setGuiVars()
{
    global
    if(shutdownOnCritical = 1)
    {
        shutdownRadioYes := 1
        shutdownRadioNo := 0
    }
    else
    {
        shutdownRadioYes := 0
        shutdownRadioNo := 1
    }
    if(botMode = 1)
    {
        botModeRadioYes := 1
        botModeRadioNo := 0
    }
    else
    {
        botModeRadioYes := 0
        botModeRadioNo := 1
    }
    if(adds = 1)
    {
        addsRadioYes := 1
        addsRadioNo := 0
    }
    else
    {
        addsRadioYes := 0
        addsRadioNo := 1
    }
    if(livePreview = 1)
    {
        liveRadioYes := 1
        liveRadioNo := 0
    }
    else
    {
        liveRadioYes := 0
        liveRadioNo := 1
    }
    if(livePreviewSize = "S")
    {
        liveSizeRadioS := 1
        liveSizeRadioM := 0
        liveSizeRadioL := 0
        liveSizeRadioXL := 0
    }
    else if(livePreviewSize = "L")
    {
        liveSizeRadioS := 0
        liveSizeRadioM := 0
        liveSizeRadioL := 1
        liveSizeRadioXL := 0
    }
    else if(livePreviewSize = "XL")
    {
        liveSizeRadioS := 0
        liveSizeRadioM := 0
        liveSizeRadioL := 0
        liveSizeRadioXL := 1
    }
    else
    {
        liveSizeRadioS := 0
        liveSizeRadioM := 1
        liveSizeRadioL := 0
        liveSizeRadioXL := 0
    }
    if(showTrayMsg = 1)
    {
        showTrayMsgYes := 1
        showTrayMsgNo := 0
    }
    else
    {
        showTrayMsgYes := 0
        showTrayMsgNo := 1
    }
    if(searchType = "sum")
    {
        searchTypeRadioA := 0
        searchTypeRadioB := 0
        searchTypeRadioC := 1
    }
    else if(searchType = "any")
    {
        searchTypeRadioA := 0
        searchTypeRadioB := 1
        searchTypeRadioC := 0
    }
    else
    {
        searchTypeRadioA := 1
        searchTypeRadioB := 0
        searchTypeRadioC := 0
    }
    if(troopsFile = "free_1")
    {
        strategyRadioA := 1
        strategyRadioB := 0
        strategyRadioC := 0
        strategyRadioD := 0
    }
    else if(troopsFile = "free_2")
    {
        strategyRadioA := 0
        strategyRadioB := 1
        strategyRadioC := 0
        strategyRadioD := 0
    }
    else if(troopsFile = "free_3")
    {
        strategyRadioA := 0
        strategyRadioB := 0
        strategyRadioC := 1
        strategyRadioD := 0
    }
    else
    {
        strategyRadioA := 0
        strategyRadioB := 0
        strategyRadioC := 0
        strategyRadioD := 1
    }
    if(resourcesAuto = 1)
    {
        resourcesRadioYes := 1
        resourcesRadioNo := 0
    }
    else
    {
        resourcesRadioYes := 0
        resourcesRadioNo := 1
    }
    if(lsTarget = "ad")
    {
        lsTargetRadioDark := 0
        lsTargetRadioAir := 1
        lsTargetRadioMortar := 0
    }
    else if(lsTarget = "mortar")
    {
        lsTargetRadioDark := 0
        lsTargetRadioAir := 0
        lsTargetRadioMortar := 1
    }
    else
    {
        lsTargetRadioDark := 1
        lsTargetRadioAir := 0
        lsTargetRadioMortar := 0
    }
}
listFiles(directory, defaultFile = 0)
{
    files := ""
    Loop %directory%\*.*
    {
        SplitPath, A_LoopFileName , , , , outNameNoExt
        if(outNameNoExt = defaultFile)
            files := files outNameNoExt "||"
        else
            files := files outNameNoExt "|"
    }
    return files
}
setGuiVars()