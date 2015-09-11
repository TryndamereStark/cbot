;This function takes an input timestamp in the form YYYYMMDDHHMISS and converts
;it into a UNIX standard epoch timestamp (ie. The number of seconds since
;Jan 1, 1970). It will only work for dates from 1970 to 2400 (which is the next
;year in which the leap year rules are different).
;If you feed in an incorrectly formatted parameter the function will
;return a string detailing the error.

UnixTimeStamp(time_orig)
{
    ;Check that input parameter is correct format.
    StringLen, date_len, time_orig
    If date_len<>14
      return "The input parameter has incorrect length or is an incorrect number format."
    If time_orig is not integer
      return "The input parameter is an incorrect number format."

    ;Split date into useable parts
    StringLeft, now_year, time_orig, 4
    StringMid, now_month, time_orig, 5, 2
    StringMid, now_day, time_orig, 7, 2
    StringMid, now_hour, time_orig, 9, 2
    StringMid, now_min, time_orig, 11, 2
    StringRight, now_sec, time_orig, 2

    ;Get year seconds
    year_sec := 31536000*(now_year - 1970)

    ;Determine how many leap days
    leap_days := (now_year - 1972)/4 + 1
    Transform, leap_days, Floor, %leap_days%

    ;Determine if date is in a leap year, and if the leap day has been yet
    this_leap := now_year/4
    Transform, this_leap_round, Floor, %this_leap%
    If (this_leap = this_leap_round)
      {
      If now_month <= 2
        leap_days--   ;subtracts 1 because this year's leap day hasn't been yet
      }
    leap_sec := leap_days*86400

    ;Determine fully completed months
    If now_month = 01
      month_sec = 0
    If now_month = 02
      month_sec = 2678400
    If now_month = 03
      month_sec = 5097600
    If now_month = 04
      month_sec = 7776000
    If now_month = 05
      month_sec = 10368000
    If now_month = 06
      month_sec = 13046400
    If now_month = 07
      month_sec = 15638400
    If now_month = 08
      month_sec = 18316800
    If now_month = 09
      month_sec = 20995200
    If now_month = 10
      month_sec = 23587200
    If now_month = 11
      month_sec = 26265600
    If now_month = 12
      month_sec = 28857600

      
    ;Determine fully completed days
    day_sec := (now_day - 1)*86400

    ;Determine fully completed hours
    hour_sec := now_hour*3600 ;don't subtract 1 because it starts at 0

    ;Determine fully completed minutes
    min_sec := now_min*60

    ;Calculate total seconds
    date_sec := year_sec + month_sec + day_sec + leap_sec + hour_sec + min_sec + now_sec

    return date_sec
}