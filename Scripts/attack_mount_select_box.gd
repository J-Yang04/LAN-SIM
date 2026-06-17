extends MarginContainer

const WEAPON_BOX = preload("res://weapon_pick_button.tscn")

var mount_box_label:Label
var weapon_box_container:HBoxContainer

func _ready() -> void:
	weapon_box_container = get_child(2).get_child(0)
	mount_box_label = get_child(1)

func setup(mount:Mount) -> void:
	mount_box_label.text = mount.name.to_upper()
	for weapon in mount.get_mounted_weapons():
		var weapon_box = WEAPON_BOX.instantiate()
		weapon_box_container.add_child(weapon_box)
		weapon_box.setup(weapon)
