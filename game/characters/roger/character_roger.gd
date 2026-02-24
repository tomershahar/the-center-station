@tool
extends PopochiuCharacter

const Data := preload('character_roger_state.gd')

var state: Data = load("res://game/characters/roger/character_roger.tres")

# ============================================================
# ROGER HINT SYSTEM
# ============================================================
# Roger provides timed hints based on Globals.roger_mode.
# Each room calls setup_room_hints() on room entry.
# reset_hint_timer() is called on any meaningful player action.
# stop_hints() is called when leaving a room or puzzle is solved.
# ============================================================

# Hint timer state
var _hint_timer: float = 0.0
var _hint_tier_given: int = 0      # 0 = none given yet, 1/2/3 = that tier given
var _is_timer_running: bool = false
var _pending_hint: int = 0         # Set by _process, delivered via call_deferred

# Current room's hint strings, keyed as "tier1_talkative", "tier2_balanced", etc.
var _room_hints: Dictionary = {}

# Tier 2/3 delay thresholds in seconds, by roger_mode
const THRESHOLDS: Dictionary = {
	"talkative": {"tier2": 60.0,  "tier3": 150.0},
	"balanced":  {"tier2": 150.0, "tier3": 270.0},
	"quiet":     {"tier2": 300.0, "tier3": 480.0},
}


#region Virtual ####################################################################################

func _on_room_set() -> void:
	pass


func _on_click() -> void:
	E.command_fallback()


func _on_double_click() -> void:
	E.command_fallback()


func _on_right_click() -> void:
	E.command_fallback()


func _on_middle_click() -> void:
	E.command_fallback()


func _on_item_used(_item: PopochiuInventoryItem) -> void:
	E.command_fallback()


func _play_idle() -> void:
	super()


func _play_walk(target_pos: Vector2) -> void:
	super(target_pos)


func _play_talk() -> void:
	super()


func _play_grab() -> void:
	super()


func _on_move_ended() -> void:
	pass


#endregion

#region Hint System ################################################################################

## Called by room scripts on room entry.
## hints_dict keys: "tier1_talkative", "tier2_balanced", "tier3_quiet", etc.
## Fires Tier 1 immediately, then starts the inactivity timer for Tier 2/3.
func setup_room_hints(hints_dict: Dictionary) -> void:
	_room_hints = hints_dict
	_hint_tier_given = 0
	_hint_timer = 0.0
	_is_timer_running = true
	# Tier 1 fires immediately on room entry (design spec requirement)
	await _give_hint(1)


## Call this on any meaningful player action (click, inventory use, dialogue choice).
## Resets the inactivity timer — prevents premature Tier 2/3 hints.
func reset_hint_timer() -> void:
	_hint_timer = 0.0


## Call when leaving a room or when a puzzle is solved.
## Stops further hints from firing.
func stop_hints() -> void:
	_is_timer_running = false
	_hint_tier_given = 0
	_hint_timer = 0.0
	_room_hints = {}


func _process(delta: float) -> void:
	if Engine.is_editor_hint() or not _is_timer_running:
		return
	_hint_timer += delta
	var mode: String = Globals.roger_mode
	if not THRESHOLDS.has(mode):
		return
	var t: Dictionary = THRESHOLDS[mode]
	# Set flag only — never await inside _process (Godot frame-loop constraint)
	if _hint_tier_given < 2 and _hint_timer >= t["tier2"] and _pending_hint == 0:
		_pending_hint = 2
		call_deferred("_deliver_pending_hint")
	elif _hint_tier_given < 3 and _hint_timer >= t["tier3"] and _pending_hint == 0:
		_pending_hint = 3
		call_deferred("_deliver_pending_hint")


func _deliver_pending_hint() -> void:
	if _pending_hint == 0:
		return
	var tier: int = _pending_hint
	_pending_hint = 0
	await _give_hint(tier)


func _give_hint(tier: int) -> void:
	if _hint_tier_given >= tier:
		return
	var mode: String = Globals.roger_mode
	var key: String = "tier%d_%s" % [tier, mode]
	if not _room_hints.has(key):
		return
	var hint_text: String = _room_hints[key]
	if hint_text.is_empty():
		# Empty string = silent tier (design spec: quiet mode tier 1 is sometimes silent)
		_hint_tier_given = tier
		return
	_hint_tier_given = tier
	await say(hint_text)


#endregion

#region Public #####################################################################################
#endregion
