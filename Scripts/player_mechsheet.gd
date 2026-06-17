class_name PlayerMechSheet extends Node2D

var equipped_frame:Frame
var assigned_pilot:Pilot
var hp
var heat = 0
var structure
var stress
var repairs
var special_mounts:Array[Mount]
## All the actions that this mech has access to. Starts with basic actions then is populated further.
var actions:Array[Action] = \
	[BasicMechActions.Attacks.new(), BasicMechActions.Barrage.new(), BasicMechActions.Skirmish.new(),
	BasicMechActions.Boost.new(), BasicMechActions.Stabilize.new(),
	BasicMechActions.GIR.new(),BasicMechActions.Grapple.new(), BasicMechActions.ImprovisedAttack.new(), BasicMechActions.Ram.new(),
	BasicMechActions.TechAction.new(), BasicMechActions.Bolster.new(), BasicMechActions.LockOn.new(), BasicMechActions.Invade.new(),
	BasicMechActions.Overcharge.new(), BasicMechActions.SelfDestruct.new(),
	BasicMechActions.ExitMech.new(), BasicMechActions.MechDismount.new(), BasicMechActions.Eject.new(),
	BasicMechActions.ShutDown.new(), BasicMechActions.BootUp.new()]

func _init(frame:Frame = null) -> void:
	if frame != null:
		equipped_frame = frame
		hp = equipped_frame.health_max
		structure = equipped_frame.structure_max
		stress = equipped_frame.stress_max
		repairs = equipped_frame.repair_max

func assign_pilot(pilot:Pilot) -> void:
	assigned_pilot = pilot

func get_mech() -> Frame:
	return equipped_frame

func get_pilot() -> Pilot:
	return assigned_pilot

func get_hp() -> int:
	return hp

## Returns the attached frame's name.
func get_mech_name() -> String:
	return equipped_frame.get_name()

## Returns the assigned pilot's name. returns NO PILOT if there is no assigned pilot.
func get_pilot_name() -> String:
	if assigned_pilot != null:
		return assigned_pilot.get_name()
	else:
		return "NO PILOT"

## Returns an array of the names of the mounts on the equipped frame.
func get_mount_names() -> Array[String]:
	var mounts_list:Array[String]
	for mount in equipped_frame.get_mounts():
		mounts_list.append(mount.name)
	return mounts_list

func get_mounted_weapon_names() -> Array[String]:
	var weapons_list:Array[String]
	for mount in equipped_frame.get_mounts():
		var weapon_name = mount.get_mounted_weapon_names()
		weapons_list.append_array(weapon_name)
	return weapons_list

## Returns a 2D array containing sets of tuples, in a [Mount,[Weapons]] format.
func get_weapon_loadout() -> Array:
	var loadout:Array
	for mount in equipped_frame.get_mounts():
		loadout.append([mount.name, [mount.get_mounted_weapon_names()]])
	return loadout

func get_actions() -> Array:
	return actions

func print_pretty_stats() -> void:
	print("CALLSIGN: " + assigned_pilot.callsign.to_upper() + " IN MECH: " + equipped_frame.get_name().to_upper())
	print("---------------------------------------------------")
	print("MECH PATTERN: " + equipped_frame.get_pattern())
	print("HP: " + str(hp) + "  HEAT: " + str(heat))
	var weapons_list = get_mounted_weapon_names()
	print("Weapons: " + str(weapons_list))
