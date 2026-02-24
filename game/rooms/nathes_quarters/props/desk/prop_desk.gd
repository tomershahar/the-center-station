@tool
extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("My workstation. Three months of simulation data, all suggesting the organism has exactly one growth pattern. Turns out I was wrong about that.")


func _on_right_click() -> void:
	await C.Nathe.say("Papers, coffee rings, and the quiet dreams of a researcher who thought this posting would be 'peaceful.'")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()
