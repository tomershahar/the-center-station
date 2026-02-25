extends PopochiuDialog


func _on_start() -> void:
	await (Engine.get_main_loop() as SceneTree).process_frame


func _option_selected(opt: PopochiuDialogOption) -> void:
	match opt.id:
		"alpha7":
			Globals.organism_name = "Subject Alpha-7"
			await E.queue([
				C.Nathe.queue_say("Professional. Systematic. Excellent."),
				C.Roger.queue_say("Boring."),
				C.Nathe.queue_say("Descriptive."),
			])
		"gerald":
			await E.queue([
				C.Nathe.queue_say("Roger, that's..."),
				C.Roger.queue_say("Memorable."),
				C.Nathe.queue_say("I'm not naming a potentially galaxy-threatening alien organism Gerald."),
				C.Roger.queue_say("You asked for suggestions."),
				C.Nathe.queue_say("I'm going with 'Gerald.' It'll make it harder to be scared of."),
			])
			Globals.organism_name = "Gerald"
		"space":
			Globals.organism_name = "S.P.A.C.E."
			await E.queue([
				C.Nathe.queue_say("It's an acronym! It works on multiple levels!"),
				C.Roger.queue_say("It took you three seconds to make that up."),
				C.Nathe.queue_say("Good acronyms require brevity."),
			])
	stop()
