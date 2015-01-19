;Responcible for Lauching and relauching the bot
#include <date.au3>
#include <masterSettings.au3>

;Local $iPID = Run("CocBot.exe")



Global $EndOfTime="N"
Global $currentTime
Global $currentTimeSplitString
Global $currentTimeHours
Global $currentTimeMinutes
Global $hourBeingReviewed=""
Global $hasHourBeenreviewed

$hasHourBeenreviewed="N"
;infinte loop
Do
	$currentTime= _NowTime(5);24 Hour Time
	$currentTimeSplitString = StringSplit($currentTime,":")
	$currentTimeHours=$currentTimeSplitString[1]
	$currentTimeMinutes=$currentTimeSplitString[2]

	if $hourBeingReviewed <> $currentTimeHours Then

		ConsoleWrite("Current Time" & @LF)
		ConsoleWrite("==============================================" & @LF)
		ConsoleWrite("The current time is   		:	" & $currentTime & @LF)
		ConsoleWrite("The current hours are		:	" & $currentTimeHours & @LF)
		ConsoleWrite("The current minutes are 	:	" & $currentTimeMinutes & @LF)

		botLauncher_checkForLaunch($currentTimeHours)
		botLauncher_checkForKill($currentTimeHours)

		$hourBeingReviewed=$currentTimeHours
	EndIf

	Sleep(Random(1,300,1))
	;Sleep(Random(1,300000,1))

Until $EndOfTime=="Y"

Func botLauncher_checkForLaunch($currentTimeHours)
	Local $launchChance = $masterSettings_launchOrKillChance[$currentTimeHours][1]
	ConsoleWrite("Launch chance this hour is	:	" & $launchChance & @LF)

	If runRandomCheckerYorN($launchChance)=="Y" Then
		If ProcessExists("CocBot.exe") Then ; Check if the Notepad process is running.
			ConsoleWrite(" Bot already running! " & @LF)
		Else
			ConsoleWrite(" ==> Turning on Bot! " & @LF)
			$sleepTime=0
			;$sleepTime=(Random(0,600000))
			ConsoleWrite("Will be turning on the bot in... " & $sleepTime & @LF)
			Sleep($sleepTime)
			Run("CocBot.exe")
		EndIf


	EndIf
EndFunc


Func botLauncher_checkForKill($currentTimeHours)
	Local $killChance = $masterSettings_launchOrKillChance[$currentTimeHours][2]
	ConsoleWrite("kill chance this hour is	:	" & $killChance & @LF)

	If runRandomCheckerYorN($killChance)=="Y" Then
		ConsoleWrite(" ===> Turning off Bot! " & @LF)
		$sleepTime=0
		;$sleepTime=(Random(0,600000))
		ConsoleWrite("Will be turning on the bot in... " & $sleepTime & @LF)
		Sleep($sleepTime)
		ProcessClose ( "CocBot.exe" )
	EndIf
EndFunc

;Checks to see if this "passes" the random time checker
Func runRandomCheckerYorN($chance)
	$prn=Random(1,100,1)

	ConsoleWrite("RandomCheckerYorN prn is	:	" & $prn & @LF)
	if $prn <= $chance Then
		Return "Y"
	Else
		Return "N"
	EndIf

EndFunc