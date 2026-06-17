@abstract
class_name Mount

var mount_number:int ## A unique identifier given to this mount when it is added to a mech.
var name:String ## The name of this mount.
var accepts:Array[Enums.MountType] ## An array of strings detailing the types of weapons this mount accepts.
var slots:int ## The MAXIMUM number of weapons this mount can hold.
var capacity:int ## The total capacity of weapons this mount can hold. Aux, Main, Heavy, and Superheavy weapons take up 1, 2, 3, and 3 capacity respectively.
var free_capacity:int
var can_be_superheavy_bracing:bool = true ## Whether this mount can be used as a brace for a Superheavy weapon.
var is_bracing:bool = false ## Whether this mount is currently being used as a brace for a Superheavy weapon.
var equipped_with:Array[MechWeapon] = [] ## An array containing the weapons mounted onto this mount.

func mount_weapon(Weapon:MechWeapon) -> bool:
	if Weapon.requiredmount in accepts and equipped_with.size() < slots and Weapon.capacity <= free_capacity:
		equipped_with.append(Weapon)
		free_capacity -= Weapon.capacity
		return true
	else:
		return false

## Tries to unmount the weapon at the given position. Returns true if it succeeded and false if it failed.
func unmount_weapon(Weapon_ID:int) -> bool:
	var removed_weapon = equipped_with.pop_at(Weapon_ID)
	if removed_weapon == null: return false
	free_capacity += removed_weapon.capacity
	return true

func clear_mount() -> void:
	equipped_with.clear()
	free_capacity = capacity
	is_bracing = false

## Returns all the weapons attached to this mount.
func get_mounted_weapons() -> Array[MechWeapon]:
	return equipped_with

func get_weapons_in_range(range:int) -> Array[MechWeapon]:
	var valid_weapons:Array[MechWeapon]
	for weapon in get_mounted_weapons():
		var max_range = weapon.get_max_range()
		if max_range >= range:
			valid_weapons.append(weapon)
	return valid_weapons

func get_mounted_weapon_names() -> Array[String]:
	var weapon_names:Array[String]
	for x in equipped_with:
		weapon_names.append(x.name)
	return weapon_names

## Sets the status of equipped weapons according to the given code.
func set_weapon_status(Weapon_ID:int, Reason:Enums.StatusCode):
	match Reason:
		Enums.StatusCode.DESTROYED:
			equipped_with[Weapon_ID].destroyed = true
		_:
			for tag in equipped_with[Weapon_ID].tags:
				var code = tag.update_status(Reason)
				if code != "":
					equipped_with[Weapon_ID].status.append(code)

## Returns true if the given weapon can be installed on this mount.
func can_equip(Weapon:MechWeapon) -> bool:
	if Weapon.requiredmount in accepts and Weapon.capacity <= free_capacity and equipped_with.size() < slots:
		return true
	else:
		return false

func is_full() -> bool:
	if free_capacity == 0:
		return true
	else:
		return false

## Can be equipped with 2 Aux weapons.
class AuxAux extends Mount:
	func _init(MountNumber) -> void:
		mount_number = MountNumber
		name = "Aux/Aux"
		accepts = [Enums.MountType.AUX]
		slots = 2
		capacity = 2
		free_capacity = capacity

## Can be equipped with 1 Main weapon or 2 Aux weapons.
class Flex extends Mount:
	func _init(MountNumber) -> void:
		mount_number = MountNumber
		name = "Flex"
		accepts = [Enums.MountType.AUX, Enums.MountType.MAIN]
		slots = 2
		capacity = 2
		free_capacity = capacity

## Can be equipped with 1 of any type of weapon.
class Heavy extends Mount:
	func _init(MountNumber) -> void:
		mount_number = MountNumber
		name = "Heavy"
		accepts = [Enums.MountType.AUX, Enums.MountType.HEAVY, Enums.MountType.MAIN, Enums.MountType.SUPERHEAVY]
		slots = 1
		capacity = 3
		free_capacity = capacity

class Integrated extends Mount:
	func _init(MountNumber) -> void:
		mount_number = MountNumber
		name = "Integrated"
		accepts = [Enums.MountType.AUX, Enums.MountType.HEAVY, Enums.MountType.MAIN, Enums.MountType.SUPERHEAVY]
		slots = 1
		capacity = 3
		free_capacity = capacity
		can_be_superheavy_bracing = false

## Can be equipped with 1 Main or Aux weapon.
class Main extends Mount:
	func _init(MountNumber) -> void:
		mount_number = MountNumber
		name = "Main"
		accepts = [Enums.MountType.AUX, Enums.MountType.MAIN]
		slots = 1
		capacity = 2
		free_capacity = capacity

## Can be equipped with 1 Main and 1 Aux weapon, or 2 Aux weapons.
class MainAux extends Mount:
	func _init(MountNumber) -> void:
		mount_number = MountNumber
		name = "Main/Aux"
		accepts = [Enums.MountType.AUX, Enums.MountType.MAIN]
		slots = 2
		capacity = 3
		free_capacity = capacity

## Can only be equipped with 1 Superheavy weapon.
class Superheavy extends Mount:
	func _init(MountNumber) -> void:
		mount_number = MountNumber
		name = "Superheavy"
		accepts = [Enums.MountType.SUPERHEAVY]
		slots = 1
		capacity = 3
		free_capacity = capacity
