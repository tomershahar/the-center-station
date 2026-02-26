extends PopochiuProp

# Monitor C — Biology data, Faction C strategy: retreat (reduces all values toward zero)

func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.math_complete:
		await C.Nathe.say("Faction C — retreat. They took my biology growth rates and reduced them toward zero. Minimize. Don't expose.")
		return

	if Globals.cc_monitor_c_decoded:
		await C.Nathe.say("Faction C's pattern. Retreat strategy — using my greenhouse zone data, all values trending down toward minimum.")
		return

	if not Globals.has_frequency_map:
		await C.Nathe.say("The pattern is structured but I can't make sense of it yet. I need more data from the other labs first.")
		return

	if not Globals.cc_research_log_read:
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
	Globals.cc_monitor_c_decoded = true

	if get_parent().get_parent()._all_decoded():
		await get_parent().get_parent()._run_discovery()


func _on_right_click() -> void:
	await C.Nathe.say("One of three data monitors. The pattern is converging on something — or toward nothing.")
