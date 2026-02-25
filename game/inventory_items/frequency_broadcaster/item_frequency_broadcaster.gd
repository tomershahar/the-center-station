extends PopochiuInventoryItem


func _on_click() -> void:
	await C.Nathe.say("Portable frequency broadcaster. Compact, durable, and apparently requires a three-page form to requisition.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Nathe.say("That's not what the broadcaster is for.")
