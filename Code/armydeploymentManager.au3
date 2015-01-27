;This class is responcible for deploying troops on the battlefield
;There are troop configuration setup and zones around the battlefield marked for where they get deployed
;All deployment locatoins are on the far corners where a drop can always happen
;There is currently the option to do "waves" but I found that works very poorly due moving around the base being slow

; Army - Finding in deployment
;======
Global $pixelSearchArmyTroops[13][2]=[["0-Barbs",0xF8F830],["1-Archers",0xE84071],["2-Gaints",0xF8CC96],["3-goblinTODO","???"],["4-WBTODO","????"],["5-Balloons","????"],["6-WizardsTODO","??"],["7-HealerTODO","??"],["8-DragonTODO","????"],["9-PEAKKATODO","????"], _
									  ["10-Barb King",0xF8E05E], ["11-Archer Queen",0x7F37FA], _
									  ["12-Minion",0x326BA3]]
Global $armydeploymentManagerActiveHeroPixels[2][2]=[["barb king gauntlet",0xCDA95C],["archer queen crossboxColor",""]]

															  ; King
Global $armydeploymentManagerActiveBarbKingGauntletPositions[4]=[0,907,1650,907]
Global $armydeploymentManagerActiveHeroHealthColor[2]=[0x74756B,"queen"]
Global $armydeploymentManagerActiveHeroWeapontoHealthYDifference[2]=[94,""]



Global $pixelSearchArmyDeploymentZone[4]=[0,800,1650,975] ;Where troops are displayed on the bottom of the screen


;"barb king health at 70% color",0x6F7269

;Battle Menu
Global $pixelSearchReturnHomeButtonPosition=[786,799,786,799]
Global $pixelSearchReturnHomeRandomClickButtonPosition=[740,775,870,940]
Global $pixelSearchReturnHomeButtonColor=0xFFFFFF

Global $pixelSearchEndBattleButtonPosition=[42,735,180,775]
Global $pixelSearchEndBattleButtonColor=0xFFFFFF

Global $pixelSearchSurrenderOkayButtonPosition=[870,560,1060,630]

;Top
Global $armydeploymentManager_top[2]=[830,10]
Global $armydeploymentManager_leftOnTop[2]=[70,583]
Global $armydeploymentManager_rightOnTop[2]=[1560,600]

Global $pathFromLeftToTop[2]=[780,-495]
Global $ratiosOfLeftToTop[2]=[.078,-.0495]

Global $pathFromTopToRight[2]=[750,530]
Global $ratiosOfTopToRight[2]=[.075,.053]

;Bottom
Global $rightOnBottom[2]=[1560,300]
Global $leftOnBottom[2]=[70,294]
Global $bottomForLeft[2]=[631,736]
Global $bottomForRight[2]=[983,779]

Global $pathFromBottomToLeft[2]=[-740,-470]
Global $ratiosOfBottomToLeft[2]=[-.074,-.047] ;moved back 4 decimal points to increase possible points

Global $pathFromBottomToRight[2]=[680,-445]
Global $ratiosOfBottomToRight[2]=[.068,-.044]

local $currentScrollLocation

;TODO do something smarter than this, these are hardcoded random orders for the array
Global $dropPositionsRandomArray[8][4]=[[0,1,2,3],[1,2,3,0],[2,3,0,1],[3,2,1,0],[3,0,1,2],[2,1,0,3],[1,0,3,2],[0,3,2,1]]
Global $dropPositionRandomName[4]=["armydeploymentManager_dropLeftToTop","armydeploymentManager_dropTopToRight","armydeploymentManager_dropBottomToRight","armydeploymentManager_dropBottomToLeft"]

;GAB Attack                  	Type    TC		Min Max DelayAfterDrop
;GAB comp					  11							100					50
;This attack will hit on all four sides and is aimed mostly at just brining in collectors
Global $GABattackWave1[3][5]=[["Giants",2,	3,	4,	450],["Archers",1,23,35,150],["Barbs",0,17,24,150]]
Global $GABOptions[1][2]=[["Timer To Quit",105000]] ;stat
Global $GABHeroOptions[2][2]=[["Use Archer Queen","Y"],["Use Barb King","Y"]]

;BARCH inactive
Global $BARCHattackInactiveWave1[2][5]=[["Archers",1,5,7,200],["Barbs",0,3,5,150]]
Global $BARCHattackInactiveWave2[3][5]=[["Barbs",0,17,21,150],["Archers",1,19,26,150],["Barbs",0,11,16,150]]

