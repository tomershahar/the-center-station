extends PopochiuRoom


func _on_room_entered() -> void:
	await C.Roger.setup_room_hints(_get_hints())


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
	C.Roger.stop_hints()
	Globals.math_complete = true
	Globals.has_faction_decode = true
	Globals.check_observation_unlock()


func _get_hints() -> Dictionary:
	if Globals.math_complete:
		return {}
	return {
		"tier1_talkative": "Three monitors, three patterns. They're not random, but they don't follow any standard sequence I know.",
		"tier1_balanced": "Structured patterns. Not standard math sequences.",
		"tier1_quiet": "Not random. Not standard.",
		"tier2_talkative": "These numbers aren't textbook math — no powers, no primes, no series I can identify. But they're definitely structured. Where would an alien GET specific numbers?",
		"tier2_balanced": "These numbers aren't abstract. The organism got them from somewhere specific.",
		"tier2_quiet": "Where did it learn these numbers?",
		"tier3_talkative": "Nathe... I've seen some of these numbers before. Check your research log. Compare them to your lab results.",
		"tier3_balanced": "Compare these to your own research data. Chemistry results, frequency readings...",
		"tier3_quiet": "Your data. Check the research log.",
	}
