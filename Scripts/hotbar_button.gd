extends Button

const ICON_QA = preload("res://Assets/LANSIM Quick Action Icon.png")
const ICON_FA = preload("res://Assets/LANSIM Full Action Icon.png")

var IconSprite
var group_name:String
var action:Action

func setup(Act:Action) -> void:
	if Act.active:
		action = Act
		group_name = ""
		IconSprite = get_child(0)
		match Act.action_cost:
			Enums.ActionType.QUICK:
				IconSprite.texture = ICON_QA
			Enums.ActionType.FULL:
				IconSprite.texture = ICON_FA
			Enums.ActionType.FREE:
				pass
			_:
				pass
		if Act.abbreviation != "":
			text = Act.abbreviation
		else:
			text = Act.name
		if Act.exhausted:
			disabled = true
			IconSprite.modulate = Color(0xffffff80)
		tooltip_text = action.description

func _on_pressed() -> void:
	if Global.in_active_mech != -1:
		Global.hotbar_dropdown_toggled.emit("Not_Dropdown")
		Global.hotbar_button_pressed.emit(action)