;BARCH active
Global $BARCHattackActiveWave1[2][5]=[["Barbs",0,20,26,150],["Archers",1,21,35,250]]
Global $BARCHattackActiveWave2[3][5]=[["Barbs",0,14,17,150],["Archers",1,11,15,300],["Archer Queen",11,5,5,50]]
Global $BARCHattackActiveWave3[2][5]=[["Barbs",0,13,15,150],["Archers",1,12,16,500]]
Global $BARCHattackActiveWave4[2][5]=[["Barbs",0,13,13,150],["Archers",1,16,21,700]]
Global $BARCHattackActiveWave5[3][5]=[["Barbs",0,11,17,150],["Archers",1,11,14,650],["Barb King",10,5,5,50]]
Global $BARCHattackActiveWave6[2][5]=[["Barbs",0,16,23,150],["Archers",1,11,13,500]]
Global $BARCHattackActiveWave7[2][5]=[["Barbs",0,17,23,150],["Archers",1,12,14,700]]
Global $BARCHattackActiveWave8[2][5]=[["Barbs",0,24,37,150],["Archers",1,23,36,200]]

Global $BARCHOptions[1][2]=[["Timer To Quit",125000]] ;stat
Global $BARCHHeroOptions[2][2]=[["Use Archer Queen","Y"],["Use Barb King","Y"]]

;BAM inactive
;Global $BAMattackinactive=

;Timer
Global $attackTimer
Global $percentChanceToQuit=5

;Mainline
Func attackManager_Attack()
	armydeploymentManager_startup()

	Switch $masterSettings_attackType
		Case "GAB"
			armydeploymentManager_AttackWithGAB()
		Case "BARCH"
			if $isBaseAbandoned=="Y" Then
				ConsoleWrite("Doing a BARCh attack, Abandoned style! " & @LF)
				armydeploymentManager_AttackInactiveWithBARCH()
			Else
				ConsoleWrite("Doing a BARCh attack, Active style! " & @LF)
				armydeploymentManager_AttackActiveWithBARCH()
			EndIf
	EndSwitch
EndFunc

Func armydeploymentManager_AttackInactiveWithBARCH()
	$randomDropOrder=Random(0,7,1)
	;Drop Wave 1
	For $i=0 To 3 Step 1
		$dropSpotForThisLoop=$dropPositionsRandomArray[$randomDropOrder][$i]
		armydeploymentManager_dropWave($BARCHattackInactiveWave1,$dropSpotForThisLoop)
	Next

	For $i=0 To 3 Step 1
		$dropSpotForThisLoop=$dropPositionsRandomArray[$randomDropOrder][$i]
		armydeploymentManager_dropWave($BARCHattackInactiveWave2,$dropSpotForThisLoop)
	Next

	armydeploymentManager_isBattleEnded($BARCHOptions)
EndFunc

Func armydeploymentManager_AttackActiveWithBARCH()

	$randomDropPosition=Random(0,3,1) ;random side to attack

	armydeploymentManager_dropWave($BARCHattackActiveWave1,$randomDropPosition)
	armydeploymentManager_dropWave($BARCHattackActiveWave2,$randomDropPosition)
	armydeploymentManager_dropWave($BARCHattackActiveWave3,$randomDropPosition)
	armydeploymentManager_dropWave($BARCHattackActiveWave4,$randomDropPosition)
	armydeploymentManager_useHeroablitiesIfNeeded()
	armydeploymentManager_dropWave($BARCHattackActiveWave5,$randomDropPosition)
	armydeploymentManager_useHeroablitiesIfNeeded()
	armydeploymentManager_dropWave($BARCHattackActiveWave6,$randomDropPosition)
	armydeploymentManager_useHeroablitiesIfNeeded()
	armydeploymentManager_dropWave($BARCHattackActiveWave7,$randomDropPosition)
	armydeploymentManager_useHeroablitiesIfNeeded()
	armydeploymentManager_dropWave($BARCHattackActiveWave8,$randomDropPosition)
	armydeploymentManager_isBattleEnded($BARCHOptions)
EndFunc

Func armydeploymentManager_AttackWithGAB()

	$randomDropOrder=Random(0,7,1);seed

	;Drop Wave 1
	For $i=0 To 3 Step 1
		$dropSpotForThisLoop=$dropPositionsRandomArray[$randomDropOrder][$i]
		armydeploymentManager_dropWave($GABattackWave1,$dropSpotForThisLoop)
	Next

	For $i=0 To 3 Step 1
		$dropSpotForThisLoop=$dropPositionsRandomArray[$randomDropOrder][$i]
		armydeploymentManager_dropWave($GABattackWave1,$dropSpotForThisLoop)
	Next

	armydeploymentManager_isBattleEnded($GABOptions)


EndFunc

