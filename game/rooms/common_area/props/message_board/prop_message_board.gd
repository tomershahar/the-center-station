extends PopochiuProp

var _read: bool = false

func _on_click() -> void:
	C.Roger.reset_hint_timer()
	if _read:
		await C.Nathe.say("Nothing new. Just the same crew notes. Mundane station life right up until it wasn't.")
		return
	_read = true
	await E.queue([
		C.Nathe.queue_say("Message board. Station crew notes. 'Thursday — Dr. Vasquez's birthday. Cake in common area.' 'Friday — hydroponics leak, contact engineering.' 'Monday — someone ate Vasquez's cake early. Please respect communal food.'"),
		C.Roger.queue_say("Normal day. Then the next entry is three weeks later."),
		C.Nathe.queue_say("'Organism contact. All non-essential crew evacuated. Dr. N. Castellano to remain for containment assessment.'"),
		C.Nathe.queue_say("That's me. 'Containment assessment.' I should write a follow-up."),
		C.Roger.queue_say("'Still here. Send help.'"),
		C.Nathe.queue_say("I'm thinking more scientific. 'Day 1 of assessment: things are fine.' Because they are. Mostly."),
	])


func _on_right_click() -> void:
	await C.Nathe.say("Cork board. Mixed station announcements and personal notes. The kind of board that only exists because someone insisted on 'human connection amid the stars.'")
