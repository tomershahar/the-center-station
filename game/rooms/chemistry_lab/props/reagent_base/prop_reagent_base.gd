extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.chemistry_complete:
		await C.Nathe.say("The base compound — key to the mineral core layer.")
		return

	if room.get_meta("base_tested", false):
		await C.Nathe.say("The base had some effect — the sample shrank slightly. Something in there reacts to it.")
		return

	room.set_meta("base_tested", true)
	await C.Nathe.say("Adding the base compound...")
	await C.Nathe.say("It shrank slightly. Some effect — but not much. The outer layer barely responded.")
	await C.Roger.say("Partial response. Something inside reacts to it. Not the surface.")
	await C.Nathe.say("So the base affects whatever is underneath. Not the lipid layer on top.")


func _on_right_click() -> void:
	await C.Nathe.say("Blue bottle. Base compound. Reacts with mineral structures.")
