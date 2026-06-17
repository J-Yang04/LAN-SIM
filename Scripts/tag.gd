@abstract
class_name Tag

var name:String
var description:String
var val:int = 0
var effects

func get_name() -> String:
	return name.format({"val": val})

func get_description() -> String:
	return description.format({"val": val})

## A boilerplate function. This should return a status code string if it needs to.
func update_status(Reason:Enums.StatusCode) -> String:
	return ""

class Accurate extends Tag:
	func _init(Val:int) -> void:
		val = Val
		name = "Accurate {val}"
		description = "Attacks made with this weapon receive +{val} Accuracy."
		effects = [Effect.new(Enums.Event.ATTACK)]

class Arcing extends Tag:
	func _init() -> void:
		name = "Arcing"
		description = "This weapon can be fired over obstacles, usually by lobbing a projectile in an arc. Attacks made with this weapon don’t require line of sight, as long as it’s possible to trace a path to the target; however, they are still affected by cover."
		effects = [Effect.new(Enums.Event.ATTACK)]

class ArmorPiercing extends Tag:
	func _init() -> void:
		name = "Armor-Piercing"
		description = "Damage dealt by this weapon ignores Armor."
		effects = [Effect.new(Enums.Event.ATTACK)]

class Grenade extends Tag:
	func _init() -> void:
		name = "Grenade"
		description = "As a quick action, this explosive or other device can be thrown to a space within line of sight and the specified Range."

class HeatSelf extends Tag:
	func _init(Val:int) -> void:
		val = Val
		name = "Heat {val} (Self)"
		description = "Immediately after using this weapon or system, the user takes {val} Heat."
		effects = [Effect.new(Enums.Event.ATTACK), Effect.new(Enums.Event.TAKE_ACTION), Effect.new(Enums.Event.TAKE_PROTOCOL)]

class Inaccurate extends Tag:
	func _init(Val:int) -> void:
		val = Val
		name = "Inaccurate {val}"
		description = "Attacks made with this weapon receive +{val} Difficulty."
		effects = [Effect.new(Enums.Event.ATTACK)]

class Knockback extends Tag:
	func _init(Val:int) -> void:
		val = Val
		name = "Knockback {val}"
		description = "On a hit, the user may choose to knock their target {val} spaces in a straight line directly away from the point of origin (e.g., the attacking mech or the center of a Blast). Multiple Knockback effects stack with each other. This means that an attack made with a Knockback 1 weapon and a talent that grants Knockback 1 counts as having Knockback 2."
		effects = [Effect.new(Enums.Event.HIT)]

class Limited extends Tag:
	var charges_remaining:int
	func _init(Val:int) -> void:
		val = Val
		name = "Limited {val}"
		description = "This weapon or system can only be used {val} times before it requires a Full Repair. "
	
	func on_effect_trigger(ignore:bool = false) -> void:
		if !ignore:
			charges_remaining -= 1

class Loading extends Tag:
	func _init() -> void:
		name = "Loading"
		description = "This weapon must be reloaded after each use. Mechs can reload with Stabilize and some systems."
		effects = [Effect.new(Enums.Event.ATTACK)]

class Ordnance extends Tag:
	func _init() -> void:
		name = "Ordnance"
		description = "This weapon can only be fired before the user moves or takes any other actions on their turn, excepting Protocols. The user can still act and move normally after attacking. Additionally, because of its size, this weapon can’t be used against targets in engagement with the user’s mech, and cannot be used for Overwatch."
		effects = [Effect.new(Enums.Event.MOVE), Effect.new(Enums.Event.TAKE_ACTION)]
	func update_status(Reason:Enums.StatusCode) -> String:
		if Reason == Enums.StatusCode.MOVED:
			return "Ordnance"
		else:
			return ""

class Overkill extends Tag:
	func _init() -> void:
		name = "Overkill"
		description = "When rolling for damage with this weapon, any damage dice that land on a 1 cause the attacker to take 1 Heat, and are then rerolled. Additional 1s continue to trigger this effect."
		effects = [Effect.new(Enums.Event.ROLL_DAMAGE)]

class Reliable extends Tag:
	func _init(Val:int) -> void:
		val = Val
		name = "Reliable {val}"
		description = "This weapon has some degree of self-correction or is simply powerful enough to cause damage even with a glancing blow. It always does {val} damage, even if it misses its target or rolls less damage. Reliable damage inherits other tags (such as AP) and base damage type but not tags that require a hit, such as Knockback."
		effects = [Effect.new(Enums.Event.MISS)]

class Smart extends Tag:
	func _init() -> void:
		name = "Smart"
		description = "This weapon has self-guidance systems, self-propelled projectiles, or even nanorobotic ammunition. These systems are effective enough that its attacks can’t simply be dodged – they must be scrambled or jammed. Because of this, all attacks with this weapon – including melee and ranged attacks – use the target’s E-Defense instead of Evasion. Targets with no E-Defense count as having 8 E-Defense."
		effects = [Effect.new(Enums.Event.ATTACK)]

class Thrown extends Tag:
	func _init(Val:int) -> void:
		val = Val
		name = "Thrown {val}"
		description = "This melee weapon can be thrown at targets within {val} spaces. Thrown attacks follow the rules for melee attacks but are affected by cover; additionally, a thrown weapon comes to rest in an adjacent space to its target and must be retrieved as a free action while adjacent to that weapon before it can be used again."
		effects = [Effect.new(Enums.Event.PICKING_TARGET), Effect.new(Enums.Event.ATTACK)]

class Unique extends Tag:
	func _init() -> void:
		name = "Unique"
		description = "This weapon or system cannot be duplicated – each character can only have one copy of it installed at a time."
