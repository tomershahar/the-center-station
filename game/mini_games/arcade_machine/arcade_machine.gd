extends Node2D

signal done

var result_game: String = ""
var result_won: bool = false

enum State { MENU, SPACE_ROCKS, QUANTUM_PADDLE, ORGANISM_GAME, RESULT }
var _state: State = State.MENU
var _result_timer: float = 0.0

# Space Rocks
var _ship_pos := Vector2(160, 90)
var _ship_rot := -PI / 2.0
var _ship_vel := Vector2.ZERO
var _ship_immune := 0.0
var _lives := 3
var _rocks: Array = []
var _bullets: Array = []
var _shoot_cd := 0.0

# Quantum Paddle
var _py := 90.0
var _ay := 90.0
var _ball := Vector2(160, 90)
var _bvel := Vector2(65, 25)
var _pscore := 0
var _ascore := 0

# Organism Game
var _org_time := 0.0
var _org_shapes: Array = []
var _org_won := false

const PH := 24.0
const PW := 4.0
const BR := 3.0
const FS := 10
const FSS := 8
const FSL := 16


func _ready() -> void:
	set_process_unhandled_input(true)


func _unhandled_input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed):
		return
	var k: int = (event as InputEventKey).keycode
	match _state:
		State.MENU:
			if k == KEY_1: _start_sr()
			elif k == KEY_2: _start_qp()
			elif k == KEY_3 and Globals.final_complete: _start_og()
			elif k == KEY_ESCAPE:
				set_process_unhandled_input(false)
				done.emit()
		State.SPACE_ROCKS:
			if k == KEY_ESCAPE: _state = State.MENU
		State.QUANTUM_PADDLE:
			if k == KEY_ESCAPE: _state = State.MENU
		State.ORGANISM_GAME:
			if k == KEY_O: _org_won = true
			elif k == KEY_ESCAPE: _state = State.MENU
		State.RESULT:
			_state = State.MENU


func _process(delta: float) -> void:
	match _state:
		State.SPACE_ROCKS: _proc_sr(delta)
		State.QUANTUM_PADDLE: _proc_qp(delta)
		State.ORGANISM_GAME: _proc_og(delta)
		State.RESULT:
			_result_timer -= delta
			if _result_timer <= 0:
				_state = State.MENU
	queue_redraw()


func _draw() -> void:
	draw_rect(Rect2(0, 0, 320, 180), Color.BLACK)
	match _state:
		State.MENU: _draw_menu()
		State.SPACE_ROCKS: _draw_sr()
		State.QUANTUM_PADDLE: _draw_qp()
		State.ORGANISM_GAME: _draw_og()
		State.RESULT: _draw_result()


# ─── MENU ────────────────────────────────────────────────────────────────────

func _draw_menu() -> void:
	var f := ThemeDB.fallback_font
	draw_string(f, Vector2(0, 45), "ARCADE ZONE 9000", HORIZONTAL_ALIGNMENT_CENTER, 320, FSL, Color.YELLOW)
	draw_string(f, Vector2(0, 82), "[1]  SPACE ROCKS", HORIZONTAL_ALIGNMENT_CENTER, 320, FS, Color.WHITE)
	draw_string(f, Vector2(0, 100), "[2]  QUANTUM PADDLE", HORIZONTAL_ALIGNMENT_CENTER, 320, FS, Color.WHITE)
	if Globals.final_complete:
		draw_string(f, Vector2(0, 118), "[3]  ???", HORIZONTAL_ALIGNMENT_CENTER, 320, FS, Color(0.8, 0.4, 1.0))
	draw_string(f, Vector2(0, 166), "[ESC]  EXIT", HORIZONTAL_ALIGNMENT_CENTER, 320, FSS, Color(0.5, 0.5, 0.5))


# ─── SPACE ROCKS ─────────────────────────────────────────────────────────────

