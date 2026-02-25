@tool
extends "res://addons/popochiu/engine/interfaces/i_inventory.gd"

# classes ----
const PIILabKeycard := preload("res://game/inventory_items/lab_keycard/item_lab_keycard.gd")
const PIIFrequencyBroadcaster := preload("res://game/inventory_items/frequency_broadcaster/item_frequency_broadcaster.gd")
const PIIChemicalSupplyKit := preload("res://game/inventory_items/chemical_supply_kit/item_chemical_supply_kit.gd")
# ---- classes

# nodes ----
var LabKeycard: PIILabKeycard : get = get_LabKeycard
var FrequencyBroadcaster: PIIFrequencyBroadcaster : get = get_FrequencyBroadcaster
var ChemicalSupplyKit: PIIChemicalSupplyKit : get = get_ChemicalSupplyKit
# ---- nodes

# functions ----
func get_LabKeycard() -> PIILabKeycard: return get_item_instance("LabKeycard")
func get_FrequencyBroadcaster() -> PIIFrequencyBroadcaster: return get_item_instance("FrequencyBroadcaster")
func get_ChemicalSupplyKit() -> PIIChemicalSupplyKit: return get_item_instance("ChemicalSupplyKit")
# ---- functions

