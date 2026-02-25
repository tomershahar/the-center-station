extends PopochiuDialog


func _on_start() -> void:
	await get_tree().process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
	Globals.department_name = opt.text
	await E.queue([
		C.Nathe.queue_say("Department of... '%s.' That's going on official paperwork." % opt.text),
		C.Roger.queue_say("I can't believe that's official paperwork."),
	])
	await ARIA.say("Department registration: '%s' — Head: Dr. %s. Department credentials stored in station registry." % [opt.text, Globals.player_name])
	stop()
