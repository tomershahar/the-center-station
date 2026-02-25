extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if not Globals.labs_unlocked:
		await C.Nathe.say("An exposed maintenance panel. Lots of wiring. I should focus on the protocol reclassification first.")
		return
	if Globals.dish2_wired:
		await C.Nathe.say("Roger's wiring for Dish 2 is still holding. Don't touch it.")
		return
	await C.Nathe.say("Maintenance panel. There's a junction box in here — this must be for Dish 2 in the Physics Lab.")
	await C.Nathe.say("The wiring diagram says... relay contacts need to be bridged at points J-12 and J-14 while maintaining ground continuity through—")
	await C.Roger.say("Red wire to blue terminal.")
	await C.Nathe.say("I was EXPLAINING the principle—")
	await C.Roger.say("And I'm connecting the wire.")
	await E.wait(2.0)
	await C.Roger.say("Done.")
	await C.Nathe.say("...The signal from Dish 2 just came online in the analyzer.")
	Globals.dish2_wired = true
	var physics_room = get_tree().get_first_node_in_group("physics_lab_room")
	if physics_room:
		physics_room._dish2_aligned = true
		if physics_room.all_dishes_aligned():
			await physics_room._complete_puzzle()


func _on_right_click() -> void:
	await C.Nathe.say("An exposed wall panel. Someone was doing maintenance and got interrupted. Story of this station.")
