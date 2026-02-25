extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.labs_unlocked:
		await G.goto_room("ComputerCore")
	else:
		await C.Nathe.say("Sealed. Hazard Containment Protocol. I need to get the labs reclassified first.")


func _on_right_click() -> void:
	if Globals.labs_unlocked:
		await C.Nathe.say("Computer Core. Numbers, data, and probably more bureaucratic forms.")
	else:
		await C.Nathe.say("Sealed. All four labs, same protocol.")
