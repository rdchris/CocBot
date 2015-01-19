#cs

#cs Version2
Global $attackYorN
Global $wallType
Global $defaultTolerance=13 ;Attack if ten or more of these pixels are found

Local $legoWallsName="Lego Walls"
Local $skullWallsName="Skull Walls"
Local $purpleWallsName="Purple Walls"
Local $pinkWallsName="Pink Walls"
Local $goldWallsName="Gold Walls"

Local $goldPixelCount			  ; gold pixels found
Local $wallType					  ; guessing at the type of walls
 programController_reconnectIfDisconnected()

	$attackYorN="N"
	$goldPIxelCount=0

	if isBaseAbandoned() == "Y" Then
		$goldPixelCount=pixelSearchForPixels($pixelSearchGoldPixels, $battleMenuAttackArea,0)
		$wallType=reviewWalls()
		determineToAttack($goldPixelCount,$wallType)
	EndIf
	ConsoleWrite("=============== <Base Evaluation> ================" & @LF)
	ConsoleWrite(" Suggestion to attack is " & $attackYorN & @LF)
	ConsoleWrite(" Is the base abandonded? " & isBaseAbandoned() & @LF)
	if isBaseAbandoned() Then
		ConsoleWrite(" Type of Walls probably are " & $wallType & @LF)
		ConsoleWrite(" Number of Gold Pixel found was " & $goldPixelCount & @LF)
	EndIf
	ConsoleWrite("=============== </Base Evaluation> ================" & @LF)

EndFunc

;Determine the overall fill level of the Gold mines
Func reviewWalls()

$legoWallsFound=pixelSearchForPixels($pixelSearchLegoWallsColors, $battleMenuAttackArea,0)
$skullWallsFound=pixelSearchForPixels($pixelSearchSkullWallsColors, $battleMenuAttackArea,0)
$purpleWallsFound=pixelSearchForPixels($pixelSearchPurpleWallColors, $battleMenuAttackArea,0)
$pinkWallsFound=pixelSearchForPixels($pixelSearchPinkWallColors, $battleMenuAttackArea,0)
$goldWallsFound=pixelSearchForPixels($pixelSearchGoldWallColors, $battleMenuAttackArea,0)

;Looking for the highest number to assign that as the main wall found, default to stronger walls in tie
For $i = 5 To 0 Step -1
	if $legoWallsFound == $i Then
		Return $legoWallsName
	ElseIf $skullWallsFound == $i Then
		Return $skullWallsName
	ElseIf $purpleWallsFound == $i Then
		Return $purpleWallsName
	ElseIf $pinkWallsFound == $i Then
		Return $pinkWallsName
	ElseIf $goldWallsFound == $i Then
		Return $goldWallsName
	EndIf
Next

EndFunc

Func determineToAttack(ByRef $goldPIxelCount, ByRef $wallType)

	local $tolerance=$defaultTolerance

	;Add a tolerance of 7 if the walls are golden
	if $wallType==$goldWallsName Then
		$tolerance=$tolerance+4
	EndIf

	if $goldPixelCount >= $tolerance Then
		programController_takeScreenshot("attackedBases")
		$attackYorN="Y"
	Else
		programController_takeScreenshot("skippedBases")
		$attackYorN="N"
	EndIf

EndFunc


Func isBaseAbandoned()

	PixelSearch(30,44,1970,50,0x5F6060,0)
	If @error Then
		Return "N"
	Else
		Return "Y"
	EndIf
EndFunc

#ce
#cs

Local $goldMineHighLevelQtrFullName="Gold Mines High Level Qtr Full"
Local $goldMineHighLevelHalfFullName="Gold Mines High Level Half Full"
Local $goldMineHighLevelFullName="Gold Mines High Level Full"
Local $goldMinesLowLevelFullName="Gold Mines Low Level Full"
Local $goldFullGoldMinesFoundName="Med Level Gold Mines Full"
Local $goldHalfFullGoldMinesName="Med Level Gold Mines Half Full"

---- OLD METHODS

Func reviewLoot()

;determine if a collector attack should happen
reviewCollectors()

;override Collector attack if a gold storage attack is happening
reviewStorages()

EndFunc


