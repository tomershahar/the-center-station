extends PopochiuRoom


func _on_room_entered() -> void:
	$Hotspots/ToStorageBay.enabled = Globals.protocol_reclassification_complete
	await C.Roger.setup_room_hints({})


func _on_room_transition_finished() -> void:
	pass
