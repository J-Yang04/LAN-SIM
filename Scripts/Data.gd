extends Node

## Stores NPC data after reading it from JSON files.
var NPC_Classes:Dictionary
## Stores NPC template data.
var NPC_Templates:Dictionary
## Stores Player frame data after reading it from JSON files.
var Player_Frames:Dictionary
## Stores Player weapon data.
var Player_Weapons:Dictionary

func _init() -> void:
	parse_npc_classes()
	parse_npc_templates()
	parse_player_frames()
	parse_player_weapons()

## Parses NPC class JSON files and stores them.
func parse_npc_classes() -> void:
	var dir = DirAccess.open("res://Resources/NPC")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var new_npc = JSON.parse_string(FileAccess.get_file_as_string("res://Resources/NPC/"+file_name))
			NPC_Classes[new_npc[0]["id"]] = new_npc
			file_name = dir.get_next()

## Parses NPC template JSON files and stores them.
func parse_npc_templates() -> void:
	var dir = DirAccess.open("res://Resources/NPCTemplates")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var new_template = JSON.parse_string(FileAccess.get_file_as_string("res://Resources/NPCTemplates/"+file_name))
			NPC_Templates[new_template[0]["id"]] = new_template
			file_name = dir.get_next()

## Parses Player frame JSON files and stores them.
func parse_player_frames() -> void:
	var dir = DirAccess.open("res://Resources/Frames")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var new_frame = JSON.parse_string(FileAccess.get_file_as_string("res://Resources/Frames/"+file_name))
			Player_Frames[new_frame["id"]] = new_frame
			file_name = dir.get_next()

## Parses Played weapon JSON files and stores them.
func parse_player_weapons() -> void:
	var dir = DirAccess.open("res://Resources/Weapons")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			var new_weapons:Array = JSON.parse_string(FileAccess.get_file_as_string("res://Resources/Weapons/"+file_name))
			for weapon in new_weapons:
				Player_Weapons[weapon["id"]] = weapon
			file_name = dir.get_next()

func random_npc() -> Array:
	var npc_keys:Array = NPC_Classes.keys()
	return NPC_Classes[npc_keys.pick_random()]
