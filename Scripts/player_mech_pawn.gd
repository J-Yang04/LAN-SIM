class_name PlayerMechPawn extends PlayerMechSheet

signal pawn_moved

## A pawn can be highlighted and in-focus. XCOM style. Typically this happens before the player has picked a mech to take their turn.
@onready var is_focus:bool = false:
	set(value):
		is_focus = value
		if value:
			combat_map.astar.set_point_disabled(combat_map.local_to_index(position), false)
		else:
			combat_map.astar.set_point_disabled(combat_map.local_to_index(position))
## A pawn is active if it is taking the current turn. Ony kicks in once a mech has taken any sort of action.
@onready var is_active:bool = false:
	set(value):
		is_active = value
		if value:
			combat_map.astar.set_point_disabled(combat_map.local_to_index(position), false)
		else:
			combat_map.astar.set_point_disabled(combat_map.local_to_index(position))
var destroyed = false
var movement_remaining

## Only moves if this is true, and should flip off when close enough to its destination.
var moving:bool = false
## The target to move to. Each time this variable is assigned, it automatically disables the corresponding space in the grid.
@onready var move_target:Vector2:
	set(value):
		#combat_map.astar.set_point_disabled(combat_map.local_to_index(move_target), false)
		#combat_map.astar.set_point_disabled(combat_map.local_to_index(value))
		move_target = value

## An array containing the queued movement steps.
var directions:Array
var glidespeed = 8
## Indicates this pawn's PID in the combat runner. Should not change once initialized.
var pid:int
## This pawn's on-screen UI.
var pawn_ui
## This pawn's name label.

## The number of quick actions this mech has taken. Full actions are simply 2 quick actions.
var quick_actions_taken:int = 0:
	set(value):
		quick_actions_taken += value
## The last action this mech took.
var last_action_taken:String:
	set(value):
		last_action_taken = value
		for action in actions:
			if action.name == value:
				action.exhausted = true

## Children of the node
var name_label
var combat_runner
var combat_map

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pawn_ui = get_node("FloatingMechUI")
	name_label = get_node("NameLabel")
	combat_runner = get_parent()
	combat_map = combat_runner.get_child(1)
	add_to_group("Combat_Group")
	Global.focus_mech.connect(_on_focus_mech)
	Global.end_turn.connect(_on_end_turn)
	combat_map.astar.set_point_disabled(combat_map.local_to_index(position))

## The pawn moves with physics.
func _physics_process(_delta: float) -> void:
	if moving:
		var velocity = position.direction_to(move_target) * glidespeed
		if position.distance_to(move_target) > 10:
			translate(velocity * (position.distance_to(move_target) / 100))
		elif position.distance_to(move_target) > 3: 
			translate(velocity / 2)
		elif directions.size() > 0 and movement_remaining > 0:
			move_target = directions.pop_front()
			movement_remaining -= 1
		else:
			combat_runner.display_movement_range(movement_remaining, pid)
			moving = false

## Takes a mechsheet and hydrates itself with the data from it.
func hydrate_pawn(Mechsheet:PlayerMechSheet) -> void:
	equipped_frame = Mechsheet.get_mech()
	assigned_pilot = Mechsheet.get_pilot()
	hp = Mechsheet.get_hp()
	heat = Mechsheet.heat
	structure = Mechsheet.structure
	stress = Mechsheet.stress
	repairs = Mechsheet.repairs
	movement_remaining = equipped_frame.speed
	name_label.text = get_mech_name()
	pawn_ui.refresh_ui()

## Sets this mech's PID and hands it around to whatever needs it. should only be called once per combat.
func set_pid(PID:int) -> void:
	pid = PID
	for action in actions:
		action.set_owner(pid)

func get_pid() -> int:
	return pid

## Gives the pawn a new location to glide to. Cancels any step movement.
func glide_to(Coords:Vector2) -> void:
	directions.clear()
	move_target = Coords
	moving = true
	get_tree().call_group("Combat_Group", "unit_moved")

## Give this pawn a set of movement steps along tiles, using local coordinates. Overrides current movement.
func step_to(Directions:Array) -> void:
	if Directions.size() > 0:
		move_target = Directions.pop_front()
		directions = Directions
		moving = true

## Add a set of movement directions to the end of the movement queue.
func queue_step(Directions:Array) -> void:
	if Directions.size() > 0:
		directions.append(Directions)
		moving = true

func cancel_movement() -> void:
	directions.clear()

func take_damage(Dmg:int) -> void:
	hp -= Dmg
	if hp < 1:
		Global.pawn_structured.emit()
		take_structure(1)
	pawn_ui.refresh_ui()

func take_structure(Dmg:int) -> void:
	pass

## Returns all the mounts on this mech with a weapon installed.
func get_filled_mounts() -> Array[Mount]:
	var valid_mounts:Array[Mount]
	for mount in equipped_frame.get_mounts():
		if mount.get_mounted_weapons().is_empty() == false:
			valid_mounts.append(mount)
	return valid_mounts

## Given a tile, checks if this mech can make an Overwatch reaction. If so, it returns its PID and the weapon(s) that can make the Overwatch, in the form of [mount, weapon position].
func check_overwatch() -> Array:
	var valid_weapons:Array
	for mount in equipped_frame.get_mounts():
		var count = 0
		for weapon in mount.get_mounted_weapons():
			if weapon.active == true and weapon.is_ordnance() == false:
				valid_weapons.append([mount, count])
				break
	if valid_weapons.size() > 0:
		valid_weapons.push_front(pid)
	return valid_weapons

func _on_focus_mech(PID:int) -> void:
	if pid == PID:
		is_focus = true
		get_child(0).modulate = Color.FOREST_GREEN
	else:
		is_focus = false
		get_child(0).modulate = Color(1,1,1)

func _on_end_turn() -> void:
	for action in actions:
		action.exhausted = false
