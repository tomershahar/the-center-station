extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.chemistry_complete:
		await C.Nathe.say("The acid made the sample grow. Very much the wrong choice.")
		return

	if Globals.chem_acid_tested:
		await C.Nathe.say("Already tested the acid. It made the sample grow — definitely the wrong approach.")
		return

	Globals.chem_acid_tested = true
	await C.Nathe.say("I apply a drop of acid solution to the sample...")
	await C.Nathe.say("Oh. It's... growing. Visibly. That's not good.")
	await C.Roger.say("Great. You fed it.")
	await C.Nathe.say("Well, it LIKED that. Acid is definitely out.")


func _on_right_click() -> void:
	await C.Nathe.say("Red bottle. Acid solution. Standard lab reagent.")
