extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()
	await C.Nathe.say("Someone's handwritten notes. 'Carbon-based, standard lipid membrane — BUT reacts to pH stimulus like silicon-based crystal structures—'")
	await C.Nathe.say("It cuts off mid-sentence. Someone was interrupted.")
	await C.Roger.say("They were onto something.")


func _on_right_click() -> void:
	await C.Nathe.say("A whiteboard with incomplete research notes from the previous crew.")
