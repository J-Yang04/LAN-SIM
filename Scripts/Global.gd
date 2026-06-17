extends Node

signal start_combat(ActiveRoster:Array[PlayerMechSheet])
## Most things end at the end of combat. Many things also break.
signal end_combat

## The turn order loops as shown below - start_round, (select_mech, start_turn, end_turn) looped, end_round.
## When a new round is started, before any turns are taken.
signal start_round(Round_No:int)
## When a new player turn is started, before an active mech is chosen.
signal select_mech()
## When the focused mech changes.
signal focus_mech(PID:int)
## When a mech starts its turn and becomes the active mech.
signal start_turn(PID:int)
## When a mech ends its turn and stops being the active mech.
signal end_turn(PID:int)
## When a round ends, after all turns are taken.
signal end_round(Round_No:int)
## When a mech starts a move
signal start_move(PID:int)
## When a mech ends a move. Helps with Overwatch.
signal end_move(PID:int)

## When a player mech starts a new movement.
signal player_mech_start_move(PID:int)
## When a player mech steps into a tile.
signal player_mech_stepped(PID:int)

## When a weapon needs to be selected.
signal select_weapon
## When a hotbar dropdown is opened. For closing other dropdowns.
signal hotbar_dropdown_toggled(Group:String)
## When a hotbar button is pressed.
signal hotbar_button_pressed(action:Action)

## In all these cases, the pawn in question is the target.
signal pawn_attacked(PID:int)
signal pawn_hit(PID:int)
signal pawn_crit(PID:int)
signal pawn_missed(PID:int)
signal attack_missed(PID:int)
signal pawn_damaged(PID:int)
signal pawn_structured(PID:int)
signal pawn_killed(PID:int)
signal pawn_moved(PID:int)

var in_combat:bool = false
## When the player is choosing which mech to activate.
var in_select_active_mech:bool = false:
	set(value):
		in_select_active_mech = value
		if value == true:
			select_mech.emit()
## When a mech is active and taking its turn. The value indicates the PID of the active mech. If no active mech, -1.
var in_active_mech:int = -1:
	set(value):
		in_active_mech = value
		if value != -1:
			in_select_active_mech = false
			start_turn.emit(value)

## The PID of the focused mech. When this changes, emits focus_mech.
var focused_mech_index:int = 0:
	set(value):
		focused_mech_index = value
		focus_mech.emit(value)
