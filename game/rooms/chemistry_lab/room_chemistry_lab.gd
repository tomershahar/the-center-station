extends PopochiuRoom


func _on_room_entered() -> void:
	await C.Roger.setup_room_hints(_get_hints())


func _get_hints() -> Dictionary:
	if Globals.chemistry_complete:
		return {}
	return {
		"tier1_talkative": "Two layers — oily outside, crystal inside. The whiteboard mentions that too.",
		"tier1_balanced": "Two layers. Might need two approaches.",
		"tier1_quiet": "Interesting structure.",
		"tier2_talkative": "You tried one thing at a time. What about handling each layer separately?",
		"tier2_balanced": "The organic solvent only got the surface. What about what's underneath?",
		"tier2_quiet": "Two layers.",
		"tier3_talkative": "Strip the outer layer first with the solvent. Then hit the core with the base.",
		"tier3_balanced": "Outer layer, then inner layer. In that order.",
		"tier3_quiet": "Outside first, then inside.",
	}
