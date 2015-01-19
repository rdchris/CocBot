takeABreak(1,2,3,5)

Func takeABreak($randomRange1,$randomRange2,$t1Value,$t2Value)
	ConsoleWrite($randomRange1 & " " & $randomRange2 & @LF)
	$psr=Random($randomRange1,$randomRange2,1)
	ConsoleWRite("$psr : " & $psr & @LF)
	if $psr==1 Then
		$psrSleepTime=Random($t1Value,$t2Value)
		ConsoleWrite("Going to sleep for : " & $psrSleepTime & @LF)
		Sleep($psrSleepTime)
		ConsoleWRite("Wake up!")
	EndIf

EndFunc