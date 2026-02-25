extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.labs_unlocked:
		await G.goto_room("PhysicsLab")
	else:
		await C.Nathe.say("Sealed. Hazard Containment Protocol. I need to get the labs reclassified first.")


func _on_right_click() -> void:
	if Globals.labs_unlocked:
		await C.Nathe.say("Physics Lab. The good kind of physics — not the kind that explains why my experiments keep exploding.")
	else:
		await C.Nathe.say("Locked down like the rest.")
