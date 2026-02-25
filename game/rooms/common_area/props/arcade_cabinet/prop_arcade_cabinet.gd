extends PopochiuProp

# Easter egg — full implementation in Milestone 8
func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("An arcade cabinet. Someone bolted it to the floor. I admire the commitment.")
	await C.Roger.say("It's plugged in.")
	await C.Nathe.say("...")
	await C.Nathe.say("Later. I have science to do.")


func _on_right_click() -> void:
	await C.Nathe.say("A full-size arcade cabinet. In a space station. Someone had priorities.")
