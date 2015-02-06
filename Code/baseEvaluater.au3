Global $baseEvaluater_attackYorN
Global $baseEvaluater_usePotions
Local $goldAmount
Local $elixirAmount
Local $deAmount
Local $isBaseAbandoned
Local $wallType

Local $legoWallsName="Lego Walls"
Local $skullWallsName="Skull Walls"
Local $purpleWallsName="Purple Walls"
Local $pinkWallsName="Pink Walls"
Local $goldWallsName="Gold Walls"

local $baseValue
local $lastBaseValue
local $baseValueMatchCount
$baseEvaluater_baseValueMatchKillCount=3

 ;Main line of base Evaluation
;============================
Func baseEvaluationForAttack()
	screenMovementFunctions_scrollUp()

	$baseEvaluater_attackYorN="N"
	$baseEvaluater_usePotions="N"
	$goldAmount=0
	$elixirAmount=0
	$deAmount=0
	$secondValidationOfResources="N"

	$isBaseAbandoned=isBaseAbandoned()
	getResources()
	reviewResourceFinding()
	determineToAttack()

	;Do a second check before commiting to an attack
	if $baseEvaluater_attackYorN=="Y" Then
		getResources()
		reviewResourceFinding()
		determineToAttack()
	EndIf
	;determineToAttackWithMiniumValues()
	baseEvaluater_reviewPossibleErrors()


EndFunc

;Review possible issue that could occur
Func baseEvaluater_reviewPossibleErrors()
	if $baseValue==$lastBaseValue Then
		$baseValueMatchCount=$baseValueMatchCount+1
	Else
		$baseValueMatchCount=0
	EndIf

	if $baseValueMatchCount >= $baseEvaluater_baseValueMatchKillCount Then
		programController_killScript("Died in baseEvaluationForATtac, If baseValue==lastBaseValue" & @LF)
	EndIf

	$lastBaseValue=$baseValue
EndFunc

;Incase there is an issue retrieving the data
Func reviewResourceFinding()


	if $goldAmount > 700000 Then
		$goldAmount=70000
	EndIf

	if $elixirAmount > 700000 Then
		$elixirAmount=70000
	EndIf

	if 	$goldAmount > $elixirAmount * 3 Then
		$goldAmount=0
	EndIf

		if 	$elixirAmount > $goldAmount * 3 Then
		$elixirAmount=0
	EndIf

	if $deAmount > 4000 Then
		$deAmount=400
	EndIf



EndFunc

;Determines if an attack is executed or not
Func determineToAttack()

	Local $goldPoints=$goldAmount*$masterSettings_goldValue
	Local $elixirPoints=$elixirAmount*$masterSettings_elixirValue
	Local $dePoints=$deAmount*$masterSettings_deValue

	$baseValue=$goldPoints+$elixirPoints+$dePoints

	Local $inactiveAttackValue
	Local $activeAttackValue

	;Determine minium number of resources to go after based on if I'm boosting or not
	if $masterSettings_boostBarracks == "Y" Then
		$inactiveAttackValue=$masterSettings_attackOnValueInactiveBOOSTING
		$activeAttackValue=$masterSettings_attackOnValueActiveBOOSTING
	Else
		$inactiveAttackValue=$masterSettings_attackOnValueInactive
		$activeAttackValue=$masterSettings_attackOnValueActive
	EndIf

	if $isBaseAbandoned=="Y" Then
		if $baseValue >= $inactiveAttackValue Then
			$baseEvaluater_attackYorN="Y"
			if $baseValue >= $masterSettings_attackOnValueInactiveUsePotions Then
				$baseEvaluater_usePotions="Y"
			EndIf
		EndIf

	ElseIf $masterSettings_attackActiveYorN == "Y" Then
		reviewWalls()
		if $baseValue >= $activeAttackValue AND ($wallType==$pinkWallsName OR $wallType==$goldWallsName) Then  ;OR $wallType==$purpleWallsName
			$baseEvaluater_attackYorN="Y"
			if $baseValue >= $masterSettings_attackOnValueInactiveUsePotions Then
				$baseEvaluater_usePotions="Y"
			EndIf
		EndIf
	EndIf

	If $baseEvaluater_attackYorN=="Y" Then
		if $masterSettings_takeScreenshotOfAttackedBases=="Y" Then
			programController_takeScreenshot("attackedBases")
		EndIf
	Else
		;programController_takeScreenshot("skippedBases")
	EndIf

	ConsoleWrite("=============== <Base Evaluation> ================" & @LF)
	ConsoleWrite(" Suggestion to attack is 		:" & $baseEvaluater_attackYorN & @LF)
	ConsoleWrite(" Gold is				:" & $goldAmount	& @LF)
	ConsoleWrite(" Elixir is				:" & $elixirAmount	& @LF)
	ConsoleWrite(" deElixir is				:" & $deAmount	& @LF)
	ConsoleWrite(" Is the base abandonded 		:" & $isBaseAbandoned & @LF)
	ConsoleWrite(" Total value of base is  		:" & $baseValue       & @LF)
	If $isBaseAbandoned=="Y" Then
		ConsoleWrite(" The Value to attack is			:" & $inactiveAttackValue   & @LF)
	Else
		ConsoleWrite(" The Value to attack is			:" & $activeAttackValue   & @LF)
	EndIf
	ConsoleWrite(" Use potions?                 :" & $baseEvaluater_usePotions & @LF)
	ConsoleWrite(" The Wall Type is 			:" & $wallType   & @LF)
	ConsoleWrite("=============== </Base Evaluation> ================" & @LF)
