extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if not Globals.bio_log_read:
		Globals.bio_log_read = true

	await C.Nathe.say("Research log. Pre-containment protocol.")
	await E.wait(0.3)
	await C.Nathe.say("Entry 1: 'Initial organism cultures showing unexpected colony variation. Zone 2 sample diverging from Zone 1 control group.'")
	await C.Nathe.say("Entry 7: 'Zone 2 variation confirmed as environmental response, not genetic drift. Stress-induced.'")
	await C.Roger.say("They had the answer. They just didn't know what it meant yet.")
	await C.Nathe.say("Entry 12: 'Containment breach in Zones 1 and 3. Research suspended pending safety review.' And then... nothing.")


func _on_right_click() -> void:
	await C.Nathe.say("A greenhouse research log. Someone was onto something important before the infection took hold.")
