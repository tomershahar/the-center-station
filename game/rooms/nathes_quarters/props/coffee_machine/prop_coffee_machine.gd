@tool
extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("Still no water. A problem with a very obvious solution that I am choosing to defer until after the alien organism crisis.")


func _on_right_click() -> void:
	await C.Nathe.say("The station's coffee machine. A triumph of engineering that works perfectly when filled with water.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()
