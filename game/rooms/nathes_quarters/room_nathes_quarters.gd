@tool
extends PopochiuRoom

const Data := preload("room_nathes_quarters_state.gd")

var state: Data = load("res://game/rooms/nathes_quarters/room_nathes_quarters.tres")


func _on_room_entered() -> void:
	if not SaveManager.title_shown:
		SaveManager.title_shown = true
		var cl := CanvasLayer.new()
		cl.layer = 100
		get_tree().root.add_child(cl)
		var title := preload("res://game/title_screen/title_screen.tscn").instantiate()
		cl.add_child(title)
		await title.done
		# If Continue was chosen, E.load_game navigated away — this
		# coroutine was already abandoned before reaching here.

	_update_organism_spread()
	if not Globals.opening_played:
		await _run_opening_sequence()
	else:
		if not Globals.tutorial_complete:
			await C.Roger.setup_room_hints(_get_tutorial_hints())


func _on_room_transition_finished() -> void:
	pass


func _on_room_exited() -> void:
	pass


func _run_opening_sequence() -> void:
	Globals.opening_played = true
	# Position characters — Nathe at desk, Roger in charging dock (powered off)
	C.Nathe.position = $Props/Desk.position + Vector2(20, 0)
	C.Roger.position = $Props/ChargingDock.position
	C.Roger.visible = false

	await E.queue([
		C.Nathe.queue_say("Okay, simulation step 47... if the organism's cellular density is proportional to the growth coefficient, then — yes. YES. That's it."),
	])

	await ARIA.say("Good morning, Dr. %s. Station time: 07:14. You have zero scheduled appointments, zero pending messages, and zero active research assignments. Have a productive day." % Globals.player_name)

	await E.queue([
		C.Nathe.queue_say("...Every morning. Same thing."),
		C.Nathe.queue_say("Coffee. Need coffee. Then I can figure out why this simulation isn't converging."),
	])

	await C.Nathe.walk_to($Props/CoffeeMachine.position)

	await E.queue([
		C.Nathe.queue_say("Okay, press the button, get the coffee, save the —"),
		C.Nathe.queue_say("...it's not working. Is there water? Of course there's no water. WHY IS THERE NO WATER?"),
		C.Nathe.queue_say("The flow rate must have dropped below the minimum threshold. If I calculate the pressure differential—"),
	])

	# Roger powers on
	await E.wait(0.5)
	C.Roger.visible = true
	await C.Roger.say("The water tank is empty.")

	await E.queue([
		C.Nathe.queue_say("...I was getting to that."),
		C.Roger.queue_say("Sure."),
	])

	await ARIA.say("Personal assistant unit ROGER-7 communication preference requires annual reconfiguration. Please select from the following options.")
	await C.Roger.say("She asks every year. I don't actually change.")
	await ARIA.say("Compliance is mandatory.")

	await D.RogerModeDialog.start()

	await C.Roger.say("Noted. I'll be exactly as helpful as I always am.")

	# Station shakes
	await E.wait(0.5)
	await E.queue([
		C.Nathe.queue_say("Whoa —"),
	])

	await ARIA.say("Anomaly detected in Biology Lab. Unidentified biological growth exceeding containment parameters. Initiating Hazard Containment Protocol. All station modules sealed. Protocol 7 — Station Sterilization — will activate in 6 hours if threat is not neutralized. Have a productive day.")

	await E.queue([
		C.Roger.queue_say("Did she just say sterilization?"),
		C.Nathe.queue_say("She means the station."),
		C.Roger.queue_say("With us in it?"),
		C.Nathe.queue_say("...I should probably look into this."),
	])

	# Nathe walks to door, finds it locked
	await C.Nathe.walk_to($Hotspots/ExitDoor.position)
	await C.Nathe.say("And it's locked. Great start to the morning.")

	await C.Roger.setup_room_hints(_get_tutorial_hints())


func _update_organism_spread() -> void:
	var existing = get_node_or_null("OrganismGrowthOverlay")
	if existing:
		existing.queue_free()
	if not Globals.biology_complete:
		return
	var overlay := ColorRect.new()
	overlay.name = "OrganismGrowthOverlay"
	overlay.color = Color(0.0, 0.4, 0.0, 0.25)
	overlay.size = Vector2(320, 180)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.z_index = -1
	add_child(overlay)


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
