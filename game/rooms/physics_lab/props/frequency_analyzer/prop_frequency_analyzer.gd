extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.physics_complete:
		await C.Nathe.say("Three clean bands. Faction A, B, and C — all mapped.")
		return
	var room = get_parent().get_parent()
	if room.all_dishes_aligned():
		await C.Nathe.say("Three separate bands, all locked in.")
		return
	await C.Nathe.say("The frequency analyzer is showing overlapping waveforms — three signals all crammed on top of each other.")
	await C.Roger.say("Three dishes, three different problems.")
	await C.Nathe.say("Dish 1 I can handle directly from the console here. Dish 2 needs the junction rewired — the diagram's over there. Dish 3 runs through ARIA's comms array.")


func _on_right_click() -> void:
	await C.Nathe.say("A frequency analyzer. It maps signal patterns from the external dish array.")
