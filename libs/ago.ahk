ago(ahkTimestamp)
{
    global TXT_MINUTE
    global TXT_HOUR
    global TXT_DAY
    timestamp := UnixTimeStamp(ahkTimestamp)
    current := UnixTimeStamp(A_Now)
    seconds := current - timestamp
    days := Floor(seconds/(60*60*24))
    hours := Floor(seconds/(60*60)-days*24)
    minutes := Floor(seconds/60-days*24*60-hours*60)
    if(days != 0)
        ago := days TXT_DAY " " hours TXT_HOUR " " minutes TXT_MINUTE
    else if(hours != 0)
        ago := hours TXT_HOUR " " minutes TXT_MINUTE
    else if(minutes != 0)
        ago := minutes TXT_MINUTE
    else
        ago := ""
    return ago
}