extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.storage_complete:
		await C.Nathe.say("The shelves where my equipment came from. Looking a little sparse now.")
	else:
		await C.Nathe.say("Equipment racks. Lots of supplies. I'd need an approved requisition form to take anything though.")


func _on_right_click() -> void:
	await C.Nathe.say("Station supply shelves. Frequency broadcasters, chemical kits, emergency rations, and a truly impressive collection of paperwork.")