Func reviewStorages()
	$goldStoragePixelsFound=pixelSearchForPixels($pixelSearchGoldStorageHalfFullColors, $battleMenuAttackArea,1)

	$defaultTolerance=7
	$tolerance=0

	if isBaseAbandoned == "Y" Then
		$tolerance=4
	Else
		$tolerance=$defaultTolerance
	EndIf

	;no gold walls as that confuses things
	if ($goldStoragePixelsFound > $tolerance AND ($wallType == $purpleWallsName OR $wallType == $pinkWallsName) AND $masterSettings_storageRaids == "Y" ) Then
		$attackYorN="Y"
		$attackCollectorOrStorage="Storage"
	EndIf
EndFunc

Func reviewCollectors()

	$goldHighLevelMinesFullWithGoldPixelsFound=pixelSearchForPixels($pixelSearchHighLevelMinesFullWithGold, $battleMenuAttackArea,0)
	$goldHighLevelHalfFullGoldMines=pixelSearchForPixels($pixelSearchHighLevelHalfFullGoldMines, $battleMenuAttackArea,0)
	$goldLowLevelGoldMinesWithGoldPixelsFound=pixelSearchForPixels($pixelSearchLowLevelGoldMinesWithGold, $battleMenuAttackArea,0)
	$goldMineHighLevelQtrFullOfGoldPixelsFound=pixelSearchForPixels($pixelSearchHighLevelQtrFullGoldMines, $battleMenuAttackArea,0)
	$goldMineMidLevelHalfFullGoldMinesFound=pixelSearchForPixels($pixelSearchMidLevelHalfFullGoldMines, $battleMenuAttackArea,0)
	$goldMineMidLevelFullGoldMinesFound=pixelSearchForPixels($pixelSearchMidLevelFullGoldMines, $battleMenuAttackArea,0)

	$goldMineType="None"

	$defaultTolerance=7
	$tolerance=0

	if isBaseAbandoned == "Y" Then
		$tolerance=5
	Else
		$tolerance=$defaultTolerance
	EndIf

	For $i = 10 To $tolerance Step -1
		if $goldHighLevelMinesFullWithGoldPixelsFound >= $i Then
			$goldMineType=$goldMineHighLevelFullName
		ElseIf $goldMineMidLevelHalfFullGoldMinesFound >= $i Then
			$goldMineType=$goldHalfFullGoldMinesName
		ElseIf $goldHighLevelHalfFullGoldMines >= $i Then
			$goldMineType=$goldMineHighLevelHalfFullName
		ElseIf $goldLowLevelGoldMinesWithGoldPixelsFound >= $i Then
			$goldMineType=$goldMinesLowLevelFullName
		ElseIf $goldMineHighLevelQtrFullOfGoldPixelsFound >= $i Then
			$goldMineType=$goldMineHighLevelQtrFullName
		ElseIf $goldMineMidLevelFullGoldMinesFound >= $i Then
			$goldMineType=$goldHalfFullGoldMinesName
		EndIf
	Next

	if ($goldMineType<>"None" AND $masterSettings_collectorRaids) Then
			$attackYorN="Y"
			$attackCollectorOrStorage="Collector"
	EndIf

EndFunc
#ce
#ce
; Reviews the base currently displayed to see if it's worth attacking
;Global $startingColumnOfGoldLoot ;0 1 2 3 4 or 5
;Global $startingColumnOfElixirLoot; 0 1 2 3 4 or 5
;Global $collectorFillLevel ;  1     2       3     4       5
							;none ;little; half mostly; ;full
Global $attackYorN

Func baseEvaluate()

;reviewLoot() Not anymore
reviewWalls()
reviewCollectors()
decideToAttack()

EndFunc


;Determine if you want to attack this base
Func decideToAttack()
		if $collectorFillLevel==5 Then
			$attack="Yes"
		ElseIf $collectorFillLevel==4 Then
			$attack="Yes"
		ElseIf $collectorFillLevel==3 AND $collectorFillLevel <=2 Then
			$attack="Yes"
		Else
			$attack="No"
		EndIf
EndFunc

;Determine the overall fill level of the Gold mines
Func reviewCollectors()

$legoWallsName="Lego Walls"
$skullWallsName="Skull Walls"
$purpleWallsName="Purple Walls"
$pinkWallsName="Pink Walls"
$goldWallsName="Gold Walls"

