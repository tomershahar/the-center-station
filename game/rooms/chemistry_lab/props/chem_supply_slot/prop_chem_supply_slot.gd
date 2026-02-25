extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if Globals.chem_kit_installed:
		await C.Nathe.say("The chemical supply kit is already installed. Mixing apparatus is ready to go.")
		return

	if I.is_item_in_inventory("ChemicalSupplyKit"):
		await C.Nathe.say("This is the chemical supply installation slot. My supply kit should fit perfectly here.")
	else:
		await C.Nathe.say("A chemical supply installation slot. Needs a proper supply kit to activate the mixing station.")


func _on_item_used(item: PopochiuInventoryItem) -> void:
	C.Roger.reset_hint_timer()
	if item.script_name == "ChemicalSupplyKit":
		Globals.chem_kit_installed = true
		Globals.has_chemical_supply_kit = false
		await I.remove_item("ChemicalSupplyKit")
		await C.Nathe.say("Perfect. Reagents, solvents, mixing apparatus — all ready to go.")
		await C.Roger.say("Good thing you requisitioned that.")
		await C.Nathe.say("Turns out the bureaucratic nightmare was worth it.")
	else:
		await C.Nathe.say("That doesn't fit the supply slot.")


func _on_right_click() -> void:
	await C.Nathe.say("The installation slot for the lab's chemical supply kit.")
