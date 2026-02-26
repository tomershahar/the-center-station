extends PopochiuRoom


func _on_room_entered() -> void:
	_update_organism_spread()
	await _organism_observation()
	await C.Roger.setup_room_hints(_get_hints())


func _update_organism_spread() -> void:
	var existing = get_node_or_null("OrganismGrowthOverlay")
	if existing:
		existing.queue_free()
	if not Globals.chemistry_complete:
		return
	var overlay := ColorRect.new()
	overlay.name = "OrganismGrowthOverlay"
	overlay.color = Color(0.0, 0.4, 0.0, 0.25)
	overlay.size = Vector2(320, 180)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.z_index = -1
	add_child(overlay)


func _organism_observation() -> void:
	if Globals.act <= Globals.growth_noted_storage:
		return
	Globals.growth_noted_storage = Globals.act
	match Globals.act:
		2:
			await C.Nathe.say("Patches of growth on some of the storage crates. The organism is pushing through the ventilation.")
		3:
			await C.Nathe.say("The storage bay is heavily contaminated. At least the filing cabinet still works.")


func _get_hints() -> Dictionary:
	if Globals.storage_complete:
		return {}
	return {
		"tier1_talkative": "Old station, old forms. Check the filing cabinet for previous paperwork.",
		"tier1_balanced": "Old crew left paperwork behind.",
		"tier1_quiet": "",
		"tier2_talkative": "Budget code's on one of those old forms. Department name — just make one up, she won't check.",
		"tier2_balanced": "Budget code's in the cabinet.",
		"tier2_quiet": "Budget code.",
		"tier3_talkative": "That scanner is older than me. I don't think it can tell a signature from a sandwich.",
		"tier3_balanced": "That scanner is ancient. Try pressing hard with anything.",
		"tier3_quiet": "That scanner isn't picky.",
	}
