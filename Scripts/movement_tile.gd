extends Area2D


var tile_grid:Vector2i

signal movement_tile_area_entered(Tile_Grid:Vector2i)

func _on_mouse_entered() -> void:
	movement_tile_area_entered.emit(tile_grid)
