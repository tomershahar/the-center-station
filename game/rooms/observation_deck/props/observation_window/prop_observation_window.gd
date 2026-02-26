extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.social_complete:
		await C.Nathe.say("Two thirds of the organism outside has synchronized — B and C holding their coalition. A's patches are still pulsing in the minority sections.")
		await C.Roger.say("A's not going anywhere quietly. But B and C have the numbers now.")
		return

	if not Globals.od_window_observed:
		Globals.od_window_observed = true
		await C.Nathe.say("The observation windows look out over the station's exterior. The organism's growth is everywhere out there.")
		await C.Nathe.say("And there — Section 7. The airlock module. It's completely covered. Faction A's growth is sitting right on top of the only exit to the planet surface.")
		await C.Roger.say("Whether intentionally or not, A has claimed the chokepoint. Nothing gets through that without clearing A first.")
		await C.Nathe.say("C wants to leave but literally cannot reach the door. That changes the negotiation completely.")
		return

	await C.Nathe.say("Faction A's growth still covers the Section 7 airlock. C can't get out without that being cleared.")
	if Globals.od_talked_to_c and not Globals.od_talked_to_b:
		await C.Roger.say("C needs an ally with an independent reason to push A back. B qualifies.")


func _on_right_click() -> void:
	await C.Nathe.say("The observation windows. Panoramic view of the station exterior — and the organism covering most of it.")
