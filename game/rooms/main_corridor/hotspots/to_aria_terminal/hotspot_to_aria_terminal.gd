extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await G.goto_room("ARIATerminal")


func _on_right_click() -> void:
	await C.Nathe.say("ARIA's main terminal. The brain of the station — or at least the part that talks back.")
