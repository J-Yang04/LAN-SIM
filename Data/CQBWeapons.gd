class_name CQBWeapons extends MechWeapon

class Pistol extends MechWeapon:
	func _init() -> void:
		name = "Pistol"
		abbreviation = "Pistol"
		requiredmount = Enums.MountType.AUX
		type = Enums.WeaponType.CQB
		damage = [[Enums.DamageType.KINETIC, Die.new(1,3)]]
		wrange = {Enums.RangeType.RANGE:5, Enums.RangeType.THREAT:3}
		tags = [Tag.Reliable.new(1)]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 1
		description = "A low-caliber (for mechs) pistol. Easy to maneuver and reliable at close ranges. Part of the GMS Type-I line."

class Shotgun extends MechWeapon:
	func _init() -> void:
		name = "Shotgun"
		abbreviation = "Shotgun"
		requiredmount = Enums.MountType.MAIN
		type = Enums.WeaponType.CQB
		damage = [[Enums.DamageType.KINETIC, Die.new(1,6)]]
		wrange = {Enums.RangeType.RANGE:5, Enums.RangeType.THREAT:3}
		tags = []
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 2
		description = "A mech-size shotgun. It features a pump-action for maximum reliability in line with GMS design philosophies. Part of the GMS Type-I line."

class ThermalPistol extends MechWeapon:
	func _init() -> void:
		name = "Thermal Pistol"
		abbreviation = "T. Pistol"
		requiredmount = Enums.MountType.AUX
		type = Enums.WeaponType.CQB
		damage = [[Enums.DamageType.KINETIC, 2]]
		wrange = {Enums.RangeType.LINE:5}
		tags = []
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 1
		description = "A short-range energy weapon designed for use in pairs. Delivers a line of directed thermal energy that can hit multiple targets. Part of the GMS Type-II line."
