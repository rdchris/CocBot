#include <ImageSearch.au3>
#include <GDIPlus.au3>

$fileA = @ScriptDir & "\testa.png"

_GDIPlus_Startup()

$hImageA =_GDIPlus_ImageLoadFromFile($fileA) ;this is the firefox icon use something else if you don't have it.
$hBitmapA = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImageA)

$x = 0
$y = 0

$result = _ImageSearch($hBitmapA, 1, $x, $y, 20, 0) ;Zero will search against your active screen
If $result > 0 Then
	MouseMove($x, $y)
EndIf


_GDIPlus_ImageDispose($hImageA)
_GDIPlus_Shutdown()