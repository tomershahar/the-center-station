extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.biology_complete:
		await C.Nathe.say("Zone 3 is still actively splitting. Moderate conditions, perpetual division. A control group that never resolved.")
		return

	var zone3_seen: bool = Globals.bio_zone3_seen

	if not zone3_seen:
		Globals.bio_zone3_seen = true
		await C.Nathe.say("Zone 3 observation port. Moderate conditions — 20°C, medium lighting, 45% humidity.")
		await C.Nathe.say("The organisms here are actively dividing. Mid-split. Some cells halfway between one color and two.")
		await C.Roger.say("Zone 3 is in a state of active fission. Real-time organism faction formation. Logging the process.")
		await C.Nathe.say("A snapshot of the process in action. This is what Zone 1 and Zone 2 must have looked like mid-transition.")
		return

	await C.Nathe.say("Zone 3 organisms are still splitting. Moderate stress, perpetual division. Caught in the middle.")
	await C.Roger.say("Ongoing fission event. Zone 3 never stabilizes in either direction.")


func _on_right_click() -> void:
	await C.Nathe.say("The Zone 3 observation port. Tempered glass panel, scratched from previous experiments.")
