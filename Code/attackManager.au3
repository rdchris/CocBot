;This class controls all actions that take place during an attack

Global $attackManager_PositionsEndBattle[4]=[30,730,190,775] ;square of End Battle Button
Global $attackManager_EndBattleColor=0xC10000
Global $attackManager_PositionsFindNext[4]=[1420,700,1600,765] ;square of Next button

Global $attackmanager_FindNextPositePosition1[4]=[1515,699,1515,699]
Global $attackmanager_FindNextPositeColor1=0xFFFFFF
Global $attackmanager_FindNextPositePosition2[4]=[1534,743,1534,743]
Global $attackmanager_FindNextPositeColor2=0xFFFFFF
Global $attackmanager_FindNextPositePosition3[4]=[1572,743,1572,743]
Global $attackmanager_FindNextPositeColor3=0xFFFFFF



Global $attackManager_FindNextColor=0xD84800



Global $attackManager_returnHomeButtonPosition[4]=[735,780,940,860]



;Loops through bases until a target is found
;I seem to get disconnect here ALOT thus all the checks
Func attackManager_FindTargetBase()
	Do
		;Did I get d/c'd?
		programController_loginIfDisconnected()
		programController_restartIfAtBase()
		pixelSearchWaitForPixelToAppear($attackManager_PositionsFindNext,$attackManager_FindNextColor,60)
		baseEvaluationForAttack()
		if $baseEvaluater_attackYorN="N" Then
			randomClickFunctions_RandomClick($attackManager_PositionsFindNext)
		EndIf

	Until $baseEvaluater_attackYorN="Y"


EndFunc

Func attackManager_executeAttack()
		attackManager_returnToBase()
EndFunc

Func attackManager_returnToBase()
	randomClickFunctions_RandomClick($attackManager_returnHomeButtonPosition)
	programController_killScriptIfNotFound($baseStaticContentBuilderLabelPosition,$baseStaticContentBuilderLabelColor,"attackManager_returnToBase")
EndFunc

