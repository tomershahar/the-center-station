extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await G.goto_room("CommonArea")


func _on_right_click() -> void:
	await C.Nathe.say("Common area. Food, recreation — and where everyone used to congregate before the station went quiet.")
