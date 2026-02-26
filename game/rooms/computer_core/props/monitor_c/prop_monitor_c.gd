extends PopochiuProp

# Monitor C — Biology data, Faction C strategy: retreat (reduces all values toward zero)

func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.math_complete:
		await C.Nathe.say("Faction C — retreat. They took my biology growth rates and reduced them toward zero. Minimize. Don't expose.")
		return

	if room.get_meta("monitor_c_decoded", false):
		await C.Nathe.say("Faction C's pattern. Retreat strategy — using my greenhouse zone data, all values trending down toward minimum.")
		return

	if not Globals.has_frequency_map:
		await C.Nathe.say("The pattern is structured but I can't make sense of it yet. I need more data from the other labs first.")
		return

	if not room.get_meta("research_log_read", false):
		await C.Nathe.say("Numbers cycling in a pattern. Structured, not random — but I can't place them. I should check the research log on Monitor 4.")
		return

	if not Globals.has_reproduction_data:
		await C.Nathe.say("This pattern references biological data I haven't gathered yet. I need to complete the Biology Lab first.")
		return

	# Decode Monitor C
	await C.Nathe.say("The zone growth percentages from the greenhouse experiment. Zone 1 comfortable colony density... Zone 2 sparse counts...")
	await C.Roger.say("Every value reduced. Trending toward minimum viable numbers. Some already at zero.")
	await C.Nathe.say("Faction C took my biology data and pushed every number down. Toward nothing. Toward minimum.")
	await C.Roger.say("Consolidate. Stop spreading. Don't attract attention.")
	await C.Nathe.say("Faction C's message: retreat. Minimize exposure. Their strategy is the opposite of Faction A's.")
	room.set_meta("monitor_c_decoded", true)

	if _all_decoded(room):
		await _run_discovery()


func _on_right_click() -> void:
	await C.Nathe.say("One of three data monitors. The pattern is converging on something — or toward nothing.")


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
