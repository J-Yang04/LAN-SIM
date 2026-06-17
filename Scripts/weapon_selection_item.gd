extends ColorRect

var pressed_once = false
var wslabel:Label
var wsbutton:Button
var self_index:int

signal prime_weapon_change(index:int)
signal weapon_cleared(index:int)

func _ready() -> void:
	wslabel = get_child(0)
	wsbutton = get_child(1)

func _on_weapon_select_button_pressed() -> void:
	pass # Replace with function body.
	if pressed_once == false:
		wslabel.text = "SEL. WEAPON\nCLICK AGAIN\nTO CLEAR"
		prime_weapon_change.emit(self_index)
		pressed_once = true
	else:
		weapon_cleared.emit(self_index)
		pressed_once = false
