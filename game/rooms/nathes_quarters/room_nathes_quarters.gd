@tool
extends PopochiuRoom

const Data := preload("room_nathes_quarters_state.gd")

var state: Data = load("res://game/rooms/nathes_quarters/room_nathes_quarters.tres")

var _opening_done: bool = false


func _on_room_entered() -> void:
	if not _opening_done:
		_opening_done = true
		await _run_opening_sequence()
	else:
		if not Globals.tutorial_complete:
			C.Roger.setup_room_hints(_get_tutorial_hints())


func _on_room_transition_finished() -> void:
	pass


func _on_room_exited() -> void:
	pass


func _run_opening_sequence() -> void:
	await E.queue([
		C.Nathe.say("Okay, simulation step 47... if the organism's cellular density is proportional to the growth coefficient, then — yes. YES. That's it."),
	])

	await ARIA.say("Good morning, Dr. %s. Station time: 07:14. You have zero scheduled appointments, zero pending messages, and zero active research assignments. Have a productive day." % Globals.player_name)

	await E.queue([
		C.Nathe.say("...Every morning. Same thing."),
		C.Nathe.say("Coffee. Need coffee. Then I can figure out why this simulation isn't converging."),
	])

	await E.queue([
		C.Nathe.say("Okay, press the button, get the coffee, save the —"),
		C.Nathe.say("...it's not working. Is there water? Of course there's no water. WHY IS THERE NO WATER?"),
		C.Nathe.say("The flow rate must have dropped below the minimum threshold. If I calculate the pressure differential—"),
		C.Roger.say("The water tank is empty."),
		C.Nathe.say("...I was getting to that."),
		C.Roger.say("Sure."),
	])

	await ARIA.say("Personal assistant unit ROGER-7 communication preference requires annual reconfiguration. Please select from the following options.")
	await C.Roger.say("She asks every year. I don't actually change.")
	await ARIA.say("Compliance is mandatory.")

	await D.RogerModeDialog.start()

	await C.Roger.say("Noted. I'll be exactly as helpful as I always am.")

	await E.queue([
		C.Nathe.say("Whoa —"),
	])

	await ARIA.say("Anomaly detected in Biology Lab. Unidentified biological growth exceeding containment parameters. Initiating Hazard Containment Protocol. All station modules sealed. Protocol 7 — Station Sterilization — will activate in 6 hours if threat is not neutralized. Have a productive day.")

	await E.queue([
		C.Roger.say("Did she just say sterilization?"),
		C.Nathe.say("She means the station."),
		C.Roger.say("With us in it?"),
		C.Nathe.say("...I should probably look into this."),
		C.Nathe.say("And the door is locked. Great start to the morning."),
	])

	C.Roger.setup_room_hints(_get_tutorial_hints())


func _get_tutorial_hints() -> Dictionary:
	return {
		"tier1_talkative": "The sensor's the problem. It's a simple on-off switch — did it see you leave?",
		"tier2_talkative": "She needs to see you go from IN bed to OUT of bed. Doesn't matter what happened before.",
		"tier3_talkative": "Just... get back in bed. Then get out. Give her what she wants to see.",
		"tier1_balanced": "Binary sensor. On or off. That's all she knows.",
		"tier2_balanced": "She didn't see you leave the bed. That's the issue.",
		"tier3_balanced": "What if you just... completed the sequence she's expecting?",
		"tier1_quiet": "",
		"tier2_quiet": "It's a state change thing.",
		"tier3_quiet": "Get in. Get out. That's all she tracks.",
	}
