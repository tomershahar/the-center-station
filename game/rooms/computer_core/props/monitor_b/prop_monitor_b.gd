extends PopochiuProp

# Monitor B — Physics data, Faction B strategy: balance (corrects to exact original values)

func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.math_complete:
		await C.Nathe.say("Faction B — precision. They corrected my frequency rounding errors to communicate. Balance and accuracy.")
		return

	if Globals.cc_monitor_b_decoded:
		await C.Nathe.say("Faction B's pattern. Precision strategy — using my frequency calibration data, corrected to exact values.")
		return

	if not Globals.has_frequency_map:
		await C.Nathe.say("The pattern is structured but I can't decode it yet. The Physics Lab frequency data is required.")
		return

	if not Globals.cc_research_log_read:
		await C.Nathe.say("Numbers cycling in a pattern. Structured, not random — but I can't place them. I should check the research log on Monitor 4.")
		return

	# Monitor B uses Physics data. The has_frequency_map check above already
	# ensures Physics Lab is complete before this point is reached.
	await C.Nathe.say("These values — the frequency calibration readings from the dish alignment in Physics.")
	await C.Roger.say("But they're not your measurements. These are the exact correct values. The organism filled in your approximations.")
	await C.Nathe.say("It corrected my rounding errors? Every approximation I made — it's giving me the true precise frequency.")
	await C.Roger.say("Not inflated. Not reduced. Exactly right.")
	await C.Nathe.say("Faction B's message: accuracy. Return to the true value. Maintain precision. That's their strategy — balance.")
	Globals.cc_monitor_b_decoded = true

	if get_parent().get_parent()._all_decoded():
		await get_parent().get_parent()._run_discovery()


func _on_right_click() -> void:
	await C.Nathe.say("One of three data monitors. The numbers keep cycling. Somehow familiar.")
