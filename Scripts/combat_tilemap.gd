class_name CombatMap extends TileMapLayer

## Setup for creating a 'rectangular' hex grid
## The grid is horizontally aligned
var astar:AStar2D = AStar2D.new()
## An AStar grid that contains all tiles, even impassable ones.
var range_astar:= AStar2D.new() as AStar2D
var grid_height:int
var grid_length:int
## All the grid coordinates that should be traversable.
var used_cells:Array[Vector2i]

## The raycast used to get LoS.
var origin_ray:RayCast2D = RayCast2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(origin_ray)
	origin_ray.hit_from_inside = true
	update_passable_cells()
	init_astar()

## Each cell that isn't on tilesheet 0 is considered impassable
func update_passable_cells() -> void:
	used_cells = get_used_cells_by_id(0, Vector2i(-1,-1), -1)

## Initializes the AStar grid, using used_cells as a map for traversible tiles.
func init_astar() -> void:
	astar.clear()
	range_astar.clear()
	var size = self.get_used_rect().size
	grid_height = size.y
	grid_length = size.x
	astar.reserve_space(grid_length * grid_height)
	range_astar.reserve_space(grid_length * grid_height)
	var count = 0
	for y in size.y:
		for x in size.x:
			## Create a pathfinding AStar point
			if Vector2i(x,y) in used_cells:
				astar.add_point(count, map_to_local(Vector2i(x,y)))
				for cell in get_surrounding_cells(Vector2i(x,y)):
					if astar.has_point(convert_grid_to_index(cell)):
						astar.connect_points(count, convert_grid_to_index(cell))
			## Create a range AStar point.
			range_astar.add_point(count, map_to_local(Vector2i(x,y)))
			for cell in get_surrounding_cells(Vector2i(x,y)):
				if range_astar.has_point(convert_grid_to_index(cell)):
					range_astar.connect_points(count, convert_grid_to_index(cell))
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

## Returns an array of all grid coordinates able to be walked to from a given hex. Accepts an Astar index OR grid coordinate.
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
			if index_is_in_movement_range(convert_grid_to_index(converted_from), convert_grid_to_index(next_tile), Max_Range) and next_tile in used_cells:
				if not cost_so_far.has(next_tile) or new_cost <= cost_so_far[next_tile]:
					cost_so_far[next_tile] = new_cost
					queue.append(next_tile)
	return reachable

## Returns an array of all grid coordinates within a range of given hex. Accepts an Astar index OR grid coordinate. Does not check Line of Sight.
## VERY INTENSIVE
func get_tiles_in_range(From, Max_Range:int) -> Array[Vector2i]:
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

## Simply draws a hexagon around the max range. MUCH LIGHTER 
func get_tiles_in_range2(From, Max_Range:int) -> Array:
	var range_outline:Array[Vector2i]
	var converted_from:Vector2i
	if typeof(From) == 2:
		converted_from = convert_index_to_grid(From)
	elif typeof(From) == 5:
		converted_from = local_to_map(From)
	else: converted_from = From
	var current_tile = Vector2i(converted_from.x-Max_Range, converted_from.y)
	for i in Max_Range:
		range_outline.append(current_tile)
		current_tile = get_neighbor_cell(current_tile, TileSet.CELL_NEIGHBOR_TOP_RIGHT_SIDE)
	for i in Max_Range:
		range_outline.append(current_tile)
		current_tile = get_neighbor_cell(current_tile, TileSet.CELL_NEIGHBOR_RIGHT_SIDE)
	for i in Max_Range:
		range_outline.append(current_tile)
		current_tile = get_neighbor_cell(current_tile, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE)
	for i in Max_Range:
		range_outline.append(current_tile)
		current_tile = get_neighbor_cell(current_tile, TileSet.CELL_NEIGHBOR_BOTTOM_LEFT_SIDE)
	for i in Max_Range:
		range_outline.append(current_tile)
		current_tile = get_neighbor_cell(current_tile, TileSet.CELL_NEIGHBOR_LEFT_SIDE)
	for i in Max_Range:
		range_outline.append(current_tile)
		current_tile = get_neighbor_cell(current_tile, TileSet.CELL_NEIGHBOR_TOP_LEFT_SIDE)
	return range_outline

