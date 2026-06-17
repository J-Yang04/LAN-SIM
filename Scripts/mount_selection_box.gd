extends VBoxContainer

var mount_select = preload("res://MountSelectBox.tscn")
var select_array:Array

signal prime_weapon_change(slot:int, mount:int)
signal weapon_cleared(slot:int, mount:int)

func create_mount_select(M:Mount, index:int):
	var new_select = mount_select.instantiate()
	var select_box = new_select.get_mount_select()
	add_child(new_select)
	new_select.weapon_cleared.connect(_on_weapon_cleared)
	new_select.prime_weapon_change.connect(_on_prime_weapon_change)
	new_select.self_index = index
	if M.is_full() == false:
		select_box.color = Color.CADET_BLUE
	else:
		select_box.color = Color.CRIMSON
	select_box.get_child(0).text = M.name.to_upper() + "\nMOUNT"
	new_select.create_weapon_selects(M)
	return new_select

func populate_mount_selects(Mounts:Array[Mount]) -> void:
	var count = 0
	for child in get_children():
		child.queue_free()
	for mount in Mounts:
		create_mount_select(mount, count)
		count += 1

func _on_weapon_cleared(Slot:int, Mountid:int) -> void:
	weapon_cleared.emit(Slot, Mountid)

func _on_prime_weapon_change(Slot:int, MountID:int) -> void:
	prime_weapon_change.emit(Slot, MountID)
