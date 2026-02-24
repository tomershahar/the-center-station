@tool
extends PopochiuProp

var _nathe_in_bed: bool = false


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.tutorial_complete:
		await C.Nathe.say("My bed. Very comfortable. Despite the incident this morning.")
		return

	if _nathe_in_bed:
		# Getting out of bed — completes the state transition ARIA needs
		_nathe_in_bed = false
		await C.Nathe.say("Okay... getting out of bed. Again. For science.")
		await ARIA.say("Rest cycle complete. Wake-up sequence registered. Secondary lock: DISENGAGED. Have a productive day.")
		Globals.tutorial_complete = true
		C.Roger.stop_hints()
		get_tree().current_scene.get_node("Hotspots/ExitDoor").enabled = true
		await E.queue([
			C.Roger.say("I can't believe that worked."),
			C.Nathe.say("I can't believe the solution to a galaxy-ending crisis started with me getting back into bed."),
			C.Roger.say("I can."),
		])
	else:
		# Getting into bed — first step of state transition
		_nathe_in_bed = true
		await E.queue([
			C.Nathe.say("Right. Okay. Getting back in bed. Just to satisfy the bureaucratic sensor. Not because I'm tired."),
			C.Nathe.say("...Although I AM tired."),
		])


func _on_right_click() -> void:
	await C.Nathe.say("My bed. Very comfortable. Despite the incident this morning where I rolled onto the floor and apparently broke causality.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()
