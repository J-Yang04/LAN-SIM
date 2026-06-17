class_name PlayerSystemActions extends Action

class GrenadeGeneric extends PlayerSystemActions:
	func _init(Name:String, Description:String, ActionGroup:String = "", GroupLeader:bool = false) -> void:
		name = Name
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = Description
		if ActionGroup:
			action_group = ActionGroup
		group_leader = GroupLeader

class MineGeneric extends PlayerSystemActions:
	func _init(Name:String, Description:String, ActionGroup:String = "", GroupLeader:bool = false) -> void:
		name = Name
		action_cost = Enums.ActionType.QUICK
		owner = Enums.ActionOwner.MECH
		description = Description
		if ActionGroup:
			action_group = ActionGroup
		group_leader = GroupLeader
