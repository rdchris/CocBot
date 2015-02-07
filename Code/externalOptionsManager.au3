
Func externalOptionsManager_configureMasterSettings()
	$masterSettings_scriptOn = IniRead("settings.ini", "Activation", "masterSettings_scriptOn", "")

	$masterSettings_boostBarracks = IniRead("settings.ini", "Attack Settings", "masterSettings_boostBarracks", "")
	$masterSettings_usePotion = IniRead("settings.ini", "Attack Settings", "masterSettings_usePotion", "")
	$masterSetings_PotionType = IniRead("settings.ini", "Attack Settings", "masterSetings_PotionType", "")
	$masterSettings_attackActiveYorN = IniRead("settings.ini", "Attack Settings", "masterSettings_attackActiveYorN", "")
	$masterSettings_attacksToExecute = IniRead("settings.ini", "Attack Settings", "masterSettings_attacksToExecute", "")

	$masterSettings_attackType = IniRead("settings.ini", "Attack Army Options", "masterSettings_attackType", "")
	$masterSettings_attackTypeOption = IniRead("settings.ini", "Attack Army Options", "masterSettings_attackTypeOption", "")

	$masterSettings_goldValue = IniRead("settings.ini", "Loot Options", "masterSettings_goldValue", "")
	$masterSettings_elixirValue = IniRead("settings.ini", "Loot Options", "masterSettings_elixirValue", "")
	$masterSettings_deValue = IniRead("settings.ini", "Loot Options", "masterSettings_deValue", "")

	;Value to attack !!Important!!
	$masterSettings_attackOnValueInactive = IniRead("settings.ini", "Loot Options", "masterSettings_attackOnValueInactive", "")
	$masterSettings_attackOnValueInactiveUsePotions = IniRead("settings.ini", "Loot Options", "masterSettings_attackOnValueInactiveUsePotions", "")

	$masterSettings_attackOnValueActive = IniRead("settings.ini", "Loot Options", "masterSettings_attackOnValueActive", "")
	$masterSettings_attackOnValueInactiveUsePotions = IniRead("settings.ini", "Loot Options", "masterSettings_attackOnValueInactiveUsePotions", "")

	$masterSettings_attackOnValueInactiveBOOSTING = IniRead("settings.ini", "Loot Options", "masterSettings_attackOnValueInactiveBOOSTING", "")
	$masterSettings_attackOnValueActiveBOOSTING = IniRead("settings.ini", "Loot Options", "masterSettings_attackOnValueActiveBOOSTING", "")

	$masterSettings_trophyRangeStartingRange = IniRead("settings.ini", "Trophy Options", "masterSettings_trophyRangeStartingRange", "")
	$masterSettings_trophyRangeEndingRange = IniRead("settings.ini", "Trophy Options", "masterSettings_trophyRangeEndingRange", "")

	$masterSettings_takeScreenshotOfAttackedBases = IniRead("settings.ini", "Screenshots", "masterSettings_takeScreenshotOfAttackedBases", "")
	$masterSettings_takeScreenshotOfDisconnections = IniRead("settings.ini", "Screenshots", "masterSettings_takeScreenshotOfDisconnections", "")
	$masterSettings_lootScreenshotPath = IniRead("settings.ini", "Screenshots", "masterSettings_lootScreenshotPath", "")

EndFunc