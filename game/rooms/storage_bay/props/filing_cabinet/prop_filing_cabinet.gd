extends PopochiuProp

var _searched: bool = false


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if _searched:
		await C.Nathe.say("I've already found what I need from here. Budget code: remembered.")
		return
	_searched = true
	await E.queue([
		C.Nathe.queue_say("Old requisition forms from the previous crew. Some half-finished, some rejected, some just... abandoned."),
		C.Nathe.queue_say("Oh! Budget code right here on Form 12-D. 'GENERAL OPERATIONS — CODE: GO-7734.' Perfect."),
		C.Roger.queue_say("GO-7734. Noted."),
	])
	Globals.storage_budget_code_found = true


func _on_right_click() -> void:
	await C.Nathe.say("Filing cabinet. The accumulated bureaucratic exhaust of three previous research crews.")
