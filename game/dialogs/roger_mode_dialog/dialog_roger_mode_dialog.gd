@tool
extends PopochiuDialog
# Options are defined in the .tres resource with IDs:
#   "talkative" — "Talkative — tell me everything"
#   "balanced"  — "Balanced — hints when I'm stuck"
#   "quiet"     — "Quiet — I'll figure it out"


func _on_start() -> void:
	# Required await so Popochiu's dialog system can initialize before showing options
	await (Engine.get_main_loop() as SceneTree).process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"talkative":
			Globals.roger_mode = "talkative"
			await E.queue([
				C.Nathe.queue_say("More information is always better. Statistically."),
				C.Roger.queue_say("I'll do my best."),
			])
		"balanced":
			Globals.roger_mode = "balanced"
			await E.queue([
				C.Nathe.queue_say("A good scientist knows when to ask for help."),
				C.Roger.queue_say("Works for me."),
			])
		"quiet":
			Globals.roger_mode = "quiet"
			await E.queue([
				C.Nathe.queue_say("I'm a PhD. I don't need a robot to —"),
				C.Roger.queue_say("Fine."),
			])
	stop()
