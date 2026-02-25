extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.chemistry_complete:
		await C.Nathe.say("The saline did absolutely nothing. Good control test.")
		return

	if room.get_meta("saline_tested", false):
		await C.Nathe.say("Saline. Completely inert against the sample.")
		return

	room.set_meta("saline_tested", true)
	await C.Nathe.say("Standard saline solution. Good for a control test...")
	await C.Nathe.say("Nothing. Absolutely nothing.")
	await C.Roger.say("Noted.")
	await C.Nathe.say("At least we know it's not salt-sensitive.")


func _on_right_click() -> void:
	await C.Nathe.say("Clear bottle. Saline solution. Used as a control.")
