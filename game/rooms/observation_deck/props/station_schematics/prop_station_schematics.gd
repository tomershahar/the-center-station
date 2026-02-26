extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.social_complete:
		await C.Nathe.say("Station schematics. Section 7 airlock — being cleared by the B+C coalition right now, according to the sensor readings.")
		return

	await C.Nathe.say("Station layout. The exterior is divided into sections. Section 7 — there, at the bottom — that's the pressurized airlock module. The only way out to the planet surface.")
	await C.Roger.say("And according to the sensor data, Faction A has the heaviest growth concentration directly over Section 7.")
	await C.Nathe.say("Convenient for A. Less convenient for anything that wants to leave.")
	await C.Roger.say("Or for B's goal of a stable equilibrium. A controls the exit — that's leverage.")
	await C.Nathe.say("Which means whoever controls A, controls movement between the station and the planet. That's significant.")


func _on_right_click() -> void:
	await C.Nathe.say("Station schematics. Pre-infection layout — the original design before the organism rewrote the map.")
