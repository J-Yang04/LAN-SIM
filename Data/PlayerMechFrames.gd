class_name Frame

var pattern:String
var _name:String
var manufacturer
var license
var license_level:int
var mech_type
var tier:int
var size:int
var health_max:int
var heat_max:int
var structure_max:int
var stress_max:int
var armor:int
var evasion:int
var edef:int
var speed:int
var sensors:int
var tech_attack:int
var save_target:int
var repair_max:int
var sp:int
var _mounts:Array[Mount]
## Special actions granted by this frame.
var actions:Array[Action]
var systems:Array

func get_traits():
	pass

func get_core_system():
	pass

func get_mounts() -> Array[Mount]:
	return _mounts

## Attempts to mount a weapon to a mount on the frame. If the frame is full or the weapon is invalid, returns false. Otherwise returns true.
func try_mount_weapon(Mount_ID:int, weapon:MechWeapon) -> bool:
	if _mounts[Mount_ID].mount_weapon(weapon):
		return true
	else:
		return false

func clear_mounts() -> void:
	for mount in _mounts:
		mount.clear_mount()

func unmount_weapon(WeaponID:int, MountID:int) -> void:
	_mounts[MountID].unmount_weapon(WeaponID)

## Returns a list of all weapons on a mount.
func get_mount_weapons(Mount_ID:int):
	return _mounts[Mount_ID].get_mounted_weapons()

## Returns a list of all weapons on all mounts.
func get_weapons() -> Array[MechWeapon]:
	var weapons_list:Array[MechWeapon]
	for mount in _mounts:
		weapons_list.append_array(mount.get_mounted_weapons())
	return weapons_list

## Gets a string detailing the manufacturer, required LL, and pattern of the mech.
func get_pattern() -> String:
	var nice_pattern = str(manufacturer, " ", license_level, " ", pattern)
	return nice_pattern

## Gets the mech's custom name.
func get_name() -> String:
	return _name

## Sets the mech's custom name.
func set_name(Name:String) -> void:
	_name = Name

class Everest extends Frame:
	func _init(Name:String = "Everest") -> void:
		pattern = "Everest"
		_name = Name
		manufacturer = "GMS"
		license = "Everest"
		license_level = 0
		mech_type = ["Balanced"]
		tier = 0
		size = 1
		health_max = 10
		heat_max = 6
		structure_max = 4
		stress_max = 4
		armor = 0
		evasion = 8
		edef = 8
		speed = 4
		sensors = 10
		tech_attack = 0
		save_target = 0
		sp = 6
		_mounts = [Mount.Main.new(0), Mount.Flex.new(1), Mount.Heavy.new(2)]

class Chomolungma extends Frame:
	func _init(Name:String = "Chomolungma") -> void:
		pattern = "Chomolungma"
		_name = Name
		manufacturer = "GMS"
		license = "Everest"
		license_level = 0
		mech_type = ["Controller", "Support"]
		tier = 0
		size = 1
		health_max = 10
		heat_max = 4
		structure_max = 4
		stress_max = 4
		armor = 0
		evasion = 8
		edef = 10
		speed = 4
		sensors = 15
		tech_attack = 1
		save_target = 11
		sp = 7
		_mounts = [Mount.MainAux.new(0), Mount.Flex.new(1)]

class Sagarmatha extends Frame:
	func _init(Name:String = "Sagarmatha") -> void:
		pattern = "Sagarmatha"
		_name = Name
		manufacturer = "GMS"
		license = "Everest"
		license_level = 0
		mech_type = ["Defender"]
		tier = 0
		size = 2
		health_max = 8
		heat_max = 4
		structure_max = 4
		stress_max = 4
		armor = 1
		evasion = 8
		edef = 10
		speed = 4
		sensors = 10
		tech_attack = 0
		save_target = 10
		sp = 6
		_mounts = [Mount.Main.new(0), Mount.Flex.new(1), Mount.Heavy.new(2)]

class Blackbeard extends Frame:
	func _init(Name:String = "Blackbeard") -> void:
		pattern = "Blackbeard"
		_name = Name
		manufacturer = "IPS-N"
		license = "Blackbeard"
		license_level = 2
		mech_type = ["Striker"]
		tier = 2
		size = 1
		health_max = 12
		heat_max = 4
		structure_max = 4
		stress_max = 4
		armor = 1
		evasion = 8
		edef = 6
		speed = 5
		sensors = 5
		tech_attack = -2
		save_target = 0
		sp = 5
		_mounts = [Mount.Flex.new(0), Mount.Main.new(1), Mount.Heavy.new(2)]
