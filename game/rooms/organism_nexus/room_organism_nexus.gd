extends PopochiuRoom


func _on_room_entered() -> void:
	await C.Roger.setup_room_hints(_get_hints())
	if not Globals.final_complete:
		await ARIA.say("Warning: Protocol 7 countdown active. Station structural integrity at 34%. Recommend immediate evacuation.")
		await C.Nathe.say("Not yet, ARIA.")


func _get_hints() -> Dictionary:
	if Globals.final_complete:
		return {}
	return {
		"tier1_talkative": "Five tools. What order makes sense?",
		"tier1_balanced": "Five tools. Right order matters.",
		"tier1_quiet": "Order matters.",
		"tier2_talkative": "Stabilize your allies before you destabilize your enemy.",
		"tier2_balanced": "Secure the alliance first.",
		"tier2_quiet": "Friends first.",
		"tier3_talkative": "Physics first — calm B and C. Then biology and chemistry on A. Then talk.",
		"tier3_balanced": "Stabilize friends, then fracture the enemy, then negotiate.",
		"tier3_quiet": "Stabilize. Fracture. Negotiate.",
	}
