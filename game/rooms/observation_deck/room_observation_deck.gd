extends PopochiuRoom


func _on_room_entered() -> void:
	await _organism_observation()
	await C.Roger.setup_room_hints(_get_hints())


func _organism_observation() -> void:
	if Globals.act <= Globals.growth_noted_obs_deck:
		return
	Globals.growth_noted_obs_deck = Globals.act
	match Globals.act:
		3:
			await C.Nathe.say("Organism tendrils along the edges of the observation glass. From here I can see how far the spread has gotten across the station.")


func _get_hints() -> Dictionary:
	if Globals.social_complete:
		return {}
	return {
		"tier1_talkative": "Three parties, three goals. Start with whoever already agrees with you.",
		"tier1_balanced": "C wants out, but can they actually get out? Check the airlock.",
		"tier1_quiet": "C can't leave.",
		"tier2_talkative": "C wants to leave, but look at the airlock — A is blocking the exit. C needs help before C can go anywhere.",
		"tier2_balanced": "A is blocking C's exit. C needs an ally to clear the path.",
		"tier2_quiet": "Airlock. Blocked.",
		"tier3_talkative": "C needs the airlock cleared. B needs A suppressed. Both want the same thing for different reasons. You're the deal-maker.",
		"tier3_balanced": "Both B and C need A pushed back. Different reasons, same goal.",
		"tier3_quiet": "Align their interests.",
	}
