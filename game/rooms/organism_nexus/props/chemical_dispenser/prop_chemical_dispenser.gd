extends PopochiuProp

# Step 3 — Chemistry: Mix two-stage solvent on-site, apply to A's growth at the airlock.
# Step 4 (A fractures) is embedded in the completion dialogue.

func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.final_complete:
		await C.Nathe.say("The dispenser's been used. The two-stage solvent broke A's structural bonds around the airlock. Can't take that back.")
		return

	if room.get_meta("step3_done", false):
		await C.Nathe.say("The solvent has already been applied. A's structural bonds in the airlock passage are compromised.")
		return

	if not Globals.has_solvent_formula:
		await C.Nathe.say("There's a chemical dispenser here — standard issue for this module. I'd need the solvent formula from the Chemistry Lab to use it.")
		return

	if not room.get_meta("step2_done", false):
		await C.Nathe.say("The solvent will work — but A's structural bonds are still at full strength. It'll be more effective after the environmental stress has already weakened them.")
		return

	await C.Nathe.say("There's a chemical dispenser — standard issue for this module. If I can get it working...")
	await C.Nathe.say("Clearing the organism from the interface... loading the solvent formula from my notes...")
	await C.Roger.say("You're synthesizing under pressure.")
	await C.Nathe.say("First time for everything.")
	await E.wait(0.4)
	await C.Nathe.say("Organic solvent for the lipid layer, then base compound for the mineral core. Ratio 3:1.")
	await C.Nathe.say("Applying to Faction A's growth around the airlock passage...")
	await E.wait(0.6)
	# Step 4 — Observe A fracturing (embedded)
	await C.Roger.say("A's structural bonds are failing. The growth around the airlock passage is pulling back.")
	await C.Nathe.say("And the isolation grid stress is still running. Watch — A is fracturing.")
	await E.wait(0.5)
	await C.Roger.say("Four... five sub-factions. All significantly weaker than the original A.")
	await C.Nathe.say("A's grip on the airlock is gone. The passage is clearing.")
	await C.Roger.say("C is pressing forward. They can see the path now.")
	await C.Nathe.say("Good. Now I open the door.")
	room.set_meta("step3_done", true)


func _on_right_click() -> void:
	await C.Nathe.say("Emergency chemical dispenser. Wall-mounted, standard for any lab module. Someone had the foresight to install one in here — I could kiss them.")
