extends ColorRect

signal weapon_box_button_pressed(Weapon:MechWeapon)

@onready var weapon_box_label:= $WeaponBoxLabel as Label
@onready var weapon_box_icon:= $WeaponIcon as TextureRect

var linked_weapon:MechWeapon

func setup(Weapon:MechWeapon) -> void:
	linked_weapon = Weapon
	weapon_box_label.text = Weapon.name.to_upper()

func _on_weapon_box_button_pressed() -> void:
	weapon_box_button_pressed.emit(linked_weapon)
