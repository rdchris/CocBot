Global $pixelSearchTroopDeplaymentpixelSpots[4]=[70, 900, 1900, 1100]


;Loot Number on the top Left
;============================
;This helps see if the left handed number is in the tens or hundred thousands (40,000 vs 400,000)
Global $pixelSearchGoldLootHundredThousandsBox[4]

Global $pixelSearch100GoldLootName="Testing for 100 Gold Loots"
Global $pixelSearch100GoldLootPixelSpots[4][2]=[[91,122], [97,122], [97,140], [93,141]]
Global $pixelSearch100GoldLootColors[4][1]=[[0xEFEBC0],[0xFEFACB], [0xFFFBCC], [0xD0CDA6]]

Global $pixelSearch200GoldLootName="Testing for 200 Gold Loots"
Global $pixelSearch200GoldLootPixelSpots[4][2]=[[91,123], [104,121], [104,140], [91,141]]
Global $pixelSearch200GoldLootColors[4][1]=[[0xE6E2B8],[0xEAE6BC], [0xFFFBCC], [0xF5F1C4]]

Global $pixelSearch300GoldLootName="Testing for 300 Gold Loots"
Global $pixelSearch300GoldLootPixelSpots[4][2]=[[92,122], [104,122], [104,140], [91,140]]
Global $pixelSearch300GoldLootColors[4][1]=[[0xF4F0C3],[0xF0ECC0], [0xFFFBCC], [0xFEFACB]]

Global $pixelSearch400GoldLootName="Testing for 400 Gold Loots"
Global $pixelSearch400GoldLootPixelSpots[4][2]=[[98,122], [106,122], [109,135], [91,135]]
Global $pixelSearch400GoldLootColors[4][1]=[[0xFEFACB],[0xFCF8CA], [0xFEFACB], [0xFEFACB]]

Global $pixelSearch500GoldLootName="Testing for 500 Gold Loots"
Global $pixelSearch500GoldLootPixelSpots[4][2]=[[91,123], [105,123], [105,137], [92,141]]
Global $pixelSearch500GoldLootColors[4][1]=[[0xE1DDB4],[0xFEFACB], [0xFFFBCC], [0xF5F1C4]]

Global $pixelSearch100ElixirLootName="Testing for 100 Elixir Loots"
Global $pixelSearch100ElixirLootPixelSpots[4][2]=[[88,173],[95,172],[94,191], [90,192]]
Global $pixelSearch100ElixirLootColors[4][1]=[[0xE2CEE1], [0xE8D3E6],[0xF4DEF2], [0xAE9EAD]]

Global $pixelSearch200ElixirLootName="Testing for 200 Elixir Loots"
Global $pixelSearch200ElixirLootPixelSpots[4][2]=[[89,173], [101,172], [101,191], [88,190]]
Global $pixelSearch200ElixirLootColors[4][1]=[[0xEDD8EB],[0xFDE6FB], [0xF8E2F6], [0xEDD8EB]]

Global $pixelSearch300ElixirLootName="Testing for 300 Elixir Loots"
Global $pixelSearch300ElixirLootPixelSpots[4][2]=[[90,173],[101,173],[102,190], [88,191]]
Global $pixelSearch300ElixirLootColors[4][1]=[[0xFFE8FD], [0xF9E2F7],[0xDBC7D9], [0xE0CCDE]]

Global $pixelSearch400ElixirLootName="Testing for 400 Elixir Loots"
Global $pixelSearch400ElixirLootPixelSpots[4][2]=[[95,172], [104,172], [106,185], [89,185]]
Global $pixelSearch400ElixirLootColors[4][1]=[[0xFBE5F9],[0xF8E1F6], [0xF2DCF0], [0xFFE8FD]]

Global $pixelSearch500ElixirLootName="Testing for 500 Elixir Loots"
Global $pixelSearch500ElixirLootPixelSpots[4][2]=[[89,172], [102,173], [102,186], [90,191]]
Global $pixelSearch500ElixirLootColors[4][1]=[[0x998C96],[0xFBE4F9], [0xFFE8FD], [0xFFE8FD]]

;Buildings!
;==========

;Walls
Global $pixelSearchLegoWallsColors[6]=["Lego Walls",0xB2ACAD,0x494B4F,0x333B46,0x57493D,0x8F7B76]
Global $pixelSearchSkullWallsColors[6]=["Skull Walls",0xCEC6C3,0x93857C,0x998777,0x34353C,0x7D787A]
Global $pixelSearchPurpleWallColors[6]=["Purple Walls",0x4C1E60,0x8B6AA8,0x4A2362,0xBF97DF,0x583C65]
Global $pixelSearchPinkWallColors[6]=["Pink Walls",0xED34D0,0xB73290,0xF338D0,0x852269,0xC70ED3]
Global $pixelSearchGoldWallColors[6]=["Gold Walls",0x605138,0xF8D56D,0xF0C05D,0x976520,0xF3C866]

