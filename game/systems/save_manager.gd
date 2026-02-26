# game/systems/save_manager.gd
# F5 = save slot 1.  F9 = load slot 1.  Brief HUD overlay for feedback.
extends Node

const SLOT := 1


func _ready() -> void:
	set_process_unhandled_input(true)


func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	if event.keycode == KEY_F5:
		_save()
	elif event.keycode == KEY_F9:
		_load()


func _save() -> void:
	E.save_game(SLOT, "slot1")
	_hud("GAME SAVED")


func _load() -> void:
	if not E.has_save():
		_hud("NO SAVE FOUND")
		return
	E.load_game(SLOT)
	# HUD shown after load completes — connect once
	E.game_loaded.connect(_on_loaded, CONNECT_ONE_SHOT)


func _on_loaded(_data: Dictionary) -> void:
	_hud("GAME LOADED")


func _hud(msg: String) -> void:
	var cl := CanvasLayer.new()
	cl.layer = 50
	get_tree().root.add_child(cl)

	var lbl := Label.new()
	lbl.text = msg
	lbl.position = Vector2(4, 4)
	lbl.add_theme_font_size_override("font_size", 8)
	cl.add_child(lbl)

	await get_tree().create_timer(2.0).timeout
	cl.queue_free()
