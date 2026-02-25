extends PopochiuRoom


func _on_room_entered() -> void:
	await C.Roger.setup_room_hints(_get_hints())


func _get_hints() -> Dictionary:
	if Globals.storage_complete:
		return {}
	return {
		"tier1_talkative": "Old station, old forms. Check the filing cabinet for previous paperwork.",
		"tier1_balanced": "Old crew left paperwork behind.",
		"tier1_quiet": "",
		"tier2_talkative": "Budget code's on one of those old forms. Department name — just make one up, she won't check.",
		"tier2_balanced": "Budget code's in the cabinet.",
		"tier2_quiet": "Budget code.",
		"tier3_talkative": "That scanner is older than me. I don't think it can tell a signature from a sandwich.",
		"tier3_balanced": "That scanner is ancient. Try pressing hard with anything.",
		"tier3_quiet": "That scanner isn't picky.",
	}
