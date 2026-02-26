extends PopochiuRoom


func _on_room_entered() -> void:
	_update_door_states()
	await _organism_observation()
	await C.Roger.setup_room_hints(_get_hints())


func _organism_observation() -> void:
	if Globals.act <= Globals.growth_noted_corridor:
		return
	Globals.growth_noted_corridor = Globals.act
	match Globals.act:
		2:
			await C.Nathe.say("Patches of growth on the corridor walls. Pale green-grey. The organism is expanding out from the Biology sector.")
		3:
			await C.Nathe.say("The growth has spread to most of the corridor now. It's faintly pulsing. The station looks like it's breathing.")
			await C.Roger.say("Atmospheric.")


func _update_door_states() -> void:
	$Hotspots/ToChemistryLab.enabled = Globals.labs_unlocked
	$Hotspots/ToPhysicsLab.enabled = Globals.labs_unlocked
	$Hotspots/ToBiologyLab.enabled = Globals.labs_unlocked
	$Hotspots/ToComputerCore.enabled = Globals.labs_unlocked
	$Hotspots/ToObservationDeck.enabled = Globals.observation_unlocked


func _get_hints() -> Dictionary:
	if not Globals.protocol_reclassification_complete:
		return {
			"tier1_talkative": "ARIA terminal's down the main corridor. That's your best bet for getting those lab doors open.",
			"tier1_balanced": "ARIA terminal. Protocol might have an exception clause.",
			"tier1_quiet": "ARIA terminal.",
			"tier2_talkative": "The lab doors are all sealed under Hazard Protocol. But protocols have exceptions — check the terminal.",
			"tier2_balanced": "Terminal. Look for a research exception.",
			"tier2_quiet": "Exception clause.",
			"tier3_talkative": "Reclassify the organism from 'hazard' to 'research subject' and ARIA has to open the labs.",
			"tier3_balanced": "Reclassify the hazard.",
			"tier3_quiet": "Research exception.",
		}
	return {}
