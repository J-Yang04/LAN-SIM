class_name PilotGearActions extends Action

class ActivateStealthHardsuit extends PilotGearActions:
	func _init() -> void:
		name = "Activate Stealth Hardsuit"
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.PILOT
		description = "Become Invisible. You will cease to be Invisible if you take any damage."
