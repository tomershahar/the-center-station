@tool
extends PopochiuHotspot


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.tutorial_complete:
		await G.goto_room("MainCorridor")
	else:
		await C.Nathe.say("It's locked. Both Hazard Containment Protocol AND 'Rest Compliance Directive 12-B,' apparently.")
		await ARIA.deny_access("Rest Compliance Directive 12-B", "Rest cycle incomplete. Sensor indicates occupant has not completed wake-up sequence")
		await C.Nathe.say("I'm STANDING RIGHT HERE, ARIA.")
		await ARIA.say("Your current state of consciousness is not within the scope of Directive 12-B.")


func _on_right_click() -> void:
	await C.Nathe.say("The corridor door. Usually it just opens. Today it requires me to engage with bureaucratic sensor logic at 7am.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()