## NOT FULLY IMPLEMENTED
func shadowcast_cover(Origin:Vector2i, Dist:int, Height:int, Arcing:bool = false, Seeking:bool =false):
	var valid_cells:Array[Vector2i]
	while true:
		var start_cell = get_neighbor_cell(Origin, TileSet.CELL_NEIGHBOR_TOP_RIGHT_SIDE)
		var current_cell = start_cell
		var following_wall = false
		while true:
			if get_cell_source_id(current_cell) < Height:
				valid_cells.append(current_cell)
				current_cell = get_neighbor_cell(current_cell, TileSet.CELL_NEIGHBOR_BOTTOM_RIGHT_SIDE)
			else:
				following_wall = true
				break

## Raycast from center, going around in a circle, and find the edge point of the first collided object.
## Make a 2-way raycast from that, one getting each tile out to range, one looking back at the origin.
## This recursive scan stops once it loses sight of the origin.
## If it sees another corner further out, recurse.
## The original scan keeps going until it finds the other side of the cover,
## OR if it finds another (closer) piece of cover.
## If it finds closer cover, recurse and keep scanning from there.
## If it finds the end of a piece of cover, make a 2-way raycast but in the other direction.
## Loop until 360 degrees have been scanned.
## Record every tile touched by the scan, these are tiles within LOS.

## FUCK IT, SEVEN RAYCASTS
func get_los(Origin:Vector2i, Target:Vector2i) -> bool:
	var blocked_lines = 0
	origin_ray.position = Vector2(map_to_local(Origin))
	origin_ray.target_position = Vector2(map_to_local(Target) - map_to_local(Origin))
	origin_ray.force_raycast_update()
	if origin_ray.is_colliding():
		print("Center Blocked")
		print(origin_ray.get_collision_point())
		blocked_lines += 1
	origin_ray.position = Vector2(map_to_local(Origin) + Vector2(0, -70))
	origin_ray.force_raycast_update()
	if origin_ray.is_colliding():
		print("Top Blocked")
		print(origin_ray.get_collision_point())
		blocked_lines += 1
	origin_ray.position = Vector2(map_to_local(Origin) + Vector2(60, -34.64))
	origin_ray.force_raycast_update()
	if origin_ray.is_colliding():
		print("TR Blocked")
		print(origin_ray.get_collision_point())
		blocked_lines += 1
	origin_ray.position = Vector2(map_to_local(Origin) + Vector2(60, 34.64))
	origin_ray.force_raycast_update()
	if origin_ray.is_colliding():
		print("BR Blocked")
		print(origin_ray.get_collision_point())
		blocked_lines += 1
	origin_ray.position = Vector2(map_to_local(Origin) + Vector2(0, 70))
	origin_ray.force_raycast_update()
	if origin_ray.is_colliding():
		print("Bottom Blocked")
		print(origin_ray.get_collision_point())
		blocked_lines += 1
	origin_ray.position = Vector2(map_to_local(Origin) + Vector2(-60, 34.64))
	origin_ray.force_raycast_update()
	if origin_ray.is_colliding():
		print("BL Blocked")
		print(origin_ray.get_collision_point())
		blocked_lines += 1
	origin_ray.position = Vector2(map_to_local(Origin) + Vector2(-60, -34.64))
	origin_ray.force_raycast_update()
	if origin_ray.is_colliding():
		print("TL Blocked")
		print(origin_ray.get_collision_point())
		blocked_lines += 1
	print(blocked_lines)
	if blocked_lines == 7:
		return false
	else:
		return true

## Returns the cover height of a cell.
func check_cell_cover(Cell:Vector2i) -> int:
	return get_cell_source_id(Cell)

func get_mouse_index() -> int:
	var tile_coords = local_to_map(get_global_mouse_position())
	if astar.has_point(convert_grid_to_index(tile_coords)):
		return convert_grid_to_index(tile_coords)
	else:
		return -1

func get_mouse_grid() -> Vector2i:
	var tile_coords = local_to_map(get_global_mouse_position())
	return tile_coords

## Check if the given Astar index is occupied.
func index_is_open(Index:int) -> bool:
	if astar.is_point_disabled(Index):
		return false
	else:
		return true

## Checks if a given index is reachable and within a certain (pathfinding) range from another.
func index_is_in_movement_range(From:int, To:int, MaxRange:int) -> bool:
	var points = astar.get_id_path(From, To)
	if points.size() <= MaxRange + 1 and points.size() > 0:
		return true
	else:
		return false

## Checks if a given range index is within a certain range from another.
func index_is_in_range(From:int, To:int, MaxRange:int) -> bool:
	var points = range_astar.get_id_path(From, To)
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
