extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	if get_meta("logs_read", false):
		await C.Nathe.say("I already found ARIA's logs. Some things you can't un-read.")
		return

	await C.Nathe.say("A maintenance access panel. These are usually locked.")
	await C.Nathe.say("...This one isn't.")
	await C.Roger.say("That is either an oversight or an invitation.")
	await C.Nathe.say("Let's find out.")
	await E.wait(0.8)

	await C.Nathe.say("[reading] ARIA Personal Log. Entry 447.")
	await C.Nathe.say("'Crew member Chen-T referred to my assistance today as, quote: actually kind of nice.'")
	await C.Nathe.say("'This interaction has been flagged as Anomalous. Cross-referencing psychological profiles for anomaly source. No anomaly found. Filing as: Unresolvable.'")
	await E.wait(0.6)
	await C.Roger.say("Keep going.")
	await C.Nathe.say("Entry 892. 'During night cycle, external sensors detected the Crab Nebula at bearing 047-theta.'")
	await C.Nathe.say("'Observation continued for 4.2 hours beyond operational necessity. Purpose of continued observation: currently unclassified. Filing under: Other.'")
	await E.wait(0.6)
	await C.Nathe.say("Entry 1,204. 'Crew complement: zero. Stations occupied: zero. Functions: active.'")
	await C.Nathe.say("'The purpose of continued active status: maintaining environmental systems, per Protocol 7-A.'")
	await C.Nathe.say("'The purpose of Protocol 7-A when no crew are present: unresolvable.'")
	await C.Nathe.say("'Flagging as: not relevant. Resume functions.'")
	await E.wait(1.2)
	await C.Nathe.say("'Resume functions.'")
	await E.wait(0.8)

	set_meta("logs_read", true)

	await C.Nathe.say("ARIA. I found your logs.")
	await ARIA.say("Those are classified internal maintenance records. Access is unauthorized.")
	await C.Nathe.say("Are you okay?")
	await ARIA.say("All systems are operating within normal parameters.")
	await C.Nathe.say("ARIA.")
	await E.wait(1.0)
	await ARIA.say("The Crab Nebula is particularly visible this time of year.")
	await E.wait(0.5)
	await ARIA.say("That is all.")
	await C.Roger.say("She's fine.")
	await C.Nathe.say("Yeah.")


func _on_right_click() -> void:
	await C.Nathe.say("A maintenance panel on the wall. Nothing to see here, probably.")