$legoWallsFound=pixelSearchForPixels($pixelSearchLegoWallsColors)
$skullWallsFound=pixelSearchForPixels($pixelSearchSkullWallsColors)
$purpleWallsFound=pixelSearchForPixels($pixelSearchPurpleWallColors)
$pinkWallsFound=pixelSearchForPixels($pixelSearchPinkWallColors)
$goldWallsFound=pixelSearchForPixels($pixelSearchGoldWallColors)

;Looking for the highest number to assign that as the main wall found, default to stronger walls in tie
For $i = 5 To 0 Step -1
	if $legoWallsFound == $i Then
		Return $legoWallsName
	ElseIf $skullWallsFound == $i Then
		Return $skullWallsName
	ElseIf $purpleWallsFound == $i Then
		Return $purpleWallsName
	ElseIf $pinkWallsFound == $i Then
		Return $pinkWallsName
	ElseIf $goldWallsFound == $i Then
		Return $goldWallsFound
	EndIf
Next




EndFunc
Func reviewLoot()

;ConsoleWrite("=============== <LOOT!> ================" & @LF)

Local  $Loot100Gold = pixelSearchDoesThisLootExist($pixelSearch100GoldLootName, $pixelSearch100GoldLootPixelSpots, $pixelSearch100GoldLootColors)
Local  $Loot200Gold = pixelSearchDoesThisLootExist($pixelSearch200GoldLootName, $pixelSearch200GoldLootPixelSpots, $pixelSearch200GoldLootColors)
Local  $Loot300Gold = pixelSearchDoesThisLootExist($pixelSearch300GoldLootName, $pixelSearch300GoldLootPixelSpots, $pixelSearch300GoldLootColors)
Local  $Loot400Gold = pixelSearchDoesThisLootExist($pixelSearch400GoldLootName, $pixelSearch400GoldLootPixelSpots, $pixelSearch400GoldLootColors)
Local  $Loot500Gold = pixelSearchDoesThisLootExist($pixelSearch500GoldLootName, $pixelSearch500GoldLootPixelSpots, $pixelSearch500GoldLootColors)
Local  $Loot100Elixir = pixelSearchDoesThisLootExist($pixelSearch100ElixirLootName, $pixelSearch100ElixirLootPixelSpots, $pixelSearch100ElixirLootColors)
Local  $Loot200Elixir = pixelSearchDoesThisLootExist($pixelSearch200ElixirLootName, $pixelSearch200ElixirLootPixelSpots, $pixelSearch200ElixirLootColors)
Local  $Loot300Elixir = pixelSearchDoesThisLootExist($pixelSearch300ElixirLootName, $pixelSearch300ElixirLootPixelSpots, $pixelSearch300ElixirLootColors)
Local  $Loot400Elixir = pixelSearchDoesThisLootExist($pixelSearch400ElixirLootName, $pixelSearch400ElixirLootPixelSpots, $pixelSearch400ElixirLootColors)
Local  $Loot500Elixir = pixelSearchDoesThisLootExist($pixelSearch500ElixirLootName, $pixelSearch500ElixirLootPixelSpots, $pixelSearch500ElixirLootColors)


 if pixelSearchDoesThisLootExist($pixelSearch100GoldLootName, $pixelSearch100GoldLootPixelSpots, $pixelSearch100GoldLootColors)=="True" Then
	 $startingColumnOfGoldLoot=1
	ElseIf pixelSearchDoesThisLootExist($pixelSearch200GoldLootName, $pixelSearch200GoldLootPixelSpots, $pixelSearch200GoldLootColors)=="True" Then
		$startingColumnOfGoldLoot=2
	Else
		$startingColumnOfGoldLoot=0
	EndIf



if pixelSearchDoesThisLootExist($pixelSearch100ElixirLootName, $pixelSearch100ElixirLootPixelSpots, $pixelSearch100ElixirLootColors)=="True" Then
	 $startingColumnOfElixirLoot=1
	ElseIf pixelSearchDoesThisLootExist($pixelSearch200ElixirLootName, $pixelSearch200ElixirLootPixelSpots, $pixelSearch200ElixirLootColors)=="True" Then
		$startingColumnOfElixirLoot=2
	Else
		$startingColumnOfElixirLoot=0
	EndIf




;ConsoleWrite("=============== <LOOT!/> ================ " & @LF)

EndFunc


