extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("The indicator light pulses blue when ARIA is processing or speaking. It's been blinking a lot lately.")


func _on_right_click() -> void:
	await C.Nathe.say("A soft blue light. ARIA's presence indicator. It never turns off.")
