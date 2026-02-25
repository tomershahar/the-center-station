extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await G.goto_room("StorageBay")


func _on_right_click() -> void:
	await C.Nathe.say("Storage bay. Requisition forms and legacy hardware. Can't wait.")
