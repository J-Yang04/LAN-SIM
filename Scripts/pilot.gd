class_name Pilot

var _base_hp:int = 6
var _base_speed:int = 4
var _name:String
var callsign:String
var background:String
var background_desc:String
var _hull:int = 0
var _agility:int = 0
var _systems:int = 0
var _engineering:int = 0
var ll:int
var triggers:Array
var talents:Array
var core_bonuses:Array

func _init(Name, Callsign, Background, Background_Desc, Hull=0, Agility=0, Systems=0, Engineering=0) -> void:
	_name = Name
	callsign = Callsign
	background = Background
	background_desc = Background_Desc
	_hull = Hull
	_agility = Agility
	_systems = Systems
	_engineering = Engineering

func set_name(Name:String) -> void:
	_name = Name

func get_name() -> String:
	return _name

## Assigns the HASE stats of the pilot from a passed Array, in order of: Hull, Agility, Systems, Engineering.
func assign_hase_array(HASE) -> void:
	_hull = HASE[0]
	_agility = HASE[1]
	_systems = HASE[2]
	_engineering = HASE[3]

## Returns an array of integers detailing the pilot's HASE attributes.
func get_hase_array() -> Array:
	var hase = []
	hase.append(_hull)
	hase.append(_agility)
	hase.append(_systems)
	hase.append(_engineering)
	return hase

func print_pilot_stats() -> void:
	print(get_name())
	print(callsign)
	print(background)
	print(background_desc)
	print(get_hase_array())
