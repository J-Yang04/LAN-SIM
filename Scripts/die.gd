class_name Die

var _size
var _number

func _init(Size:int, Number:int) -> void:
	_size = Size
	_number = Number

func roll() -> int:
	var result = 0
	for i in _number:
		result += randi_range(1, _size)
	return result
