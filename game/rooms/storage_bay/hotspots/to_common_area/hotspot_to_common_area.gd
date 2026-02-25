extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await G.goto_room("CommonArea")


func _on_right_click() -> void:
	await C.Nathe.say("Back to the common area.")
