extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.chemistry_complete:
		await C.Nathe.say("The mixing station where I synthesized the two-stage formula. The formula's been logged.")
		return

	if Globals.chem_formula_ready:
		await C.Nathe.say("The two-stage formula is ready. I should apply it to the petri dish sample.")
		return

	if not Globals.chem_kit_installed:
		if I.is_item_in_inventory("ChemicalSupplyKit"):
			await C.Nathe.say("I need proper mixing apparatus before I can synthesize anything. I should install that supply kit first.")
		else:
			await C.Nathe.say("I'd need proper mixing apparatus to synthesize anything here. The standard lab setup isn't equipped for this.")
		return

	if not Globals.chem_solvent_tested:
		await C.Nathe.say("I haven't finished testing the reagents yet. I should understand what works on each layer before combining anything.")
		return

	if not Globals.chem_base_tested:
		await C.Nathe.say("The organic solvent handles the outer layer — but I haven't worked out the inner core solution yet.")
		return

	Globals.chem_formula_ready = true
	await C.Nathe.say("Organic solvent for the lipid layer, base compound for the mineral core. Ratio 3:1.")
	await C.Nathe.say("A two-stage approach — each reagent targets one layer. Sequential application.")
	await C.Roger.say("You're not keeping any of the compound?")
	await C.Nathe.say("Carrying unstable reactive chemicals around the station? That's how you lose fingers, Roger.")
	await C.Nathe.say("I'll log the formula. I can synthesize it on-site when I need it.")


func _on_right_click() -> void:
	await C.Nathe.say("A synthesis workstation for combining reagents. Proper lab equipment.")
