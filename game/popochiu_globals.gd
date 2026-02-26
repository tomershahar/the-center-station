extends Node

# ============================================================
# THE CENTER STATION — Game State (Globals autoload)
# ============================================================
# All game state lives here. Access via: Globals.variable_name
# ============================================================

# === PLAYER ===
var player_name: String = "Nathe"       # "Nathe" or "Nathali" — set in opening scene
var roger_mode: String = "balanced"     # "talkative" | "balanced" | "quiet"

# === ORGANISM ===
var organism_name: String = "Subject Alpha-7"  # Set during Protocol Reclassification
var organism_has_spoken: bool = false           # True after First Contact event

# === ACT TRACKING ===
var act: int = 1  # 1, 2, or 3

# === PUZZLE COMPLETION FLAGS ===
var tutorial_complete: bool = false
var opening_played: bool = false
var nathe_in_bed: bool = false
var protocol_reclassification_complete: bool = false
var chemistry_complete: bool = false
var physics_complete: bool = false
var biology_complete: bool = false
var math_complete: bool = false
var storage_complete: bool = false
var social_complete: bool = false
var final_complete: bool = false

# === PROGRESSION FLAGS ===
var labs_unlocked: bool = false         # Set true when protocol_reclassification_complete
var observation_unlocked: bool = false  # Set true when all 4 lab components done
var nexus_unlocked: bool = false        # Set true when social_complete

# === DATA ITEMS (logged in Nathe's notebook — not physical inventory) ===
var has_chemical_analysis: bool = false    # From Chemistry Lab spectrometer
var has_frequency_map: bool = false        # From Physics Lab frequency analyzer
var has_reproduction_data: bool = false    # From Biology Lab experiment
var has_faction_decode: bool = false       # From Computer Core pattern analysis
var has_faction_alliance: bool = false     # From Observation Deck First Contact

# === PHYSICAL INVENTORY FLAGS ===
var has_lab_keycard: bool = false
var has_frequency_broadcaster: bool = false
var has_chemical_supply_kit: bool = false

# === STATE FLAGS (system state, not inventory) ===
# NOTE: has_solvent_formula replaces has_two_stage_solvent (v04 design change)
var has_solvent_formula: bool = false              # From Chemistry Lab (data/formula, not item)
var department_credentials_obtained: bool = false  # From Storage Bay, used for Physics Dish 3
var chem_kit_installed: bool = false               # ChemicalSupplyKit used in Chemistry Lab slot
var dish2_wired: bool = false                      # Dish 2 junction wired in Main Corridor (for Physics Lab puzzle)

# === MID-PUZZLE PROGRESS (migrated from node meta for save/load persistence) ===

# Biology Lab zone states
var bio_zone1_seen: bool = false
var bio_zone2_seen: bool = false
var bio_zone3_seen: bool = false
var bio_zone1_stressed: bool = false
var bio_zone1_stressed_seen: bool = false
var bio_zone2_comforted: bool = false

# Computer Core decode state
var cc_research_log_read: bool = false
var cc_monitor_a_decoded: bool = false
var cc_monitor_b_decoded: bool = false
var cc_monitor_c_decoded: bool = false

# Observation Deck negotiation state
var od_talked_to_c: bool = false
var od_talked_to_b: bool = false

# Organism Nexus step state
var nexus_step1_done: bool = false
var nexus_step2_done: bool = false
var nexus_step3_done: bool = false

# Easter egg discovery flags
var ee_photo_seen: bool = false
var ee_logs_read: bool = false
var ee_arcade_visited: bool = false
var ee_organism_revealed: bool = false

# === PLAYER-CHOSEN STRINGS ===
var department_name: String = ""  # Player's fake department name (set in Storage Bay)

# ============================================================
# HELPER FUNCTIONS
# ============================================================

# Returns true if all 4 lab component puzzles are complete
func all_components_complete() -> bool:
	return chemistry_complete and physics_complete and biology_complete and math_complete

# Call after any lab puzzle completes — unlocks Observation Deck when all 4 done
func check_observation_unlock() -> void:
	if all_components_complete() and not observation_unlocked:
		observation_unlocked = true
		act = 3
		print("[Globals] Observation Deck unlocked. Act 3 begins.")
