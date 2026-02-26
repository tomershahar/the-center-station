extends Node2D

signal done

enum State { TITLE, NAME_SELECT, LOADING }

const W := 320
const H := 180
const OPTIONS_NO_SAVE := ["NEW GAME", "QUIT"]
const OPTIONS_SAVE    := ["CONTINUE", "NEW GAME", "QUIT"]
const NAME_OPTIONS    := ["NATHE", "NATHALI"]

var _state: State = State.TITLE
var _selected: int = 0
var _finished: bool = false
var _has_save: bool = false
var _blink_timer: float = 0.0
var _blink_on: bool = true


func _ready() -> void:
	_has_save = E.has_save()
	set_process_unhandled_input(true)
	set_process(true)


func _process(delta: float) -> void:
	_blink_timer += delta
	if _blink_timer >= 0.55:
		_blink_timer = 0.0
		_blink_on = not _blink_on
		queue_redraw()


func _unhandled_input(event: InputEvent) -> void:
	if _finished or _state == State.LOADING:
		return
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	match event.keycode:
		KEY_UP, KEY_W:
			_selected = (_selected - 1 + _option_count()) % _option_count()
			_blink_on = true
			_blink_timer = 0.0
			queue_redraw()
		KEY_DOWN, KEY_S:
			_selected = (_selected + 1) % _option_count()
			_blink_on = true
			_blink_timer = 0.0
			queue_redraw()
		KEY_ENTER, KEY_KP_ENTER, KEY_SPACE:
			_confirm()
		KEY_ESCAPE:
			if _state == State.NAME_SELECT:
				_state = State.TITLE
				_selected = 0
				queue_redraw()


func _option_count() -> int:
	match _state:
		State.TITLE: return OPTIONS_SAVE.size() if _has_save else OPTIONS_NO_SAVE.size()
		State.NAME_SELECT: return NAME_OPTIONS.size()
		_: return 0


func _options() -> Array:
	match _state:
		State.TITLE: return OPTIONS_SAVE if _has_save else OPTIONS_NO_SAVE
		State.NAME_SELECT: return NAME_OPTIONS
		_: return []


func _confirm() -> void:
	var choice: String = _options()[_selected]
	match _state:
		State.TITLE:
			match choice:
				"CONTINUE":
					_do_continue()
				"NEW GAME":
					_state = State.NAME_SELECT
					_selected = 0
					queue_redraw()
				"QUIT":
					get_tree().quit()
		State.NAME_SELECT:
			# "NATHE" → "Nathe", "NATHALI" → "Nathali"
			Globals.player_name = choice[0] + choice.substr(1).to_lower()
			_do_new_game()


func _do_new_game() -> void:
	_finished = true
	set_process_unhandled_input(false)
	set_process(false)
	get_parent().queue_free()
	done.emit()


func _do_continue() -> void:
	_state = State.LOADING
	_finished = true
	set_process_unhandled_input(false)
	set_process(false)
	queue_redraw()
	E.game_loaded.connect(_on_loaded, CONNECT_ONE_SHOT)
	E.load_game(1)


func _on_loaded(_data: Dictionary) -> void:
	get_parent().queue_free()
	done.emit()


func _draw() -> void:
	draw_rect(Rect2(0, 0, W, H), Color.BLACK)
	var f := ThemeDB.fallback_font

	if _state == State.LOADING:
		draw_string(f, Vector2(0, 92), "LOADING...", HORIZONTAL_ALIGNMENT_CENTER, W, 9, Color.WHITE)
		return

	# Game title
	draw_string(f, Vector2(0, 48), "THE CENTER STATION", HORIZONTAL_ALIGNMENT_CENTER, W, 14, Color.YELLOW)

	# Subtitle / prompt
	if _state == State.TITLE:
		draw_string(f, Vector2(0, 66), "a game about science, cooperation,", HORIZONTAL_ALIGNMENT_CENTER, W, 7, Color(0.38, 0.38, 0.38))
		draw_string(f, Vector2(0, 75), "and a very understanding alien organism.", HORIZONTAL_ALIGNMENT_CENTER, W, 7, Color(0.38, 0.38, 0.38))
	elif _state == State.NAME_SELECT:
		draw_string(f, Vector2(0, 68), "choose your name:", HORIZONTAL_ALIGNMENT_CENTER, W, 7, Color(0.45, 0.45, 0.45))

	# Divider
	draw_line(Vector2(80, 88), Vector2(240, 88), Color(0.2, 0.2, 0.2), 1.0)

	# Options
	var opts := _options()
	var start_y := 106.0
	var spacing := 16.0
	for i in opts.size():
		var is_sel := (i == _selected)
		var col: Color
		if is_sel:
			col = Color.WHITE if _blink_on else Color(0.55, 0.55, 0.55)
		else:
			col = Color(0.32, 0.32, 0.32)
		draw_string(f, Vector2(0, start_y + i * spacing), opts[i], HORIZONTAL_ALIGNMENT_CENTER, W, 9, col)

	# ESC hint for name select
	if _state == State.NAME_SELECT:
		draw_string(f, Vector2(0, 170), "esc to go back", HORIZONTAL_ALIGNMENT_CENTER, W, 7, Color(0.22, 0.22, 0.22))
	else:
		draw_string(f, Vector2(0, 170), "arrows + enter", HORIZONTAL_ALIGNMENT_CENTER, W, 7, Color(0.22, 0.22, 0.22))

	# Fade top and bottom edges
	draw_rect(Rect2(0, 0, W, 20), Color(0, 0, 0, 0.6))
	draw_rect(Rect2(0, 160, W, 20), Color(0, 0, 0, 0.6))
