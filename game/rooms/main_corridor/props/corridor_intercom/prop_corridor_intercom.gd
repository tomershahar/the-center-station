extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await ARIA.say("Station intercom active. Current status: Hazard Containment Protocol in effect. Have a productive day.")


func _on_right_click() -> void:
	await C.Nathe.say("The corridor intercom. ARIA's eyes and ears everywhere. Comforting and unsettling in equal measure.")