func _start_sr() -> void:
	_ship_pos = Vector2(160, 90)
	_ship_rot = -PI / 2.0
	_ship_vel = Vector2.ZERO
	_ship_immune = 2.0
	_lives = 3
	_rocks = []
	_bullets = []
	_shoot_cd = 0.0
	for _i in range(4):
		var p := Vector2(randf_range(0, 320), randf_range(0, 180))
		while p.distance_to(_ship_pos) < 55:
			p = Vector2(randf_range(0, 320), randf_range(0, 180))
		_rocks.append({"p": p, "v": Vector2.from_angle(randf() * TAU) * randf_range(12, 28), "r": 18.0})
	_state = State.SPACE_ROCKS


func _proc_sr(delta: float) -> void:
	_shoot_cd = maxf(_shoot_cd - delta, 0.0)
	_ship_immune = maxf(_ship_immune - delta, 0.0)

	if Input.is_action_pressed("ui_left"):  _ship_rot -= 2.8 * delta
	if Input.is_action_pressed("ui_right"): _ship_rot += 2.8 * delta
	if Input.is_action_pressed("ui_up"):
		_ship_vel += Vector2.from_angle(_ship_rot) * 90.0 * delta
	_ship_vel = _ship_vel.limit_length(80.0).lerp(Vector2.ZERO, 0.4 * delta)
	_ship_pos = Vector2(fposmod(_ship_pos.x + _ship_vel.x * delta, 320.0),
						fposmod(_ship_pos.y + _ship_vel.y * delta, 180.0))

	if Input.is_action_just_pressed("ui_accept") and _shoot_cd <= 0.0:
		_shoot_cd = 0.25
		_bullets.append({"p": _ship_pos, "v": Vector2.from_angle(_ship_rot) * 160.0, "t": 1.2})

	for b in _bullets:
		b.p = Vector2(fposmod(b.p.x + b.v.x * delta, 320.0), fposmod(b.p.y + b.v.y * delta, 180.0))
		b.t -= delta
	_bullets = _bullets.filter(func(b): return b.t > 0)

	for r in _rocks:
		r.p = Vector2(fposmod(r.p.x + r.v.x * delta, 320.0), fposmod(r.p.y + r.v.y * delta, 180.0))

	# Bullet-rock collisions
	var new_rocks: Array = []
	var dead: Array = []
	for bi in range(_bullets.size() - 1, -1, -1):
		if bi >= _bullets.size(): continue
		var b = _bullets[bi]
		for ri in range(_rocks.size()):
			if ri in dead: continue
			var r = _rocks[ri]
			if b.p.distance_to(r.p) < r.r:
				dead.append(ri)
				_bullets.remove_at(bi)
				if r.r > 8.0:
					for _s in range(2):
						new_rocks.append({"p": r.p, "v": Vector2.from_angle(randf() * TAU) * randf_range(18, 40), "r": r.r * 0.55})
				break
	var kept: Array = []
	for ri in range(_rocks.size()):
		if not ri in dead:
			kept.append(_rocks[ri])
	_rocks = kept + new_rocks

	# Ship-rock collision
	if _ship_immune <= 0.0:
		for r in _rocks:
			if _ship_pos.distance_to(r.p) < r.r + 4.0:
				_lives -= 1
				_ship_pos = Vector2(160, 90)
				_ship_vel = Vector2.ZERO
				_ship_immune = 2.0
				break

	if _lives <= 0:
		result_game = "space_rocks"; result_won = false
		_result_timer = 2.5; _state = State.RESULT
	elif _rocks.is_empty():
		result_game = "space_rocks"; result_won = true
		_result_timer = 2.5; _state = State.RESULT


