@abstract
class_name Action

## The name of this string. Shows up on tooltips, and on buttons if there is no abbreviation.
var name:String
## An abbreviated name for this action that shows up on buttons.
var abbreviation:String
var action_cost:Enums.ActionType
## The character, Mech or Pilot, whose actions this costs. Actions owned by a pilot are not necessarily only usable while on foot - Dismounting, for example.
var owner:Enums.ActionOwner
var description:String
## Actions that are not active will not display.
var active:bool = true
## For actions with a cooldown. Actions on cooldown stay in the hotbar but are disabled.
var on_cooldown:bool = false
## A boolean depicting which side of the hotbar this action appears on. Less common actions go on the right.
var hotbar_right:bool = false
## This action will be grouped with other actions of the same group.
var action_group:String = ""
## Whether this action is the leader of its group. Group leaders simply provide a cover and title to their group and don't do anything by themselves.
## Without a group leader, a group will stack its members on top of each other. This can be useful for mutually exclusive actions such as Shut Down and Boot Up.
var group_leader:bool = false

#These variables change during gameplay.
## The PID of the pawn that owns this action. When this action is taken, it is considered to have originated from this pawn.
var owner_pid:int
## Whether this action has already been taken as a quick action this turn, and therefore cannot be taken as a quick action again.
var exhausted:bool

func _init(Name:String, Cost:Enums.ActionType, Owner:Enums.ActionOwner, Description:String) -> void:
	name = Name
	action_cost = Cost
	owner = Owner
	description = Description

func set_owner(PID:int) -> void:
	owner_pid = PID

## Gets the PID of this action's owner.
func get_owner() -> int:
	return owner_pid
