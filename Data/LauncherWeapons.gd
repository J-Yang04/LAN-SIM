class_name LauncherWeapons extends MechWeapon

class MissileRack extends LauncherWeapons:
	func _init() -> void:
		name = "Missile Rack"
		abbreviation = "Miss. Rack"
		requiredmount = Enums.MountType.AUX
		type = Enums.WeaponType.LAUNCHER
		damage = [[Enums.DamageType.EXPLOSIVE, Die.new(1,3), 1]]
		wrange = {Enums.RangeType.RANGE:10, Enums.RangeType.BLAST:1}
		tags = [Tag.Loading.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 1
		description = "A rack of small, unguided missiles, designed to be mounted and fired in groups. Part of the GMS Type-III line."

class RPG extends LauncherWeapons:
	func _init() -> void:
		name = "Rocket-Propelled Grenade"
		abbreviation = "RPG"
		requiredmount = Enums.MountType.MAIN
		type = Enums.WeaponType.LAUNCHER
		damage = [[Enums.DamageType.EXPLOSIVE, Die.new(1,6), 1]]
		wrange = {Enums.RangeType.RANGE:10, Enums.RangeType.BLAST:2}
		tags = [Tag.Loading.new(), Tag.Ordnance.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 3
		description = "A muzzle-loaded explosive rocket launcher. Creates large explosions but slow to load. Part of the GMS Type-III line."
