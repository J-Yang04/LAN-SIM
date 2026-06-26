class_name EnemyMechWeapon

var name:String
var type:Enums.WeaponType
var mount:Enums.MountType
var weapon_range:Dictionary[Enums.RangeType, int]
var damage:Dictionary[Enums.DamageType, int]
var bonus:int
var accuracy:int
var tags:Array[Tag]
## An array detailing the reasons why this weapon is inactive. If it's empty the weapon is active.
var status:Array[String]
## Whether this weapon is destroyed. Destroying a weapon makes it not active. The opposite is not neccesarily true.
var destroyed: bool:
	set(value):
		destroyed = value

func get_damage():
	return damage

## Returns this weapon's threat. If there is no listed threat, returns 1 as all weapons have at least threat 1.
func get_threat() -> int:
	return weapon_range.get(Enums.RangeType.THREAT, 1)

## Gets the maximum range of a weapon, which is its listed range plus its largest pattern.
func get_max_range() -> int:
	var max_range:int = weapon_range.get(Enums.RangeType.RANGE, 0)
	var max_pattern:int = 0
	for range_type in weapon_range:
		if range_type != Enums.RangeType.RANGE:
			if weapon_range[range_type] > max_pattern:
				max_pattern = weapon_range[range_type]
	return max_range + max_pattern

## Returns whether this weapon has the Ordnance tag.
func is_ordnance():
	for tag in tags:
		if tag.name == "Ordnance":
			return true
		else:
			return false

class AssaultAR extends EnemyMechWeapon:
	func _init(Tier:int) -> void:
		name = "Heavy Assault Rifle"
		type = Enums.WeaponType.RIFLE
		mount = Enums.MountType.MAIN
		weapon_range = {Enums.RangeType.RANGE:10}
		accuracy = 0
		tags = [Tag.Reliable.new(2)]
		match Tier:
			1:
				damage = {Enums.DamageType.KINETIC:6}
				bonus = 1
			2:
				damage = {Enums.DamageType.KINETIC:8}
				bonus = 2
			3:
				damage = {Enums.DamageType.KINETIC:10}
				bonus = 3

class AssaultKnife extends EnemyMechWeapon:
	func _init(Tier:int) -> void:
		name = "Combat Knife"
		type = Enums.WeaponType.MELEE
		mount = Enums.MountType.AUX
		weapon_range = {Enums.RangeType.THREAT:1}
		accuracy = 0
		match Tier:
			1:
				damage = {Enums.DamageType.KINETIC:4}
				bonus = 1
			2:
				damage = {Enums.DamageType.KINETIC:6}
				bonus = 2
			3:
				damage = {Enums.DamageType.KINETIC:7}
				bonus = 3

class AssaultGL extends EnemyMechWeapon:
	func _init(Tier:int) -> void:
		name = "Underslung Grenade Launcher"
		type = Enums.WeaponType.LAUNCHER
		mount = Enums.MountType.AUX
		weapon_range = {Enums.RangeType.RANGE:8, Enums.RangeType.BLAST:2}
		accuracy = 0
		tags = [Tag.Arcing.new(), Tag.Loading.new()]
		match Tier:
			1:
				damage = {Enums.DamageType.EXPLOSIVE:4}
				bonus = 1
			2:
				damage = {Enums.DamageType.EXPLOSIVE:6}
				bonus = 2
			3:
				damage = {Enums.DamageType.EXPLOSIVE:8}
				bonus = 3