EndFunc

Func isBaseAbandoned()
	PixelSearch(30,44,1970,50,0x5F6060,0)
	If @error Then
		Return "N"
	Else
		Return "Y"
	EndIf
EndFunc

Func getResources()
		Global $Title = "BlueStacks App Player"
		Local $HWnD = WinGetHandle (WinGetTitle($Title))
		Global $Left =74, $Top = 105, 					$Right =1550,				$Bottom = @DesktopHeight - 125

		;Need to refactor and encapsolute
			  ;_TesseractWinCapture(	   $win_title,  $win_text = "", 	$get_last_capture = 0, $delimiter = "", $cleanup = 1, $scale = 2, 	$left_indent = 0, 	$top_indent = 0, 	$right_indent = 0	, $bottom_indent = 0	, $show_capture = 0)
         $Read = _TesseractWinCapture($HWnD,		"",					0,						"",				0,					   4,	$Left,				$Top,				$Right,				  $Bottom				,0)       ;Capture screen region with gold and elixir

		;Break String up into array based on @LF
		$ReadSS = StringSplit($Read,@LF,1)
		$arrayLength=(UBound($ReadSS)-1)

		;Delete empty elements of the Array
		;Remove special characters
		;1=Gold,2=Elixir,3=DE
		local $finalArray[0]=[]
		For $i = 1 To $arrayLength Step 1
			If ($ReadSS[$i]="" OR $ReadSS[$i]=" ") Then
				;ConsoleWrite("Did not add " & $readSS[$i] & " To the array" & @LF)
			Else
				$ReadSS[$i]=StringReplace($ReadSS[$i],"-","")
				$ReadSS[$i]=StringReplace($ReadSS[$i],".","")
				$ReadSS[$i]=StringReplace($ReadSS[$i]," ","")
				_ArrayAdd($finalArray, $ReadSS[$i])
				;ConsoleWrite("Adding " & $readSS[$i] & " To the array" & @LF)
			EndIf
		Next

		For $i = 0 To (Ubound($finalArray)-1) Step 1
			Switch $i
				Case 0
					$goldAmount=$finalArray[$i]
				Case 1
					$elixirAmount=$finalArray[$i]
				Case 2
					$deAmount=$finalArray[$i]
			EndSwitch
		Next

EndFunc

;Determine the overall fill level of the Gold mines
Func reviewWalls()

	$legoWallsFound=pixelSearchForPixels($pixelSearchLegoWallsColors, $menuPositions_attackManager_AttackArea,0)
	$skullWallsFound=pixelSearchForPixels($pixelSearchSkullWallsColors, $menuPositions_attackManager_AttackArea,0)
	$purpleWallsFound=pixelSearchForPixels($pixelSearchPurpleWallColors, $menuPositions_attackManager_AttackArea,0)
	$pinkWallsFound=pixelSearchForPixels($pixelSearchPinkWallColors, $menuPositions_attackManager_AttackArea,0)
	$goldWallsFound=pixelSearchForPixels($pixelSearchGoldWallColors, $menuPositions_attackManager_AttackArea,0)

	;Looking for the highest number to assign that as the main wall found, default to stronger walls in tie
	For $i = 5 To 0 Step -1
		if $legoWallsFound == $i Then
			$wallType=$legoWallsName
			Return
		ElseIf $skullWallsFound == $i Then
			$wallType=$skullWallsName
			Return
		ElseIf $purpleWallsFound == $i Then
			$wallType=$purpleWallsName
			Return
		ElseIf $pinkWallsFound == $i Then
			$wallType=$pinkWallsName
		ElseIf $goldWallsFound == $i Then
			$wallType=$goldWallsName
			Return
		EndIf
	Next

EndFunc


Func baseManager_takeScreenshotOfLoot()
	_ScreenCapture_Capture("C:\Users\Chris\Dropbox\AutoIt\autoScreenshots\loot\currentloot.jpg",1350,0,1650,240,True)
	_ScreenCapture_Capture("C:\wamp\www\Images\currentloot.jpg",1350,0,1650,240,True)
		;_ScreenCapture_Capture("C:\Users\Chris\Dropbox\AutoIt\autoScreenshots\" & $dir & "\" & $dateTime & ".jpg")
EndFunc