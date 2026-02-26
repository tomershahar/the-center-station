extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.ee_photo_seen:
		await C.Nathe.say("A photo of the assembly lab. Roger's birthplace, more or less.")
		return

	Globals.ee_photo_seen = true

	await C.Nathe.say("This photo frame — I've walked past it every day and never actually looked.")
	await C.Nathe.say("That's the assembly room. Where Roger was first put together.")
	await E.wait(0.8)
	await C.Nathe.say("Two researchers. Dr. Chen and Dr. Vasquez. They called him 'Unit V.4' until he decided otherwise.")
	await C.Nathe.say("First words on record: 'I have a structural integrity concern about your coffee table.'")
	await C.Roger.say("The table had a 12% stress fracture along the primary load-bearing joint.")
	await C.Nathe.say("Did you know I'd find this?")
	await C.Roger.say("I was aware of the statistical possibility.")
	await C.Nathe.say("Roger.")
	await C.Roger.say("...")
	await E.wait(0.6)
	await C.Roger.say("I miss them.")
	await E.wait(0.5)
	await C.Nathe.say("Yeah.")
	await E.wait(0.8)
	await C.Nathe.say("Me too.")
	await E.wait(0.5)
	await C.Nathe.say("I'm going to make coffee.")
	await C.Roger.say("That seems appropriate.")


func _on_right_click() -> void:
	await C.Nathe.say("A photo frame. Small. Easy to miss.")
