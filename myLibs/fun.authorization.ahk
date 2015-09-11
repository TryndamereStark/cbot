authorization(mode = "auto")
{
    global
    
    if(cbot_name = 0 OR cbot_pass = 0 OR cbot_name = "" OR cbot_pass = "")
    {
        writeLog(txt["LOGGED_IN_AS"] ": " txt["ANONYMOUS"], "warning")
        authorized["status"] := false
        account := "FREE"
    }
    else
    {
        url = http://runcbot.com/cbot/cbot_auth.php?cbot_name=%cbot_name%&cbot_pass=%cbot_pass%
        bytesDownloaded := HTTPRequest(url, response)
        if(response = "pro" OR response = "free")
        {
            if(response = "pro")
            {
                writeLog(txt["LOGGED_IN_AS"] ": " txt["PRO_ACCOUNT"], "success")
                account := "PRO"
            }
            else
            {
                writeLog(txt["LOGGED_IN_AS"] ": " txt["FREE_ACCOUNT"], "success")
                account := "FREE"
            }
            authorized["status"] := true
        }
        else
        {
            if(mode = "auto")
                writeLog(txt["LOG_IN_ERR"] " " txt["LOGGED_IN AS"] ": " txt["ANONYMOUS"], "error")
            else
            {
                if(response = "error_pass")
                    MsgBox % txt["WRONG_PASS"] " " txt["TRY_AGAIN"]
                else if(response = "error_user")
                    MsgBox % txt["USER_NOT_EXIST"] " " txt["TRY_AGAIN"]
                else if(response = "error_query")
                    MsgBox % txt["DB_QUERY_ERR"] " " txt["TRY_AGAIN_LATER"] " " txt["REPORT_TO_FORUM"]
                else if(response = "error_db")
                    MsgBox % txt["DB_CONNECTION_ERR"] " " txt["TRY_AGAIN_LATER"] " " txt["REPORT_TO_FORUM"]
                else
                    MsgBox % txt["SERVER_ERR"] " " txt["TRY_AGAIN_LATER"] " " txt["REPORT_TO_FORUM"]
            }
            authorized["status"] := false
            account := "FREE"
        }
    }
}