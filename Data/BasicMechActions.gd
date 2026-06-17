class_name BasicMechActions extends Action

class Attacks extends BasicMechActions:
	func _init() -> void:
		name = "Attacks"
		owner = Enums.ActionOwner.MECH
		description = "Use one or more of your mech's weapons to attack an enemy."
		action_group = "Attacks"
		group_leader = true

class Skirmish extends BasicMechActions:
	func _init() -> void:
		name = "Skirmish"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Attack with a single weapon. To SKIRMISH, choose a weapon and a valid target within RANGE (or THREAT) then make an attack. In addition to your primary attack, you may also attack with a different AUXILIARY weapon on the same mount. That weapon doesn’t deal bonus damage. SUPERHEAVY weapons are too cumbersome to use in a SKIRMISH, and can only be fired as part of a BARRAGE."
		action_group = "Attacks"

class Barrage extends BasicMechActions:
	func _init() -> void:
		name = "Barrage"
		action_cost = Enums.ActionType.FULL
		owner = Enums.ActionOwner.MECH
		description = "Attack with two weapons, or with one SUPERHEAVY weapon. To BARRAGE, choose your weapons and either one target or different targets – within range – then make an attack with each weapon. In addition to your primary attacks, you may also attack with an AUXILIARY weapon on each mount that was fired, so long as the AUXILIARY weapon hasn’t yet been fired this action. These AUXILIARY weapons don’t deal bonus damage. SUPERHEAVY weapons can only be fired as part of a BARRAGE."
		action_group = "Attacks"

class Boost extends BasicMechActions:
	func _init() -> void:
		name = "Boost"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Gain additional movement equal to your speed. Certain talents and systems can only be used when you BOOST, not when you make a standard move."

class Stabilize extends BasicMechActions:
	func _init() -> void:
		name = "Stabilize"
		action_cost = Enums.ActionType.FULL
		owner = Enums.ActionOwner.MECH
		description = "Enact emergency protocols to purge your mech’s systems of excess heat, repair your chassis where you can, or eliminate hostile code."

class GIR extends BasicMechActions:
	func _init() -> void:
		name = "Weaponless Attacks"
		abbreviation = "Special Attacks"
		owner = Enums.ActionOwner.MECH
		description = "Make a Grapple, Ram, or Improvised Attack without using any of your mech's weapons."
		action_group = "GIR"
		group_leader = true

class Grapple extends BasicMechActions:
	func _init() -> void:
		name = "Grapple"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Try to grab hold of a target and overpower them – disarming, subduing, or damaging them so they can’t do the same to you."
		action_group = "GIR"

class ImprovisedAttack extends BasicMechActions:
	func _init() -> void:
		name = "Improvised Attack"
		action_cost = Enums.ActionType.FULL
		owner = Enums.ActionOwner.MECH
		description = "Attack with a rifle butt, fist, or another improvised melee weapon. To make an IMPROVISED ATTACK, make a melee attack against an adjacent target. On a success, they take 1d6 kinetic damage."
		action_group = "GIR"

class Ram extends BasicMechActions:
	func _init() -> void:
		name = "Ram"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Make a melee attack with the aim of knocking a target down or back. To RAM, make a melee attack against an adjacent character the same SIZE or smaller than you. On a success, your target is knocked PRONE and you may also choose to knock them back by one space, directly away from you."
		action_group = "GIR"

class TechAction extends BasicMechActions:
	func _init() -> void:
		name = "Tech Actions"
		owner = Enums.ActionOwner.MECH
		description = "Engage in electronic warfare, countermeasures, and other technical actions, often aided by a mech’s powerful computing and simulation cores."
		action_group = "TechActions"
		group_leader = true

class Bolster extends BasicMechActions:
	func _init() -> void:
		name = "Bolster"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Use your mech’s formidable processing power to enhance another character’s systems. To BOLSTER, choose a character within SENSORS. They receive +2 Accuracy on the next skill check or save they make between now and the end of their next turn. Characters can only benefit from one BOLSTER at a time."
		action_group = "TechActions"