;Mines
;Suggestion Found  > 7
;Global $pixelSearchHighLevelMinesFullWithGold[11]=["High Level Gold Mines Full of Gold",0xF3EA05,0xE9D300,0xEFDD00,0xE2CB00,0xAD8E00,0xEAE000,0xEAE003,0xE2CB00,0xF5F600,0xE4AB03]
;Global $pixelSearchHighLevelHalfFullGoldMines[19]=["High Level Half Full Gold Mines"	,0xCFAA00,0xE1CD00,0x938A1D,0xE1C100,0xE4D800,0xF6F600,0x946F02,0x9E7A00,0xDAC612,0xC7AE00,
;Global $pixelSearchHighLevelQtrFullGoldMines[11]=["High Level Qtr Full Gold Mines"		,0xA28200,0xF3E800,0xD6B600,0xAF8B00,0xC7A000,0xA28200,0xD3C400,0xA58100,0xD0B001,0xF3E800]
;Global $pixelSearchMidLevelFullGoldMines[19]=["Mid Level Full Gold Mines"				,0xE3CC00,0xB18E00,0xE0A900,0x9A7E00,0xEAB601,0xE4C000,0xAB8800,0xF6E300,0xE6B400,0xF6E000, 0xDCC800,0xF7E900,0xF1BF00,0xD7C112,0xE3CD02,0xECB100,0xC8AF03,0xCC9D00]
;Global $pixelSearchMidLevelHalfFullGoldMines[11]=["Mid Level Half Full Gold Mines"		,0xF0D000,0xF7E500,0xAF8300,0xC0AF00,0xE3B700,0xDDAA00,0xF7E500,0xEEB700,0xDDD628,0xE8C902]
;Global $pixelSearchLowLevelGoldMinesWithGold[11]=["Lower Level Gold Mines Full"			,0xECAD01,0xF8DB00,0xCEA800,0xC29D00,0xDDC500,0xC4A300,0xECAD01,0xEAB500,0xD8B900,0xE1D000]

;Gold Storage
;Suggestion Found if > 6
Global $pixelSearchGoldPixels[122]=[							"Gold Pixels",0xF3EA05,0xE9D300,0xEFDD00,0xAD8E00,0xEAE000,0xEAE003,0xE2CB00,0xF5F600,0xE4AB03,0xA78601, _
																		  0xF8CB00,0xF8E600,0xF8FC00,0xE3DE00,0xDACC00,0xC4A400,0xF4D400,0xC5A100,0xAE8C00,0xECC700, _
																		  0xCFAA00,0xE1CD00,0x938A1D,0xE1C100,0xE4D800,0xF6F600,0x946F02,0x9E7A00,0xDAC612,0xC7AE00, _
																		  0xC5A300,0xE3B600,0xCBA300,0xDCC000,0xB08300,0xB98E00,0xE4C101,0xE3C000,0xF6E200,0xECDF00, _
																		  0xE3CC00,0xB18E00,0xE0A900,0x9A7E00,0xEAB601,0xE4C000,0xAB8800,0xF6E300,0xE6B400,0xF6E000, _
																		  0xDCC800,0xF7E900,0xF1BF00,0xD7C112,0xE3CD02,0xECB100,0xC8AF03,0xCC9D00,0xE2D100,0xF8DE00, _
																		  0xF0D000,0xF7E500,0xAF8300,0xC0AF00,0xE3B700,0xDDAA00,0xEEB700,0xDDD628,0xE8C902,0x7D6101, _
																		  0xF8DB00,0xCEA800,0xC29D00,0xDDC500,0xC4A300,0xECAD01,0xEAB500,0xD8B900,0xE1D000,0xB89429, _
																		  0xD7BF16,0xEBC700,0xA59103,0x967A08,0xB28A00,0xB59101,0xBD9802,0xB48B00,0xB9A930,0xB19400, _
																		  0xBF980C,0xE5C41F,0xB99410,0xCDA92E,0xD2A71D,0xCCA641,0xBF9F32,0xA68500,0xB69A46,0xD3AE08, _
																		  0xC7A015,0xB89209,0xC39F0B,0xCDA51F,0xC39F09,0xBD9A00,0xBF9C02,0xCDA704,0xDBB417,0xB99304, _
																		  0xB79300,0xB28F00,0xBE9A04,0xBC9925,0xCBA826,0xD0B108,0xA27600,0xAF8F00,0xE2B524,0xA78601, _
																		  0xC6AA0B]

;Goldish ones

;Gave up doing mines and collectors due to the highly random nature of the pixels

;Global $pixelSearch??????Colors[6]=["Name",???,????,????,????,????]
;

