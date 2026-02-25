extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.labs_unlocked:
		await G.goto_room("ChemistryLab")
	else:
		await C.Nathe.say("Sealed. Hazard Containment Protocol. I need to get the labs reclassified first.")


func _on_right_click() -> void:
	if Globals.labs_unlocked:
		await C.Nathe.say("Chemistry Lab. Molecules and mayhem — my specialty.")
	else:
		await C.Nathe.say("Sealed tight. A red warning light for good measure.")
