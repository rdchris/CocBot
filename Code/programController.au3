;===========================================================================
; The purpose of this class is to control non-game related items, such as
; logging in, checking for disconnections and launching bluestacks app player
;===============================================================================

;programController manipulates external programs and controlls logging into Coc
Global $programController_positionForReconnect[4]=[320,550,1350,600]

Global $programController_IsDisconnected
Global $programController_EnemyAttackOkayButtonPosition1=[791,719]
Global $programController_EnemyAttackOkayButtonPosition2=[879,727]
Global $programController_EnemyAttackOkayButtonColor=0xFFFFFF

#cs
;Should be changed to restart if disconnected
Func programController_restartIfDisconnected()

	programController_isDisconnected()

	If $programController_IsDisconnected=="Y" Then
		ConsoleWrite("programController_restartIfDisconnected() = isDisconnected = " & $programController_IsDisconnected)
		programController_takeScreenshot("disconnections")
	EndIf
EndFunc
#ce

;If disconnected reconnection
Func programController_loginIfDisconnected()
		programController_isDisconnected()
	If $programController_IsDisconnected=="Y" Then
		ConsoleWrite("programController_loginIfDisconnected() triggered" & @LF)
		programController_reconnect()

	EndIf
EndFunc

;Checks to see if the connection was lost
Func programController_isDisconnected()

	$programController_IsDisconnected="N"

	PixelSearch($programController_positionForReconnect[0],$programController_positionForReconnect[1],$programController_positionForReconnect[0],$programController_positionForReconnect[1],0x282828)
	If @error Then
	Else
		ConsoleWrite("programController_isDisconnected() Bombed in first statement" & @LF)
		$programController_IsDisconnected="Y"
	EndIf

	PixelSearch($programController_positionForReconnect[0],$programController_positionForReconnect[1],$programController_positionForReconnect[0],$programController_positionForReconnect[1],0x2A5261)
	If @error Then
	Else
		ConsoleWrite("programController_isDisconnected() Bombed in second statement" & @LF)
		$programController_IsDisconnected="Y"
	EndIf

	Return $programController_IsDisconnected
EndFunc

;Click on the reconnect button
Func programController_reconnect()
	randomClickFunctions_randomClick($programController_positionForReconnect)
	$programController_IsDisconnected="N"
	Sleep(Random(11000,16000))
	startAttackLoop()
EndFunc

;Kills app and relaunches if a pixel is not found, this prevents the bot from getting completely lost
Func programController_killScriptIfNotFound($position, $color, $nameOfProcess)

	PixelSearch($position[0],$position[1],$position[0],$position[1],$color)
	if @error Then
		programController_killScript($nameOfProcess)
	EndIf
EndFunc

;Kills the script
Func programController_killScript($nameOfProcess)
	ConsoleWrite("-----------------------------------" & @LF)
	ConsoleWrite(" BOOM!!!! BOT IS DOWN! " & @LF)
	ConsoleWrite(" BOOM!!!! BOT IS DOWN! " & @LF)
	ConsoleWrite("Bot resetProgramIfPixel NotFound trigger when looking for " & $nameOfProcess & @LF)
	ConsoleWrite("-----------------------------------" & @LF)
	if $masterSettings_takeScreenshotOfDisconnections=="Y" Then
		programController_takeScreenshot("disconnections")
	EndIf
	programController_takeABreak(311000,530000)
EndFunc

Func programController_takeScreenshot($dir)
	$tCur = _Date_Time_GetSystemTime()
	$dateTime=StringReplace(StringReplace(StringReplace(_Date_Time_SystemTimeToDateTimeStr($tCur),"/","-")," ",""),":","")
	_ScreenCapture_Capture("C:\Users\Chris\Dropbox\AutoIt\autoScreenshots\" & $dir & "\" & $dateTime & ".jpg")
EndFunc

;Restart from the top of the script if something bad happened
Func programController_reStartScript()
	ConsoleWrite("Restarting from the top of the script..... " & @LF)
	startAttackLoop()
EndFunc

;Does a random to see if a break should be taken
;Random bases on 1
;example
; 25% chance to sleep for 1-2 minutes 4,60000,120000
Func programController_takeABreakRandom($randomRange,$t1Value,$t2Value)
	$psr=Random(1,$randomRange,1)
	if $psr==1 Then
		$psrSleepTime=Random($t1Value,$t2Value)
		ConsoleWrite("Going to sleep for : " & $psrSleepTime & @LF)
		Sleep($psrSleepTime)
		programController_loginIfDisconnected()
	Else
		ConsoleWrite("Not going to sleep" & @LF)
	EndIf
EndFunc

Func programController_takeABreak($t1Value,$t2Value)
	$psrSleepTime=Random($t1Value,$t2Value)
	ConsoleWrite("Going to sleep for : " & $psrSleepTime & @LF)
	Sleep(Random($t1Value,$t2Value))
	programController_loginIfDisconnected()
EndFunc

;Function
Func programController_restartIfNotAtBase()
		if baseManager_amIinMyBase() == "N" Then
			startAttackLoop()
		EndIf
EndFunc

Func programController_restartIfAtBase()
		if baseManager_amIinMyBase() == "Y" Then
			startAttackLoop()
		EndIf
EndFunc

;Launchs bluestacks app player if needed and selects clash of clans
Func programController_loadBlueStacksIfNeeded()

	;if Does not exist
	if ProcessExists ( "HD-Frontend.exe" ) ==0 Then
		ConsoleWrite("Bluestacks is not running!" & @LF)

		;Launches Bluestacks
		Run("C:\Program Files (x86)\BlueStacks\HD-StartLauncher.exe")

		;Waits for the window to appear
		Local $hWnd = WinWait("BlueStacks App Player")

		;Maximize window
		WinSetState($hWnd, "", @SW_MAXIMIZE)
		WinActivate("BlueStacks App Player")

		;Wait for Pixel showing that you can click on the coc button
		Sleep(30000)

		;Click on Coc
		MouseClick("left",$bluestacksCocPosition[0],$bluestacksCocPosition[1])

		;Sleep while loading elements
		Sleep(45000)

	Else
		ConsoleWrite("Bluestacks is running!" & @LF)
	EndIf

	WinActivate("BlueStacks App Player")

EndFunc

