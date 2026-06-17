class_name PlayerMechSystem

var name:String
var description:String
## A type tag. Mostly for sorting and decoration.
var type:String
var manufacturer:String
var license:String
var license_level:int
var tier
## The cost in SP to mount this equipment.
var sp_cost:int
var tags:Array[Tag]
## Special actions granted by this system.
var actions:Array[Action]
## ActiveEffects granted by this system.
var active_effects:Array[ActiveEffect]

class SmokeCharges extends PlayerMechSystem:
	func _init() -> void:
		name = "Pattern-A Smoke Charges"
		description = "Mech-size smoke grenades, for creating defensive smokescreens. Can also be laid as mines to distract enemies."
		type = "Deployable"
		manufacturer = "GMS"
		license = "GMS 0"
		license_level = 0
		tier = 0
		sp_cost = 2
		tags = [Tag.Grenade.new(), Tag.Limited.new(3), Tag.Unique.new()]
		actions = [PlayerSystemActions.GrenadeGeneric.new("Smoke Grenade", "Throw a Smoke Grenade within Range 5. All characters and objects within a Blast 2 area benefit from soft cover until the end of your next turn, at which point the smoke disperses.", "SmokeCharges"),
			PlayerSystemActions.MineGeneric.new("Smoke Mine", "This mine detonates when any allied character moves over or adjacent to it. All characters and objects within a Burst 3 area benefit from soft cover until the end of the detonating character’s next turn, at which point the smoke disperses.", "SmokeCharges")]

class HexCharges extends PlayerMechSystem:
	func _init() -> void:
		name = "Pattern-B HEX Charges"
		description = "Programmable high-explosive charges that can be used as grenades or laid as mines."
		type = "Deployable"
		manufacturer = "GMS"
		license = "GMS 0"
		license_level = 0
		tier = 0
		sp_cost = 2
		tags = [Tag.Grenade.new(), Tag.Limited.new(3), Tag.Unique.new()]
		actions = [PlayerSystemActions.GrenadeGeneric.new("HEX Grenade", "Throw a HEX Grenade within Range 5. All characters within a Blast 1 area must pass an Agility save or take 1d6 Explosive damage. On a success, they take half damage.", "SmokeCharges"),
			PlayerSystemActions.MineGeneric.new("HEX Mine", "This mine detonates when any allied character moves over or adjacent to it. All characters and objects within a Burst 3 area benefit from soft cover until the end of the detonating character’s next turn, at which point the smoke disperses.", "SmokeCharges")]
