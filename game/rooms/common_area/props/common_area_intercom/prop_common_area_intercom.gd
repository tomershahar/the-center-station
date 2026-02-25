extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await ARIA.say("Common Area intercom active. All systems nominal. Have a productive day.")


func _on_right_click() -> void:
	await C.Nathe.say("Another ARIA intercom. She's everywhere. It's fine. I'm not thinking about it.")
