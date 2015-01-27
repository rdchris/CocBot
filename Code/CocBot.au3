;===============================
;Clash of clans automated bot
;Author: rdchris
;===============================

;Libaries
#include <Array.au3>
#include <PrintFromArray.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <Tesseract.au3>

;Environment Vars
#include <masterSettings.au3>
#include <masterConfig.au3>

;static positions
#include <buildingMenuPositions.au3>
#include <pixelPositions.au3>
#include <menuPositions.au3>

;Menu & Building Interactions
#include <baseManager.au3>
#include <randomClickFunctions.au3>
#include <screenMovementFunctions.au3>

;Attacking
#include <pixelSearches.au3>
#include <baseEvaluater.au3>
#include <armyQueingManager.au3>
#include <attackManager.au3>
#include <armydeploymentManager.au3>
#include <potionUseManager.au3>

;External Programs and Lauching
#include <programController.au3>
;=======================================================================================================================================
;Master Script Below
;=======================================================================================================================================

armyQueingManager_queSpells()
Exit

programController_loadBlueStacksIfNeeded()
initScriptVars()
startKeepAliveLoop()
;</Mainline>

;instanciate instance vars4
Func initScriptVars()
	Global $numberOfAttacksToDoThisSession=$masterSettings_attacksToExecute
	Global $numberOfAttacksThisSession=0
	ConsoleWrite("For This Session there will be " & $numberOfAttacksToDoThisSession & " attacks" & @LF)
EndFunc

;Master Loops - This is here incase there is a disconnection
Func startKeepAliveLoop()

	While $masterSettings_scriptOn=="Y"
		If $masterSettings_scriptOn=="N" Then
			Exit
		EndIf

		WinActivate("BlueStacks App Player")
		programController_loginIfDisconnected()

		While $programController_IsDisconnected=="N" AND $masterSettings_scriptOn=="Y"
			startAttackLoop()
		WEnd
	WEnd
	ConsoleWrite(" ########################### " & @LF)
	ConsoleWRite(" End of Attacks! " & @LF)
	ConsoleWrite(" ########################### " & @LF)
	Exit
EndFunc

;High Level Walkthrough of the Bots logic
Func startAttackLoop()
	While $numberOfAttacksToDoThisSession >= $numberOfAttacksThisSession AND $programController_IsDisconnected == "N"
		screenMovementFunctions_resetBaseView()				;Zooms out and moves the view to the top (needed for consistency
		baseManager_randomlyCollectResources()
		baseManager_takeScreenshotOfLoot()
		armyQueingManager_buildArmy()						;Ques up the army selected in the master settings screen.
		armyQueingManager_waitForArmyCampsToBeFull()				;waits until army is ready to attack
		baseManager_InitiateAttack() 						;Navigates through menus and pulls up first base
		attackManager_FindTargetBase()						;Scans through target bases until one that meets criteria is found5
		attackManager_Attack()								;Performs the attack55
		ConsoleWrite(" $numberOfAttacksToDoThisSession is : " & $numberOfAttacksToDoThisSession & @LF)
		ConsoleWrite(" $numberOfAttacksThisSession is : " & $numberOfAttacksThisSession & @LF)
		$numberOfAttacksThisSession=$numberOfAttacksThisSession+1
	WEnd
	$masterSettings_scriptOn="N"
EndFunc
