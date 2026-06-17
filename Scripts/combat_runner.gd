extends CanvasLayer

# Preload constants
const PLAYER_MECH_PAWN = preload("res://PlayerMechPawn.tscn")
const MOVEMENT_TILE = preload("res://movement_tile.tscn")

var combat_map:TileMapLayer
var combat_ui

var player_mechsheets:Array
## An array containing references to all the player mechs.
var player_mech_pawns:Array
## The index of the currently active friendly mech. If no mech is active, this defaults to -1. THIS IS THE MAIN REFERENCE OF ALL PLAYER MECH PAWNS
var active_mech_index:int = -1
## The index of the friendly mech currently being inspected. A mech should always be in focus. If there's an active mech, it should be the same as the focused mech.
var focused_mech_index:int = 0
## An array containing the PIDs of all the player mechs that have already taken their turns.
var player_expended_mechs:Array[int]
var enemy_mech_pawns:Array
## An array of every character in the combat. Does not include deployables or terrain.
var combat_roster:Array

## A grid of movement hints that show when previewing movement.
var movement_tile_grid

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	combat_map = get_node("CombatTileMap")
	combat_ui = get_node("LansimCombatOverlay")
	movement_tile_grid = get_node("MovementTileGrid")
	Global.start_combat.connect(_on_combat_start)
	Global.start_turn.connect(_on_start_turn)
	Global.end_turn.connect(_on_end_turn)
	Global.hotbar_button_pressed.connect(_on_hotbar_button_pressed)
	combat_map.get_child(0).input_event.connect(_on_map_clicked)
	combat_map.enabled = false
	add_to_group("Combat_Group")
	# Create a grid of movement tiles for displaying movement ranges.
	for tile in combat_map.get_used_cells():
		var movement_tile = MOVEMENT_TILE.instantiate()
		movement_tile.tile_grid = tile
		movement_tile.position = combat_map.map_to_local(tile)
		movement_tile.movement_tile_area_entered.connect(_on_movement_tile_hover)
		movement_tile_grid.add_child(movement_tile)

## This is the main method that starts a combat scene.
func _on_combat_start(ActiveRoster:Array[PlayerMechSheet]) -> void:
	Global.in_combat = true
	combat_map.enabled = true
	visible = true
	init_combat(ActiveRoster)
	place_player_mech_pawns([35, 36, 50])
	Global.in_select_active_mech = true
	Global.start_round.emit(1)
	cycle_focused_mech()

func _on_start_turn(PID:int) -> void:
	active_mech_index = PID

## Set the active mech to -1 and mark the current mech as expended.
func _on_end_turn(PID:int) -> void:
	active_mech_index = -1
	player_expended_mechs.append(PID)
	Global.in_active_mech = -1
	## ADD END TURN LOGIC HERE
	cycle_focused_mech()
	Global.in_select_active_mech = true

func _on_hotbar_button_pressed(action:Action) -> void:
	take_action(action)
	combat_ui.refresh_hotbar(get_active_mech().get_actions())

# Functions that perform actions should be named in the form take_action_name().
# They must include an optional bool that says if they're free actions, unless they're always free actions anyway.

## Figures out what action is being taken.
func take_action(action:Action):
	match action.name:
		"Skirmish":
			initiate_attack_action(action)
		"Barrage":
			initiate_attack_action(action)
		"Boost":
			take_boost(action)
		_:
			print("ERROR: Unidentified Action initiated.")

## Starts the process of making a normal attack.
func initiate_attack_action(action:Action):
	var filled_mounts = combat_roster[action.get_owner()].get_filled_mounts()
	combat_ui.show_weapon_select(filled_mounts)
	pass

## Starts the process of selecting a target within range. Takes a point of origin and a pattern.
func pick_target(Origin:int, Pattern:Array):
	pass

func take_boost(action:Action, Free:bool = false):
	var mech:PlayerMechPawn = combat_roster[action.get_owner()]
	mech.movement_remaining += mech.get_mech().speed
	display_movement_range(mech.movement_remaining, mech.get_pid())
	if Free == false:
		mech.quick_actions_taken += 1
		mech.last_action_taken = action.name

## A general function for making a whole attack.
func take_attack_action():
	pass

## Initialize combat with all required parameters.
func init_combat(ActiveMechs:Array[PlayerMechSheet]) -> void:
	init_player_mechsheets(ActiveMechs)
	init_player_mech_pawns(ActiveMechs)

## Initialize the player mechsheets to be used in this combat. DO NOT CALL DURING COMBAT
func init_player_mechsheets(Mechsheets:Array[PlayerMechSheet]) -> void:
	player_mechsheets.clear()
	player_mechsheets.append_array(Mechsheets)

