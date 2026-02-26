extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	var room = get_parent().get_parent()

	if Globals.biology_complete:
		await C.Nathe.say("Zone 1 is stable now. The organisms are unified under comfortable conditions.")
		return

	var zone1_seen: bool = room.get_meta("zone1_seen", false)
	var zone2_seen: bool = room.get_meta("zone2_seen", false)
	var zone3_seen: bool = room.get_meta("zone3_seen", false)
	var zone1_stressed: bool = room.get_meta("zone1_stressed", false)
	var zone1_stressed_seen: bool = room.get_meta("zone1_stressed_seen", false)

	if zone1_stressed_seen:
		await C.Nathe.say("Zone 1 organisms are still subdivided. Multiple color factions maintaining separation under stress.")
		return

	if zone1_stressed:
		await C.Nathe.say("The Zone 1 colony is fracturing. Multiple color variants already.")
		room.set_meta("zone1_stressed_seen", true)
		return

	if not zone1_seen:
		room.set_meta("zone1_seen", true)
		await C.Nathe.say("Zone 1 environmental panel. Currently: 28°C, high-intensity lighting, 72% humidity.")
		await C.Roger.say("The organisms in Zone 1 are dense. All the same color — consistent, uniform colonies.")
		await C.Nathe.say("Optimal conditions. They're thriving. All together. I'll note this.")
		return

	if not (zone2_seen and zone3_seen):
		await C.Nathe.say("Dense, uniform colonies in Zone 1. High comfort conditions. Worth comparing to the other zones.")
		return

	# All zones observed — time to stress Zone 1
	await ARIA.say("Adjusting Zone 1 environment. Note: adjusting greenhouse climate will void Current Crop Insurance Policy. Proceed?")
	await C.Nathe.say("...Yes, ARIA. Proceed.")
	await C.Nathe.say("Lowering temperature... reducing light intensity... dropping humidity...")
	room.set_meta("zone1_stressed", true)
	await E.wait(0.8)
	await C.Nathe.say("The Zone 1 colony — it's changing. The uniform mass is fracturing.")
	await C.Roger.say("Multiple color variants emerging. Three distinct clusters forming. Significant genetic divergence.")
	await C.Nathe.say("Environmental stress triggering faction diversification. We're watching it happen in real time.")
	await C.Nathe.say("Just like Zone 2. Stress equals splitting. Now I need to prove the reverse.")
	room.set_meta("zone1_stressed_seen", true)


func _on_right_click() -> void:
	await C.Nathe.say("Zone 1 environmental controls. Temperature, lighting, humidity — all adjustable.")