class LockOn extends BasicMechActions:
	func _init() -> void:
		name = "Lock On"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Digitally mark a target, lighting them up for your teammates’ targeting systems and exposing weak points. To LOCK ON, choose a character within SENSORS and line of sight. They gain the LOCK ON condition. Any character making an attack against a character with LOCK ON may choose to gain +1 Accuracy on that attack and then clear the LOCK ON condition after that attack resolves. This is called consuming LOCK ON."
		action_group = "TechActions"

class Invade extends BasicMechActions:
	func _init() -> void:
		name = "Invade"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Mount a direct electronic attack against a target. To INVADE, make a tech attack against a character within SENSORS and line of sight. On a success, your target takes 2 heat and you choose one of the INVASION options available to you. FRAGMENT SIGNAL is available to all characters, and additional options are granted by certain systems and equipment with the INVADE tag. You can also INVADE willing allied characters to create certain effects. If your target is willing and allied, you are automatically successful, it doesn’t count as an attack, and your target doesn’t take any heat."
		action_group = "TechActions"

class Overcharge extends BasicMechActions:
	func _init() -> void:
		name = "Overcharge"
		action_cost = Enums.ActionType.SPECIAL
		owner = Enums.ActionOwner.MECH
		description = "Briefly push your mech beyond factory specifications for a tactical advantage. Moments of intense action won’t tax your mech’s systems too much, but sustained action beyond prescribed limits takes a toll. Once per turn, you can OVERCHARGE your mech, allowing you to make any quick action as a free action – even actions you have already taken this turn.."

class SelfDestruct extends BasicMechActions:
	func _init() -> void:
		name = "!!Self Destruct!!"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Overload your mech’s reactor in a final, catastrophic play if there’s no other option for escape or you deem your sacrifice necessary. You can SELF DESTRUCT as a quick action, initiating a reactor meltdown. At the end of your next turn, or at the end of one of your turns within the following two rounds (your choice), your mech explodes as though it suffered a reactor meltdown. The explosion annihilates your mech, killing anyone inside and causing a BURST 2 explosion that deals 4d6 explosive damage. Characters caught in the explosion that succeed on an AGILITY save take half of this damage."
		hotbar_right = true

class ExitMech extends BasicMechActions:
	func _init() -> void:
		name = "Exit Mech"
		owner = Enums.ActionOwner.MECH
		description = "Dismount or Eject from your mech. Be advised that mechs cannot operate autonomously unless they have an NHP or COMP/CON unit installed."
		action_group = "ExitMech"
		hotbar_right = true
		group_leader = true

class MechDismount extends BasicMechActions:
	func _init() -> void:
		name = "Dismount"
		action_cost = Enums.ActionType.FULL
		owner = Enums.ActionOwner.PILOT
		description = "Climb off of a mech. Dismounting is the preferred term among most pilots. You can DISMOUNT as a full action. When you DISMOUNT, you are placed in an adjacent space – if there are no free spaces, you cannot DISMOUNT. Additionally, you can also DISMOUNT willing allied mechs or vehicles you have MOUNTED."
		hotbar_right = true
		action_group = "ExitMech"

class Eject extends BasicMechActions:
	func _init() -> void:
		name = "Eject"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.PILOT
		description = "Perform an emergency ejection from your mech, flying 6 spaces in the direction of your choice; however, this is a single-use system for emergency use only – it leaves your mech IMPAIRED. Your mech remains IMPAIRED and you cannot EJECT again until your next FULL REPAIR."
		hotbar_right = true
		action_group = "ExitMech"

class ShutDown extends BasicMechActions:
	func _init() -> void:
		name = "Shut Down"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = "Turn your mech off completely. It’s always risky to do in the field, but it’s sometimes necessary to prevent a catastrophic systems overload or an NHP cascading."
		hotbar_right = true
		action_group = "SDBU"

class BootUp extends BasicMechActions:
	func _init() -> void:
		name = "Boot Up"
		action_cost = Enums.ActionType.FULL
		owner = Enums.ActionOwner.MECH
		description = "You can BOOT UP a mech that you are piloting as a full action, clearing SHUT DOWN and restoring your mech to a powered state."
		hotbar_right = true
		action_group = "SDBU"
