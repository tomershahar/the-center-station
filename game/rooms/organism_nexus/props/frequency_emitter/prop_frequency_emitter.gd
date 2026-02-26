extends PopochiuProp

# Step 1 — Physics: Sync broadcaster to station emitter, stabilize B+C coalition frequencies.

func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if Globals.final_complete:
		await C.Nathe.say("The frequency emitter is still broadcasting on the B-C coalition frequencies. B is holding the room.")
		return

	if Globals.nexus_step1_done:
		await C.Nathe.say("The broadcaster is synced and running. B and C's coalition is stable under the calming frequencies.")
		return

	if not Globals.has_frequency_broadcaster:
		await C.Nathe.say("There's a station frequency emitter here. I'd need the portable broadcaster from Storage Bay to sync the faction frequencies through it.")
		return

	await C.Nathe.say("The station's frequency emitter. I can sync Roger's portable broadcaster through it — broadcast the B-C coalition frequencies at room scale.")
	await C.Nathe.say("Syncing the broadcaster... locking onto the B and C response frequencies from the observation deck negotiation...")
	await C.Roger.say("Broadcasting. B and C growth patterns are stabilizing under the reinforced signal.")
	await C.Roger.say("The coalition is holding. Both factions are steady.")
	await C.Nathe.say("Good. While they're anchored, I can go after A without B considering a defensive merger.")
	Globals.nexus_step1_done = true


func _on_right_click() -> void:
	await C.Nathe.say("Station frequency emitter. Part of the original comms infrastructure — before the organism decided to redecorate.")
