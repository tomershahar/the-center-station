extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if not room.get_meta("textbook_read", false):
		room.set_meta("textbook_read", true)

	await C.Nathe.say("'Xenobiological Adaptation Theory, Third Edition.' Let me check the relevant chapter...")
	await E.wait(0.5)
	await C.Nathe.say("'Under sustained environmental stress, the organism exhibits rapid fission-based colony segmentation, producing genetically distinct subpopulations.'")
	await C.Nathe.say("'This diversification strategy increases survivability under hostile conditions by distributing genetic variance across multiple subgroups.'")
	await C.Roger.say("Stress causes splitting. It's a survival mechanism.")
	await C.Nathe.say("And the corollary: comfortable conditions remove the pressure to diversify. Factions would have no reason to stay separate.")


func _on_right_click() -> void:
	await C.Nathe.say("Standard xenobiology reference. Pre-infection era. Whoever wrote this had no idea what they were describing.")
