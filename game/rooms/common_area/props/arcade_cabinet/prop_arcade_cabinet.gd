extends PopochiuProp


func _on_click() -> void:
	C.Roger.reset_hint_timer()

	# First time approaching the cabinet
	if not Globals.ee_arcade_visited:
		Globals.ee_arcade_visited = true
		await C.Nathe.say("An arcade cabinet. With actual games.")
		await C.Roger.say("Two. Someone took their leisure time seriously.")

	# Reveal organism game the first time after credits
	if Globals.final_complete and not Globals.ee_organism_revealed:
		Globals.ee_organism_revealed = true
		await C.Nathe.say("Wait. There's a third game now. I did not put that there.")
		await C.Roger.say("The organism added it while we were busy saving it.")
		await C.Nathe.say("It made a video game.")
		await C.Roger.say("It attempted a video game.")
		await C.Nathe.say("That's adorable.")

	# Spawn arcade machine as a CanvasLayer so it renders over everything
	var cl := CanvasLayer.new()
	cl.layer = 100
	get_tree().root.add_child(cl)
	var arcade := preload("res://game/mini_games/arcade_machine/arcade_machine.tscn").instantiate()
	cl.add_child(arcade)
	await arcade.done

	var last_game: String = arcade.result_game
	var last_won: bool = arcade.result_won
	cl.queue_free()

	# Nathe and Roger react to the last game played
	if last_game == "space_rocks":
		if last_won:
			await C.Nathe.say("HA! Take THAT, space debris!")
			await C.Roger.say("You are celebrating the destruction of rocks.")
			await C.Nathe.say("SPACE rocks. The distinction matters.")
		else:
			await C.Nathe.say("I was destroyed by a pebble.")
			await C.Roger.say("A medium-sized asteroid fragment.")
			await C.Nathe.say("A. Pebble.")
	elif last_game == "quantum_paddle":
		if last_won:
			await C.Nathe.say("The machine has been defeated! Let this be a lesson to all machines.")
			await C.Roger.say("The lesson being that you had time to practice a paddle game.")
			await C.Nathe.say("The lesson being that I WIN.")
		else:
			await C.Nathe.say("The paddle was too short. I demand a rematch.")
			await C.Roger.say("You can press 2 again.")
			await C.Nathe.say("...In a minute.")
	elif last_game == "organism_game":
		await C.Nathe.say("I won. I WON the incomprehensible alien game.")
		await C.Roger.say("The organism has acknowledged your victory condition.")
		await C.Nathe.say("What does THAT mean?")
		await C.Roger.say("Unknown. Congratulations.")
		await C.Nathe.say("This is going on my academic record.")


func _on_right_click() -> void:
	await C.Nathe.say("A full-size arcade cabinet. In a space station. Someone had priorities.")