func _draw_sr() -> void:
	var f := ThemeDB.fallback_font
	for r in _rocks:
		draw_arc(r.p, r.r, 0.0, TAU, 10, Color(0.6, 0.6, 0.6), 1.5)
	for b in _bullets:
		draw_circle(b.p, 1.5, Color.YELLOW)
	if _ship_immune <= 0.0 or fmod(_ship_immune, 0.3) > 0.15:
		var fwd := Vector2.from_angle(_ship_rot)
		var rgt := fwd.rotated(PI / 2.0)
		draw_colored_polygon(PackedVector2Array([
			_ship_pos + fwd * 7.0,
			_ship_pos - fwd * 4.0 + rgt * 4.0,
			_ship_pos - fwd * 4.0 - rgt * 4.0
		]), Color.WHITE)
	draw_string(f, Vector2(5, 16), "LIVES: " + str(_lives), HORIZONTAL_ALIGNMENT_LEFT, -1, FS, Color(1.0, 0.4, 0.4))
	draw_string(f, Vector2(0, 16), str(_rocks.size()) + " rocks", HORIZONTAL_ALIGNMENT_RIGHT, 315, FS, Color.WHITE)
	draw_string(f, Vector2(0, 178), "ARROWS: Fly   SPACE: Shoot   ESC: Menu", HORIZONTAL_ALIGNMENT_CENTER, 320, FSS - 1, Color(0.45, 0.45, 0.45))


# ─── QUANTUM PADDLE ───────────────────────────────────────────────────────────

func _start_qp() -> void:
	_py = 90.0; _ay = 90.0
	_ball = Vector2(160, 90)
	var a := randf_range(-PI / 5.0, PI / 5.0)
	_bvel = Vector2.from_angle(a) * 65.0
	if randf() > 0.5: _bvel.x = -_bvel.x
	_pscore = 0; _ascore = 0
	_state = State.QUANTUM_PADDLE


func _proc_qp(delta: float) -> void:
	const SPD := 80.0
	if Input.is_key_pressed(KEY_W): _py = maxf(_py - SPD * delta, PH)
	if Input.is_key_pressed(KEY_S): _py = minf(_py + SPD * delta, 180.0 - PH)
	var diff := _ball.y - _ay
	_ay = clampf(_ay + sign(diff) * minf(absf(diff), SPD * 0.78 * delta), PH, 180.0 - PH)

	_ball += _bvel * delta
	if _ball.y < BR: _bvel.y = absf(_bvel.y)
	if _ball.y > 180.0 - BR: _bvel.y = -absf(_bvel.y)

	# Player paddle (left, x=10)
	if _ball.x <= 12.0 + BR and _ball.x >= 6.0 and absf(_ball.y - _py) < PH + BR:
		_bvel.x = absf(_bvel.x)
		_bvel = (_bvel + Vector2(0.0, (_ball.y - _py) * 1.5)).normalized() * 72.0
	# AI paddle (right, x=310)
	if _ball.x >= 308.0 - BR and _ball.x <= 314.0 and absf(_ball.y - _ay) < PH + BR:
		_bvel.x = -absf(_bvel.x)
		_bvel = (_bvel + Vector2(0.0, (_ball.y - _ay) * 1.5)).normalized() * 72.0

	if _ball.x < 0: _ascore += 1; _reset_ball(true)
	if _ball.x > 320: _pscore += 1; _reset_ball(false)

	if _pscore >= 5:
		result_game = "quantum_paddle"; result_won = true
		_result_timer = 2.5; _state = State.RESULT
	elif _ascore >= 5:
		result_game = "quantum_paddle"; result_won = false
		_result_timer = 2.5; _state = State.RESULT


func _reset_ball(going_right: bool) -> void:
	_ball = Vector2(160, 90)
	var a := randf_range(-PI / 5.0, PI / 5.0)
	_bvel = Vector2.from_angle(a) * 65.0
	if not going_right: _bvel.x = -_bvel.x


