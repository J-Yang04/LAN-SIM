extends Node

## List of pilot first names, 6066
var pilot_fname_list:Array[String]
## List of pilot last names, 5548
var pilot_lname_list:Array[String]
## List of pilot callsigns, 676
var pilot_callsign_list:Array[String]
## List of mech names, 1338
var mech_name_list:Array[String]

var mech_storage:Array[PlayerMechSheet]
var active_mech_roster:Array[PlayerMechSheet]
var pilot_storage:Array[PlayerPilotSheet]
var active_pilot_roster:Array[PlayerPilotSheet]
## The special or limited weapons the player has.
var special_weapon_storage:Array[MechWeapon] = [RifleWeapons.OracleLMG.new()]

## All the weapons the player has access to at the beginning of the game.
var core_weapon_storage:Array[MechWeapon] = \
	[CannonWeapons.HMG.new(), CannonWeapons.Howitzer.new(), CannonWeapons.HurricaneClusterProjector.new(), CannonWeapons.Mortar.new(), CannonWeapons.ThermalLance.new(),
	CQBWeapons.Pistol.new(), CQBWeapons.Shotgun.new(), CQBWeapons.ThermalPistol.new(),
	LauncherWeapons.MissileRack.new(), LauncherWeapons.RPG.new(),
	MeleeWeapons.ChargedBlade.new(), MeleeWeapons.HeavyChargedBlade.new(), MeleeWeapons.HeavyMeleeWeapon.new(), MeleeWeapons.SegmentKnife.new(), MeleeWeapons.TacticalKnife.new(), MeleeWeapons.TacticalMeleeWeapon.new(), MeleeWeapons.TempestChargedBlade.new(), 
	NexusWeapons.DevastatorNexus.new(), NexusWeapons.HunterKillerNexus.new(), NexusWeapons.LightNexus.new(),
	RifleWeapons.AMR.new(), RifleWeapons.AssaultRifle.new(), RifleWeapons.CyclonePulseRifle.new(), RifleWeapons.ThermalRifle.new()]

## All the mechs the player has access to at the beginning of the game.
var core_mech_storage:Array[Frame] = \
	[Frame.Everest.new(), Frame.Chomolungma.new(), Frame.Sagarmatha.new()]

## All the weapons available for mounting onto a mech.
var weapon_selection:Array[MechWeapon]
## All the mechs available for selection
var mech_selection:Array[Frame]

func _init() -> void:
	refresh_weapon_selection()
	refresh_mech_selection()
	var name_file = FileAccess.open("res://Data/PilotFNames.txt", FileAccess.READ)
	for i in 6066:
		var namel = name_file.get_line()
		pilot_fname_list.append(namel)
	name_file.close()
	name_file = FileAccess.open("res://Data/PilotLNames.txt", FileAccess.READ)
	for i in 5548:
		var namel = name_file.get_line()
		pilot_lname_list.append(namel)
	name_file.close()
	name_file = FileAccess.open("res://Data/MechNames.txt", FileAccess.READ)
	for i in 1338:
		var namel = name_file.get_line()
		mech_name_list.append(namel)
	name_file.close()
	name_file = FileAccess.open("res://Data/PilotCallsigns.txt", FileAccess.READ)
	for i in 676:
		var namel = name_file.get_line()
		pilot_callsign_list.append(namel)
	name_file.close()

## Refreshes the available weapon selection with all weapons available to the player. 
func refresh_weapon_selection() -> void:
	weapon_selection.clear()
	weapon_selection.append_array(core_weapon_storage)
	weapon_selection.append_array(special_weapon_storage)

func refresh_mech_selection() -> void:
	mech_selection.clear()
	mech_selection.append_array(core_mech_storage)

## Returns a LL0 pilot with randomized HASE scores and name.
func generate_random_pilot() -> Pilot:
	var hase = [0,0,0,0]
	hase[randi_range(0,3)] += 1
	hase[randi_range(0,3)] += 1
	var newpilot = Pilot.new(pilot_fname_list[randi_range(0, 6065)] + " " + pilot_lname_list[randi_range(0, 5547)], pilot_callsign_list[randi_range(0, 675)], "Random Background", "Random Background Description")
	newpilot.assign_hase_array(hase)
	return newpilot

## Returns a mech from the available selection with a random name.
func generate_random_mech() -> Frame:
	var newmech = mech_selection[randi_range(0, mech_selection.size()-1)]
	newmech.set_name(mech_name_list[randi_range(0, 1337)])
	return newmech

## Returns a random weapon from the available selection.
func generate_random_weapon() -> MechWeapon:
	return weapon_selection[randi_range(0, weapon_selection.size()-1)]

func set_mechsheet_active(Sheet:PlayerMechSheet) -> void:
	active_mech_roster.append(Sheet)
	print(Sheet.get_mech_name())