## Initialize the player mech pawn scenes to be used in this combat. DO NOT CALL DURING COMBAT
func init_player_mech_pawns(Mechsheets:Array[PlayerMechSheet]) -> void:
	player_mech_pawns.clear()
	var pid = 0
	for sheet in Mechsheets:
		var mech_pawn = PLAYER_MECH_PAWN.instantiate()
		add_child(mech_pawn)
		mech_pawn.hydrate_pawn(sheet)
		player_mech_pawns.append(mech_pawn)
		combat_roster.append(mech_pawn)
		mech_pawn.set_pid(pid)
		pid += 1

## Places the player mechs in the given deployment zone on the map. The zone is given as an array of Astar indexes.
func place_player_mech_pawns(Deployment_Area:Array[int]) -> void:
	for pawn in player_mech_pawns:
		for index in Deployment_Area:
			if combat_map.index_is_open(index):
				pawn.position = combat_map.map_to_local(combat_map.convert_index_to_grid(index))
				pawn.move_target = pawn.position
				combat_map.astar.set_point_disabled(index)
				break

func _input(event: InputEvent) -> void:
	if Global.in_combat:
		if event.is_action_pressed("cycle_target") and active_mech_index == -1 and Global.in_select_active_mech == true:
			cycle_focused_mech()

func _on_map_clicked(_viewport:Viewport, event:InputEvent, _shape_idx: int) -> void:
	if Global.in_combat:
		if event.is_action_pressed("click_move"):
			if Global.in_select_active_mech == false:
				var click_index = combat_map.get_mouse_index()
				if combat_map.index_is_open(click_index) and get_active_mech().moving == false:
					step_active_mech(combat_map.get_local_path(combat_map.local_to_index(get_active_mech().position), click_index))
				else:
					get_active_mech().cancel_movement()

## Shows a movement path preview as the mouse moves.
func _on_movement_tile_hover(Tile_Grid:Vector2i) -> void:
	if visible:
		highlight_movement_path(Tile_Grid, Global.focused_mech_index)

## Finds the next INACTIVE mech and focuses it.
func cycle_focused_mech() -> void:
	if player_mech_pawns.size() > player_expended_mechs.size():
		var new_focus = get_next_mech(Global.focused_mech_index)
		while player_mech_pawns[new_focus].pid in player_expended_mechs:
			new_focus = get_next_mech(new_focus)
		Global.focused_mech_index = new_focus
		display_movement_range(get_focused_mech().movement_remaining, Global.focused_mech_index)
		

## Returns the next valid player mech PID. Once at the end of the list of player mechs, flips to zero.
func get_next_mech(PID:int) -> int:
	var next_id = PID
	next_id += 1
	if next_id >= player_mech_pawns.size():
		next_id = 0
	return next_id

## Returns the previous valid player mech PID. Once at the start of the list of player mechs, flips to the end.
func get_previous_mech(PID:int) -> int:
	var last_id = PID
	last_id -= 1
	if last_id < 0:
		last_id = player_mech_pawns.size() -1
	return last_id

## Returns the focused mech.
func get_focused_mech():
	return player_mech_pawns[Global.focused_mech_index]

## Returns the active mech.
func get_active_mech():
	return player_mech_pawns[active_mech_index]

## Move the active mech smoothly (glide it) from its current position to the given Astar index, in a straight line.
## This function should only be used to move 1 tile at a time. Or fly. Or go wild, I don't care.
func glide_active_mech(Destination:int) -> void:
	hide_movement_range()
	player_mech_pawns[active_mech_index].glide_to(combat_map.index_to_local(Destination))

## Move the active pawn along a set of tiles to its destination. Much more reasonable.
func step_active_mech(Directions:Array) -> void:
	hide_movement_range()
	player_mech_pawns[active_mech_index].step_to(Directions)

## Display the range for a given movement from a pawn, usually displays the mech's remaining movement.
func display_movement_range(Distance:int, PID:int) -> void:
	for tile in movement_tile_grid.get_children():
		tile.modulate = Color.WHITE
	var range_zone = combat_map.get_reachable_tiles(player_mech_pawns[PID].position, Distance)
	range_zone.remove_at(0) # Remove the origin tile.
	for movement_tile in movement_tile_grid.get_children():
		if movement_tile.tile_grid in range_zone:
			movement_tile.get_child(1).show()
		else:
			movement_tile.get_child(1).hide()

## Highlights a path in the displayed movement range grid, starting at a mech.
func highlight_movement_path(Tile_Grid:Vector2i, PID:int) -> void:
	var path = combat_map.get_grid_path(combat_map.local_to_index(player_mech_pawns[PID].position), combat_map.convert_grid_to_index(Tile_Grid))
	for tile in movement_tile_grid.get_children():
		tile.modulate = Color.WHITE
		for step in path:
			if tile.tile_grid == step:
				tile.modulate = Color.FIREBRICK

## Hides the range indication.
func hide_movement_range() -> void:
	for movement_tile in movement_tile_grid.get_children():
		movement_tile.get_child(1).hide()

## Creates a player object, probably a mech. Does not add it to the scene, only instantiates it.
func create_player():
	return PLAYER_MECH_PAWN.instantiate()
