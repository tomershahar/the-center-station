extends PopochiuRoom


func _on_room_entered() -> void:
	await C.Roger.setup_room_hints(_get_hints())


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
