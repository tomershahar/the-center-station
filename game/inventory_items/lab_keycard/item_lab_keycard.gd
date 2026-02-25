extends PopochiuInventoryItem


func _on_click() -> void:
	await C.Nathe.say("One keycard, four labs. It's been a productive morning, bureaucratically speaking.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	await C.Nathe.say("I don't think that goes together. The keycard is for doors.")
