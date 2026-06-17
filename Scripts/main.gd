extends CanvasLayer

var mainmenuscene = preload("res://MainMenu.tscn")
var combatuiscene = preload("res://CombatUI.tscn")
var battlecamerascene = preload("res://BattleCamera.tscn")
var strategyrunnerscript = preload("res://Scripts/strategy_runner.gd")
var combatrunnerscript = preload("res://Scripts/combat_runner.gd")
var main_menu
var strategy_runner
var combat_runner

# Lots of initialization of the game here.
func _ready() -> void:
	strategy_runner = strategyrunnerscript.new()
	main_menu = mainmenuscene.instantiate()
	combat_runner = combatuiscene.instantiate()
	add_child(main_menu)
	add_child(combat_runner)
