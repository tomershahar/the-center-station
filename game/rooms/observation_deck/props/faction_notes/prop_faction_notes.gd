extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.social_complete:
		await C.Nathe.say("My compiled research notes. All four data sets — and the coalition outcome. This is going to be a very unusual paper.")
		return

	await C.Nathe.say("My compiled research notes. Four puzzles worth of data, synthesized.")
	await E.wait(0.3)
	await C.Nathe.say("Faction A: expansion strategy. Uses my chemistry data with every value inflated. More, bigger, proliferate.")
	await C.Nathe.say("Faction B: precision strategy. Corrected my frequency rounding errors to communicate. Balance and accuracy.")
	await C.Nathe.say("Faction C: retreat strategy. Used my biology growth rates, all reduced toward zero. Minimize exposure.")
	await C.Roger.say("And they've been watching every experiment you ran. They know you know.")
	await C.Nathe.say("Which means they already understand I have leverage. I just need to use it correctly.")
	await C.Roger.say("B respected the data analysis. C will cooperate if offered a concrete benefit. A won't negotiate — A only understands dominance.")
	await C.Nathe.say("Then I don't negotiate with A at all. I negotiate around A.")


func _on_right_click() -> void:
	await C.Nathe.say("My research notes — four lab puzzles synthesized into faction profiles. The organism is the most complicated research subject I've ever had.")
