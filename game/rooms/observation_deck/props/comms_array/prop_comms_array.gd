extends PopochiuProp

# The main puzzle driver — 3-click progression through the coalition negotiation.

func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.social_complete:
		await C.Nathe.say("The comms array is still receiving signals from both factions. B and C holding their coalition. A still pulsing its objections.")
		return

	if not Globals.has_frequency_broadcaster:
		await C.Nathe.say("The comms array is here, but I'd need the portable frequency broadcaster to tune it to the faction frequencies. The one from Storage.")
		return

	var talked_to_c: bool = room.get_meta("talked_to_c", false)
	var talked_to_b: bool = room.get_meta("talked_to_b", false)

	if not talked_to_c:
		await _first_contact(room)
	elif not talked_to_b:
		await _talk_to_b(room)
	else:
		await _propose_coalition(room)


func _on_right_click() -> void:
	await C.Nathe.say("Roger's modified comms array. Tuned to broadcast on all three faction frequencies simultaneously.")


func _first_contact(room: Node) -> void:
	await C.Nathe.say("All four data sets logged. Chemistry, Physics, Biology, Math. I know what each faction wants and why.")
	await C.Roger.say("Connecting the portable broadcaster to the array. Broadcasting on all three faction frequencies.")
	await E.wait(0.5)
	await C.Nathe.say("The observation windows — the organism's reacting. The patterns are changing.")
	await C.Roger.say("Receiving responses on all three channels simultaneously.")
	await E.wait(0.3)
	await C.Nathe.say("Faction C is responding first. They're... very eager. They want out immediately.")
	await C.Roger.say("They're signaling the airlock. Section 7. Passage to the planet surface.")
	await E.wait(0.3)
	await C.Nathe.say("Right. I prepared a diplomatic opening statement for this moment.")
	await C.Nathe.say("'Greetings. My name is Nathe and I represent the station research team. I wish to open a dialogue regarding—'")
	await C.Roger.say("Nathe. They already said yes. They want to leave immediately. They agreed before you finished the first sentence.")
	await C.Nathe.say("But I prepared talking points—")
	await C.Roger.say("They said yes, Nathe. Take the win.")
	await E.wait(0.5)
	await C.Roger.say("Wait. Faction C is still transmitting. There's a complication.")
	await C.Nathe.say("What complication?")
	await C.Roger.say("The airlock. Section 7 is completely covered by Faction A's growth. C cannot physically reach the exit.")
	await C.Nathe.say("Oh.")
	await C.Roger.say("Yeah.")
	await C.Nathe.say("Well. I also prepared contingency talking points.")
	await C.Roger.say("Of course you did.")
	await E.wait(0.5)
	await C.Nathe.say("C wants to leave but A is sitting on the only exit. C needs someone to push A back from the airlock before they can go anywhere.")
	await C.Nathe.say("Which means C needs an ally. Someone with an independent reason to suppress A.")
	room.set_meta("talked_to_c", true)


func _talk_to_b(room: Node) -> void:
	await C.Nathe.say("Opening the Faction B frequency.")
	await E.wait(0.3)
	await C.Nathe.say("Faction B is responding. Cautious. They're analyzing the transmission.")
	await C.Roger.say("They recognize the data patterns in the broadcast signal. The frequency values. They've seen these numbers before.")
	await C.Nathe.say("Of course — they corrected my rounding errors in the computer core.")
	await E.wait(0.3)
	await C.Nathe.say("Faction B. We know you want balance. Sustainable coexistence. A's expansion strategy undermines that.")
	await C.Roger.say("They're acknowledging. Careful acknowledgment, but acknowledgment.")
	await C.Nathe.say("If A's dominance is reduced, B holds the majority position. That IS your stated goal.")
	await C.Roger.say("They're holding back. They're not sure if they trust a human broker.")
	await C.Nathe.say("They watched every experiment I ran. They corrected my data. They know I don't guess.")
	await C.Roger.say("...That landed. They're still listening.")
	await C.Nathe.say("Good. I have a proposal — but I need both B and C in the room for it.")
	room.set_meta("talked_to_b", true)


func _propose_coalition(room: Node) -> void:
	await C.Nathe.say("Here's the deal.")
	await C.Nathe.say("Faction C wants to leave the station — but can't reach the airlock because A is blocking Section 7.")
	await C.Nathe.say("Faction B wants A's dominance reduced — because that's the only path to the balance you want.")
	await C.Nathe.say("If B and C cooperate to push A back from Section 7: C gets a clear exit route to the planet. B gets majority position. Both factions get exactly what they want.")
	await C.Roger.say("You're telling them they already want the same thing.")
	await C.Nathe.say("I'm telling them they can only GET it by working together. The math is simple.")
	await E.wait(0.8)
	await C.Roger.say("Faction C is responding immediately. They agree.")
	await C.Nathe.say("C was always going to agree — they have the most urgent need.")
	await C.Roger.say("Faction B. They're deliberating. The patterns are cycling.")
	await E.wait(1.0)
	await C.Roger.say("Faction B has agreed.")
	await C.Nathe.say("Of course. It's not altruism — it's game theory. Each party gets what they specifically need, and they can only get it by cooperating first.")
	await E.wait(0.5)
	await C.Roger.say("Nathe. Look at the observation windows.")
	await C.Nathe.say("Two thirds of the organism's growth is shifting. B and C patterns synchronizing into the same color.")
	await C.Roger.say("Faction A's patches are pulsing. They don't like this.")
	await C.Nathe.say("They don't have to like it. They just have to be outvoted.")
	await E.wait(0.5)
	await C.Nathe.say("Faction Alliance logged. Coalition formed — not from goodwill. From aligned self-interest. As all the best coalitions are.")
	Globals.social_complete = true
	Globals.has_faction_alliance = true
	Globals.organism_has_spoken = true
	Globals.nexus_unlocked = true
	C.Roger.stop_hints()
