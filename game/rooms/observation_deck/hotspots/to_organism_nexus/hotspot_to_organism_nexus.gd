extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.nexus_unlocked:
		C.Roger.stop_hints()
		await G.goto_room("OrganismNexus")
	else:
		await C.Nathe.say("That passage leads into the Nexus — the heart of the organism's growth. I'm not going in there until I have a plan.")


func _on_right_click() -> void:
	if Globals.nexus_unlocked:
		await C.Nathe.say("The Nexus. This is where it ends.")
	else:
		await C.Nathe.say("The passage into the organism's core. Sealed for now. I need the coalition in place first.")
