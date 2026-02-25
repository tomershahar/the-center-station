extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.observation_unlocked:
		await G.goto_room("ObservationDeck")
	else:
		await C.Nathe.say("The observation deck is locked. I need to finish the lab research first.")


func _on_right_click() -> void:
	if Globals.observation_unlocked:
		await C.Nathe.say("Observation deck. Where this whole situation comes into focus.")
	else:
		await C.Nathe.say("Observation deck. Sealed until all research is complete.")
