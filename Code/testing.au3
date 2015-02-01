Local $trophyManager_currentTrophyCount
Local $trophyManager_needToDropTrophies

armydeploymentManager_dropASingleTroop()

;used when dropping trophies
Func armydeploymentManager_dropASingleTroop()
	ConsoleWrite(" AQ? : " & armydeploymentManager_areAnyTroopsOfThisTypeLeft(10) & @LF)
	ConsoleWrite(" BK? : " & armydeploymentManager_areAnyTroopsOfThisTypeLeft(11) & @LF)
	ConsoleWrite(" barb? : " &  armydeploymentManager_areAnyTroopsOfThisTypeLeft(0) & @LF)
	ConsoleWrite(" archer? : " &  armydeploymentManager_areAnyTroopsOfThisTypeLeft(1) & @LF)

EndFunc

Exit

Func reviewTrophiesDropIfNeeded()
	getTrophies()
	$trophyManager_needToDropTrophies=reviewTrophiesAgainstRanges()

	if $trophyManager_needToDropTrophies=="Y" Then
		baseManager_InitiateAttack()
		attackManager_GoToFirstBase()
		getTrophies()
		$trophyManager_needToDropTrophies=reviewTrophiesAgainstRanges()
	EndIf
EndFunc

Func reviewTrophiesAgainstRanges()
	if trophyManager_currentTrophyCount > $masterSettings_trophyRangeEndingRange Then
		return "Y"
	Else
		return "N"
	EndIf

EndIf

Func getTrophies()
		Global $Title = "BlueStacks App Player"
		Local $HWnD = WinGetHandle (WinGetTitle($Title))
		Global $Left =80, $Top = 105, 					$Right =1450,				$Bottom = @DesktopHeight - 125

		;Need to refactor and encapsolute
			  ;_TesseractWinCapture(	   $win_title,  $win_text = "", 	$get_last_capture = 0, $delimiter = "", $cleanup = 1, $scale = 2, 	$left_indent = 0, 	$top_indent = 0, 	$right_indent = 0	, $bottom_indent = 0	, $show_capture = 0)
         $Read = _TesseractWinCapture($HWnD,		"",					0,						"",				0,					   4,	$Left,				$Top,				$Right,				  $Bottom				,0)       ;Capture screen region with gold and elixir

		;Break String up into array based on @LF
		$ReadSS = StringSplit($Read,@LF,1)
		$arrayLength=(UBound($ReadSS)-1)

		;Delete empty elements of the Array
		;Remove special characters
		local $finalArray[0]=[]
		For $i = 1 To $arrayLength Step 1
			If ($ReadSS[$i]="" OR $ReadSS[$i]=" ") Then
				;ConsoleWrite("Did not add " & $readSS[$i] & " To the array" & @LF)
			Else
				$ReadSS[$i]=StringReplace($ReadSS[$i],"-","")
				$ReadSS[$i]=StringReplace($ReadSS[$i],".","")
				$ReadSS[$i]=StringReplace($ReadSS[$i]," ","")
				_ArrayAdd($finalArray, $ReadSS[$i])
				ConsoleWrite("Adding " & $readSS[$i] & " To the array" & @LF)
			EndIf
		Next

		$trophyManager_currentTrophyCount = $finalArray[0];
		ConsoleWrite("Current trophy count is : " & $trophyManager_currentTrophyCount)

EndFunc