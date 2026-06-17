extends TileMapLayer

## Setup for creating a 'rectangular' hex grid
## The grid is horizontally aligned
## THE GRID MUST CONTAIN ROWS OF EQUAL SIZE I.E. gridheight * gridwidth must equal gridsize 
var astar:AStar2D = AStar2D.new()
var grid_height:int
var grid_length:int
## All the grid coordinates that should be traversable.
var used_cells:Array[Vector2i]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	used_cells = get_used_cells()
	InitAStar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

## Initializes the AStar grid based on the size of the tilemap.
func InitAStar() -> void:
	astar.clear()
	var size = self.get_used_rect().size
	grid_height = size.y
	grid_length = size.x
	astar.reserve_space(grid_length * grid_height)
	var count = 0
	for y in size.y:
		for x in size.x:
			if Vector2i(x,y) in used_cells:
				astar.add_point(count, map_to_local(Vector2i(x,y)))
				for cell in get_surrounding_cells(Vector2i(x,y)):
					if astar.has_point(convert_grid_to_index(cell)):
						astar.connect_points(count, convert_grid_to_index(cell))
			count += 1

## Returns an array of Vector2s detailing an Astar path.
func get_local_path(From:int, To:int, allow_partial_path:bool = false) -> Array[Vector2]:
	var local_path_array:Array[Vector2]
	astar.set_point_disabled(From, false)
	for step in astar.get_id_path(From, To, allow_partial_path):
		local_path_array.append(index_to_local(step))
	return local_path_array

## Returns an Astar path in grid coordinates.
func get_grid_path(From:int, To:int, allow_partial_path:bool = false) -> Array[Vector2i]:
	var local_path_array:Array[Vector2i]
	astar.set_point_disabled(From, false)
	for step in astar.get_id_path(From, To, allow_partial_path):
		local_path_array.append(convert_index_to_grid(step))
	return local_path_array

## Returns an array of all grid coordinates reachable from a given hex. Accepts an Astar index OR grid coordinate.
func get_reachable_tiles(From, Max_Range:int) -> Array[Vector2i]:
	var converted_from:Vector2i
	if typeof(From) == 2:
		converted_from = convert_index_to_grid(From)
	elif typeof(From) == 5:
		converted_from = local_to_map(From)
	else: converted_from = From
	var reachable:Array[Vector2i]
	var queue:Array = [converted_from]
	var cost_so_far:Dictionary = {converted_from:0}

	while queue.size() > 0:
		var current_tile:Vector2i = queue.pop_front()
		reachable.append(current_tile)
		for dir in get_surrounding_cells(current_tile):
			var next_tile = dir
			var new_cost = cost_so_far[current_tile] + 1
			if index_is_in_range(convert_grid_to_index(converted_from), convert_grid_to_index(next_tile), Max_Range) and next_tile in used_cells:
				if not cost_so_far.has(next_tile) or new_cost <= cost_so_far[next_tile]:
					cost_so_far[next_tile] = new_cost
					queue.append(next_tile)
	return reachable

func get_mouse_index() -> int:
	var tile_coords = local_to_map(get_global_mouse_position())
	if astar.has_point(convert_grid_to_index(tile_coords)):
		return convert_grid_to_index(tile_coords)
	else:
		return -1

## Check if the given Astar index is occupied.
func index_is_open(Index:int) -> bool:
	if astar.is_point_disabled(Index):
		return false
	else:
		return true

## Checks if a given index is reachable and within a certain (pathfinding) range from another.
func index_is_in_range(From:int, To:int, MaxRange:int) -> bool:
	var points = astar.get_id_path(From, To)
	if points.size() <= MaxRange + 1 and points.size() > 0:
		return true
	else:
		return false

## Converts a grid coordinate to an Astar index.
func convert_grid_to_index(Coords:Vector2i) -> int:
	var index = Coords.y * grid_length + Coords.x
	return index

## Converts an Astar index to a grid coordinate.
func convert_index_to_grid(Index:int) -> Vector2i:
	var coords = Vector2i(Index % grid_length, int(Index / grid_length))
	return coords

func index_to_local(Index:int) -> Vector2:
	return map_to_local(convert_index_to_grid(Index))

func grid_to_local(Grid:Vector2i) -> Vector2:
	return index_to_local(convert_grid_to_index(Grid))

func local_to_index(Local:Vector2) -> int:
	return convert_grid_to_index(local_to_map(Local))
