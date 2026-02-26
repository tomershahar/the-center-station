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

	if _all_decoded():
		await _run_discovery()


func _on_right_click() -> void:
	await C.Nathe.say("One of three data monitors. The pattern looks almost mathematical.")


func _all_decoded() -> bool:
	return (Globals.cc_monitor_a_decoded
		and Globals.cc_monitor_b_decoded
		and Globals.cc_monitor_c_decoded)


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