func _draw_qp() -> void:
	var f := ThemeDB.fallback_font
	for i in range(0, 180, 10):
		draw_line(Vector2(160, i), Vector2(160, i + 5), Color(0.25, 0.25, 0.25), 1.0)
	draw_rect(Rect2(10.0 - PW / 2.0, _py - PH, PW, PH * 2.0), Color.CYAN)
	draw_rect(Rect2(310.0 - PW / 2.0, _ay - PH, PW, PH * 2.0), Color(1.0, 0.4, 0.4))
	draw_circle(_ball, BR, Color.WHITE)
	draw_string(f, Vector2(0, 28), str(_pscore), HORIZONTAL_ALIGNMENT_CENTER, 120, FSL, Color.CYAN)
	draw_string(f, Vector2(200, 28), str(_ascore), HORIZONTAL_ALIGNMENT_CENTER, 120, FSL, Color(1.0, 0.4, 0.4))
	draw_string(f, Vector2(0, 178), "W / S  Move   ESC  Menu", HORIZONTAL_ALIGNMENT_CENTER, 320, FSS - 1, Color(0.45, 0.45, 0.45))


# ─── ORGANISM GAME ────────────────────────────────────────────────────────────

func _start_og() -> void:
	_org_time = 0.0; _org_won = false
	_org_shapes = []
	for _i in range(18):
		_org_shapes.append({
			"p": Vector2(randf_range(20, 300), randf_range(20, 160)),
			"r": randf_range(4, 16),
			"c": Color(randf(), randf(), randf(), 0.75),
			"sp": randf_range(8, 35),
			"d": randf() * TAU
		})
	_state = State.ORGANISM_GAME


func _proc_og(delta: float) -> void:
	_org_time += delta
	for s in _org_shapes:
		s.d += randf_range(-1.5, 1.5) * delta
		s.p += Vector2.from_angle(s.d) * s.sp * delta
		s.p = Vector2(fposmod(s.p.x, 320.0), fposmod(s.p.y, 180.0))
	if _org_won:
		result_game = "organism_game"; result_won = true
		_result_timer = 3.0; _state = State.RESULT


func _draw_og() -> void:
	var f := ThemeDB.fallback_font
	for s in _org_shapes:
		draw_circle(s.p, s.r, s.c)
	draw_string(f, Vector2(0, 22), "WELCOME TO [UNTRANSLATABLE]", HORIZONTAL_ALIGNMENT_CENTER, 320, FS, Color(0.8, 0.4, 1.0))
	var prompts := ["PRESS [X+] TO ???", "USE [AB-Z] FOR @@@@", "HOLD [|O|] THEN [<>]?", "*** x *** = *****"]
	draw_string(f, Vector2(0, 96), prompts[int(_org_time * 0.4) % 4], HORIZONTAL_ALIGNMENT_CENTER, 320, FS, Color.WHITE)
	if _org_time > 12.0:
		draw_string(f, Vector2(0, 116), "(maybe try pressing O?)", HORIZONTAL_ALIGNMENT_CENTER, 320, FSS, Color(0.35, 0.35, 0.35))
	draw_string(f, Vector2(0, 178), "ESC  Give Up", HORIZONTAL_ALIGNMENT_CENTER, 320, FSS - 1, Color(0.45, 0.45, 0.45))


# ─── RESULT ───────────────────────────────────────────────────────────────────

func _draw_result() -> void:
	var f := ThemeDB.fallback_font
	var msg := "YOU WIN!" if result_won else "GAME OVER"
	var col := Color(0.2, 1.0, 0.2) if result_won else Color(1.0, 0.35, 0.35)
	if result_game == "organism_game" and result_won:
		msg = "YOU WON ???"
		col = Color(0.8, 0.4, 1.0)
	draw_string(f, Vector2(0, 90), msg, HORIZONTAL_ALIGNMENT_CENTER, 320, FSL + 4, col)
	draw_string(f, Vector2(0, 112), "press any key", HORIZONTAL_ALIGNMENT_CENTER, 320, FSS, Color(0.5, 0.5, 0.5))
