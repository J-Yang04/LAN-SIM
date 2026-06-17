class_name RifleWeapons extends MechWeapon


class AMR extends RifleWeapons:
	func _init() -> void:
		name = "Anti-Materiel Rifle"
		abbreviation = "AMR"
		requiredmount = Enums.MountType.HEAVY
		type = Enums.WeaponType.RIFLE
		damage = [[Enums.DamageType.KINETIC, Die.new(2,6)]]
		wrange = {Enums.RangeType.RANGE:20}
		tags = [Tag.Accurate.new(1), Tag.ArmorPiercing.new(), Tag.Loading.new(), Tag.Ordnance.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 3
		description = "A heavy single-shot rifle. Delivers armor-penetrating bullets with great accuracy. Part of the GMS Type-III line."

class AssaultRifle extends RifleWeapons:
	func _init() -> void:
		name = "Assault Rifle"
		abbreviation = "AR"
		requiredmount = Enums.MountType.MAIN
		type = Enums.WeaponType.RIFLE
		damage = [[Enums.DamageType.KINETIC, Die.new(1,6)]]
		wrange = {Enums.RangeType.RANGE:10}
		tags = [Tag.Reliable.new(2), Tag.Overkill.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 2
		description = "A magazine-fed automatic rifle suitable for use in all theatres. This GMS design is possibly the most mass-produced mech weapon ever. Part of the GMS Type-I line."

class CyclonePulseRifle extends RifleWeapons:
	func _init() -> void:
		name = "Cyclone Pulse Rifle"
		abbreviation = "Cyclone PR"
		requiredmount = Enums.MountType.SUPERHEAVY
		type = Enums.WeaponType.RIFLE
		damage = [[Enums.DamageType.KINETIC, Die.new(3,6), 3]]
		wrange = {Enums.RangeType.RANGE:15}
		tags = [Tag.Accurate.new(1), Tag.Loading.new(), Tag.Reliable.new(5)]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 3
		description = "A pulse weapon of extreme size. The projectile is charged with unstable energy as it leaves the barrel for a massive impact on target. Part of the GMS Type-III line."

class ThermalRifle extends RifleWeapons:
	func _init() -> void:
		name = "Thermal Rifle"
		abbreviation = "T. Rifle"
		requiredmount = Enums.MountType.MAIN
		type = Enums.WeaponType.RIFLE
		damage = [[Enums.DamageType.ENERGY, Die.new(1,3), 2]]
		wrange = {Enums.RangeType.RANGE:5}
		tags = [Tag.ArmorPiercing.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 2
		description = "A short-range directed energy weapon. Delivers waves of heat that melt and crack armor. Part of the GMS Type-II line."

class OracleLMG extends RifleWeapons:
	func _init() -> void:
		name = "Oracle LMG-I"
		abbreviation = "O/LMG-I"
		requiredmount = Enums.MountType.AUX
		type = Enums.WeaponType.RIFLE
		damage = [[Enums.DamageType.KINETIC, Die.new(1,3)]]
		wrange = {Enums.RangeType.RANGE:15}
		tags = [Tag.Accurate.new(1), Tag.Arcing.new()]
		source = "SSC"
		license = "Swallowtail"
		license_level = 2
		capacity = 1
		sp = 1
		description = "The Oracle Indirect Light Machine Gun (designated O/LMG-I) packs a subsentient, high-volume DOWNPOUR static quad-barrel system into a single cylinder typically installed on the dorsal panel of a chassis. Paired with a firing system, the Oracle is capable of directing persistent defilade-ignorant kinetic fire at targets."
