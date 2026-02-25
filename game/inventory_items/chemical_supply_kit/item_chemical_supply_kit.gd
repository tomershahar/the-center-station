extends PopochiuInventoryItem


func _on_click() -> void:
	await C.Nathe.say("Chemical supply kit. Reagents, solvents, mixing apparatus. The good stuff. Also acquired via questionable bureaucratic methods.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	# Used in Chemistry Lab via ChemSupplySlot prop
	await C.Nathe.say("That doesn't go there.")
