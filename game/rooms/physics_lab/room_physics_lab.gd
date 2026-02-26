extends PopochiuRoom

var _dish1_aligned: bool = false
var _dish2_aligned: bool = false
var _dish3_aligned: bool = false


func _ready() -> void:
	add_to_group("physics_lab_room")


func _on_room_entered() -> void:
	# Restore persistent cross-room state
	if Globals.dish2_wired:
		_dish2_aligned = true
	_update_organism_spread()
	await _organism_observation()
	await C.Roger.setup_room_hints(_get_hints())
	if Globals.physics_complete:
		await C.Nathe.say("The frequency analyzer is still showing three clean signals. Three factions, three frequencies.")


func all_dishes_aligned() -> bool:
	return _dish1_aligned and _dish2_aligned and _dish3_aligned


func _complete_puzzle() -> void:
	await C.Nathe.say("All three dishes aligned. Running analysis...")
	await C.Nathe.say("Three separate frequency bands. Three distinct signal patterns.")
	await C.Nathe.say("Three... groups? The organism isn't a single colony. It's three distinct communication networks operating simultaneously.")
	await C.Roger.say("It argues with itself.")
	await C.Nathe.say("Or it has three different factions with different... agendas.")
	Globals.has_frequency_map = true
	Globals.physics_complete = true
	C.Roger.stop_hints()
	Globals.check_observation_unlock()


func _update_organism_spread() -> void:
	var existing = get_node_or_null("OrganismGrowthOverlay")
	if existing:
		existing.queue_free()
	if not Globals.physics_complete:
		return
	var overlay := ColorRect.new()
	overlay.name = "OrganismGrowthOverlay"
	overlay.color = Color(0.0, 0.4, 0.0, 0.25)
	overlay.size = Vector2(320, 180)
	overlay.mouse_filter = Control.MOUSE_FILTER_IGNORE
	overlay.z_index = -1
	add_child(overlay)


func _organism_observation() -> void:
	if Globals.act <= Globals.growth_noted_physics:
		return
	Globals.growth_noted_physics = Globals.act
	match Globals.act:
		2:
			await C.Nathe.say("Green patches on the equipment, near the antenna arrays. The organism seems drawn to the frequency emitters.")
		3:
			await C.Nathe.say("The growth is pulsing in sync with the signal frequencies. It's actively responding to the equipment.")
			await C.Roger.say("It's listening.")


func _get_hints() -> Dictionary:
	if Globals.physics_complete:
		return {}
	return {
		"tier1_talkative": "Three dishes, three different problems. Start with the easy one in this room.",
		"tier2_talkative": "Dish 2's junction is in the Corridor. I can do the wiring if you read the diagram.",
		"tier3_talkative": "Dish 3 goes through ARIA's comms. You'll need department credentials to authorize a maintenance window.",
		"tier1_balanced": "Three dishes. One here, one in Corridor, one tied to ARIA.",
		"tier2_balanced": "I can handle the wiring on Dish 2 if you find the diagram.",
		"tier3_balanced": "ARIA needs department credentials for the Dish 3 maintenance request.",
		"tier1_quiet": "Three dishes.",
		"tier2_quiet": "Corridor. Wiring.",
		"tier3_quiet": "ARIA. Credentials.",
	}
