;Building Positions
Global $elixirCollectorPositions[6][2] = [[330,550],[400,500],[475,450],[545,380],[620,330],[690,280]]
Global $goldCollectorPositions[6][2] = [[985,270],[1060,335],[1130,380],[1200,430],[1280,490],[1360,545]]
Global $darkElixirCollectorPositions[2][2] = [[710,880],[770,930]]
Global $barrackPositions[4][2] =  [[382, 654], [437, 687], [491, 727], [549, 768]] ;Barracks 1,2,3,4
Global $darkBarrackPositions[2][2] = [[600,590], [650,720]] ; DB 1,2
Global $baseManager_spellFactorPosition[2]=[436,604]

Global $pixelSearchFullArmyCampBarracksPosition[4]=[1015,552,1015,552]
Global $pixelSearchFullArmyCampBarracksColor=0xF8FCFF
Global $pixelSearchFullArmyCampCampPosition[4]=[1328,609,1328,609]
Global $pixelSearchFullArmyCampCampColor=0xECECEC

;Menu Positions
Global $baseMenuPositionAttackButton[4]=[30,835,160,950]
Global $baseMenuPositionAttackMenuFindAMatchButton[4]=[180,700,470,800]
Global $baseMenuPositionAttackMenuFindAMatchdColor=0xFFFFFF
Global $baseMenuPositionAttackMenuCancelShieldButton[4]=[870,550,1070,620]
Global $baseMenuPositionAttackMenuCancelShieldColor=0xFFFFFF

Global $programController_EnemyAttackedOkayButtonPosition=[735,700,940,775]     ; for random click
Global $programController_EnemyAttackedOkayButtonPosition1=[791,719] ;White letter
Global $programController_EnemyAttackedOkayButtonPosition2=[879,727] ; White letter
Global $programController_EnemyAttackedOkayButtonColor=0xFFFFFF

;Static Content
Global $baseStaticContentBuilderLabelPosition[4]=[679,13,679,13] ;finds the white in the "B" for builder
Global $baseStaticContentBuilderLabelColor=0xFFFFFF

Global $baseManager_spendGemsMenuPosition[4]=[735,545,935,620] ;Where the click to spend GEms button is

Func baseManager_amIinMyBase()
	return pixelSearchIsPixelFound($baseStaticContentBuilderLabelPosition,$baseStaticContentBuilderLabelColor)
EndFunc


;Looks to see if the menu of "enemy raid" is present, if so click on the okay buttons
Func baseManager_clickOkayIfEnemyAttacked()
	PixelSearch($programController_EnemyAttackedOkayButtonPosition1[0],$programController_EnemyAttackedOkayButtonPosition1[1],$programController_EnemyAttackedOkayButtonPosition1[0],$programController_EnemyAttackedOkayButtonPosition1[1],$programController_EnemyAttackedOkayButtonColor)
	If @error Then
		Return
	Else
		PixelSearch($programController_EnemyAttackedOkayButtonPosition2[0],$programController_EnemyAttackedOkayButtonPosition2[1],$programController_EnemyAttackedOkayButtonPosition2[0],$programController_EnemyAttackedOkayButtonPosition2[1],$programController_EnemyAttackedOkayButtonColor)
		If @error Then
			Return
		Else
			randomClickFunctions_RandomClick($programController_EnemyAttackedOkayButtonPosition)
			Sleep(Random(1250,5003))
		EndIf
	EndIf

EndFunc

;Naivgates through menus and begins attack
Func baseManager_InitiateAttack()

	randomClickFunctions_RandomClick($baseMenuPositionAttackButton)

	$found=pixelSearchWaitForPixelToAppear($baseMenuPositionAttackMenuFindAMatchButton,$baseMenuPositionAttackMenuFindAMatchdColor,5)

	if $found=="Y" Then
		randomClickFunctions_RandomClick($baseMenuPositionAttackMenuFindAMatchButton)
	Else
			;Hard reset
	EndIf

	$found=pixelSearchWaitForPixelToAppear($baseMenuPositionAttackMenuCancelShieldButton,$baseMenuPositionAttackMenuCancelShieldColor,3)

	if $found=="Y" Then
		randomClickFunctions_RandomClick($baseMenuPositionAttackMenuCancelShieldButton)
	EndIf

EndFunc

;Randomly clicks somewhere in the "trees" in the base view, can cause no harm
;base must be zoomed up
Func baseManager_randomMouseClickInTrees()
		Sleep( Random(250,2500))
		$randomPosition=Random(1,4,1)
		Switch $randomPosition
			case 1
				;Left side of menu options
				MouseClick("left", 450 + Random(0,151,1), 150 + Random(0,52,1))
			case 2
				;Right side of menu options
				MouseClick("left", 1250 + Random(0,101,1), 150 + Random(0,99,1))
			case 3
				;Bottom Left side
				MouseClick("left", 310 + Random(0,51,1), 925 + Random(0,26,1))
			case 4
				;Bottom Right side
				MouseClick("left", 1340 + Random(0,30), 910 + Random(0,15,1))
		EndSwitch

EndFunc

;collects all the resources around the base
Func baseManager_collectResources()
	;Collect Elixir
	For $i = 0 To 5 Step 1
		Sleep(Random(350,750))
		MouseClick("left", $elixirCollectorPositions[$i][0] + Random(1,9,1), $elixirCollectorPositions[$i][1] + Random(1,9,1))
	Next
	;Collect Gold
	For $i = 0 To 5 Step 1
		Sleep(Random(350,750))
		MouseClick("left", $goldCollectorPositions[$i][0] + Random(1,9,1), $goldCollectorPositions[$i][1] + Random(1,9,1))
	Next

	;collect Dark elixir
	For $i = 0 To 1 Step 1
		baseManager_randomMouseClickInTrees() ;as they are down below it's easy for menus to sit ontop of them
		Sleep(Random(350,750))
		MouseClick("left", $darkElixirCollectorPositions[$i][0] + Random(1,9,1), $darkElixirCollectorPositions[1][1] + Random(1,9,1))
	Next

EndFunc

;Randomly collects from the collectors
Func baseManager_randomlyCollectResources()
	Local $psr=Random(1,8,1)
	If $psr==1 Then
		baseManager_collectResources()							;Collects all resources
		ConsoleWrite("baseManager_randomlyCollectResources - collectoring Resources" & @LF)
	Else
		ConsoleWrite("baseManager_randomlyCollectResources - Not collectoring Resources" & @LF)
	EndIf
EndFunc