extends Sprite2D

const HOTBAR_DROPDOWN = preload("res://hotbar_dropdown.tscn")
const HOTBAR_BUTTON = preload("res://HotbarButton.tscn")
const MOUNT_SELECT_BOX = preload("res://attack_mount_select_box.tscn")

var parent
var turn_counter_label:Label
var turn_status_label:Label
var hotbar_left:HBoxContainer
var hotbar_right:HBoxContainer
var start_turn_button:Button
var end_turn_button:Button
var mount_select_container:HBoxContainer

func _ready() -> void:
	parent = get_parent()
	turn_counter_label = get_child(1)
	turn_status_label = get_child(2)
	hotbar_left = get_child(3).get_child(0)
	hotbar_right = get_child(3).get_child(1)
	start_turn_button = get_child(4)
	end_turn_button = get_child(5)
	mount_select_container = get_child(6).get_child(1)
	Global.start_round.connect(_on_start_round)
	Global.select_mech.connect(_on_select_mech)
	Global.focus_mech.connect(_on_focus_mech)
	Global.start_turn.connect(_on_start_turn)
	Global.end_turn.connect(_on_end_turn)

func _on_start_round(Round_No:int) -> void:
	turn_counter_label.text = "ROUND " + str(Round_No)

func _on_select_mech() -> void:
	turn_status_label.text = "TURN START - SELECT MECH"
	start_turn_button.get_child(0).text = parent.player_mech_pawns[Global.focused_mech_index].get_mech_name() + "\n//ACTIVATE//"
	start_turn_button.visible = true
	start_turn_button.disabled = false

func _on_focus_mech(PID:int) -> void:
	start_turn_button.get_child(0).text = parent.player_mech_pawns[PID].get_mech_name() + "\n//ACTIVATE//"
	refresh_hotbar(parent.get_focused_mech().get_actions())

func _on_start_turn(PID:int) -> void:
	turn_status_label.text = "MECH ACTIVE: " + parent.player_mech_pawns[PID].get_mech_name()
	start_turn_button.visible = false
	start_turn_button.disabled = true
	end_turn_button.visible = true
	refresh_hotbar(parent.player_mech_pawns[PID].get_actions())

func _on_end_turn(_PID:int) -> void:
	end_turn_button.visible = false

func _on_start_turn_button_pressed() -> void:
	Global.in_active_mech = Global.focused_mech_index

## Displays all the active (or focused) mech's actions.
func refresh_hotbar(Actions:Array) -> void:
	for child in hotbar_left.get_children():
		child.queue_free()
	for child in hotbar_right.get_children():
		child.queue_free()
	await RenderingServer.frame_post_draw
	for action:Action in Actions:
		if action.group_leader:
			var new_dropdown = HOTBAR_DROPDOWN.instantiate()
			new_dropdown.setup(action)
			if action.hotbar_right:
				hotbar_right.add_child(new_dropdown)
			else:
				hotbar_left.add_child(new_dropdown)
		else:
			var new_button = HOTBAR_BUTTON.instantiate()
			new_button.setup(action)
			if action.hotbar_right and action.action_group != "":
				for button in hotbar_right.get_children():
					if button.group_name == action.action_group:
						button.add_child(new_button)
						button.move_child(new_button, 0)
						new_button.visible = false
						break
			elif action.action_group != "":
				for button in hotbar_left.get_children():
					if button.group_name == action.action_group:
						button.add_child(new_button)
						button.move_child(new_button, 0)
						new_button.visible = false
						break
			elif action.hotbar_right:
				hotbar_right.add_child(new_button)
			else:
				hotbar_left.add_child(new_button)

## Shows the weapon select interface and populates it with the given valid weapons.
func show_weapon_select(Mounts:Array[Mount]):
	for child in mount_select_container.get_children():
		child.queue_free()
	for mount in Mounts:
		var mount_box = MOUNT_SELECT_BOX.instantiate()
		mount_select_container.add_child(mount_box)
		mount_box.setup(mount)
	get_child(6).visible = true

func _on_end_turn_button_pressed() -> void:
	Global.end_turn.emit(parent.active_mech_index)
