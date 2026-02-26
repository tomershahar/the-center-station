extends PopochiuRoom


func _on_room_entered() -> void:
	await C.Roger.setup_room_hints(_get_hints())


func _get_hints() -> Dictionary:
	if Globals.biology_complete:
		return {}
	return {
		"tier1_talkative": "Three zones, three results. What's different about the environments?",
		"tier1_balanced": "Two zones, two different outcomes.",
		"tier1_quiet": "",
		"tier2_talkative": "Zone 1 is comfortable and unified. Zone 2 is harsh and divided. Coincidence?",
		"tier2_balanced": "The environments are different. So are the organisms.",
		"tier2_quiet": "Environment matters.",
		"tier3_talkative": "What happens if you change the conditions? Make Zone 1 uncomfortable and see.",
		"tier3_balanced": "Change the conditions. See what happens.",
		"tier3_quiet": "Change Zone 1's conditions.",
	}
