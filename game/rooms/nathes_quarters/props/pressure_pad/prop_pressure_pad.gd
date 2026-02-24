@tool
extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("It's the pressure sensor. Old model. Detects weight — that's it. On or off. Binary.")


func _on_right_click() -> void:
	await C.Nathe.say("A pressure sensor embedded in the bed frame. Simple, reliable, and apparently very important to ARIA.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()
