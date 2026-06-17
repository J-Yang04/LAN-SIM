extends Control
var weaponselectscene = preload("res://MechWeaponSelectBox.tscn")
var weaponpickscene = preload("res://WeaponPickList.tscn")
var mountselectionbox = preload("res://MountSelectionBox.tscn")
var mech_info_label:Label
var active_mechsheet
var mechframe:Frame
var strategy_runner
var weapon_selector
var mount_selection_box
var weapon_picker:ItemList
var active_pilot

var valid_weapons:Array[MechWeapon]
var weapon_change_primed:bool = false
var primed_slot:int
var primed_mount:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mech_info_label = get_node("MechInfoLabel")
	strategy_runner = get_parent().strategy_runner
	weapon_selector = weaponselectscene.instantiate()
	weapon_picker = weaponpickscene.instantiate()
	mount_selection_box = mountselectionbox.instantiate()
	add_child(weapon_selector)
	add_child(weapon_picker)
	add_child(mount_selection_box)
	mount_selection_box.weapon_cleared.connect(_on_weapon_cleared)
	mount_selection_box.prime_weapon_change.connect(_on_prime_weapon_change)
	weapon_picker.item_selected.connect(_on_weaponlist_selected)

func _on_weaponlist_selected(index: int) -> void:
	if weapon_change_primed:
		mechframe.try_mount_weapon(primed_mount, valid_weapons[index])
		mount_selection_box.populate_mount_selects(mechframe.get_mounts())
		weapon_change_primed = false

func _on_mechtest_button_pressed() -> void:
	active_mechsheet = PlayerMechSheet.new(strategy_runner.generate_random_mech())
	mechframe = active_mechsheet.equipped_frame
	active_pilot = strategy_runner.generate_random_pilot()
	active_pilot.print_pilot_stats()
	active_mechsheet.assign_pilot(active_pilot)
	var mountcount = mechframe.get_mounts().size()
	for i in mountcount:
		mechframe.try_mount_weapon(i, strategy_runner.generate_random_weapon())
		mechframe.try_mount_weapon(i, strategy_runner.generate_random_weapon())
	active_mechsheet.print_pretty_stats()
	mech_info_label.text = str("MECH NAME: ", mechframe.get_name(),"\n",
							"MECH PATTERN: ", mechframe.get_pattern(),"\n",
							"EQUIPPED WEAPONS: ", active_mechsheet.get_weapon_loadout(),"\n",
							"MECH PILOT: ", active_mechsheet.assigned_pilot.get_name()
							)
	
	mount_selection_box.populate_mount_selects(mechframe.get_mounts())
	
	weapon_picker.clear()
	for x in strategy_runner.weapon_selection:
		var box = Label.new()
		box.text = x.name + "\n" + x.description
		weapon_selector.get_child(0).add_child(box)
		var index = weapon_picker.add_item(x.name)
		weapon_picker.set_item_tooltip(index, x.description)

func _on_clearmounts_pressed() -> void:
	mechframe.clear_mounts()
	mount_selection_box.populate_mount_selects(mechframe.get_mounts())

func _on_weapon_cleared(Slot:int, MountID:int) -> void:
	mechframe.unmount_weapon(Slot, MountID)
	mount_selection_box.populate_mount_selects(mechframe.get_mounts())

func _on_prime_weapon_change(Slot:int, MountID:int) -> void:
	primed_slot = Slot
	primed_mount = MountID
	weapon_picker.clear()
	valid_weapons.clear()
	for weapon in strategy_runner.weapon_selection:
		if mechframe.get_mounts()[primed_mount].can_equip(weapon):
			valid_weapons.append(weapon)
			var index = weapon_picker.add_item(weapon.name)
			weapon_picker.set_item_tooltip(index, weapon.description)
	weapon_change_primed = true

func _on_play_button_pressed() -> void:
	visible = false
	strategy_runner.set_mechsheet_active(active_mechsheet)
	active_mechsheet = PlayerMechSheet.new(strategy_runner.generate_random_mech())
	active_pilot = strategy_runner.generate_random_pilot()
	active_mechsheet.assign_pilot(active_pilot)
	strategy_runner.set_mechsheet_active(active_mechsheet)
	Global.start_combat.emit(strategy_runner.active_mech_roster)
