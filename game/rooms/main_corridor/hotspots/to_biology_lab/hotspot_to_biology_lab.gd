extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.labs_unlocked:
		await G.goto_room("BiologyLab")
	else:
		await C.Nathe.say("Sealed. Hazard Containment Protocol. I need to get the labs reclassified first.")


func _on_right_click() -> void:
	if Globals.labs_unlocked:
		await C.Nathe.say("Biology Lab. Where the organism was first catalogued. Full circle.")
	else:
		await C.Nathe.say("Bio-containment seals. Very thorough.")
