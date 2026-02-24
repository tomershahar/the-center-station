@tool
extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.tutorial_complete:
		await C.Nathe.say("The door panel. Both locks clear now. I can leave whenever I want.")
		return
	await C.Nathe.say("ARIA's door control panel. Two locks engaged: Hazard Containment Protocol AND Rest Compliance Directive 12-B.")
	await ARIA.deny_access("Rest Compliance Directive 12-B", "Rest cycle incomplete. Sensor indicates occupant has not completed wake-up sequence")


func _on_right_click() -> void:
	await C.Nathe.say("The door panel. Normally it just opens doors. Today it's a philosophical adversary.")


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()
