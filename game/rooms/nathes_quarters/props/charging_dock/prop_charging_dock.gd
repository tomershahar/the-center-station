@tool
extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("Roger's charging dock. He starts every day here and somehow ends every day more judgmental than when he woke up.")


func _on_right_click() -> void:
	await C.Nathe.say("Roger's charging dock. The little cradle where his personality recharges overnight.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()
