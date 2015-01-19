;Searching for all the pixels in an Array starting in position 1
;Returns the number of hits
Func pixelSearchForPixels($nameAndColors,$positions,$tolerance)

	local $lengthOfArray=(UBound($nameAndColors)) -1
	local $foundColorsArray[0]
	local $notFoundColorsArray[0]

	For $i = 1 To $lengthOfArray Step 1
		PixelSearch( $positions[0], $positions[1], $positions[2], $positions[3], $nameAndColors[$i], $tolerance)
		if @error Then
			_ArrayAdd($notFoundColorsArray, "Number " & $i)
		Else
			_ArrayAdd($foundColorsArray, "Number " & $i)
		EndIf
	Next

	local $isPresent
	if UBound($foundColorsArray) > UBound($notFoundColorsArray) Then
		$isPresent="Yes"
	Else
		$isPresent="No"
	EndIf

#cs Used to debug why I did or did not attack
	ConsoleWrite("----------------------------------------------" & @LF)
	ConsoleWrite("For " & $nameAndColors[0] & " There were " & UBound($foundColorsArray) & " Found and " & UBound($notFoundColorsArray) & " not Found" & @LF)
	ConsoleWrite("======> " & $isPresent & @LF)
	ConsoleWrite("Found" & @LF)
	ConsoleWrite("==========" & @LF)
	_PrintFromArray($foundColorsArray)
	ConsoleWrite("Not Found" & @LF)
	ConsoleWrite("==========" & @LF)
	_PrintFromArray($notFoundColorsArray)
	ConsoleWrite("----------------------------------------------" & @LF)
#ce

	Return UBound($foundColorsArray)

EndFunc

Func pixelSearchClickOnThis($color, $position)
	Local $coordsOfFoundPixel = PixelSearch($position[0],$position[1],$position[2],$position[3], $color)
	Sleep(Random(20,50))
	MouseClick("left", $coordsOfFoundPixel[0] + Random(0,10,1), $coordsOfFoundPixel[1] + Random(0,10,1))
EndFunc

;Waits for a pixel to be displayed

;$position[3]= top,left,right,bottom coords
;$color = color of pixel
;$waitTime(optional) pass 0 if you want to use the default, each "1" will be between .5 and 1 second thus if you want
; to wait between 30 and 60 seconds pass in "120"
Func pixelSearchWaitForPixelToAppear($position,$color,$waitTime)

	$counter=0
	$locatedYorN="N"

	;assign a custom waitTime if it is passed
	if $waitTime > 0 Then
	Else
		$waitTime=10
	EndIf

	Do

		PixelSearch($position[0], $position[1], $position[2], $position[3], $color)
		if @error Then
			$counter=$counter+1
		Else
			$locatedYorN="Y"
		EndIf

		Sleep(Random(500,1000))
	Until ($counter=$waitTime OR $locatedYorN="Y")

	Return $locatedYorN

EndFunc

Func pixelSearchIsPixelFound($position,$color)
		PixelSearch($position[0], $position[1], $position[2], $position[3], $color)
		if @error Then
			Return "N"
		Else
			Return "Y"
		EndIf
EndFunc