class_name CannonWeapons extends MechWeapon

class HMG extends CannonWeapons:
	func _init() -> void:
		name = "Heavy Machine Gun"
		abbreviation = "HMG"
		requiredmount = Enums.MountType.HEAVY
		type = Enums.WeaponType.CANNON
		damage = [[Enums.DamageType.KINETIC, Die.new(2,6), 4]]
		wrange = {Enums.RangeType.RANGE:8}
		tags = [Tag.Inaccurate.new(1)]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 3
		description = "A high-caliber machine gun capable of laying down a hail of supressive fire. Its effective range and accuracy is limited by its heavy recoil. Part of the GMS Type-I line."

class Howitzer extends CannonWeapons:
	func _init() -> void:
		name = "Howitzer"
		abbreviation = "Howitzer"
		requiredmount = Enums.MountType.HEAVY
		type = Enums.WeaponType.CANNON
		damage = [[Enums.DamageType.EXPLOSIVE, Die.new(2,6)]]
		wrange = {Enums.RangeType.RANGE:20, Enums.RangeType.BLAST:2}
		tags = [Tag.Arcing.new(), Tag.Inaccurate.new(1), Tag.Loading.new(), Tag.Ordnance.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 3
		description = "A long-range mech-mounted artillery piece. Part of the GMS Type-III line."
		

class HurricaneClusterProjector extends CannonWeapons:
	func _init() -> void:
		name = "Hurricane Cluster Projector"
		abbreviation = "Hurricane CP"
		requiredmount = Enums.MountType.SUPERHEAVY
		type = Enums.WeaponType.CANNON
		damage = [[Enums.DamageType.EXPLOSIVE, Die.new(1,6), 1]]
		wrange = {Enums.RangeType.RANGE:10, Enums.RangeType.BLAST:2}
		tags = [Tag.Arcing.new(), Tag.Inaccurate.new(1), Tag.Loading.new(), Tag.Ordnance.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 3
		description = "This oversized, chassis-mounted artillery platform is capable of unleashing a devastating barrage. With a short maximum range for a weapon of its kind, it is nevertheless capable of saturating a targeted area in a harrowing hail of intelligent self-correcting cluster munitions. It is currently carried in the “Storm” line of superheavy equipment."

class Mortar extends CannonWeapons:
	func _init() -> void:
		name = "Mortar"
		abbreviation = "Mortar"
		requiredmount = Enums.MountType.MAIN
		type = Enums.WeaponType.CANNON
		damage = [[Enums.DamageType.EXPLOSIVE, Die.new(1,6), 1]]
		wrange = {Enums.RangeType.RANGE:15, Enums.RangeType.BLAST:1}
		tags = [Tag.Arcing.new(), Tag.Inaccurate.new(1)]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 2
		description = "A self-loading light artillery piece. Lobs shells quickly, but not particularly accurately. Part of the GMS Type-III line."

class ThermalLance extends CannonWeapons:
	func _init() -> void:
		name = "Thermal Lance"
		abbreviation = "T. Lance"
		requiredmount = Enums.MountType.HEAVY
		type = Enums.WeaponType.CANNON
		damage = [[Enums.DamageType.ENERGY, Die.new(1,6), 3]]
		wrange = {Enums.RangeType.LINE:10}
		tags = [Tag.HeatSelf.new(2)]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 3
		description = "A long-range directed energy weapon. The beam of heat that issues from this weapon is so powerful it can hit multiple targets in a row. Part of the GMS Type-II line."
