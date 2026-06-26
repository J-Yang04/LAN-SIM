extends VBoxContainer

@onready var hp_container:= $HPContainer as FlowContainer
@onready var struct_container:= $StructContainer as HBoxContainer
@onready var heat_container:= $HeatContainer as FlowContainer
@onready var stress_container:= $StressContainer as HBoxContainer
@onready var parent:= get_parent() as PlayerMechPawn

func refresh_ui() -> void:
	for child:Object in hp_container.get_children():
		child.queue_free()
	for child:Object in struct_container.get_children():
		child.queue_free()
	for child:Object in heat_container.get_children():
		child.queue_free()
	for child:Object in stress_container.get_children():
		child.queue_free()
	for i in parent.hp:
		var hpsquare = ColorRect.new()
		hp_container.add_child(hpsquare)
		hpsquare.custom_minimum_size = Vector2(15, 10)
		hpsquare.set_color(Color(0.0, 0.0, i * 0.06))
	for i in parent.structure:
		var structsquare = ColorRect.new()
		struct_container.add_child(structsquare)
		structsquare.custom_minimum_size = Vector2(40, 15)
		structsquare.set_color(Color(0.0, 0.0, i * 0.2))
	for i in parent.heat:
		var heatsquare = ColorRect.new()
		heat_container.add_child(heatsquare)
		heatsquare.custom_minimum_size = Vector2(15, 10)
		heatsquare.set_color(Color(i * 0.06, 0.0, 0.0))
	for i in parent.stress:
		var stresssquare = ColorRect.new()
		stress_container.add_child(stresssquare)
		stresssquare.custom_minimum_size = Vector2(40, 15)
		stresssquare.set_color(Color(i * 0.2, 0.0, 0.0))
	
