;Change to BarrackQueingManager
;Menu Postions

															;barbs		archers		giants		goblins		WallBreakers 	Ballons	 	Wizards	 	Healers	 	Dragons		PEAKKAs
Global $armyQueingManager_barracksMenuPosition[10][2] 	= 	[[515, 470], [690, 480], [850, 480], [1015, 480], [1180, 480], [520, 640], [675, 640], [830, 640], [1010, 630], [1170, 640]]
Global $armyQueingManager_barracksMenuClosePosition[2] 	= 	[1300, 200]
Global $armyQueingManager_barracksMenuCloseColor	=		0xF8FCFF

Global $armyQueingManager_barrackMenuAreTroopsBoostingCheckPositions1[4]=[964,905,964,905]
Global $armyQueingManager_barrackMenuAreTroopsBoostingCheckPositions2[4]=[1019,924,1019,924]
Global $armyQueingManager_barrackMenuAreTroopsBoostingCheckColors=0xFFFFFF
Global $armyQueingManager_barracksTrainTroopsMenu[2]=[1060, 875 ]; Menu item in the Base Manager
Global $armyQueingManager_barracksTrainTroopsMenuIfBoosting[2]=[990,875]

Global $armyQueingManager_barracksBoostAllMenuPosition[4]=[860, 825,960,935 ]; Menu item in the Base Manager

Global $areBarracksBeingBoosted

;The Army used for the queing
Global $armyQueingManager_barracksArmy[4][10] =[[0,0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0,0], [0,0,0,0,0,0,0,0,0,0]]

;Constructs various armies

;Pull from configuration file what type of army to build
Func armyQueingManager_buildArmy()
	Switch	$masterSettings_attackType
		Case "GAB"
			armyQueingManager_buildGABArmy()
		Case "BARCH"
			armyQueingManager_buildBarchArmy()
		Case Else
			armyQueingManager_buildGABArmy()
	EndSwitch
EndFunc

; Army Order!
; Barbs - Archers - Giants - Goblins - WB - Balloons - Wizards - Healer - Dragon - PEAKKA

Func armyQueingManager_buildGABArmy()
	Global  $allBarracksArmy[4][10] =[[0,0,"ALL",0,0,0,0,0,0,0], ["ALL",0,0,0,0,0,0,0,0,0], [0,"ALL",0,0,0,0,0,0,0,0], [0,"ALL",0,0,0,0,0,0,0,0]]
	armyQueingManager_loadBarracks($allBarracksArmy)
EndFunc

Func armyQueingManager_buildBarchArmy()
	Global  $allBarracksArmy[4][10] =[["ALL",0,0,0,0,0,0,0,0,0], ["ALL",0,0,0,0,0,0,0,0,0], [0,"ALL",0,0,0,0,0,0,0,0], [0,"ALL",0,0,0,0,0,0,0,0]]
	armyQueingManager_loadBarracks($allBarracksArmy)
EndFunc



; MainLine
;=========
;Loading Barracks
Func armyQueingManager_loadBarracks($allBarracksArmy)
	;Load the 4 Army bases
	For $currentArmyBaseNumber = 0 To 3 Step 1
		baseManager_randomMouseClickInTrees()
		armyQueingManager_selectBarracks($currentArmyBaseNumber)
		armyQueingManager_barrackSelectTrainTroopsMenu($currentArmyBaseNumber)
		armyQueingManager_barracksMenuLoadTroopsSelected($allBarracksArmy,$currentArmyBaseNumber)
		armyQueingManager_closeArmyMenu()
	Next
EndFunc

;Private Methods
;===============
;Selecting Barracks
Func armyQueingManager_selectBarracks($currentArmyBaseNumber)
	Sleep(Random(250,3000))
	MouseClick("left",$barrackPositions[$currentArmyBaseNumber][0] + Random(0,1,1),$barrackPositions[$currentArmyBaseNumber][1] + Random(0,1,1))
EndFunc

;Selecting Menus
Func armyQueingManager_barrackSelectTrainTroopsMenu($currentArmyBaseNumber)
	Sleep(Random(350,900))

	If $masterSettings_boostBarracks=="Y" AND armyQueingManager_isBoosting()=="N" Then
			boostSelectedBarracks()
	EndIf

	;IsBoosting
	if armyQueingManager_isBoosting()=="Y" Then
		MouseClick("left",$armyQueingManager_barracksTrainTroopsMenuIfBoosting[0],$armyQueingManager_barracksTrainTroopsMenuIfBoosting[1])
	Else
		MouseClick("left", $armyQueingManager_barracksTrainTroopsMenu[0] + Random(0,45,1), $armyQueingManager_barracksTrainTroopsMenu[1] + Random(0,45,1))
	EndIf

