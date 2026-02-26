extends PopochiuProp

# Step 2 — Biology: Activate zonal isolation grid, target A's zone with stress conditions.

func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.final_complete:
		await C.Nathe.say("The isolation grid is still active. A's zone was stress-fractured. The grid held B and C's areas stable throughout.")
		return

	if room.get_meta("step2_done", false):
		await C.Nathe.say("A's zone is under targeted environmental stress. High temp, high light — the isolation grid is keeping B and C's areas unaffected.")
		return

	if not room.get_meta("step1_done", false):
		await C.Nathe.say("I could activate this — but if I stress A before B and C are stabilized, they might interpret A's reaction as aggression and consider merging for safety. Coalition first.")
		return

	await C.Nathe.say("Ceiling-mounted environmental emitters. This module has a zonal isolation grid — like the greenhouse controls, but localized.")
	await C.Roger.say("Convenient.")
	await C.Nathe.say("It's a research station, Roger. This is literally what it was built for.")
	await E.wait(0.3)
	await C.Nathe.say("Clearing the organism from the control panel... targeting Faction A's central zone...")
	await C.Nathe.say("Applying high temperature and high-intensity light to A's zone only. B and C's areas held at current conditions.")
	await C.Roger.say("A's zone is responding. B and C are unaffected — the grid is isolating the stimulus perfectly.")
	await C.Nathe.say("A's growth is starting to divide. Environmental stress triggering fission — same mechanism as the greenhouse, but targeted.")
	await C.Roger.say("A is weakening. The structural bonds are under pressure.")
	room.set_meta("step2_done", true)


func _on_right_click() -> void:
	await C.Nathe.say("The zonal isolation grid controls. Ceiling-mounted emitters that can stress individual areas independently. Standard for this kind of research module.")