;Items that need to happen before every attack
Func armydeploymentManager_startup()
	screenMovementFunctions_scrollUp();start scrolled up
	$currentScrollLocation="UP"
	$attackTimer=TimerInit() ; attack timer to trigger the chance of when to quit
	$percentChanceToQuit=5 ;reset chance to quit back at 5%

EndFunc

;Ends the battle if either the battle ends naturually or if the timer expires.
;Once the timer expires there's a 5% chance every second that the battle will be ended
Func armydeploymentManager_isBattleEnded($TimerToQuit)
	ConsoleWrite("Entering armydeploymentManager_isBattleEnded($TimerToQuit)" & @LF)
	$endBattleFlag=""

	Do
	if pixelSearchIsPixelFound($pixelSearchReturnHomeButtonPosition,$pixelSearchReturnHomeButtonColor)=="Y" Then
		Sleep(Random(22,143)) ;adds a delay from the button being seen to it being clicked on
		armydeploymentManager_ClickOnReturnHomeButton()
		$endBattleFlag="Y"
	EndIf

	;ConsoleWrite("attack Timer is " & TimerDiff($attackTimer) &@LF)
	;ConsoleWrite("Timer to Quit is " & $TimerToQuit[0][1] &@LF)
	if  TimerDiff($attackTimer) > $TimerToQuit[0][1] AND $endBattleFlag<>"Y" Then
		$chanceToQuit=Random(1,100,1)
		ConsoleWrite("The chance to quit was...." & $chanceToQuit & @LF)
		if $chanceToQuit <= $percentChanceToQuit Then
			armydeploymentManager_ClickOnEndBattleButton()
			armydeploymentManager_ClickOnReturnHomeButton()
			$endBattleFlag="Y"
		Else
			$percentChanceToQuit=$percentChanceToQuit+Random(1,7) ;the longer you wait the more and more likely that you will quit
		EndIf
	EndIf

	Sleep(1000)
	armydeploymentManager_useHeroablitiesIfNeeded()
	Until $endBattleFlag="Y"

EndFunc

;Deplys the waves
Func armydeploymentManager_dropWave($wave,$randomDropOrder)
	For $i=0 To (UBound($wave)-1) Step 1
		if armydeploymentManager_areAnyTroopsOfThisTypeLeft($wave[$i][1])=="Y" Then
			armydeploymentManager_armydeploymentManagerSelectTroop($wave[$i][1]) 	   ; Selects the correct Troop
			Switch $randomDropOrder
				Case 0
					armydeploymentManager_dropLeftToTop(Random($wave[$i][2],$wave[$i][3]))
				Case 1
					armydeploymentManager_dropTopToRight(Random($wave[$i][2],$wave[$i][3]))
				Case 2
					armydeploymentManager_dropBottomToRight(Random($wave[$i][2],$wave[$i][3]))
				Case 3
					armydeploymentManager_dropBottomToLeft(Random($wave[$i][2],$wave[$i][3]))
			EndSwitch

			Sleep($wave[$i][4]*Random(.5,.75)) 				   ; Wait a random amount of time after the drop, between 50% & 150%
		EndIf
	Next

EndFunc

;Click on the troops on the bottom of the screen during an attack
Func armydeploymentManager_armydeploymentManagerSelectTroop($troopNumber)
	pixelSearchClickOnThis($pixelSearchArmyTroops[$troopNumber][1],$pixelSearchArmyDeploymentZone)
	Sleep(Random(150,200))
EndFunc

Func armydeploymentManager_areAnyTroopsOfThisTypeLeft($troopNumber)
	Return pixelSearchIsPixelFound($pixelSearchArmyDeploymentZone,$pixelSearchArmyTroops[$troopNumber][1])
EndFunc

Func armydeploymentManager_dropTopToRight($numberOfTroops)
	if $currentScrollLocation=="DOWN" Then
		screenMovementFunctions_scrollUp()
		$currentScrollLocation="UP"
	EndIf
	armydeploymentManager_dropTroops($armydeploymentManager_top,$ratiosOfTopToRight,$numberOfTroops)
EndFunc


Func armydeploymentManager_dropLeftToTop($numberOfTroops)
	if $currentScrollLocation=="DOWN" Then
		screenMovementFunctions_scrollUp()
		$currentScrollLocation="UP"
	EndIf
	armydeploymentManager_dropTroops($armydeploymentManager_leftOnTop,$ratiosOfLeftToTop,$numberOfTroops)
EndFunc

Func armydeploymentManager_dropBottomToLeft($numberOfTroops)
	if $currentScrollLocation=="UP" Then
		screenMovementFunctions_scrollDown()
		$currentScrollLocation="DOWN"
	EndIf
	armydeploymentManager_dropTroops($bottomForLeft,$ratiosOfBottomToLeft,$numberOfTroops)
