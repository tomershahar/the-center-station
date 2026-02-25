extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.chemistry_complete:
		await C.Nathe.say("The organic solvent dissolved the outer lipid layer — first stage of the two-stage formula.")
		return

	if room.get_meta("solvent_tested", false):
		await C.Nathe.say("The organic solvent dissolved the outer layer but couldn't reach the mineral core.")
		return

	room.set_meta("solvent_tested", true)
	await C.Nathe.say("Organic solvent... oh! The outer layer is dissolving. This is actually working!")
	await C.Nathe.say("...Wait. It stopped. The lipid layer is gone but the mineral core is completely untouched.")
	await C.Roger.say("Two layers. Different chemistry. One dissolves, one doesn't.")
	await C.Nathe.say("Two layers that each need a different treatment. Strip the outer first — then hit the core.")


func _on_right_click() -> void:
	await C.Nathe.say("Yellow bottle. Organic solvent. Effective against lipid-based structures.")
