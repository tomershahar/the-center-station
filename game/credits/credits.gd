extends Node2D

signal done

const SCROLL_SPEED: float = 22.0
const LINE_H: int = 14

var _y: float = 185.0
var _finished: bool = false

var _lines: Array = [
	"THE CENTER STATION",
	"",
	"A game about a scientist, her robot,",
	"a space station, and a very",
	"understanding alien organism.",
	"",
	"",
	"---",
	"",
	"DESIGNED & WRITTEN BY",
	"[developer]",
	"",
	"",
	"---",
	"",
	"BUILT WITH",
	"Godot 4",
	"Popochiu",
	"",
	"",
	"---",
	"",
	"CHARACTERS",
	"",
	"DR. NATHE",
	"the scientist",
	"",
	"ROGER-7",
	"the assistant",
	"",
	"ARIA",
	"the station AI",
	"",
	"THE ORGANISM",
	"the unexpected guest",
	"",
	"",
	"---",
	"",
	"SPECIAL THANKS",
	"",
	"",
	"\"The organism thanks you for your",
	" patience and understanding.\"",
	"",
	"\"ARIA has no notes at this time.",
	" All systems are nominal.\"",
	"",
	"\"Roger would like to remind you",
	" to check your furniture for",
	" structural integrity issues.\"",
	"",
	"",
	"---",
	"",
	"",
	"Have a productive day.",
	"",
	"",
	"",
]


func _ready() -> void:
	set_process_unhandled_input(true)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		_emit_done()


func _process(delta: float) -> void:
	if _finished:
		return
	_y -= SCROLL_SPEED * delta
	if _y + _lines.size() * LINE_H < 0:
		_emit_done()
	queue_redraw()


func _emit_done() -> void:
	if _finished:
		return
	_finished = true
	set_process_unhandled_input(false)
	set_process(false)
	done.emit()


func _draw() -> void:
	draw_rect(Rect2(0, 0, 320, 180), Color.BLACK)
	var f := ThemeDB.fallback_font
	var y: float = _y
	for line in _lines:
		if line == "---":
			draw_line(Vector2(80, y + 4), Vector2(240, y + 4), Color(0.3, 0.3, 0.3), 1.0)
		elif line != "":
			var col: Color
			if line == "THE CENTER STATION":
				col = Color.YELLOW
			elif line in ["DR. NATHE", "ROGER-7", "ARIA", "THE ORGANISM"]:
				col = Color.CYAN
			elif line in ["DESIGNED & WRITTEN BY", "BUILT WITH", "CHARACTERS", "SPECIAL THANKS"]:
				col = Color(0.7, 0.7, 0.7)
			elif line == "Have a productive day.":
				col = Color(0.5, 0.5, 0.5)
			elif line.begins_with("\"") or line.begins_with(" "):
				col = Color(0.65, 0.65, 0.65)
			else:
				col = Color.WHITE
			draw_string(f, Vector2(0, y + 10), line, HORIZONTAL_ALIGNMENT_CENTER, 320, 10, col)
		y += LINE_H

	# Fade top and bottom edges
	draw_rect(Rect2(0, 0, 320, 35), Color(0, 0, 0, 0.8))
	draw_rect(Rect2(0, 150, 320, 30), Color(0, 0, 0, 0.8))
	draw_string(f, Vector2(0, 177), "press any key to skip", HORIZONTAL_ALIGNMENT_CENTER, 320, 7, Color(0.28, 0.28, 0.28))
