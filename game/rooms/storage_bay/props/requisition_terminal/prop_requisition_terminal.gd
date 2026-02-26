extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.storage_complete:
		await C.Nathe.say("Already submitted Form 27-B/6. Equipment acquired. No need to file again.")
		return

	if not Globals.storage_budget_code_found:
		await E.queue([
			C.Nathe.queue_say("Form 27-B/6 — Equipment Requisition. Requires: budget code, department name, authorization signature."),
			C.Nathe.queue_say("I don't know the budget code. There must be one somewhere."),
		])
		return

	match Globals.storage_terminal_stage:
		0: await _start_form()
		1: await _enter_department()
		2: await _request_signature()


func _start_form() -> void:
	await E.queue([
		C.Nathe.queue_say("Form 27-B/6. Budget code: GO-7734. Check."),
		C.Nathe.queue_say("Now: Department name. The form requires a department."),
		C.Roger.queue_say("The form requires a department. Last I checked, you ARE the department."),
	])
	Globals.storage_terminal_stage = 1
	await _enter_department()


func _enter_department() -> void:
	await D.DepartmentNameDialog.start()
	Globals.storage_terminal_stage = 2
	await _request_signature()


func _request_signature() -> void:
	await E.queue([
		C.Nathe.queue_say("Authorization signature required. One small problem: signature has to match an authorized researcher."),
		C.Roger.queue_say("That scanner is old. Look at it."),
		C.Nathe.queue_say("It's... very old. I don't think it can actually verify—"),
	])
	Globals.storage_ready_to_sign = true
	await C.Nathe.say("Scanner's asking for signature. Roger, what's the pressure threshold on that model?")
	await C.Roger.say("Zero. It accepts any pressure above zero.")
	await C.Nathe.say("I love legacy hardware.")


func _on_right_click() -> void:
	await C.Nathe.say("ARIA's equipment requisition terminal. Form 27-B/6 is apparently the standard form for everything from 'portable communications equipment' to 'emergency snacks.'")
