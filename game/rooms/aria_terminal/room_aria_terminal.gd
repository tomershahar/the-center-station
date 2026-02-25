extends PopochiuRoom


func _on_room_entered() -> void:
	await C.Roger.setup_room_hints(_get_hints())
	if not Globals.protocol_reclassification_complete:
		await ARIA.say("Research Classification Terminal: available. Current organism status: HAZARD. Labs: SEALED. Have a productive day.")


func _get_hints() -> Dictionary:
	if not Globals.protocol_reclassification_complete:
		return {
			"tier1_talkative": "The protocol tree is on screen. There's always an exception clause.",
			"tier1_balanced": "ARIA follows rules. Rules have exceptions.",
			"tier1_quiet": "Read the protocol.",
			"tier2_talkative": "Research Exception — 4-C. That sounds promising.",
			"tier2_balanced": "Look for a research exception in the protocol tree.",
			"tier2_quiet": "Exception clause.",
			"tier3_talkative": "You need a supervisor to sign off. Who's the most senior researcher on this station, Nathe?",
			"tier3_balanced": "So you need someone senior to approve it. Look around, Nathe.",
			"tier3_quiet": "Who's senior here?",
		}
	return {}
