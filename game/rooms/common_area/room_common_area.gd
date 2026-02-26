extends PopochiuRoom


func _on_room_entered() -> void:
	$Hotspots/ToStorageBay.enabled = Globals.protocol_reclassification_complete
	await _organism_observation()
	await C.Roger.setup_room_hints({})


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
