class_name PilotArmor

var armor_bonus:int
var hp_bonus:int
var e_defense:int
var evasion:int
var speed:int
var abilities:Array
var actions:Array

class LightHardsuit extends PilotArmor:
	func _init() -> void:
		armor_bonus = 0
		hp_bonus = 3
		e_defense = 10
		evasion = 10
		speed = 4

class AssaultHardsuit extends PilotArmor:
	func _init() -> void:
		armor_bonus = 1
		hp_bonus = 3
		e_defense = 8
		evasion = 8
		speed = 4

class HeavyHardsuit extends PilotArmor:
	func _init() -> void:
		armor_bonus = 2
		hp_bonus = 3
		e_defense = 8
		evasion = 6
		speed = 3

class MobilityHardsuit extends PilotArmor:
	func _init() -> void:
		armor_bonus = 0
		hp_bonus = 0
		e_defense = 10
		evasion = 10
		speed = 5
		abilities = [{"name":"Mobility Hardsuit", "description":"These hardsuits have integrated flight systems, allowing pilots to fly when they move or Boost. Flying pilots must end their turn on the ground (or another surface) or begin falling."}]

class StealthHardsuit extends PilotArmor:
	func _init() -> void:
		armor_bonus = 0
		hp_bonus = 0
		e_defense = 8
		evasion = 8
		speed = 4
		abilities = [{"name":"Stealth Hardsuit", "description":"As a quick action, pilots wearing stealth hardsuits can become Invisible. They cease to be Invisible if they take any damage."}]
		actions = [PilotGearActions.ActivateStealthHardsuit.new()]
