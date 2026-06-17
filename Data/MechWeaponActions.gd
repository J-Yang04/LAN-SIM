class_name MechWeaponActions extends Action

class RetrieveThrownWeapon extends MechWeaponActions:
	func _init() -> void:
		name = "Retrieve Thrown Weapon"
		action_cost = Enums.ActionType.FREE
		owner = Enums.ActionOwner.MECH
		description = "Retrieve a thrown Melee weapon."
		active = false
