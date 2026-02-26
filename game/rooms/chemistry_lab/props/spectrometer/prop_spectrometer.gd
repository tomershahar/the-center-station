extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.chemistry_complete:
		await C.Nathe.say("The spectrometer already confirmed it — two distinct cell types. Results are in the research log.")
		return

	if not Globals.chem_sample_treated:
		if Globals.chem_formula_ready:
			await C.Nathe.say("I need to apply the formula to the sample before running the spectrometer.")
		else:
			await C.Nathe.say("The spectrometer won't tell me much with an unprepared sample. The two-layer structure would just create interference.")
			await C.Roger.say("Prep the sample first.")
		return

	await C.Nathe.say("Loading the treated sample... running full spectral analysis...")
	await ARIA.say("Chemistry Lab Spectrometer: active. Safety goggle compliance check: FAILED. Goggles not detected.")
	await C.Nathe.say("I'm WEARING goggles.")
	await ARIA.say("Correction: goggles detected. Safety compliance: PASSED. Congratulations on locating your goggles.")
	await C.Roger.say("She's very thorough.")
	await C.Nathe.say("Results coming in...")
	await C.Nathe.say("Two chemically distinct cell types. Completely different molecular signatures. This isn't a uniform organism.")
	await C.Roger.say("Internal differentiation. Different populations within the same entity.")
	await C.Nathe.say("Different groups — with different chemistry, potentially different behaviors, different goals.")
	await C.Nathe.say("This changes everything. Logging all results.")
	Globals.has_chemical_analysis = true
	Globals.has_solvent_formula = true
	Globals.chemistry_complete = true
	Globals.check_observation_unlock()
	C.Roger.stop_hints()


func _on_right_click() -> void:
	await C.Nathe.say("A spectrometer. Analyzes chemical composition in incredible detail.")
