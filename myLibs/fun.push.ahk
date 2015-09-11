push(title, message)
{
    global txt
    global cbot_name
    global pushbullet_mail

    if(cbot_name != "" AND pushbullet_mail != "")
    {
        url = http://runcbot.com/pushbullet.php?user=%cbot_name%&mail=%pushbullet_mail%&title=%title%&message=%message%
        bytesDownloaded := HTTPRequest(url, msg)
        writeLog(txt["PUSH_MSG"])
    }
}