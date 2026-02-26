extends PopochiuProp

# Monitor 4 — Nathe's research log. Reading this enables monitor cross-referencing.

func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.math_complete:
		await C.Nathe.say("My research log. Every experiment, every data point. The organism used all of it.")
		return

	if not Globals.has_frequency_map:
		await C.Nathe.say("Station research log. My experiment records are here — but the other monitors are still showing noise I can't interpret.")
		return

	var already_read: bool = room.get_meta("research_log_read", false)

	if not already_read:
		room.set_meta("research_log_read", true)
		await C.Nathe.say("Station research log. There's a record of every experiment I've run. The frequency calibration values. The molecular weights.")
		if Globals.has_reproduction_data:
			await C.Nathe.say("The greenhouse zone growth percentages. All of it, timestamped.")
		await C.Roger.say("Nathe.")
		await C.Roger.say("The numbers on those three monitors. I've seen some of them before.")
		await C.Nathe.say("...they're in the log. The organism has been watching. Every experiment. Every data point I collected.")
		await C.Roger.say("And it's been commenting on them. The way it changes your numbers tells you what each faction thinks of your research.")
		await C.Nathe.say("It's communicating through my own data. I need to cross-reference the monitors against these records.")
	else:
		await C.Nathe.say("My research log. Frequency data, chemical analysis, biological readings. The organism is using all of it.")
		await C.Roger.say("The three monitors each correspond to a different dataset. Compare the transformations.")


func _on_right_click() -> void:
	await C.Nathe.say("Station research log — Monitor 4. My experiment records going back to the beginning of this mess.")
