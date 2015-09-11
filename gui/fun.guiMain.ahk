    guiMain(mode = "show")
{
    global
    
    ;STYLES!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    foptProMark := "s8 cEE0000 left normal"
    fontProMark := fontDisabled := "Verdana"
    foptDisabled := "s8 c777777 left normal"
    ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    
    if(mode = "show")
    {
        langList := listFiles("data\languages", lang)
        if(account = "PRO")
        {
            strategyList := listFiles("strategy\pro", troopsFile)
            configList := listFiles("configs", config)
            layoutList := listFiles("layouts", layout)
            
        }
        Gui main: Destroy
        Gui main: -Caption -DPIScale +LastFound +ToolWindow +Owner%BlueStacksID%
        Gui main: Color, 1B1321, FFFFFF
        Gui main: Margin, 0, 0
        WinSet, Transparent, 240
        
        ;*****VERSION_INFO*****************************************************************************************************
        Gui main: font, s8 cDC56D0 bold
        Gui main: Add, Text, x10 y35 r1 Left, v 1.7.7
        
        ;*****PRO_DONATE*****************************************************************************************************
        if(account != "PRO")
        {
            if(lang = "polski")
            {
                Gui main: Add, Picture, gWebsiteProPL x450 y15, data\ico\pro_pl.png
                Gui main: Add, Picture, gWebsiteDonationsPL x560 y15, data\ico\donate_pl.png
            }
            else
            {
                Gui main: Add, Picture, gWebsitePro x450 y15, data\ico\pro.png
                Gui main: Add, Picture, gWebsiteDonations x560 y15, data\ico\donate.png
            }
        }
        
        ;*****PROFIL*****************************************************************************************************
        if(authorized["status"] = false)
        {
            Gui main: font, s8 cDC56D0 normal
            Gui main: Add, Text, x680 y10 w40 r1 Right vnameDescription, %TXT_LOGIN%:
            Gui main: font, s7 normal
            Gui main: Add, Edit, x724 y7 w120 r1 Left vcbot_name
            Gui main: font, s8 normal
            Gui main: Add, Text, x680 y35 w40 r1 Right vpassDescription, %TXT_PASSWORD%:
            Gui main: font, s7 normal
            Gui main: Add, Edit, x724 y32 w95 r1 Left Password vcbot_pass
            Gui main: Add, Picture, gLogIn x824 y32 vlogInButton, data\ico\login.png
            Gui main: font, s9 bold Hidden
            Gui main: Add, Text, x680 y10 w135 r1 Hidden Right vnameTextFiled, %cbot_name%
            Gui main: font, s9 normal Hidden
            Gui main: Add, Text, x680 y30 w135 r1 Hidden Right vprofileTextFiled, %TXT_ACCOUNT%: %account%
            Gui main: Add, Picture, gLogOut x824 y7 Hidden vlogOutButton, data\ico\logout.png
        }
        else
        {
            Gui main: font, s8 cDC56D0 normal
            Gui main: Add, Text, x680 y10 w40 r1 Right Hidden vnameDescription, %TXT_LOGIN%:
            Gui main: font, s7 normal
            Gui main: Add, Edit, x724 y7 w120 r1 Left Hidden vcbot_name
            Gui main: font, s8 normal
            Gui main: Add, Text, x680 y35 w40 r1 Right Hidden vpassDescription, %TXT_PASSWORD%:
            Gui main: font, s7 normal
            Gui main: Add, Edit, x724 y32 w95 r1 Left Hidden Password vcbot_pass
            Gui main: Add, Picture, gLogIn x824 y32 Hidden vlogInButton, data\ico\login.png
            Gui main: font, s9 bold
            Gui main: Add, Text, x680 y10 w135 r1 Right vnameTextFiled, %cbot_name%
            Gui main: font, s9 normal
            Gui main: Add, Text, x680 y30 w135 r1 Right vprofileTextFiled, %TXT_ACCOUNT%: %account%
            Gui main: Add, Picture, gLogOut x824 y7 vlogOutButton, data\ico\logout.png
        }
        
        ;*****ZAK£ADKI*******************************************************************************************************
        Gui main: font, s8 cDDDDDD normal, Verdana
        Gui main: Add, Tab2, x10 y10 w848 h654 0x100, %TXT_FARMING%|%TXT_ADVANCED%|%TXT_INTERFACE%|%TXT_STATS%|%TXT_LOG%
        
        ;*****FARMING*****************************************************************************************************
        Gui main: Tab, %TXT_FARMING%
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x24 y50 w400 h140 cDC56D0, %TXT_PROFILES%
        if(account = "PRO")
        {
            Gui main: font, s8 cDDDDDD, Verdana
            Gui main: Add, Text, x49 y80, %TXT_SAVED_CONFIGS%:
            Gui main: font, c2E2138
            Gui main: Add, DropDownList, x49 y100 w200 r10 Center Sort gReloadConfig vconfig, %configList%
            Gui main: font, s7
            Gui main: Add, Button, x254 y100 w70 Center gAddConfig, %TXT_ADD%
            Gui main: Add, Button, x329 y100 w70 Center gRemoveConfig, %TXT_REMOVE%
            Gui main: font, s8 cDDDDDD, Verdana
            Gui main: Add, Text, x49 y130, %TXT_SAVED_LAYOUTS%:
            Gui main: font, c2E2138
            Gui main: Add, DropDownList, x49 y150 w200 r10 Center Sort gReloadLayout vlayout, %layoutList%
            Gui main: font, s7
            Gui main: Add, Button, x254 y150 w70 Center gAddLayout, %TXT_ADD%
            Gui main: Add, Button, x329 y150 w70 Center gRemoveLayout, %TXT_REMOVE%
        }
        else
        {
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x49 y80, %TXT_SAVED_CONFIGS%:
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x49 y100, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x79 y100, ----- default -----
            Gui main: Add, Text, x49 y130, %TXT_SAVED_LAYOUTS%:
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x49 y150, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x79 y150, ----- default -----
        }
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x24 y200 w400 h420 cDC56D0, %TXT_SEARCHING%
        Gui main: font, s8 cDC56D0, Verdana
        Gui main: Add, Checkbox, x49 y230 Checked%deadBases% vdeadBases, %TXT_DEAD_BASES% (%TXT_RESOURCES_IN_MINES%):
        Gui main: font, s8 cDDDDDD, Verdana
        Gui main: Add, Text, x49 y250 w80 r1 Left, %TXT_GOLD%:
        Gui main: Add, Text, x136 y250 w80 r1 Left, %TXT_ELIXIR%:
        Gui main: Add, Text, x223 y250 w80 r1 Left, %TXT_DARK%:
        Gui main: Add, Text, x330 y250 w80 r1 Left, %TXT_TROPHIES%:
        Gui main: font, c2e2138
        Gui main: Add, Edit, x49 y270 w70 r1 Left Number vdeadGold, %deadGold%
        Gui main: Add, Edit, x136 y270 w70 r1 Left Number vdeadElixir, %deadElixir%
        Gui main: Add, Edit, x223 y270 w70 r1 Left Number vdeadDark, %deadDark%
        Gui main: Add, Edit, x330 y270 w70 r1 Left Number vdeadTrophies, %deadTrophies%
        Gui main: font, s8 cDC56D0, Verdana
        Gui main: Add, Checkbox, x49 y300 Checked%usualBases% vusualBases, %TXT_USUAL_BASES% (%TXT_RESOURCES_IN_STORAGES%):
        Gui main: font, s8 cDDDDDD, Verdana
        Gui main: Add, Text, x49 y320 w80 r1 Left, %TXT_GOLD%:
        Gui main: Add, Text, x136 y320 w80 r1 Left, %TXT_ELIXIR%:
        Gui main: Add, Text, x223 y320 w80 r1 Left, %TXT_DARK%:
        Gui main: Add, Text, x330 y320 w80 r1 Left, %TXT_TROPHIES%:
        Gui main: font, c2e2138
        Gui main: Add, Edit, x49 y340 w70 r1 Left Number vusualGold, %usualGold%
        Gui main: Add, Edit, x136 y340 w70 r1 Left Number vusualElixir, %usualElixir%
        Gui main: Add, Edit, x223 y340 w70 r1 Left Number vusualDark, %usualDark%
        Gui main: Add, Edit, x330 y340 w70 r1 Left Number vusualTrophies, %usualTrophies%
        Gui main: font, s8 cDDDDDD, Verdana
        Gui main: Add, Text, x49 y375, %TXT_SEARCH_TYPE%:
        Gui main: font, cDC56D0
        Gui main: Add, Radio, x49 y395 w80 r1 Left vsearchTypeRadio1 Checked%searchTypeRadioA%, %TXT_SEARCH_ALL%
        Gui main: Add, Radio, x134 y395 w80 r1 Left vsearchTypeRadio2 Checked%searchTypeRadioB%, %TXT_SEARCH_ANY%
        Gui main: Add, Radio, x219 y395 w80 r1 Left vsearchTypeRadio3 Checked%searchTypeRadioC%, %TXT_SEARCH_SUM%
        Gui main: font, s8 cDDDDDD, Verdana
        Gui main: Add, Text, x49 y420, %TXT_DEAD_RECOGNITION%:
        Gui main: font, s8 cDC56D0, Verdana
        Gui main: Add, Checkbox, x49 y440 w170  Checked%checkStorages% vcheckStorages, %TXT_CHECK_STORAGES%
        Gui main: Add, Checkbox, x224 y440 w170  Checked%checkCollectors% vcheckCollectors, %TXT_CHECK_COLLECTORS%
        Gui main: font, s8 cDC56D0, Verdana
        Gui main: Add, Text, x49 y460 w300, ----------------------------------------------------------------------
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x34 y490 w200 r1 Right, %TXT_MY_TH%:
        Gui main: font, c2E2138
        Gui main: Add, DropDownList, x244 y486 w40 r10 Left vmyTH Choose%myTH%, 1|2|3|4|5|6|7|8|9|10
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x34 y515 w200 r1 Right, %TXT_MAX_TH%:
        Gui main: font, c2E2138
        Gui main: Add, DropDownList, x244 y511 w40 r10 Left vmaxTH Choose%maxTH%, 1|2|3|4|5|6|7|8|9|10
        Gui main: font, s8 cDDDDDD
        Gui main: Add, Text, x34 y540 w200 r1 Right, %TXT_EASY_TH%:
        Gui main: font, c2E2138
        Gui main: Add, DropDownList, x244 y536 w40 r10 Left vweakTH Choose%weakTH%, 1|2|3|4|5|6|7|8|9|10
        Gui main: font, cDC56D0
        Gui main: Add, Text, x295 y477 w20 r7 Left, |`n|`n|`n|`n|`n|`n|
        Gui main: Add, Text, x300 y479 w114 r1 Center, %TXT_WAIT_FOR%:
        Gui main: Add, Checkbox, x310 y500 Checked%waitForSpells% vwaitForSpells, %TXT_SPELLS%
        Gui main: Add, Checkbox, x310 y525 Checked%waitForKing% vwaitForKing, %TXT_KING%
        Gui main: Add, Checkbox, x310 y550 Checked%waitForQueen% vwaitForQueen, %TXT_QUEEN%
        Gui main: Add, Checkbox, x49 y580 Checked%thOutside% vthOutside, %TXT_TH_OUTSIDE_INFO%
        
        ;###################################################################################################################
        
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x444 y50 w400 h570 cDC56D0, %TXT_ATTACK%
        Gui main: Add, Picture, gRefresh x814 y70, data\ico\refresh.png
        Gui main: font, s8 cDC56D0, Verdana
        Gui main: Add, Checkbox, x469 y80 Checked%troopsOn% vtroopsOn, %TXT_SELECT_STRATEGY%:
        Gui main: font, cDC56D0
        Gui main: Add, Radio, x469 y106 w100 r1 Left vstrategyRadio1 Checked%strategyRadioA%, FREE 1:
        Gui main: Add, Radio, x469 y166 w100 r1 Left vstrategyRadio2 Checked%strategyRadioB%, FREE 2:
        Gui main: Add, Radio, x469 y226 w100 r1 Left vstrategyRadio3 Checked%strategyRadioC%, FREE 3:
        if(account = "PRO")
            Gui main: Add, Radio, x469 y286 w300 r1 Left vstrategyRadio4 Checked%strategyRadioD%, %TXT_PRO_STRATEGIES%:
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x469 y286, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x499 y286, %TXT_PRO_STRATEGIES%
        }
        Gui main: Add, Picture, gEditStrategy1 x810 y106, data\ico\edit.png
        troopsPreview("strategy\free_1.ini", 469, 126)
        Gui main: Add, Picture, gEditStrategy2 x810 y166, data\ico\edit.png
        troopsPreview("strategy\free_2.ini", 469, 186)
        Gui main: Add, Picture, gEditStrategy3 x810 y226, data\ico\edit.png
        troopsPreview("strategy\free_3.ini", 469, 246)
        Gui main: font, c2E2138
        if(account = "PRO")
            Gui main: Add, DropDownList, x469 y306 w300 r15 Center gRefresh vtroopsFilePro Sort, %strategyList%
        else
        {
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x469 y306 w300 r15 Left, ------------------------------------------------------------
        }
        Gui main: Add, Picture, gEditStrategy x810 y306, data\ico\edit.png
        if troopsFile not in free_1,free_2,free_3
            troopsPreview("strategy\pro\" troopsFile ".ini", 469, 336)
            
        Gui main: font, cDC56D0
        Gui main: Add, Text, x469 y370 w350 r1 Left, -----------------------------------------------------------------------------
        if(account = "PRO")
        {
            Gui main: Add, Checkbox, x469 y390 Checked%lsOn% vlsOn, %TXT_LIGHTNING%:
            Gui main: Add, Radio, x469 y415 w110 r1 Left vlsTargetRadio1 Checked%lsTargetRadioDark%, %TXT_DARK_DRILL%
            Gui main: Add, Radio, x589 y415 w110 r1 Left vlsTargetRadio2 Checked%lsTargetRadioAir%, %TXT_AIR_DEFENCE%
            Gui main: Add, Radio, x709 y415 w110 r1 Left vlsTargetRadio3 Checked%lsTargetRadioMortar%, %TXT_MORTAR%
            Gui main: font, cDDDDDD
            Gui main: Add, Text, x469 y444 w235 r1 Right, %TXT_DARK_MIN%:
            Gui main: font, c2e2138
            Gui main: Add, Edit, x714 y440 w60 r1 Left Number vdarkMin, %darkMin%
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x469 y390, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x499 y390, %TXT_LIGHTNING%:
            Gui main: Add, Text, x469 y415 w110 r1 Left, %TXT_DARK_DRILL%
            Gui main: Add, Text, x589 y415 w110 r1 Left, %TXT_AIR_DEFENCE%
            Gui main: Add, Text, x709 y415 w110 r1 Left, %TXT_MORTAR%
            Gui main: Add, Text, x469 y444 w235 r1 Right, %TXT_DARK_MIN%:
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x714 y444 w60 r1 Left, %TXT_PRO%
        }
        
        Gui main: font, cDC56D0
        Gui main: Add, Text, x469 y475 w350 r1 Left, -----------------------------------------------------------------------------
        Gui main: Add, Text, x469 y495 w350, %TXT_QUICK_FINISH%:
        Gui main: Add, Checkbox, x469 y520 Checked%oneStarMin% voneStarMin, %TXT_ONE_STAR%
        Gui main: Add, Checkbox, x469 y545 Checked%noDamage% vnoDamage, %TXT_NO_DAMEGE%:
        Gui main: font, c2e2138
        Gui main: Add, Edit, x714 y541 w30 r1 Left Number vnoDamageTime, %noDamageTime%
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x749 y545 w20, %TXT_SECOND%
        
        
        
        Gui main: font, s10 cFFB200
        Gui main: Add, Text, x0 y635 w868 r1 Center, %TXT_SETTINGS_SAVE_INFO%
        
        ;*****ADVANCED*****************************************************************************************************
        Gui main: Tab, %TXT_ADVANCED%
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x24 y50 w400 h280 cDC56D0, %TXT_ANNOUNCEMENTS%
        if(account = "PRO")
        {
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x49 y90 Checked%adds% vadds, %TXT_ANNOUNCEMENTS_GLOBAL%
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x49 y90, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x79 y90 w320 r1 Left, %TXT_ANNOUNCEMENTS_GLOBAL%:
        }
        if(account = "PRO")
            Gui main: font, s8 cDDDDDD, Verdana
        else
            Gui main: font, %foptDisabled%, %fontDisabled%
        Gui main: Add, Text, x49 y110 w350 r2 Left, %TXT_ANNOUNCEMENTS_GLOBAL_CONTENT%:
        if(account = "PRO")
        {
            Gui main: font, c2e2138
            Gui main: Add, Edit, x49 y145 w350 r5 Left vaddsMsg, %addsMsg%
        }
        else
        {
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, text, x49 y145 w350 r1 Left, ------------------------------------------------------------
        }
        if(account = "PRO")
        {
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x49 y235 Checked%request% vrequest, %TXT_REQUEST_ON%
            Gui main: font, s8 cDDDDDD, Verdana
            Gui main: Add, Text, x49 y255 w350 r2 Left, %TXT_REQUEST_CONTENT%:
            Gui main: font, c2e2138
            Gui main: Add, Edit, x49 y275 w350 r2 Left vrequestText, %requestText%
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x49 y235, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x79 y235, %TXT_REQUEST_ON%
            Gui main: Add, Text, x49 y255 w350 r2 Left, %TXT_REQUEST_CONTENT%:
            Gui main: Add, text, x49 y275 w350 r1 Left, ------------------------------------------------------------
        }
        
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x444 y50 w400 h280 cDC56D0, PUSHBULLET
        if(account = "PRO")
            Gui main: font, s8 cDDDDDD, Verdana
        else
            Gui main: font, %foptDisabled%, %fontDisabled%
        Gui main: Add, Text, x469 y90 w350 r3 Left, %TXT_PUSHBULLET_INFO%
        Gui main: Add, Text, x469 y140 w350 r1 Left, %TXT_PUSHBULLET_AUTH%:
        if(account = "PRO")
        {
        Gui main: font, c2e2138
        Gui main: Add, Edit, x469 y160 w350 r1 Left vpushbullet_mail, %pushbullet_mail%
        }
        else
        {
        Gui main: font, %foptDisabled%, %fontDisabled%
        Gui main: Add, text, x469 y160 w350 r5 Left, ------------------------------------------------------------
        }
        
        if(account = "PRO")
        {
            Gui main: font, cDC56D0
            Gui main: Add, Checkbox, x469 y200 Checked%pushFound% vpushFound, %TXT_NOTIFY_FOUND%
            Gui main: Add, Checkbox, x469 y230 Checked%pushLoot% vpushLoot, %TXT_NOTIFY_LOOT%
            Gui main: Add, Checkbox, x469 y260 Checked%pushCritical% vpushCritical, %TXT_NOTIFY_CRITICAL%
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x469 y200, %TXT_PRO%
            Gui main: Add, Text, x469 y230, %TXT_PRO%
            Gui main: Add, Text, x469 y260, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x499 y200, %TXT_NOTIFY_FOUND%
            Gui main: Add, Text, x499 y230, %TXT_NOTIFY_LOOT%
            Gui main: Add, Text, x499 y260, %TXT_NOTIFY_CRITICAL%
        }
        
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x24 y340 w400 h280 cDC56D0, %TXT_UPGRADES%
        if(account = "PRO")
        {
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x49 y370 Checked%upgradesOn% vupgradesOn, %TXT_UPGRADES_ON%
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Text, x49 y390 w350 r1, -------------------------------------------------------------------------------------------------------------
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Text, x49 y410 r1, %TXT_WALL_UPGRADES%:
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x49 y440 Checked%useGoldForWalls% vuseGoldForWalls, %TXT_USE_GOLD%
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x165 y440 Checked%useElixirForWalls% vuseElixirForWalls, %TXT_USE_ELIXIR%
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x281 y440 Checked%useElixirFirst% vuseElixirFirst, %TXT_ELIXIR_FIRST%
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Text, x49 y460 w350 r1, -------------------------------------------------------------------------------------------------------------
            Gui main: font, cDDDDDD
            Gui main: Add, Text, x34 y490 w200 r1 Right, %TXT_GOLD_MIN%:
            Gui main: font, c2e2138
            Gui main: Add, Edit, x244 y486 w70 r1 Left Number vminGold, %minGold%
            Gui main: font, cDDDDDD
            Gui main: Add, Text, x34 y520 w200 r1 Right, %TXT_ELIXIR_MIN%:
            Gui main: font, c2e2138
            Gui main: Add, Edit, x244 y516 w70 r1 Left Number vminElixir, %minElixir%
            Gui main: font, cDDDDDD
            Gui main: Add, Text, x34 y550 w200 r1 Right, %TXT_DARK_MIN%:
            Gui main: font, c2e2138
            Gui main: Add, Edit, x244 y546 w70 r1 Left Number vminDark, %minDark%
            Gui main: font, s8 c2e2138, Verdana
            Gui main: Add, Button, gOpenUpgradesSet x54 y580 w340 r1 Center, %TXT_SELECT_UPGRADES%
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x49 y370, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x79 y370, %TXT_UPGRADES_ON%
            Gui main: Add, Text, x49 y390 w350 r1, -------------------------------------------------------------------------------------------------------------
            Gui main: Add, Text, x49 y410 r1, %TXT_WALL_UPGRADES%:
            Gui main: Add, Text, x49 y440, %TXT_USE_GOLD%
            Gui main: Add, Text, x165 y440, %TXT_USE_ELIXIR%
            Gui main: Add, Text, x281 y440, %TXT_ELIXIR_FIRST%
            Gui main: Add, Text, x49 y460 w350 r1, -------------------------------------------------------------------------------------------------------------
            Gui main: Add, Text, x34 y490 w200 r1 Right, %TXT_GOLD_MIN%:
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x244 y490 w70 r1 Left, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x34 y520 w200 r1 Right, %TXT_ELIXIR_MIN%:
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x244 y520 w70 r1 Left, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x34 y550 w200 r1 Right, %TXT_DARK_MIN%:
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x244 y550 w70 r1 Left, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Button, gOpenUpgradesSet x54 y580 w340 r1 Center, %TXT_SELECT_UPGRADES%
        }
        
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x444 y340 w400 h280 cDC56D0, %TXT_BOOST%
        if(account = "PRO")
        {
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Text, x469 y370 r1, %TXT_BOOST_BARRACKS%:
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x469 y400 Checked%boostBar1% vboostBar1, 1
            Gui main: Add, Checkbox, x556 y400 Checked%boostBar2% vboostBar2, 2
            Gui main: Add, Checkbox, x643 y400 Checked%boostBar3% vboostBar3, 3
            Gui main: Add, Checkbox, x730 y400 Checked%boostBar4% vboostBar4, 4
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Text, x469 y430 r1, %TXT_BOOST_DARK_BARRACKS%:
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x469 y460 Checked%boostDarkBar1% vboostDarkBar1, 1
            Gui main: Add, Checkbox, x556 y460 Checked%boostDarkBar2% vboostDarkBar2, 2
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Text, x469 y490 r1, %TXT_OTHER%:
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Checkbox, x469 y520 Checked%boostKing% vboostKing, %TXT_KING%
            Gui main: Add, Checkbox, x556 y520 Checked%boostQueen% vboostQueen, %TXT_QUEEN%
            Gui main: Add, Checkbox, x643 y520 Checked%boostSpells% vboostSpells, %TXT_SPELLS%
            Gui main: font, s8 cDC56D0, Verdana
            Gui main: Add, Text, x469 y540 w350 r1, -------------------------------------------------------------------------------------------------------------
            Gui main: font, cDDDDDD
            Gui main: Add, Text, x454 y570 w200 r1 Right, %TXT_GEM_MIN%:
            Gui main: font, c2e2138
            Gui main: Add, Edit, x664 y566 w70 r1 Left Number vminGems, %minGems%
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x469 y370, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x499 y370 r1, %TXT_BOOST_BARRACKS%:
            Gui main: Add, Text, x469 y400, 1
            Gui main: Add, Text, x556 y400, 2
            Gui main: Add, Text, x643 y400, 3
            Gui main: Add, Text, x730 y400, 4
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x469 y430, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x499 y430 r1, %TXT_BOOST_DARK_BARRACKS%:
            Gui main: Add, Text, x469 y460, 1
            Gui main: Add, Text, x556 y460, 2
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x469 y490, %TXT_PRO%
            Gui main: font, %foptDisabled%, %fontDisabled%
            Gui main: Add, Text, x499 y490 r1, %TXT_OTHER%:
            Gui main: Add, Text, x469 y520, %TXT_KING%
            Gui main: Add, Text, x556 y520, %TXT_QUEEN%
            Gui main: Add, Text, x643 y520, %TXT_SPELLS%
            Gui main: Add, Text, x469 y540 w350 r1, -------------------------------------------------------------------------------------------------------------
            Gui main: Add, Text, x454 y570 w200 r1 Right, %TXT_GEM_MIN%:
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x664 y570 w70 r1, %TXT_PRO%
        }
        
        Gui main: font, s10 cFFB200, verdana
        Gui main: Add, Text, x0 y635 w868 r1 Center, %TXT_SETTINGS_SAVE_INFO%
        
        ;*****INTERFACE*****************************************************************************************************
        Gui main: Tab, %TXT_INTERFACE%
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x24 y50 w400 h280 cDC56D0, %TXT_GENERAL%
        Gui main: font, s8 cDDDDDD, Verdana
        Gui main: Add, Text, x34 y90 w250 r1 Right, %TXT_BACKGROUND_MODE%:
        Gui main: font, cDC56D0
        Gui main: Add, Radio, x294 y90 w50 r1 Left vbotModeRadio1 Checked%botModeRadioYes%, %TXT_YES%
        Gui main: Add, Radio, x344 y90 w50 r1 Left vbotModeRadio2 Checked%botModeRadioNo%, %TXT_NO%
        Gui main: font, s8 cDDDDDD
        Gui main: Add, Text, x34 y115 w250 r1 Right, %TXT_AUTOMATIC_SHUTDOWN%:
        Gui main: font, cDC56D0
        Gui main: Add, Radio, x294 y115 w50 r1 Left vshutdownRadio1 Checked%shutdownRadioYes%, %TXT_YES%
        Gui main: Add, Radio, x344 y115 w50 r1 Left vshutdownRadio2 Checked%shutdownRadioNo%, %TXT_NO%
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x34 y140 w250 r1 Right, %TXT_ANOTHER_DEVICE_TIME%:
        Gui main: font, c2e2138
        Gui main: Add, Edit, x294 y136 w40 r1 Left Number vanotherDeviceTime, %anotherDeviceTime%
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x339 y140 w30 r1 left, [%TXT_SECOND%]
        if(account = "PRO")
            Gui main: font, s8 cDDDDDD
        Else
            Gui main: font, %foptDisabled%, %fontDisabled%
        Gui main: Add, Text, x34 y165 w250 r1 Right, %TXT_PREVIEW_WIN%:
        if(account = "PRO")
        {
            Gui main: font, cDC56D0
            Gui main: Add, Radio, x294 y165 w50 r1 Left vliveRadio1 Checked%liveRadioYes%, %TXT_YES%
            Gui main: Add, Radio, x344 y165 w50 r1 Left vliveRadio2 Checked%liveRadioNo%, %TXT_NO%
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x294 y165, %TXT_PRO%
        }
        if(account = "PRO")
            Gui main: font, s8 cDDDDDD
        Else
            Gui main: font, %foptDisabled%, %fontDisabled%
        Gui main: Add, Text, x34 y190 w250 r1 Right, %TXT_PREVIEW_WIN_SIZE%:
        if(account = "PRO")
        {
            Gui main: font, cDC56D0
            Gui main: Add, Radio, x294 y190 w30 r1 Left vliveSizeRadio1 Checked%liveSizeRadioS%, S
            Gui main: Add, Radio, x324 y190 w30 r1 Left vliveSizeRadio2 Checked%liveSizeRadioM%, M
            Gui main: Add, Radio, x354 y190 w30 r1 Left vliveSizeRadio3 Checked%liveSizeRadioL%, L
            Gui main: Add, Radio, x384 y190 w35 r1 Left vliveSizeRadio4 Checked%liveSizeRadioXL%, XL
        }
        else
        {
            Gui main: font, %foptProMark%, %fontProMark%
            Gui main: Add, Text, x294 y190, %TXT_PRO%
        }
        Gui main: font, s8 cDDDDDD
        Gui main: Add, Text, x34 y215 w250 r1 Right, %TXT_TRAY_MSG%:
        Gui main: font, cDC56D0
        Gui main: Add, Radio, x294 y215 w50 r1 Left vshowTrayMsg1 Checked%showTrayMsgYes%, %TXT_YES%
        Gui main: Add, Radio, x344 y215 w50 r1 Left vshowTrayMsg2 Checked%showTrayMsgNo%, %TXT_NO%
        Gui main: font, s8 cDDDDDD
        Gui main: Add, Text, x34 y240 w250 r1 Right, %TXT_LANGUAGE%:
        Gui main: Add, DropDownList, x294 y236 w100 r10 Center gRefresh vlang Sort, %langList% ;gRefresh
        Gui main: font, s8 cDC56D0, Verdana
        ;Gui main: Add, Checkbox, x49 y265 Checked%autoUpdates% vautoUpdates, %TXT_AUTO_UPDATES%
        Gui main: Add, Button, gOpenBuildingsSet x54 y290 w340 r1 Center, %TXT_BUILDINGS_POSITION_BUTTON%
        
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x24 y340 w400 h280 cDC56D0, %TXT_FILES%
        Gui main: font, s8 cDC56D0, Verdana
        Gui main: Add, Button, gFilesMainFolder x54 y380 w165 r1 Center, %TXT_FILES_MAIN_FOLDER%
        Gui main: Add, Button, gFilesStrategies x229 y380 w165 r1 Center, %TXT_FILES_STRATEGIES%
        Gui main: Add, Button, gFilesFullLog x54 y420 w165 r1 Center, %TXT_FILES_FULL_LOG%
        Gui main: Add, Button, gFilesCalibration x229 y420 w165 r1 Center, %TXT_FILES_CALIBRATION%
        Gui main: Add, Button, gFilesConfigs x54 y460 w165 r1 Center, %TXT_FILES_CONFIGS%
        Gui main: Add, Button, gFilesLayouts x229 y460 w165 r1 Center, %TXT_FILES_LAYOUTS%
        Gui main: Add, Text, x49 y500 w350 Center, %TXT_FILES_SCREENSHOTS%:
        Gui main: Add, Button, gFilesFoundBases x54 y535 w165 r1 Center, %TXT_FILES_FOUND_BASES%
        Gui main: Add, Button, gFilesLootGained x229 y535 w165 r1 Center, %TXT_FILES_LOOT_GAINED%
        Gui main: Add, Button, gFilesCriticalErrors x54 y575 w165 r1 Center, %TXT_FILES_CRITICAL_ERRORS%
        Gui main: Add, Button, gFilesCustom x229 y575 w165 r1 Center, %TXT_FILES_CUSTOM%
        
        
        ;########################################################################################
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: font,, Audiowide
        Gui main: Add, GroupBox, x444 y50 w400 h570 cDC56D0, %TXT_TOOLS%
        Gui main: font, s10 cDDDDDD, Verdana
        Gui main: Add, Text, x469 y120 w350 r2 Center, %TXT_AD1%
        Gui main: Add, Text, x469 y170 w350 r2 Center, %TXT_AD2%
        Gui main: Add, Text, x469 y220 w350 r2 Center, %TXT_AD3%
        Gui main: font, s20 cDDDDDD bold, Verdana
        Gui main: Add, Text, x469 y300 w350 r1 Center, %TXT_AD4%
        
        Gui main: Add, Picture, gWww x485 y400, data\ico\logo.png
        
        Gui main: font, s10 cFFB200, verdana
        Gui main: Add, Text, x0 y635 w868 r1 Center, %TXT_SETTINGS_SAVE_INFO%
        
        ;*****LOG*****************************************************************************************************
        Gui main: Tab
        Gui main: Tab, %TXT_LOG%
        Gui main: font, cDC56D0 s8 bold, Consolas
        Gui main: Add, Edit, x24 y60 w800 h20 Left ReadOnly, %TXT_LOG_HEADERS%
        Gui main: Add, Picture, gClearLog x824 y58, data\ico\clear.png
        Gui main: font, s8 cAAAAAA normal
        Gui main: Add, Edit, x24 y82 w820 r44 Left ReadOnly vlogEdit, %liveLog%
        
        ;*****STATYSTYKI*****************************************************************************************************
        Gui main: Tab
        Gui main: Tab, %TXT_STATS%
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: Add, Text, x24 y330 w820 r1 Left, %TXT_STATS_TABLE_TITLE%:
        Gui main: font, s6 cDC56D0, Verdana
        Gui main: Add, Text, x24 y350 w820 r1 Left, __________________________________________________________________________________________________________________________________________________________________________________________
        Gui main: font, s10 cDC56D0, Consolas
        Gui main: Add, Text, x190 y370 w15 r1 Right, |
        Gui main: Add, Text, x209 y370 w340 r1 Center, %TXT_STATS_HEADER_FOUND%
        Gui main: Add, Text, x540 y370 w15 r1 Right, |
        Gui main: Add, Text, x559 y370 w260 r1 Center, %TXT_STATS_HEADER_LOOT%
        Gui main: Add, Text, x809 y370 w15 r1 Right, |
        Gui main: font, s10 cAAAAAA, Consolas
        Gui main: Add, ListView, x24 y390 r12 w820 cAAAAAA Background1B1321 vlootList, %TXT_STATS_HEADER_N%|!|%TXT_STATS_HEADER_TIME_AGO%|!|%TXT_STATS_HEADER_GOLD%|%TXT_STATS_HEADER_ELIXIR%|%TXT_STATS_HEADER_DARK%|%TXT_STATS_HEADER_TH%|%TXT_STATS_HEADER_DEAD%|%TXT_STATS_HEADER_NEXT%|!|%TXT_STATS_HEADER_GOLD%|%TXT_STATS_HEADER_ELIXIR%|%TXT_STATS_HEADER_DARK%|%TXT_STATS_HEADER_TOTAL%
        Gui main: Default
        loot := Object()
        Loop, read, log\loot.csv
        {
            if(A_Index > 1)
            {
                singleLoot := StrSplit(A_LoopReadLine, ";", " ")
                Loop 5
                {
                    if(A_Index = 1)
                        loot[singleLoot[1], A_Index] := singleLoot[A_Index]
                    else
                        loot[singleLoot[1], A_Index+7] := singleLoot[A_Index]
                }
            }
        }
        Loop, read, log\found.csv
        {
            if(A_Index > 1)
            {
                singleFound := StrSplit(A_LoopReadLine, ";", " ")
                Loop 8
                {
                    if(A_Index = 6)
                    {
                        if(singleFound[A_Index] = "yes")
                            singleFound[A_Index] := TXT_YES
                        else if(singleFound[A_Index] = "no")
                            singleFound[A_Index] := TXT_NO
                    }
                    loot[singleFound[1], A_Index] := singleFound[A_Index]
                }
            }
        }
        for index, singleLoot in loot
        {
            Loop 11
            {
                if(singleLoot[A_Index+1] = "")
                    singleLoot[A_Index+1] := "-"
            }
            LV_Add(, A_Index, "|", ago(singleLoot[1]), "|", singleLoot[2], singleLoot[3], singleLoot[4], singleLoot[5], singleLoot[6], singleLoot[7], "|", singleLoot[9], singleLoot[10], singleLoot[11], singleLoot[12])
        }

        LV_ModifyCol(1, "45 Integer SortDesc")
        LV_ModifyCol(2, "20 Integer")
        LV_ModifyCol(3, "100 NoSort Left")
        LV_ModifyCol(4, "20 Integer")
        LV_ModifyCol(5, "65 Integer")
        LV_ModifyCol(6, "65 Integer")
        LV_ModifyCol(7, "65 Integer")
        LV_ModifyCol(8, "35 Integer")
        LV_ModifyCol(9, "60 Integer")
        LV_ModifyCol(10, "40 Integer")
        LV_ModifyCol(11, "20 Integer")
        LV_ModifyCol(12, "65 Integer")
        LV_ModifyCol(13, "65 Integer")
        LV_ModifyCol(14, "65 Integer")
        LV_ModifyCol(15, "65 Integer")
        
        Gui main: font, s12 cDC56D0, Verdana
        Gui main: Add, Text, x24 y60 w820 r1 Left, %TXT_STATS_SUMMARY%:
        Gui main: font, s6 cDC56D0, Verdana
        Gui main: Add, Text, x24 y80 w820 r1 Left, __________________________________________________________________________________________________________________________________________________________________________________________
        ;menu - side:
        Gui main: font, s9 cF0EB50 Bold, Verdana
        Gui main: Add, Text, x24 y130 w120 r1 Right, %TXT_GOLD% - %TXT_STATS_HEADER_TOTAL%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x24 y150 w120 r1 Right, %TXT_ELIXIR% - %TXT_STATS_HEADER_TOTAL%
        Gui main: font, cB187C6
        Gui main: Add, Text, x24 y170 w120 r1 Right, %TXT_DARK% - %TXT_STATS_HEADER_TOTAL%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x24 y190 w120 r1 Right, Total - %TXT_STATS_HEADER_TOTAL%
        Gui main: font, cF0EB50 Normal
        Gui main: Add, Text, x24 y215 w120 r1 Right, %TXT_GOLD% - %TXT_STATS_HEADER_AVERAGE%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x24 y235 w120 r1 Right, %TXT_ELIXIR% - %TXT_STATS_HEADER_AVERAGE%
        Gui main: font, cB187C6
        Gui main: Add, Text, x24 y255 w120 r1 Right, %TXT_DARK% - %TXT_STATS_HEADER_AVERAGE%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x24 y275 w120 r1 Right, Total - %TXT_STATS_HEADER_AVERAGE%
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x24 y300 w120 r1 Right, Next - %TXT_STATS_HEADER_AVERAGE%
        ;linie pionowe:
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x144 y105 w30 r15 Center, |`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|
        Gui main: Add, Text, x264 y105 w30 r15 Center, |`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|
        Gui main: Add, Text, x384 y105 w30 r15 Center, |`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|
        Gui main: Add, Text, x504 y105 w30 r15 Center, |`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|`n|
        ;menu - top:
        Gui main: font, cDDDDDD Bold
        Gui main: Add, Text, x174 y105 w90 r1 Right, %TXT_STATS_HEADER_LAST% 24%TXT_HOUR%
        Gui main: Add, Text, x294 y105 w90 r1 Right, %TXT_STATS_HEADER_LAST% 12%TXT_HOUR%
        Gui main: Add, Text, x414 y105 w90 r1 Right, %TXT_STATS_HEADER_LAST_CURRENT_AF%
        
        ;first column:
        
        goldSumm := lootMath(loot, 9, 24)
        elixSumm := lootMath(loot, 10, 24)
        darkSumm := lootMath(loot, 11, 24)
        totalSumm := goldSumm + elixSumm + darkSumm
        goldAverage := Round(lootMath(loot, 9, 24,, "average"))
        elixAverage := Round(lootMath(loot, 10, 24,, "average"))
        darkAverage := Round(lootMath(loot, 11, 24,, "average"))
        totalAverage := goldAverage + elixAverage + darkAverage
        nextAverage := Round(lootMath(loot, 7, 24,, "average"))
        
        Gui main: font, s10 cF0EB50 Bold, Consolas
        Gui main: Add, Text, x174 y130 w90 r1 Right, %goldSumm%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x174 y150 w90 r1 Right, %elixSumm%
        Gui main: font, cB187C6
        Gui main: Add, Text, x174 y170 w90 r1 Right, %darkSumm%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x174 y190 w90 r1 Right, %totalSumm%
        Gui main: font, cF0EB50 Normal
        Gui main: Add, Text, x174 y215 w90 r1 Right, %goldAverage%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x174 y235 w90 r1 Right, %elixAverage%
        Gui main: font, cB187C6
        Gui main: Add, Text, x174 y255 w90 r1 Right, %darkAverage%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x174 y275 w90 r1 Right, %totalAverage%
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x174 y300 w90 r1 Right, %nextAverage%
        
        ;second column:
        
        goldSumm := lootMath(loot, 9, 12)
        elixSumm := lootMath(loot, 10, 12)
        darkSumm := lootMath(loot, 11, 12)
        totalSumm := goldSumm + elixSumm + darkSumm
        goldAverage := Round(lootMath(loot, 9, 12,, "average"))
        elixAverage := Round(lootMath(loot, 10, 12,, "average"))
        darkAverage := Round(lootMath(loot, 11, 12,, "average"))
        totalAverage := goldAverage + elixAverage + darkAverage
        nextAverage := Round(lootMath(loot, 7, 12,, "average"))
        
        Gui main: font, s10 cF0EB50 Bold, Consolas
        Gui main: Add, Text, x294 y130 w90 r1 Right, %goldSumm%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x294 y150 w90 r1 Right, %elixSumm%
        Gui main: font, cB187C6
        Gui main: Add, Text, x294 y170 w90 r1 Right, %darkSumm%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x294 y190 w90 r1 Right, %totalSumm%
        Gui main: font, cF0EB50 Normal
        Gui main: Add, Text, x294 y215 w90 r1 Right, %goldAverage%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x294 y235 w90 r1 Right, %elixAverage%
        Gui main: font, cB187C6
        Gui main: Add, Text, x294 y255 w90 r1 Right, %darkAverage%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x294 y275 w90 r1 Right, %totalAverage%
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x294 y300 w90 r1 Right, %nextAverage%
        
        ;third column:
        
        goldSumm := lootMath(loot, 9, afTimeStamp, true)
        elixSumm := lootMath(loot, 10, afTimeStamp, true)
        darkSumm := lootMath(loot, 11, afTimeStamp, true)
        totalSumm := goldSumm + elixSumm + darkSumm
        goldAverage := Round(lootMath(loot, 9, afTimeStamp, true, "average"))
        elixAverage := Round(lootMath(loot, 10, afTimeStamp, true, "average"))
        darkAverage := Round(lootMath(loot, 11, afTimeStamp, true, "average"))
        totalAverage := goldAverage + elixAverage + darkAverage
        nextAverage := Round(lootMath(loot, 7, afTimeStamp, true, "average"))
        
        Gui main: font, s10 cF0EB50 Bold, Consolas
        Gui main: Add, Text, x414 y130 w90 r1 Right, %goldSumm%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x414 y150 w90 r1 Right, %elixSumm%
        Gui main: font, cB187C6
        Gui main: Add, Text, x414 y170 w90 r1 Right, %darkSumm%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x414 y190 w90 r1 Right, %totalSumm%
        Gui main: font, cF0EB50 Normal
        Gui main: Add, Text, x414 y215 w90 r1 Right, %goldAverage%
        Gui main: font, cEC72F9
        Gui main: Add, Text, x414 y235 w90 r1 Right, %elixAverage%
        Gui main: font, cB187C6
        Gui main: Add, Text, x414 y255 w90 r1 Right, %darkAverage%
        Gui main: font, cCDF49C
        Gui main: Add, Text, x414 y275 w90 r1 Right, %totalAverage%
        Gui main: font, cDDDDDD
        Gui main: Add, Text, x414 y300 w90 r1 Right, %nextAverage%
        
        currentStamp := A_TickCount
        totalDuration := Round((currentStamp - startStamp)/1000)
        showTime := duration(totalDuration)
        Gui main: font, s10 cDDDDDD Bold, Verdana
        Gui main: Add, Text, x560 y170 w250 r2 Center, %TXT_CUR_SESSION_TIME%:
        Gui main: font, s20 cF0EB50 Bold, Verdana
        Gui main: Add, Text, x560 y210 w250 r1 Center, %showTime%

        placeGuiElement(0, 0, barPosX, barPosY)
        Gui main: Show, W868 H672 X%barPosX% Y%barPosY% NA
        
        LVA_ListViewAdd("lootList", "AR RB2A1D33 RFAAAAAA")
        for index, singleLoot in loot
            LVA_SetCell("lootList", A_Index, 12, "", "F0EB50")
        for index, singleLoot in loot
            LVA_SetCell("lootList", A_Index, 13, "", "EC72F9")
        for index, singleLoot in loot
            LVA_SetCell("lootList", A_Index, 14, "", "B187C6")
        for index, singleLoot in loot
        {
            if(Mod(A_Index, 2) = 0)
                LVA_SetCell("lootList", A_Index, 15, "1B1321", "CDF49C")
            else
                LVA_SetCell("lootList", A_Index, 15, "0A070C", "CDF49C")
        }
        OnMessage("0x4E", "LVA_OnNotify")
    }
    else if(mode = "move")
    {
        placeGuiElement(0, 0, barPosX, barPosY)
        Gui main: Show, X%barPosX% Y%barPosY% NA
    }
    else if(mode = "hide")
        Gui main: Hide
    else if(mode = "stop")
        Gui main: Destroy
}

;###############################################################################
placeGuiElement(shiftX, shiftY, ByRef barPosX, ByRef barPosY)
{
    global wShiftX
    global wShiftY
    WinGetPos, winPosX, winPosY, width, height, BlueStacks App Player
    barPosX := winPosX + wShiftX + shiftX
    barPosY := winPosY + wShiftY + shiftY
}

;###############################################################################
saveSettings()
{
    global
    
    if(shutdownRadio1 = 1)
        shutdownOnCritical := 1
    else
        shutdownOnCritical := 0
    if(botModeRadio1 = 1)
        botMode := 1
    else
        botMode := 0
    if(addsRadio1 = 1)
        adds := 1
    else
        adds := 0
    if(liveRadio1 = 1)
        livePreview := 1
    else
        livePreview := 0
    if(liveSizeRadio1 = 1)
        livePreviewSize := "S"
    else if(liveSizeRadio2 = 1)
        livePreviewSize := "M"
    else if(liveSizeRadio3 = 1)
        livePreviewSize := "L"
    else if(liveSizeRadio4 = 1)
        livePreviewSize := "XL"
    if(showTrayMsg1 = 1)
        showTrayMsg := 1
    else
        showTrayMsg := 0
    if(strategyRadio1 = 1)
        troopsFile := "free_1"
    else if(strategyRadio2 = 1)
        troopsFile := "free_2"
    else if(strategyRadio3 = 1)
        troopsFile := "free_3"
    else
        troopsFile := troopsFilePro
    if(lsTargetRadio1 = 1)
        lsTarget := "drill"
    else if(lsTargetRadio2 = 1)
        lsTarget := "ad"
    else if(lsTargetRadio3 = 1)
        lsTarget := "mortar"
    if(searchTypeRadio3 = 1)
        searchType := "sum"
    else if(searchTypeRadio2 = 1)
        searchType := "any"
    else
        searchType := "all"
        
    addsMsg := RegExReplace(addsMsgX, "`n", "; ")
    
    writeGeneralConfig()
    readGeneralConfig()
    readStrategyConfig()
    setLanguage()
    setGuiVars()
    livePreview(livePreview, livePreviewSize)
    guiBar(TXT_SETTINGS_SAVED, "success")
    WinActivate BlueStacks App Player
}

;###############################################################################
lootMath(arr, colNr, time, af = false, mode = "summ")
{
    result := 0
    i := 0
    for index, singleLoot in arr
    {
        if(af = false)
        {
            if(UnixTimeStamp(A_Now) - UnixTimeStamp(singleLoot[1]) <= time*60*60 AND singleLoot[colNr] != "-")
            {
                result += singleLoot[colNr]
                i++
            }
        }
        else
        {
            if(UnixTimeStamp(singleLoot[1]) >= UnixTimeStamp(time) AND singleLoot[colNr] != "-")
            {
                result += singleLoot[colNr]
                i++
            }
        }
    }
    if(mode = "average")
        result := result / i
    Return result
}
troopsPreview(iniPath, startX, startY)
{
    preview := myIniRead(iniPath, "GENERAL", "preview")
    if(preview != 0)
    {
        picW := 20
        troops := StrSplit(preview , ",", " ")
        for index, troop in troops
        {
            posX := startX + (A_Index - 1)*(picW + 5)
            Gui main: Add, Picture, x%posX% y%startY%, data\ico\%troop%.png
        }
    }
}