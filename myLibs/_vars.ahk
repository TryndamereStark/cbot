;ZMIENNE POMOCNICZE:
calib := 0 ; zmienna kalibruj¹ca - modyfikuje standardow¹ wartoœæ parametrów variation funkcji multiImageSearch oraz multiPixelSearch
freezeMsg := ""
freezeCounter := 0
gameRect := "0, 0, 868, 672" ; wspó³rzêdne obszaru klienta (obszar gry)
searchCount := 0 ; zainicjowania licznika wyszukiwañ (jest zerowany przy trafieniu wioski)
botMode := "normal"
account := "FREE"
authorized := Object()
thStats := Object()
position := Object()
army := Object()
resources := Object()
liveLog := ""
attackType := "normal" ; normal / thOnly
thCoords := 0
posNames := ["posTH","posCastle","posArmyCamp","posSpellFactory","posDarkSpellFactory","posKingAltar","posQueenAltar","posBarracks1","posBarracks2","posBarracks3","posBarracks4","posDarkBarracks1","posDarkBarracks2","posGoldMine1","posGoldMine2","posGoldMine3","posGoldMine4","posGoldMine5","posGoldMine6","posGoldMine7","posElixirCollector1","posElixirCollector2","posElixirCollector3","posElixirCollector4","posElixirCollector5","posElixirCollector6","posElixirCollector7","posDarkElixirDrill1","posDarkElixirDrill2","posDarkElixirDrill3"]

getImgSize(filePath)
{
    pToken := Gdip_Startup()
    Gdip_GetDimensions(pBitmap := Gdip_CreateBitmapFromFile(filePath), w, h)
    Gdip_DisposeImage(pBitmap)
    Gdip_ShutDown(pToken)
    size = %w%, %h%
    return  size
}

setImg(name, folder, position)
{
    global
    imgPos[name] := position
    imagePath = %folder%/%name%.png
    imgPath[name] := imagePath
    imgSize[name] := getImgSize(imgPath[name])
}

setPix(name, pixColor, position)
{
    global
    pixPos[name] := position
    pixCol[name] := pixColor
}

;PIXELS:
setPix("info", 0xFFFFFF, "223, 33")

;IMAGES:
setImg("calib1", "patterns/calibration", "120, 575, 750, 610")
setImg("calib2", "patterns/calibration", "120, 575, 750, 610")
setImg("calib3", "patterns/calibration", cliRect)
setImg("th4", "patterns/th", cliRect)
setImg("th5", "patterns/th", cliRect)
setImg("th6", "patterns/th", cliRect)
setImg("th7", "patterns/th", cliRect)
setImg("th8", "patterns/th", cliRect)
setImg("th9", "patterns/th", cliRect)
setImg("th10", "patterns/th", cliRect)
setImg("emptyGold8", "patterns/resources", cliRect)
setImg("emptyGold9", "patterns/resources", cliRect)
setImg("emptyGold10", "patterns/resources", cliRect)
setImg("emptyGold11", "patterns/resources", cliRect)
setImg("test", "patterns/resources", cliRect)
setImg("test2", "patterns/resources", cliRect)

;TH STATS - maksymalne poziomy budowli dla danego th
thStats[5] := {ad: 3, mortar: 3, deStorage: 0}
thStats[6] := {ad: 4, mortar: 4, deStorage: 0}
thStats[7] := {ad: 5, mortar: 5, deStorage: 2}
thStats[8] := {ad: 6, mortar: 6, deStorage: 4}
thStats[9] := {ad: 7, mortar: 7, deStorage: 6}
thStats[10] := {ad: 8, mortar: 8, deStorage: 6}

; ZAWARTOŒÆ DARK ELIXIR STORAGE W ZALE¯NOŒCI OD TH, POZIOMU STORAGE i WYPE£NIENIA STORAGE
lsDarkTH7 := Object()
lsDarkTH8 := Object()
lsDarkTH9 := Object()
lsDarkTH10 := Object()

lsDarkTH7[1,"10%"] := 60
lsDarkTH7[1,"25%"] := 150
lsDarkTH7[1,"50%"] := 300
lsDarkTH7[1,"100%"] := 600
lsDarkTH7[2,"10%"] := 120
lsDarkTH7[2,"25%"] := 300
lsDarkTH7[2,"50%"] := 600
lsDarkTH7[2,"100%"] := 1200

lsDarkTH8[1,"10%"] := 60
lsDarkTH8[1,"25%"] := 150
lsDarkTH8[1,"50%"] := 300
lsDarkTH8[1,"100%"] := 600
lsDarkTH8[2,"10%"] := 120
lsDarkTH8[2,"25%"] := 300
lsDarkTH8[2,"50%"] := 600
lsDarkTH8[2,"100%"] := 1200
lsDarkTH8[3,"10%"] := 240
lsDarkTH8[3,"25%"] := 600
lsDarkTH8[3,"50%"] := 1200
lsDarkTH8[3,"100%"] := 2000
lsDarkTH8[4,"10%"] := 480
lsDarkTH8[4,"25%"] := 1200
lsDarkTH8[4,"50%"] := 2000
lsDarkTH8[4,"100%"] := 2000

lsDarkTH9[1,"10%"] := 50
lsDarkTH9[1,"25%"] := 125
lsDarkTH9[1,"50%"] := 250
lsDarkTH9[1,"100%"] := 500
lsDarkTH9[2,"10%"] := 100
lsDarkTH9[2,"25%"] := 250
lsDarkTH9[2,"50%"] := 500
lsDarkTH9[2,"100%"] := 1000
lsDarkTH9[3,"10%"] := 200
lsDarkTH9[3,"25%"] := 500
lsDarkTH9[3,"50%"] := 1000
lsDarkTH9[3,"100%"] := 2000
lsDarkTH9[4,"10%"] := 400
lsDarkTH9[4,"25%"] := 1000
lsDarkTH9[4,"50%"] := 2000
lsDarkTH9[4,"100%"] := 2500
lsDarkTH9[5,"10%"] := 750
lsDarkTH9[5,"25%"] := 1875
lsDarkTH9[5,"50%"] := 2500
lsDarkTH9[5,"100%"] := 2500
lsDarkTH9[6,"10%"] := 1000
lsDarkTH9[6,"25%"] := 2500
lsDarkTH9[6,"50%"] := 2500
lsDarkTH9[6,"100%"] := 2500

lsDarkTH10[1,"10%"] := 40
lsDarkTH10[1,"25%"] := 100
lsDarkTH10[1,"50%"] := 200
lsDarkTH10[1,"100%"] := 400
lsDarkTH10[2,"10%"] := 80
lsDarkTH10[2,"25%"] := 200
lsDarkTH10[2,"50%"] := 400
lsDarkTH10[2,"100%"] := 800
lsDarkTH10[3,"10%"] := 160
lsDarkTH10[3,"25%"] := 400
lsDarkTH10[3,"50%"] := 800
lsDarkTH10[3,"100%"] := 1600
lsDarkTH10[4,"10%"] := 320
lsDarkTH10[4,"25%"] := 800
lsDarkTH10[4,"50%"] := 1600
lsDarkTH10[4,"100%"] := 3000
lsDarkTH10[5,"10%"] := 600
lsDarkTH10[5,"25%"] := 1500
lsDarkTH10[5,"50%"] := 3000
lsDarkTH10[5,"100%"] := 3000
lsDarkTH10[6,"10%"] := 800
lsDarkTH10[6,"25%"] := 2000
lsDarkTH10[6,"50%"] := 3000
lsDarkTH10[6,"100%"] := 3000
