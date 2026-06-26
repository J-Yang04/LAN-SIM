extends MarginContainer

const WEAPON_BOX = preload("res://weapon_pick_button.tscn")

## Calls when this mount is selected
signal weapon_box_select()

@onready var mount_box_label:= $MountBoxLabel as Label
@onready var weapon_box_container:= $WeaponPickMarginBox/WeaponBoxContainer as HBoxContainer

var linked_mount:Mount

func setup(mount:Mount) -> void:
	linked_mount = mount
	mount_box_label.text = mount.name.to_upper()
	for weapon in mount.get_mounted_weapons():
		var weapon_box = WEAPON_BOX.instantiate()
		weapon_box_container.add_child(weapon_box)
		weapon_box.setup(weapon)
		weapon_box.weapon_box_button_pressed.connect(_on_weapon_box_button_pressed)

func _on_weapon_box_button_pressed(Weapon:MechWeapon) -> void:
	weapon_box_select.emit(Weapon)
