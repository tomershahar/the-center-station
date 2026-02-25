extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()
	if room._dish1_aligned:
		await C.Nathe.say("Dish 1 is aligned. Clean signal on Band A.")
		return
	await C.Nathe.say("Dish 1 console — direct control from this room. Let me run the alignment sequence.")
	await C.Nathe.say("Azimuth correction... elevation adjustment... signal strength increasing...")
	await C.Nathe.say("Got it! Dish 1 aligned. Band A is clean.")
	room._dish1_aligned = true
	if room.all_dishes_aligned():
		await room._complete_puzzle()


func _on_right_click() -> void:
	await C.Nathe.say("A control console for the first dish array. Direct manual alignment.")
