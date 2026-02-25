extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()
	if room._dish3_aligned:
		await C.Nathe.say("Dish 3 is already aligned through the comms array. Let's not touch it.")
		return
	if not room._dish2_aligned:
		await C.Nathe.say("I should handle Dish 2 first before messing with ARIA's comms array.")
		return
	await _request_maintenance()


func _request_maintenance() -> void:
	await C.Nathe.say("Filing Communications Maintenance Downtime Request with ARIA...")

	if not Globals.department_credentials_obtained:
		await ARIA.say("Communications Maintenance Downtime Request: DENIED. Requestor 'Dr. %s' is classified as Research Personnel. Maintenance authorizations require Department Head credentials from an Engineering or Operations department." % Globals.player_name)
		await C.Nathe.say("...She needs department credentials. Research personnel aren't authorized for maintenance overrides.")
		await C.Roger.say("You need some kind of department credentials. Maybe there's a way to get those somewhere on the station.")
		return

	await C.Nathe.say("Logging in with %s credentials..." % Globals.department_name)
	await ARIA.say("Credentials verified. %s — Department Head: Dr. %s. Maintenance authorization: APPROVED. External communications paused for scheduled calibration window: 15 minutes. Have a productive day." % [Globals.department_name, Globals.player_name])
	await C.Roger.say("Your fake department came in handy.")
	await C.Nathe.say("It's not fake, Roger. It's... creatively legitimate.")
	await C.Nathe.say("Rerouting Dish 3 through the calibration window... alignment sequence running...")
	await C.Nathe.say("Dish 3 locked. Three bands isolated.")
	var room = get_parent().get_parent()
	room._dish3_aligned = true
	if room.all_dishes_aligned():
		await room._complete_puzzle()


func _on_right_click() -> void:
	await C.Nathe.say("A terminal linked to ARIA's external communications array. Dish 3 runs through this.")
