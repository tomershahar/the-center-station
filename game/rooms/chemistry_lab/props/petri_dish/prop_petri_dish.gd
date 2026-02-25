extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.chemistry_complete:
		await C.Nathe.say("The spectrometer analysis is already done. Two distinct cell populations — completely different chemical signatures.")
		return

	var sample_treated: bool = room.get_meta("sample_treated", false)
	var formula_ready: bool = room.get_meta("formula_ready", false)

	if sample_treated:
		await C.Nathe.say("Sample's been treated with the two-stage formula. Ready for the spectrometer.")
		return

	if formula_ready:
		room.set_meta("sample_treated", true)
		await C.Nathe.say("I apply the two-stage formula. Organic solvent first...")
		await C.Nathe.say("The outer lipid layer dissolves cleanly. Now the base compound for the mineral core...")
		await C.Roger.say("Complete penetration. Both layers neutralized.")
		await C.Nathe.say("Perfect. Now let's see what the spectrometer makes of this.")
		return

	await C.Nathe.say("A petri dish with a small organism sample. The surface has an oily, iridescent sheen...")
	await C.Nathe.say("But underneath — I can see something crystalline. Two completely different structures.")
	await C.Roger.say("Surface layer is lipid-based. Core structure is mineral. I'm reading both.")
	await C.Nathe.say("Two layers, completely different chemistry. This is going to need a very specific approach.")


func _on_right_click() -> void:
	await C.Nathe.say("The organism sample. More complex than it looks.")
