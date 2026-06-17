class_name NexusWeapons extends MechWeapon

class DevastatorNexus extends NexusWeapons:
	func _init() -> void:
		name = "Devastator Nexus"
		abbreviation = "Dev. Nexus"
		requiredmount = Enums.MountType.HEAVY
		type = Enums.WeaponType.NEXUS
		damage = [[Enums.DamageType.KINETIC, Die.new(1,3), 1], [Enums.DamageType.ENERGY, Die.new(1,3), 1]]
		wrange = {Enums.RangeType.RANGE:12}
		tags = [Tag.Smart.new()]
		source = "???"
		license = "??? 0"
		license_level = 0
		capacity = 3
		description = "A deployment system for a trio of semi-autonomous Devastator drones. These drones attack with both kinetic and energy weaponry. Found on the side of the road."


class HunterKillerNexus extends NexusWeapons:
	func _init() -> void:
		name = "Hunter-Killer Nexus"
		abbreviation = "H-K Nexus"
		requiredmount = Enums.MountType.MAIN
		type = Enums.WeaponType.NEXUS
		damage = [[Enums.DamageType.KINETIC, Die.new(1,6)]]
		wrange = {Enums.RangeType.RANGE:10}
		tags = [Tag.Smart.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 2
		description = "A deployment system for a swarm of semi-autonomous Hunter-Killer drones. The drones can intelligently seek and attack threats. Part of the GMS Type-III line."

class LightNexus extends NexusWeapons:
	func _init() -> void:
		name = "Light Nexus"
		abbreviation = "L. Nexus"
		requiredmount = Enums.MountType.AUX
		type = Enums.WeaponType.NEXUS
		damage = [[Enums.DamageType.KINETIC, Die.new(1,3)]]
		wrange = {Enums.RangeType.RANGE:10}
		tags = [Tag.Smart.new()]
		source = "GMS"
		license = "GMS 0"
		license_level = 0
		capacity = 1
		description = "A deployment system for a swarm of semi-autonomous drones. This light version requires less mounting space and processor capacity. Part of the GMS Type-III line."
