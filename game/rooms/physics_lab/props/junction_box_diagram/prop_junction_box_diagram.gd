extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("A technical diagram showing the relay configuration for Dish 2's junction box.")
	await C.Nathe.say("Relay contacts need to be bridged at points J-12 and J-14 while maintaining ground continuity through the auxiliary circuit.")
	await C.Roger.say("There's a maintenance panel in the corridor that has those relay contacts.")
	await C.Nathe.say("Right. The maintenance panel in the main corridor. That's where I need to do the wiring.")


func _on_right_click() -> void:
	await C.Nathe.say("A wiring diagram for the dish relay system. Very... specific.")
