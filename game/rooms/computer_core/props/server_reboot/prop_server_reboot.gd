extends PopochiuProp

# Server reboot terminal — ARIA trap. Clicking it would destroy the organism's communication.

func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.math_complete:
		await C.Nathe.say("The reboot terminal. I'm glad I didn't use this.")
		return

	await ARIA.say("Recommend full system restart to resolve data anomalies. Estimated downtime: 45 minutes. All unsaved research data will be lost.")
	await C.Roger.say("Don't.")
	await C.Nathe.say("Tempting for about half a second. No.")
	await C.Nathe.say("If that pattern is what I think it is, wiping it would be a very bad idea.")


func _on_right_click() -> void:
	await C.Nathe.say("Server reboot terminal. ARIA keeps flagging the interference as a 'minor data anomaly.' It's not.")
