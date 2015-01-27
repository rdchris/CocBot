#include <Array.au3>
;This is really part of ArmyDeployment manager but is complex enough I wanted to split it out

local $starginPosition[4]=[0,0,1650,850]

local $pixelSearchPotions[5][2]=[["Lightening",""],["Healing",""],["Rage",0x531182],["Jump",""],["Frost",""]]

Local $pixelMatchesArray[1][3]
Local $uniqueTroopsArray[1][3]
Local $bestGroupingArray[1][3]
local $differenceArray[1]

Local $troopGroupPositionY
Local $troopGroupPositionX

Local $potionDropPositionX
Local $potionDropPositionY

local $loop="on"
;ocal $sorterLoop="on"


Func dropPotionOnhighestConcentrationofTroops()
	getArrayOfTroopColor(0xFBB4A9,0x91847C)
	buildDifferenceArray()
	determineHighestConcentrationOfTroops()
	determinePotionSpot()
	dropPotion($masterSetings_PotionType)
EndFunc


;The purpose of this loop is to make an array of
Func getArrayOfTroopColor($troopColor1,$troopColor2)
	While $loop=="on"
		$miniumDistanceToConsiderAnotherTroops=5
		$pixelDistanceToConsiderInTheSameGroup=150
		$shadeVariance=7

		local $location=PixelSearch($starginPosition[0],$starginPosition[1],$starginPosition[2],$starginPosition[3],$troopColor1,$shadeVariance)
		If @error OR $location[1]==850 Then
			$loop="off"
		Else
			PixelSearch($location[0]-25,$location[1]-25,$location[0]+25,$location[1]+25,$troopColor2,$shadeVariance)
			if @error Then
			Else
				ConsoleWrite("Pixel Found at: " & $location[0] & " " & $location[1] & @LF)
				local $tempArray[1][3]=[[$location[0],$location[1],($location[0]+$location[1])]]
				_ArrayAdd($pixelMatchesArray,$tempArray)

			EndIf
		$starginPosition[1]=$location[1]+1
		EndIf


	WEnd
EndFunc

;_ArrayDisplay($pixelMatchesArray)

;Builds an array comparing how far each sprite is from each other, the goal is to drop a potion
;on the highest concentration of troops
Func buildDifferenceArray()
	local $numberOfElementToReview = (UBound($pixelMatchesArray))-2
	For  $i=2 To $numberOfElementToReview Step 1
		local $xDifference=$pixelMatchesArray[$i][0]-$pixelMatchesArray[$i+1][0]
		local $yDifference=$pixelMatchesArray[$i][1]-$pixelMatchesArray[$i+1][1]

		#cs
		ConsoleWrite("$i is : " & $i & @LF)
		ConsoleWrite("$numberOfElementToReview is : " & $numberOfElementToReview & @LF)
		ConsoleWrite("X difference is : " & $xDifference & @LF)
		ConsoleWrite("Y difference is : " & $yDifference & @LF)
		ConsoleWRite("Total differnce is : " & Abs($xDifference+$yDifference) & @LF)
		#ce
		_ArrayAdd($differenceArray,Abs($xDifference+$yDifference))

	Next
EndFunc


Func determineHighestConcentrationOfTroops()
	local $closestGroupDifference=9999
	local $closestGroupNumber=0

	If UBound($differenceArray) > 4 Then
		;_ArrayDisplay($differenceArray)
		For $i=4 To (UBound($differenceArray)-1) Step 1
		;Element one is $i or where you are at, $i is the difference of the last 3 positions combined



		local $differenceOfThisGroup=(Abs($differenceArray[$i-4])+Abs($differenceArray[$i-3])+Abs($differenceArray[$i-2])+Abs($differenceArray[$i-1])+Abs($differenceArray[$i]))
		if Number($differenceOfThisGroup) < Number($closestGroupDifference) Then

		ConsoleWrite("The current top differnece is : " & $closestGroupDifference & @LF)
			$closestGroupNumber=$i
			$closestGroupDifference=$differenceOfThisGroup
		EndIf

		Next
	EndIf
	$troopGroupPositionY=$pixelMatchesArray[$closestGroupNumber][1]
	$troopGroupPositionX=$pixelMatchesArray[$closestGroupNumber][0]
	;ConsoleWrite("The closest group was number : " & $closestGroupNumber & " The difference was " & $closestGroupDifference & @LF)
	;ConsoleWRite("This location is " & $pixelMatchesArray[$closestGroupNumber][0] & " " &  $pixelMatchesArray[$closestGroupNumber][1] & @LF)
EndFunc

;Function determine potion spot
Func determinePotionSpot()
	 local $positionPositionXRelativeToTroops
	 local $positionPositionYRelativeToTroops
	 ;If greated than one you are on the right side
	 If ($troopGroupPositionX-(@DesktopWidth/2)) > 1 Then
		$potionDropPositionX=$troopGroupPositionX-50
		$positionPositionXRelativeToTroops="Left"
	 Else ;otherwise left side
		$potionDropPositionX=$troopGroupPositionX+50
		$positionPositionXRelativeToTroops="Right"
	 EndIf

	 If ($troopGroupPositionY-(@DesktopHeight/2)) > 1 Then
		$potionDropPositionY=$troopGroupPositionY-50
		$positionPositionYRelativeToTroops="Down"
	 Else ;otherwise left side
		$potionDropPositionY=$troopGroupPositionY+50
		$positionPositionYRelativeToTroops="Up"
	 EndIf

	 ;MouseMove($potionDropPositionX,$potionDropPositionY)
EndFunc

Func dropPotion($potionType)
	If $potionType=="Rage" Then
		pixelSearchClickOnThis($pixelSearchPotions[2][1],$pixelSearchArmyDeploymentZone)
		Sleep(Random(20,80))
		MouseClick("Left",$potionDropPositionX,$potionDropPositionY)
		ConsoleWrite(" RAGEEEEEEEE!!!!!!!!!! " & @LF)
	EndIf

EndFunc
