#RequireAdmin
#include <StaticConstants.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GuiComboBox.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <TrayConstants.au3>
#include <Misc.au3>
#include <Tesseract.au3>

WinActivate("BlueStacks App Player")
Global $Title = "BlueStacks App Player"
Global $HWnD = WinGetHandle (WinGetTitle($Title))
Global $Left = 0, $Top = 0, $Right = 0, $Bottom = 0
;More is Right		Less is up more is more|	More is Left				Less is down more is up
;Global $Left =1500, $Top = 25, 					$Right =80,				$Bottom = @DesktopHeight - 50
Global $Left =74, $Top = 105, 					$Right =1550,				$Bottom = @DesktopHeight - 125
Global $BSsize = WinGetClientSize($hWnd)
;GUIRegisterMsg($WM_COMMAND, "GUIControl")
Global $RunState = True


;GUIRegisterMsg($WM_SYSCOMMAND, "GUIControl")

;Global $Title = "BlueStacks App Player"
;Global $HWnD = WinGetHandle (WinGetTitle($Title))
;WinActivate ($HWnD)

		  ;_TesseractWinCapture(	   $win_title,  $win_text = "", 	$get_last_capture = 0, $delimiter = "", $cleanup = 1, $scale = 2, 	$left_indent = 0, 	$top_indent = 0, 	$right_indent = 0	, $bottom_indent = 0	, $show_capture = 0)
          $Read = _TesseractWinCapture($HWnD,		"",					0,						"",				0,					   4,	$Left,				$Top,				$Right,				  $Bottom				,0)       ;Capture screen region with gold and elixir


		;Break String up into array based on @LF
		ConsoleWrite("Step1"  & $Read & @LF)
		ConsoleWRite("===============" & @LF)
		$ReadSS = StringSplit($Read,@LF,1)
		$arrayLength=UBound($ReadSS)
		ConsoleWrite("Array is " & $arrayLength & " long" & @LF)
		ConsoleWRite("===============" & @LF)
		For $i = 1 To ($arrayLength-1) Step 1
			ConsoleWrite("$Read " & $i & "  : " & $ReadSS[$i] & " End of String" & @LF)
		Next


		;Remove empty elements in Array
		ConsoleWrite("Step 2" & @LF)
		ConsoleWRite("===============" & @LF)
		For $i = 1 To 3 Step 1
			If ($ReadSS[$i]="" OR $ReadSS[$i]=" ") Then
				_ArrayDelete($ReadSS, $i)
				$arrayLength=$arrayLength-1
			EndIf
		Next

		For $i = 0 To 3 Step 1
			ConsoleWrite("$Read " & $i & "  : " & $ReadSS[$i] & " End of String" & @LF)
		Next
		;At this point 1= gold, 2=elixir, 3= de

		;Remove special characters

		ConsoleWrite(@LF & @LF & "Final look!!! " & @LF)
		For $i = 0 To 3 Step 1
			$ReadSS[$i]=StringReplace($ReadSS[$i],"-","")
			$ReadSS[$i]=StringReplace($ReadSS[$i],".","")
			$ReadSS[$i]=StringReplace($ReadSS[$i]," ","")
			ConsoleWrite("$Read " & $i & "  : " & $ReadSS[$i] & " End of String" & @LF)

		Next
		ConsoleWRite("===============")





#Cs
ConsoleWrite("UBound is : " & UBound($Read) & @LF)
		  For $i=0 To ($i >= UBound($Read)) Step 1
				ConsoleWrite("$REad 3 .. : " & $Read[$i] & @LF)
		  Next


		ConsoleWrite("$REad 1  : " & $Read & @LF)
		ConsoleWrite("$Read[0] : " & $Read[0] & @LF)
		ConsoleWrite("$Read[1] : " & $Read[1] & @LF)
		ConsoleWrite("$Read[2] : " & $Read[2] & @LF)


          $Read = StringRegExpReplace(StringRegExpReplace($Read, "(\v)+", @CRLF), "\A\v|\v\Z", "")      ;Strip whitespaces & blank lines and split into array


		ConsoleWrite("$REad 2: .. : " & $Read & @LF)

          $Read = StringSplit($Read, @CRLF, 1)
		  ConsoleWrite(@LF)
		  ConsoleWrite("$REad .. : " & $Read[0] & @LF)

		  For $i=0 To ($i > UBound($Read)) Step 1
				ConsoleWrite("$REad 3 .. : " & $Read[$i] & @LF)
		  Next

          While UBound($Read) < 5
                 If $RunState = False Then
                        ExitLoop(2)
                 EndIf
                 $Read = _TesseractWinCapture($HWnD,"",0,"",1,2,$Left*$x_ratio,$Top*$y_ratio,$Right*$x_ratio,$Bottom*$y_ratio,0)        ;Capture screen region with gold and elixir
                 $Read = StringRegExpReplace(StringRegExpReplace($Read, "(\v)+", @CRLF), "\A\v|\v\Z", "")       ;Strip whitespaces & blank lines and split into array
                 $Read = StringSplit($Read, @CRLF, 1)
          WEnd
          If $RunState = False Then

          EndIf
          $x = Number(StringRegExpReplace($Read[2], "[^[:digit:]]", ""))        ;Convert gold to number
          $y = Number(StringRegExpReplace($Read[3], "[^[:digit:]]", ""))        ;Convert exlir to number

		  ConsoleWrite(@LF)
		  ConsoleWrite("The $X is being returned as.. " & $x & @LF)
		  ConsoleWrite("The $Y is being returned as .. " & $y & @LF)
		  ConsoleWrite(@LF)
#ce
