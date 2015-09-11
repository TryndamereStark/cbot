writeCsv(csvName, csvData)
{
    if(csvName = "found")
        csvHeaders := "id;gold;elixir;dark elixir;th level;dead base;next number;forced match"
    else if(csvName = "loot")
        csvHeaders := "id;gold;elixir;dark elixir;total"
    else if(csvName = "currentSession")
        csvHeaders := "id;gold;elixir;dark elixir;total"
    writeCsvEngine(csvName, csvData, csvHeaders)
}
writeCsvEngine(csvName, csvData, csvHeaders)
{
    if (FileExist("log/" csvName ".csv"))
        FileAppend , %csvData%`n, log/%csvName%.csv
    else
    {
        FileAppend , %csvHeaders%`n, log/%csvName%.csv
        FileAppend , %csvData%`n, log/%csvName%.csv
    }
}