EndFunc

;Must have a barracks already selected
Func boostSelectedBarracks()
	randomClickFunctions_RandomClick($armyQueingManager_barracksBoostAllMenuPosition)
	Sleep(Random(350,2305))
	randomClickFunctions_RandomClick($baseManager_spendGemsMenuPosition)
	Sleep(Random(350,2305))
	ConsoleWrite("Turning on barracks boosting!!" & @LF)
EndFunc

;Closing Menu, kill app if item not found
Func armyQueingManager_closeArmyMenu()
	Sleep(Random(250,3000))
	MouseClick("left", $armyQueingManager_barracksMenuClosePosition[0] + Random(0,10,1),$armyQueingManager_barracksMenuClosePosition[1] + Random(0,10,1))
	programController_killScriptIfNotFound($armyQueingManager_barracksMenuClosePosition,$armyQueingManager_barracksMenuCloseColor, "armyQueManager_closeArmyMenu")
EndFunc

;Selecting troops from the barracks menu ;Pass in the Array for this specific barracks
Func armyQueingManager_barracksMenuLoadTroops($allBarracksArmy, $currentArmyBaseNumber)

EndFunc

;Ques up Troops
;Cycles through the troops (numbers 0-9 and selects the numbers of troops per their value in the array
;Looks up X & Y positions from $barracksMenuPosition
Func armyQueingManager_barracksMenuLoadTroopsSelected($allBarracksArmy,$currentArmyBaseNumber)
	Sleep(Random(50,150))
	For $currentSelectedTroop = 0 To 9 Step 1
		if $allBarracksArmy[$currentArmyBaseNumber][$currentSelectedTroop]=="ALL" Then
			MouseMove($armyQueingManager_barracksMenuPosition[$currentSelectedTroop][0] + Random(0,45,1), $armyQueingManager_barracksMenuPosition[$currentSelectedTroop][1] + Random(0,45,1))
			MouseDown("left")
			Sleep(Random(2950,6322))
			MouseUp("left")
		ElseIf  $allBarracksArmy[$currentArmyBaseNumber][$currentSelectedTroop]	> 0 Then
			For $i = 0 To $allBarracksArmy[$currentArmyBaseNumber][$currentSelectedTroop] Step 1
				Sleep(Random(150,250))
				MouseClick("left", $armyQueingManager_barracksMenuPosition[$currentSelectedTroop][0] + Random(0,45,1), $armyQueingManager_barracksMenuPosition[$currentSelectedTroop][1] + Random(0,45,1))
			Next
		EndIf
	Next
EndFunc

;Checks to see if the barracks selected is being boostedbarracks are being boosted
Func armyQueingManager_isBoosting()
	if ((pixelSearchIsPixelFound($armyQueingManager_barrackMenuAreTroopsBoostingCheckPositions1,$armyQueingManager_barrackMenuAreTroopsBoostingCheckColors)=="Y") _
	AND (pixelSearchIsPixelFound($armyQueingManager_barrackMenuAreTroopsBoostingCheckPositions2,$armyQueingManager_barrackMenuAreTroopsBoostingCheckColors)=="Y")) Then
		$areBarracksBeingBoosted="Y"
		Return "Y"
	Else
		$areBarracksBeingBoosted="N"
		Return "N"
	EndIf
EndFunc

;Sits around waiting for the timer to expire to attack
Func armyQueingManager_waitForArmyCampsToBeFull()
	If $areBarracksBeingBoosted=="N" Then
		programController_takeABreakRandom(12,23,405)
		programController_loginIfDisconnected()
	EndIf

	;Test to see if maybe I'm stuck zoomed in
	local $armyCampsLoops=0

	While (pixelSearchIsPixelFound($pixelSearchFullArmyCampBarracksPosition,$pixelSearchFullArmyCampBarracksColor)<>"Y" AND pixelSearchIsPixelFound($pixelSearchFullArmyCampCampPosition,$pixelSearchFullArmyCampCampColor)<>"Y")
		If $masterSettings_boostBarracks=="Y" Then
			Sleep(Random(1253,4432))
		Else
			Sleep(Random(2530,19053))
		EndIf

		ConsoleWrite("Waiting for Army Camps to fill up" & @LF)

		programController_loginIfDisconnected()
		baseManager_randomMouseClickInTrees()
		$armyCampsLoops=$armyCampsLoops+1

		;Somewhat randomly attempt to zoom out
		If $armyCampsLoops > 20 Then
			screenMovementFunctions_resetBaseView()
			$armyCampsLoops=0
		EndIf
	WEnd
EndFunc