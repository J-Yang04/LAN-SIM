class_name EnemyFrame

## The pattern of this mech. Open information.
var pattern:String
## The name of this specific unit. Might not be used.
var name:String
var enemy_type:String
var hase:Array[int]
var tier:int
var size:int
var armor:int
var hp_max:int
var heat_max:int
var structure_max:int = 1
var stress_max:int = 1
var evasion:int
var edef:int
var speed:int
var sensors:int
var save_target:int
var weapons:Array
var actions:Array[Action]
var systems:Array

## Gets the mech's custom name.
func get_name() -> String:
	return name

## Sets the mech's custom name.
func set_name(Name:String) -> void:
	name = Name

class Assault extends EnemyFrame:
	func _init(Name:String, Tier:int) -> void:
		pattern = "Assault"
		name = Name
		tier = Tier
		size = 1
		armor = 1
		heat_max = 8
		speed = 4
		sensors = 8
		weapons = [NPCWeapons.AssaultAR, EnemyMechWeapon.AssaultKnife.new(Tier)]
		match Tier:
			1:
				hase = [1,1,1,1]
				hp_max = 15
				evasion = 8
				edef = 8
				save_target = 10
			2:
				hase = [2,2,2,2]
				hp_max = 18
				evasion = 10
				edef = 9
				save_target = 12
			3:
				hase = [3,3,3,3]
				hp_max = 21
				evasion = 12
				edef = 10
				save_target = 14