EndFunc

Func armydeploymentManager_dropBottomToRight($numberOfTroops)
	if $currentScrollLocation=="UP" Then
		screenMovementFunctions_scrollDown()
		$currentScrollLocation="DOWN"
	EndIf

	armydeploymentManager_dropTroops($bottomForRight,$ratiosOfBottomToRight,$numberOfTroops)
EndFunc

;Drops Troops starting from the $starting position  to the $endingPosition
;Multiplies a random number times the ratio of the difference between the spots
Func armydeploymentManager_dropTroops($startingPosition,$ratioToEndingPosition,$numberOfTroopsToDrop)
		For $i=0 To $numberOfTroopsToDrop Step 1
		$randomSeed=Random(1,10000)

		$xMovement=$randomSeed*$ratioToEndingPosition[0]
		$yMovement=$randomSeed*$ratioToEndingPosition[1]

		$xPosition=$xMovement+$startingPosition[0]
		$yPosition=$yMovement+$startingPosition[1]

		MouseClick("left",$xPosition,$yPosition,1,3)

		Sleep(Random(15,35))
	Next
EndFunc

Func armydeploymentManager_ClickOnReturnHomeButton()
	ConsoleWrite("Enting armydeploymentManager_ClickOnReturnHomeButton() Function" & @LF)
	Sleep(Random(500,31000))
	pixelSearchClickOnThis($pixelSearchReturnHomeButtonColor,$pixelSearchReturnHomeButtonPosition)
	Sleep(Random(11000,23000))
	programController_restartIfNotAtBase()

EndFunc

Func armydeploymentManager_ClickOnEndBattleButton()
	ConsoleWrite("Enting armydeploymentManager_ClickOnEndBattleButton() Function" & @LF)
	Sleep(Random(1250,4000))
	randomClickFunctions_RandomClick($pixelSearchEndBattleButtonPosition)
	Sleep(Random(5350,7100))
	randomClickFunctions_RandomClick($pixelSearchSurrenderOkayButtonPosition)
EndFunc


Func armydeploymentManager_useHeroablitiesIfNeeded()

	;if the barb king is spawned check to see if he needs healing
	If armydeploymentManager_areAnyTroopsOfThisTypeLeft(10)=="Y" Then
		healBarbKingIfNeeded()
	EndIf

	If armydeploymentManager_areAnyTroopsOfThisTypeLeft(11)=="Y" Then
		healthArcherQueenifNeeded()
	EndIf

EndFunc

Func healBarbKingIfNeeded()

	;gets the location of the barb kign's gauntlet
	local $localOfBarbKingsGauntlet=PixelSearch($armydeploymentManagerActiveBarbKingGauntletPositions[0],$armydeploymentManagerActiveBarbKingGauntletPositions[1],$armydeploymentManagerActiveBarbKingGauntletPositions[2],$armydeploymentManagerActiveBarbKingGauntletPositions[3],$armydeploymentManagerActiveHeroPixels[0][1])
	if @error Then
		return
	Else
		;ConsoleWrite("Location of barb king's gauntlet : " & $localOfBarbKingsGauntlet[0] & " " & $localOfBarbKingsGauntlet[1] & @LF)
		;ConsoleWrite("I think the healthbar is.. " & ($localOfBarbKingsGauntlet[1] - $armydeploymentManagerActiveHeroWeapontoHealthYDifference[0]) & @LF)

		;Find the position where his health bar should be
		local $localHealthYPosition=($localOfBarbKingsGauntlet[1] - $armydeploymentManagerActiveHeroWeapontoHealthYDifference[0])

		;Determine if you can see through the healthbar at 70%, if so heal him, otherwise do nothing
		PixelSearch($localOfBarbKingsGauntlet[0],$localHealthYPosition,$localOfBarbKingsGauntlet[0],$localHealthYPosition,$armydeploymentManagerActiveHeroHealthColor[0])
		if @error Then
		Else ;Health the king
			ConsoleWrite("The king needs healing!!" & @LF)
			;generate a random Y position between the guantlet and healthbar
			local $randomYforClick=(Random($localHealthYPosition,$localOfBarbKingsGauntlet[1],1))
			local $randomXPosition=(Random($localOfBarbKingsGauntlet[0]-10,$localOfBarbKingsGauntlet[0]+10))
			ConsoleWrite("Position of click is.. " & $randomXPosition & " " & $randomYforClick & @LF)
			MouseClick("left",$randomXPosition,$randomYforClick,1)
		EndIf

	EndIf
EndFunc

Func healthArcherQueenifNeeded()
	;TODO
EndFunc