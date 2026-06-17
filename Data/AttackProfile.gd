class_name AttackProfile
## Describes a way to make an attack. Also includes targeted saves.

var name:String = ""
var damage:Array
var range:Array
var tags:Array

func _init(Name:String, Damage:Array, Weapon_Range:Array, Tags:Array) -> void:
	name = Name
	damage = Damage
	range = Weapon_Range
	tags = Tags
