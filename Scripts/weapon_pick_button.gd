extends ColorRect

var weapon_box_label:Label
var weapon_box_icon:TextureRect

func _ready() -> void:
	weapon_box_label = get_child(0)
	weapon_box_icon = get_child(1)

func setup(Weapon:MechWeapon) -> void:
	weapon_box_label.text = Weapon.name.to_upper()
