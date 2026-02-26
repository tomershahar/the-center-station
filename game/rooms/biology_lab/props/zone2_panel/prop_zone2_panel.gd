extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.biology_complete:
		await C.Nathe.say("Zone 2 organisms have unified. Comfortable conditions maintained. All factions cooperating.")
		return

	var zone2_seen: bool = Globals.bio_zone2_seen
	var zone1_stressed_seen: bool = Globals.bio_zone1_stressed_seen
	var zone2_comforted: bool = Globals.bio_zone2_comforted

	if zone2_comforted:
		await C.Nathe.say("Zone 2 organisms — one unified color. Comfortable conditions, unified colony. The reverse of what stress does.")
		return

	if not zone2_seen:
		Globals.bio_zone2_seen = true
		await C.Nathe.say("Zone 2 environmental panel. Currently: 14°C, minimal lighting, 20% humidity.")
		await C.Roger.say("Organisms in Zone 2 are sparse. Two distinct color signatures — red and blue clusters. Completely separated.")
		await C.Nathe.say("Harsh conditions. And the organism has split into factions. I'll note this.")
		return

	if not zone1_stressed_seen:
		await C.Nathe.say("Two distinct factions in Zone 2. They're not mixing. The cold, dark environment is clearly doing something to them.")
		return

	# Zone 1 has been stressed and observed splitting — now reverse Zone 2
	await ARIA.say("Adjusting Zone 2 environment. Note: adjusting greenhouse climate will void Current Crop Insurance Policy. Proceed?")
	await C.Nathe.say("...Yes, ARIA. Proceed.")
	await C.Nathe.say("Raising temperature... increasing light... bringing humidity up...")
	Globals.bio_zone2_comforted = true
	await E.wait(0.8)
	await C.Roger.say("Zone 2 organisms — the two factions are moving toward each other. The red and blue are blending.")
	await C.Nathe.say("They're merging. The factions are unifying under comfortable conditions.")
	await C.Roger.say("Complete merger. One color. One colony.")
	await C.Nathe.say("Stress causes factions. Comfort causes unity. I have the controlled experiment data.")
	await E.wait(0.5)
	await C.Nathe.say("This confirms my thesis!")
	await C.Roger.say("The thesis with the simulated data that—")
	await C.Nathe.say("MOVING ON.")
	await E.wait(0.5)
	await C.Nathe.say("Organism Reproduction Data logged. Environmental conditions directly influence faction formation and dissolution.")
	Globals.biology_complete = true
	Globals.has_reproduction_data = true
	C.Roger.stop_hints()
	Globals.check_observation_unlock()


func _on_right_click() -> void:
	await C.Nathe.say("Zone 2 environmental controls. Much colder and darker than standard lab conditions.")
