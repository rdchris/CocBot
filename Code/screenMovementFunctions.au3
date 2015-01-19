Global $currentZoomUpOrDown

; This handles moving the view of the base
; This resets the base view to the same position everytime
Func screenMovementFunctions_resetBaseView()
	screenMovementFunctions_zoomOut()
	screenMovementFunctions_scrollUp()
	;TODO Fix This
	;programController_killScriptIfNotFound($baseStaticContentBuilderLabelPosition,$baseStaticContentBuilderLabelColor, "screenMovementFunctions_resetBaseView")
EndFunc

Func screenMovementFunctions_zoomOut()

	For $i = 0 To  Random(13, 16) Step 1
		Sleep(Random(850,900))
		SEND("{DOWN}")
		Sleep(Random(250,350))
	Next
EndFunc

Func screenMovementFunctions_scrollUp()
	;ScrollUP
	For $i = 0 To  Random(2, 3) Step 1
		MouseMove(Random(300,1200),Random(50,600))
		Sleep(Random(700,800))
		MouseWheel("UP")
		Sleep(Random(150,350))
	Next
	$currentZoomUpOrDown="UP"
EndFunc


Func screenMovementFunctions_scrollDown()
	;ScrollUP
	For $i = 0 To  Random(2, 3) Step 1
		MouseMove(Random(300,1200),Random(50,600))
		Sleep(Random(700,800))
		MouseWheel("DOWN")
		Sleep(Random(150,350))

	Next
	$currentZoomUpOrDown="DOWN"
EndFunc