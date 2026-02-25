extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.act >= 2:
		await C.Nathe.say("The food station is contaminated. I'm not touching anything from here until the organism situation is resolved.")
	else:
		await C.Nathe.say("Standard station food dispenser. It produces something technically edible if you press the right buttons.")


func _on_right_click() -> void:
	if Globals.act >= 2:
		await C.Nathe.say("Contaminated. Off-limits. Probably fine. Definitely not fine.")
	else:
		await C.Nathe.say("Food station. The crew used to gather here. Now it's just me, Roger, and whatever passes for a nutritious meal at 0300.")
