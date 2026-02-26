extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	C.Roger.stop_hints()
	await G.goto_room("MainCorridor")


func _on_right_click() -> void:
	await C.Nathe.say("The corridor door. Back to the hub.")
