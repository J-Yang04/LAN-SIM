extends HBoxContainer

var weapon_select = preload("res://WeaponSelectBox.tscn")
var self_index:int

signal prime_weapon_change(slot:int, mountid:int)
signal weapon_cleared(slot:int, mountid:int)

func get_mount_select():
	return get_child(0)

func _on_mount_select_button_pressed() -> void:
	pass # Replace with function body.

func create_weapon_selects(M:Mount):
	var equipped_weapons = M.get_mounted_weapons()
	for slot in M.slots:
		var new_select = weapon_select.instantiate()
		add_child(new_select)
		new_select.weapon_cleared.connect(_on_weapon_cleared)
		new_select.prime_weapon_change.connect(_on_prime_weapon_change)
		new_select.self_index = slot
		if equipped_weapons.size() > slot:
			var weapon = equipped_weapons[slot]
			new_select.color = Color.CRIMSON
			new_select.get_child(0).text = weapon.abbreviation
			if weapon.capacity > 1:
				new_select.custom_minimum_size = Vector2(204, 100)
		else:
			new_select.color = Color.CADET_BLUE
			if M.free_capacity == 0:
				new_select.visible = false

func _on_weapon_cleared(Slot:int) -> void:
	weapon_cleared.emit(Slot, self_index)

func _on_prime_weapon_change(Slot:int) -> void:
	prime_weapon_change.emit(Slot, self_index)
