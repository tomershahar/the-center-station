extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if not Globals.labs_unlocked:
		await C.Nathe.say("An exposed maintenance panel. Lots of wiring. I should focus on the protocol reclassification first.")
		return
	if Globals.physics_complete:
		await C.Nathe.say("The wiring is all sorted. Dish 2 is connected and operational.")
		return
	# Physics puzzle - Dish 2 wiring (used in physics lab puzzle)
	await C.Nathe.say("Maintenance panel. I can see the relay connections for the external dishes. Dish 2 is disconnected — I'd need the right configuration from the physics lab to know how to reconnect it.")


func _on_right_click() -> void:
	await C.Nathe.say("An exposed wall panel. Someone was doing maintenance and got interrupted. Story of this station.")
