extends PopochiuProp

# Step 5 — Social: Open the airlock, C departs, B stabilizes, ending sequence.

func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.final_complete:
		await C.Nathe.say("The airlock is sealed again. C is on the other side — on the planet surface. B holds the station.")
		return

	var room = get_parent().get_parent()

	if not room.get_meta("step3_done", false):
		# Partial implementation of wrong-order consequence: ARIA opens it, but passage is blocked
		if room.get_meta("step1_done", false) or room.get_meta("step2_done", false):
			await C.Nathe.say("A's growth is still physically blocking the airlock passage. Opening the door won't help C if there's a wall of organism in the way.")
		else:
			await C.Nathe.say("I need to clear A's growth from the passage before opening the airlock. Otherwise C just hits a wall.")
		return

	# Trigger ending sequence
	await C.Nathe.say("ARIA. I need to open the Section 7 airlock. Waste Disposal Protocol 9-A.")
	await ARIA.say("Initiating Waste Disposal Protocol 9-A. Airlock Section 7 opening. Note: current contents may include live biological material. Have a productive day.")
	await E.wait(0.5)
	await C.Roger.say("Nathe. Look.")
	await C.Nathe.say("C is moving through the passage. All of Faction C — streaming toward the airlock.")
	await C.Roger.say("And A's remaining sub-factions... some of them are following. The weakest fragments are taking the exit rather than hold a losing position.")
	await C.Nathe.say("B is expanding into the space they're leaving. The room is changing color.")
	await E.wait(0.8)
	await C.Roger.say("Airlock sealed. C is on the other side. Heading for the planet surface.")
	await C.Nathe.say("ARIA — organism threat assessment.")
	await ARIA.say("Organism threat level reclassified from CRITICAL to MANAGEABLE. Protocol 7: cancelled. Reason: reclassification. Have a productive day.")
	await E.wait(0.8)
	await C.Roger.say("So. Should I put the coffee on?")
	await C.Nathe.say("...I still don't know how the machine works.")
	await C.Roger.say("I know.")
	Globals.final_complete = true
	C.Roger.stop_hints()
	await E.wait(1.5)

	# Roll credits
	var cl := CanvasLayer.new()
	cl.layer = 100
	get_tree().root.add_child(cl)
	var credits := preload("res://game/credits/credits.tscn").instantiate()
	cl.add_child(credits)
	await credits.done
	cl.queue_free()


func _on_right_click() -> void:
	await C.Nathe.say("Airlock controls for Section 7. The only pressurized exit to the planet surface. The whole game has been about this door.")
