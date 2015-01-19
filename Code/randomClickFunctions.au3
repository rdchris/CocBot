;Randomly Clicks somewhere in the grid passed
Func randomClickFunctions_RandomClick($squareArrayOfItemToClick)

	Sleep(Random(25,75))

	local $maxLeft=$squareArrayOfItemToClick[0]
	local $maxTop=$squareArrayOfItemToClick[1]
	local $maxRight=$squareArrayOfItemToClick[2]
	local $maxBottom=$squareArrayOfItemToClick[3]

	local $xCoordToClick=(Random($maxLeft,$maxRight))
	local $yCoordToClick=(Random($maxTop,$maxBottom))

	MouseClick("left",$xCoordToClick,$yCoordToClick)

	Sleep(Random(150,750))
EndFunc


