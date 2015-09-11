sendLoot(gold, elixir, dark, total)
{
    global cbot_name
    global troopsFile
    global txt
    timestamp := uri_encode(A_YYYY "-" A_MM "-" A_DD " " A_Hour ":" A_Min)
    
    if(cbot_name != "" AND total > 0)
    {
        url := "http://runcbot.com/cbot/cbot_lootWrite.php?name=" cbot_name "&timestamp=" timestamp "&gold=" gold "&elixir=" elixir "&dark=" dark "&total=" total "&strategy=" troopsFile
        bytesDownloaded := HTTPRequest(url, msg)
        writeLog(txt["SERVER_RESULTS"])
    } 
}
sendCurrentStats(gold, elixir, dark, trophies, thLevel)
{
    global cbot_name
    global txt
    timestamp := uri_encode(A_YYYY "-" A_MM "-" A_DD " " A_Hour ":" A_Min)
    th := uri_encode(thLevel)
    
    if(cbot_name != "")
    {
        url := "http://runcbot.com/cbot/cbot_currentWrite.php?name=" cbot_name "&timestamp=" timestamp "&gold=" gold "&elixir=" elixir "&dark=" dark "&trophies=" trophies "&th=" th
        bytesDownloaded := HTTPRequest(url, msg)
        writeLog(txt["SERVER_CURRENT_STATS"])
    }
}