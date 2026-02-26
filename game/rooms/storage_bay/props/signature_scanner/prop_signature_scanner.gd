extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if not Globals.storage_ready_to_sign:
		await C.Nathe.say("It's a signature scanner. I need to fill out the form first.")
		return

	await C.Nathe.say("Here goes.")
	await ARIA.say("Signature verified. Requisition Form 27-B/6: APPROVED. Equipment: authorized for collection. Estimated delivery: immediately, as all items are in this room. Have a productive day.")
	await E.queue([
		C.Roger.queue_say("It accepted a palm print."),
		C.Nathe.queue_say("It accepted ANY palm print. I could have pressed a coffee mug to this."),
		C.Roger.queue_say("Useful flaw."),
	])
	await I.add_item("FrequencyBroadcaster")
	await I.add_item("ChemicalSupplyKit")
	Globals.has_frequency_broadcaster = true
	Globals.has_chemical_supply_kit = true
	Globals.storage_complete = true
	Globals.department_credentials_obtained = true
	C.Roger.stop_hints()


func _on_right_click() -> void:
	await C.Nathe.say("Biometric signature scanner, circa... a long time ago. Technically it's a security device. Technically.")
