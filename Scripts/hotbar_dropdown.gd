extends VBoxContainer

var toggle_button
var group_name:String

func setup(Act:Action) -> void:
	Global.hotbar_dropdown_toggled.connect(_on_hotbar_signal)
	group_name = Act.action_group
	toggle_button = get_child(0)
	#match Act.action_cost:
		#Enums.ActionType.QUICK:
			#IconSprite.texture = ICON_QA
		#Enums.ActionType.FULL:
			#IconSprite.texture = ICON_FA
	if Act.abbreviation != "":
		toggle_button.text = Act.abbreviation
	else:
		toggle_button.text = Act.name


func _on_hotbar_dropdown_button_toggled(toggled_on: bool) -> void:
	var length = get_child_count() - 1
	if toggled_on:
		Global.hotbar_dropdown_toggled.emit(group_name)
		for child in get_children():
			if child.get_index() < length:
				child.visible = true
	else:
		for child in get_children():
			if child.get_index() < length:
				child.visible = false

func _on_hotbar_signal(Group:String) -> void:
	if Group != group_name:
		toggle_button.button_pressed = false
