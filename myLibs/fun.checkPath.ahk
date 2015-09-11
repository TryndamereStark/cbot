checkPath()
{
    global pathBlueStacks
    global txt
    if(pathBlueStacks = 0)
    {
        SELECT_PATH:
        msg := txt["SPECIFY_BS_FOLDER"]
        FileSelectFolder, path,::{20d04fe0-3aea-1069-a2d8-08002b30309d},0,%msg%
        if (path = "")
        {
            MsgBox % txt["BS_FOLDER_NOT_SPECIFED"]
            ExitApp
        }
        else
        {
            IfExist, %path%\HD-RunApp.exe
            {
                IniWrite, %path%, data\settings.ini, PATHS, pathBlueStacks
                IniRead, pathBlueStacks, data\settings.ini, PATHS, pathBlueStacks
            }    
            Else
            {
                MsgBox % txt["BS_FOLDER_WRONG_PATH"]
                Goto SELECT_PATH
            }
        }
        readGeneralConfig()
    }
}
