activeModule(name)
{
    global activeModule
    activeModule := name
    IniWrite, %activeModule%, data\temp.ini, TEMP, activeModule
}