extends PopochiuProp

# Monitor A — Chemistry data, Faction A strategy: expansion (inflates all values)

func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.math_complete:
		await C.Nathe.say("Faction A — expansion. They took my chemistry results and multiplied every value. More, bigger, proliferate.")
		return

	if Globals.cc_monitor_a_decoded:
		await C.Nathe.say("Faction A's pattern. Expansion strategy — using my molecular weight ratios, all scaled up.")
		return

	if not Globals.has_frequency_map:
		await C.Nathe.say("The pattern is structured but I can't make sense of it yet. I need more data from the other labs first.")
		return

	if not Globals.cc_research_log_read:
		await C.Nathe.say("Numbers cycling in a pattern. Structured, not random — but I can't place them. I should check the research log on Monitor 4.")
		return

	if not Globals.has_chemical_analysis:
		await C.Nathe.say("This pattern references chemical data I haven't gathered yet. I need to complete the Chemistry Lab first.")
		return

	# Decode Monitor A
	await C.Nathe.say("These values... these are the molecular weight ratios from my spectrometer analysis.")
	await C.Roger.say("Every value is scaled up. Consistently larger than your source data by the same factor.")
	await C.Nathe.say("The organism took my chemistry results and amplified them. Inflated. Every number bigger than reality.")
	await C.Roger.say("That's not noise. That's a position. More. Larger. Expand.")
	await C.Nathe.say("Faction A's message: expansion. Proliferate. Don't stop growing.")
	Globals.cc_monitor_a_decoded = true

	if get_parent().get_parent()._all_decoded():
		await get_parent().get_parent()._run_discovery()


func _on_right_click() -> void:
	await C.Nathe.say("One of three data monitors. The pattern looks almost mathematical.")
