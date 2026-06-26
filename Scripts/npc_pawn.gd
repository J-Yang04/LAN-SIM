class_name NPCPawn extends Node
## Contains all data and state for a single NPC in combat.
## Hydrated from a Dictionary.

@onready var floating_ui:= $FloatingNPCUI as VBoxContainer
@onready var name_label:= $NameLabel as Label
@onready var hit_chance_label:= $HitChanceLabel as Label

## Pawn ID. Unique for each pawn in combat.
var pid:int
var tier:int
var npc_name:String
# This data is from the COMP/CON JSONs and may not be used.
var role:String
var flavor:String
var tactics:String
var terse:String
# Base NPC stats
var armor:int
var maxhp:int
var evade:int
var edef:int
var heatcap:int
var speed:int
var sensor:int
var save:int
var hull:int
var agi:int
var sys:int
var eng:int
var size:float
var activations:int

var actions:Array
var weapons:Array
var systems:Array
var traits:Array

var hp:int
var heat:int = 0
var structure = 1
var stress = 1

var move_target:Vector2

## Hydrate this pawn's variables with an NPC class.
func hydrate_pawn(NPC_Data:Array, Tier:int) -> void:
	var frame_data:Dictionary = NPC_Data[0]
	tier = Tier
	npc_name = frame_data["name"]
	role = frame_data["role"]
	flavor = frame_data["info"]["flavor"]
	tactics = frame_data["info"]["tactics"]
	terse = frame_data["info"]["terse"]
	if frame_data["stats"]["armor"] is Array:
		armor = frame_data["stats"]["armor"][Tier-1]
	else:
		armor = frame_data["stats"]["armor"]
	if frame_data["stats"]["hp"] is Array:
		maxhp = frame_data["stats"]["hp"][Tier-1]
	else:
		maxhp = frame_data["stats"]["hp"]
	hp = maxhp
	if frame_data["stats"]["evade"] is Array:
		evade = frame_data["stats"]["evade"][Tier-1]
	else:
		evade = frame_data["stats"]["evade"]
	if frame_data["stats"]["edef"] is Array:
		edef = frame_data["stats"]["edef"][Tier-1]
	else:
		edef = frame_data["stats"]["edef"]
	if frame_data["stats"]["heatcap"] is Array:
		heatcap = frame_data["stats"]["heatcap"][Tier-1]
	else:
		heatcap = frame_data["stats"]["heatcap"]
	if frame_data["stats"]["speed"] is Array:
		speed = frame_data["stats"]["speed"][Tier-1]
	else:
		speed = frame_data["stats"]["speed"]
	if frame_data["stats"]["sensor"] is Array:
		sensor = frame_data["stats"]["sensor"][Tier-1]
	else:
		sensor = frame_data["stats"]["sensor"]
	if frame_data["stats"]["save"] is Array:
		save = frame_data["stats"]["save"][Tier-1]
	else:
		save = frame_data["stats"]["save"]
	if frame_data["stats"]["hull"] is Array:
		hull = frame_data["stats"]["hull"][Tier-1]
	else:
		hull = frame_data["stats"]["hull"]
	if frame_data["stats"]["agility"] is Array:
		agi = frame_data["stats"]["agility"][Tier-1]
	else:
		agi = frame_data["stats"]["agility"]
	if frame_data["stats"]["systems"] is Array:
		sys = frame_data["stats"]["systems"][Tier-1]
	else:
		sys = frame_data["stats"]["systems"]
	if frame_data["stats"]["engineering"] is Array:
		eng = frame_data["stats"]["engineering"][Tier-1]
	else:
		eng = frame_data["stats"]["engineering"]
	size = frame_data["stats"]["size"]
	activations = frame_data["stats"]["activations"]
	var npc_traits = NPC_Data.duplicate()
	npc_traits.pop_front()
	for feature in npc_traits:
		if feature["type"] == "Weapon":
			weapons.append(feature)
		elif feature["type"] == "Trait":
			traits.append(feature)
		elif feature["type"] == "System":
			systems.append(feature)
		else:
			actions.append(feature)
	name_label.text = npc_name
	floating_ui.refresh_ui()

## Return this pawn's position.
func get_position() -> Vector2:
	return self.position



func take_damage(Val:int) -> void:
	hp -= Val
	if hp <= 0:
		lose_structure()
		hp += maxhp

func lose_structure() -> void:
	structure -= 1
	if structure == 0:
		pass

func take_heat(Val:int) -> void:
	heat += Val
	if heat > heatcap:
		lose_stress()
		heat -= heatcap

func lose_stress() -> void:
	stress -= 1
	if stress == 0:
		pass

## Returns hit chance as a fraction of 1, given a flat bonus to hit and accuracy.
func calculate_hit_chance(Bonus:int, Accuracy:int = 0, Difficulty:int = 0) -> float:
	var hit_chance:float
	var accuracy_value:float = 0
	var final_accuracy:int = abs(Accuracy - Difficulty)
	if final_accuracy > 0:
		var total_outcomes: float = pow(6, final_accuracy)
		for i in range(1, 7):
			var combinations: float = pow(i, final_accuracy) - pow(i-1, final_accuracy)
			accuracy_value += i * (combinations/total_outcomes)
	if Difficulty > Accuracy: accuracy_value = -accuracy_value
	var final_bonus = Bonus + accuracy_value
	hit_chance = (21-(evade-final_bonus))/20
	return hit_chance

func _on_mouse_entered() -> void:
	print("Hover")
	if Global.ui_state == "target select":
		var weapon:MechWeapon = Global.Targeting_Weapon
		var hit_chance = calculate_hit_chance(0, 0, 6)
		hit_chance_label.text = str(snappedf(hit_chance * 100, 0.01)) + "% TO HIT"
		hit_chance_label.show()

func _on_mouse_exited() -> void:
	hit_chance_label.hide()
