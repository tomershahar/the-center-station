extends PopochiuRoom


func _on_room_entered() -> void:
	$Hotspots/ToStorageBay.enabled = Globals.protocol_reclassification_complete
	_update_organism_spread()
	await _organism_observation()
	await C.Roger.setup_room_hints({})


func _update_organism_spread() -> void:
	var existing = get_node_or_null("OrganismGrowthOverlay")
	if existing:
		existing.queue_free()
	if not Globals.social_complete:
		return
	var overlay := ColorRect.new()
	overlay.name = "OrganismGrowthOverlay"
	overlay.color = Color(0.0, 0.4, 0.0, 0.25)
	overlay.size = Vector2(320, 180)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.z_index = -1
	add_child(overlay)


func _organism_observation() -> void:
	if Globals.act <= Globals.growth_noted_common_area:
		return
	Globals.growth_noted_common_area = Globals.act
	match Globals.act:
		2:
			await C.Nathe.say("The food station... it's reached the food station. The organism has started growing into the station's common systems.")
		3:
			await C.Nathe.say("Most of the common area is covered. I think we're on emergency rations, Roger.")


func _on_room_transition_finished() -> void:
	pass
