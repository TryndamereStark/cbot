blockProVars()
{
    global
    if(account = "FREE")
    {
        livePreview := 0
        adds := 0
        addsMsg := txt["BLOCK_VARS_MSG"]
        if troopsFile not in free_1,free_2,free_3
            troopsFile := "free_1"
        pushFound := 0
        pushLoot := 0
        pushCritical := 0
        lsOn := 0
        boostBar1 := 0
        boostBar2 := 0
        boostBar3 := 0
        boostBar4 := 0
        boostDarkBar1 := 0
        boostDarkBar2 := 0
        boostSpells := 0
        boostKing := 0
        boostQueen := 0
        upgradesOn := 0
        request := 0
    }
}