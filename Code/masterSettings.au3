; Master Settings!

;Attack Settings
Global $masterSettings_scriptOn="Y"
Global $masterSettings_attackType="BARCH"      ;options GAB, BARCH
Global $masterSettings_boostBarracks="N"
Global $masterSettings_attackActiveYorN="Y"

Global $masterSettings_attacksPerSession[2][2]=[["Low End",211],["High End",300]] ;Boosting
;Global $masterSettings_attacksPerSession[2][2]=[["Low End",3],["High End",4]] ;Boosting
;Global $masterSettings_attacksPerSession[2][2]=[["Low End",25],["High End",37]]
;Global $masterSettings_attacksPerSession[2][2]=[["Low End",5],["High End",8]]
;Global $masterSettings_attacksPerSession[2][2]=[["Low End",8],["High End",11]]

;Loot Values!
Global $masterSettings_goldValue=1
Global $masterSettings_elixirValue=1
Global $masterSettings_deValue=10

Global $masterSettings_miniumGoldValue=120000
Global $masterSettings_miniumElixirValue=120000
Global $masterSettings_miniumDarkElixirValue=0

Global $masterSettings_attackOnValueInactive=250000
Global $masterSettings_attackOnValueInactive=250000
Global $masterSettings_attackOnValueActive=350000

Global $masterSettings_attackOnValueInactiveBOOSTING=150000
Global $masterSettings_attackOnValueActiveBOOSTING=200000

;Hero Settings
Global $masterSettings_dropHeros="Y"

;Timer for bot                                   Hour, Chance to Launch Bot, Chance to kill bot
Global $masterSettings_launchOrKillChance[24][3]=[[00,100,0],[01,100,0],[02,100,0],[03,100,0],[04,100,0],[05,100,0],[06,100,0],[07,100,0],[08,100,0],[09,100,0],[10,100,0],[11,100,0],[12,100,0],[13,100,00],[14,100,00],[15,100,00],[16,0,20],[17,0,50],[18,0,100],[19,0,100],[20,0,100],[21,0,100],[22,25,0],[23,75,00]]

;Global $masterSettings_dropQueenValueOnInactive=300000
;Global $masterSettings_dropQueenValueActive=400000

;Global $masterSettings_dropKingValueOnInactive=400000
;Global $masterSettings_dropKingValueActive=400000


#cs
;Loot Value multiplies
;The purpose of this is to look for more loot at odd hours and less during busy hours
Global $masterSettings_lootPercentageMultiplier[24][2]=[	[00,1.0],[01,1.1],[02,1.2],[03,1.3],[04,1.3],[05,1.2],[06,1.1],[07,1.0],[08,1.0],[09,1.0],[10,1.0],[11,1.0],_
															[12,1.0],[13,1.0],[14,1.0],[15,1.0],[16,0.9],[17,0.9],[18,0.9],[19,0.8],[20,0.8],[21,0.8],[22,0.9],[23,1.0]]
															#ce