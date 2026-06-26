class_name MechWeapon

var name:String
## A shortened version of the name, used in some places to save space.
var abbreviation:String
var requiredmount:Enums.MountType
var type:Enums.WeaponType
var damage:Array
var wrange:Dictionary[Enums.RangeType, int]
var tags:Array[Tag]
var source:String
var license:String
var license_level:int
var capacity:int
var sp:int = 0
var description:String
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
	return wrange.get(Enums.RangeType.THREAT, 1)

## Gets the maximum range of a weapon, which is its listed range plus its largest pattern.
func get_max_range() -> int:
	var max_range:int
	if wrange.has(Enums.RangeType.RANGE):
		max_range = wrange.get(Enums.RangeType.RANGE)
	else:
		max_range = wrange.get(Enums.RangeType.THREAT, 0)
	var max_pattern:int = 0
	for range_type in wrange:
		if range_type != Enums.RangeType.RANGE and range_type != Enums.RangeType.THREAT:
			if wrange[range_type] > max_pattern:
				max_pattern = wrange[range_type]
	return max_range + max_pattern

## Returns whether this weapon has the Ordnance tag.
func is_ordnance():
	for tag in tags:
		if tag.name == "Ordnance":
			return true
		else:
			return false
