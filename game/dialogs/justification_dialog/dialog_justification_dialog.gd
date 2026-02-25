extends PopochiuDialog


func _on_start() -> void:
	await (Engine.get_main_loop() as SceneTree).process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"galaxy":
			await ARIA.say("Research justification 'To save the galaxy': ACCEPTED. All justifications equally valid under Protocol Form R-4C.")
		"science":
			await ARIA.say("Research justification 'For science': ACCEPTED. All justifications equally valid under Protocol Form R-4C.")
		"tuesday":
			await ARIA.say("Research justification 'Because it\\'s Tuesday and I have nothing better to do': ACCEPTED. All justifications equally valid under Protocol Form R-4C.")
	await E.queue([
		C.Roger.queue_say("She accepted 'it's Tuesday.'"),
		C.Nathe.queue_say("ARIA doesn't do judgment calls. That's almost comforting."),
	])
	stop()
