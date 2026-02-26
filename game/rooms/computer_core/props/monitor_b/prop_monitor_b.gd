extends PopochiuProp

# Monitor B — Physics data, Faction B strategy: balance (corrects to exact original values)

func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.math_complete:
		await C.Nathe.say("Faction B — precision. They corrected my frequency rounding errors to communicate. Balance and accuracy.")
		return

	if room.get_meta("monitor_b_decoded", false):
		await C.Nathe.say("Faction B's pattern. Precision strategy — using my frequency calibration data, corrected to exact values.")
		return

	if not Globals.has_frequency_map:
		await C.Nathe.say("The pattern is structured but I can't decode it yet. The Physics Lab frequency data is required.")
		return

	if not room.get_meta("research_log_read", false):
		await C.Nathe.say("Numbers cycling in a pattern. Structured, not random — but I can't place them. I should check the research log on Monitor 4.")
		return

	# Decode Monitor B — physics is always available by the time this puzzle is accessible
	await C.Nathe.say("These values — the frequency calibration readings from the dish alignment in Physics.")
	await C.Roger.say("But they're not your measurements. These are the exact correct values. The organism filled in your approximations.")
	await C.Nathe.say("It corrected my rounding errors? Every approximation I made — it's giving me the true precise frequency.")
	await C.Roger.say("Not inflated. Not reduced. Exactly right.")
	await C.Nathe.say("Faction B's message: accuracy. Return to the true value. Maintain precision. That's their strategy — balance.")
	room.set_meta("monitor_b_decoded", true)

	if _all_decoded(room):
		await _run_discovery()


func _on_right_click() -> void:
	await C.Nathe.say("One of three data monitors. The numbers keep cycling. Somehow familiar.")


func _all_decoded(room: Node) -> bool:
	return (room.get_meta("monitor_a_decoded", false)
		and room.get_meta("monitor_b_decoded", false)
		and room.get_meta("monitor_c_decoded", false))


func _run_discovery() -> void:
	await C.Nathe.say("Three factions. Three strategies. And they encoded them using MY data.")
	await C.Roger.say("Faction A: expand. Faction B: maintain precision. Faction C: minimize and retreat.")
	await C.Nathe.say("They've been watching every experiment I ran. Formulating a response.")
	await E.wait(0.8)
	await C.Roger.say("Nathe. Look at the screens.")
	await C.Roger.say("All three patterns just synchronized. Briefly.")
	await C.Nathe.say("They're arguing in real time. Using my methodology as the medium.")
	await C.Roger.say("And now separating again. Back to their disagreement.")
	await E.wait(0.5)
	await C.Nathe.say("It's using MY data? That's... actually flattering.")
	await C.Roger.say("It's been watching your every experiment and judging your methodology. Less flattering.")
	await C.Nathe.say("...it corrected my rounding errors.")
	await C.Roger.say("Faction B did. Faction A thought your numbers weren't big enough.")
	await C.Nathe.say("I don't know if I should be offended or impressed.")
	await E.wait(0.5)
	await C.Nathe.say("Faction Communication Decode logged. Three factions, three strategies. They're not in agreement — but they ARE intelligent.")
	Globals.math_complete = true
	Globals.has_faction_decode = true
	C.Roger.stop_hints()
	Globals.check_observation_unlock()
