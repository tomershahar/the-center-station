extends PopochiuProp

var _stage: int = 0


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.protocol_reclassification_complete:
		await C.Nathe.say("The terminal shows all four labs as OPEN. Good. I'm not touching this again.")
		return
	match _stage:
		0: await _show_protocol_tree()
		1: await _show_reclassification_form()
		2: await _handle_organism_name()
		3: await _handle_justification()
		4: await _handle_supervisor_approval()


func _show_protocol_tree() -> void:
	await E.queue([
		C.Nathe.queue_say("Protocol Classification Tree. Let's see... Biological Hazard... Hazard Containment... Lab Access Restriction..."),
		C.Nathe.queue_say("Ooh. Research Exception 4-C: 'Authorized personnel may access hazardous areas IF hazard is reclassified as a Research Subject pursuant to Form R-4C.'"),
		C.Nathe.queue_say("It has a FORM. Of course it has a form."),
		C.Roger.queue_say("What does it need?"),
		C.Nathe.queue_say("Subject name, research justification, supervisor approval. Simple."),
		C.Roger.queue_say("You don't have a supervisor."),
		C.Nathe.queue_say("I... let me keep reading."),
		C.Nathe.queue_say("'In absence of a station supervisor, the senior-most researcher present may provide approval authorization.' That's me."),
		C.Roger.queue_say("You're going to approve your own request."),
		C.Nathe.queue_say("It's technically legal."),
		C.Roger.queue_say("It's very you."),
	])
	_stage = 1


func _show_reclassification_form() -> void:
	await C.Nathe.say("Form R-4C. Research Subject Designation Form. Step 1: Subject Name.")
	_stage = 2
	await _handle_organism_name()


func _handle_organism_name() -> void:
	await D.OrganismNameDialog.start()
	_stage = 3
	await _handle_justification()


func _handle_justification() -> void:
	await C.Nathe.say("Step 2: Research Justification.")
	await D.JustificationDialog.start()
	_stage = 4
	await _handle_supervisor_approval()


func _handle_supervisor_approval() -> void:
	await E.queue([
		C.Nathe.queue_say("Step 3: Supervisor Approval. 'Signature of department head or station supervisor required.'"),
		C.Nathe.queue_say("Right. That's me. I'm the senior researcher on station. I'm approving my own research request."),
		C.Nathe.queue_say("This is completely normal. Very normal. Everything is fine."),
	])
	await ARIA.say("Supervisor credentials verified. Dr. %s — Senior Researcher, sole station occupant. Authorization: ACCEPTED. Research Subject Designation Form R-4C: APPROVED." % Globals.player_name)
	await ARIA.say("Organism '%s' reclassified from BIOLOGICAL HAZARD to AUTHORIZED RESEARCH SUBJECT. Lab access: GRANTED. Have a productive day." % Globals.organism_name)
	await E.queue([
		C.Roger.queue_say("You just approved your own request to yourself."),
		C.Nathe.queue_say("I prefer 'exercised senior researcher authority.'"),
		C.Roger.queue_say("I'm putting it in my log as 'approved own request.'"),
	])
	Globals.protocol_reclassification_complete = true
	Globals.labs_unlocked = true
	Globals.act = 2
	await I.add_item("LabKeycard")
	Globals.has_lab_keycard = true
	await C.Nathe.say("And the keycard. One keycard, four labs. Let's see what we're dealing with.")
	C.Roger.stop_hints()


func _on_right_click() -> void:
	await C.Nathe.say("ARIA's central protocol management terminal. I can feel it judging me.")
