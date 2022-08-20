extends Node2D

# Object Ids (for convenience when map-making)
const o: int = Globals.TILE_PIECE_ID
const w: int = Globals.WALL_PIECE_ID
const P: int = Globals.PLAYER_PIECE_ID
const T: int = Globals.TIME_PORTAL_PIECE_ID
const B: int = Globals.BUTTON_PIECE_ID
const H: int = Globals.HOURGLASS_PIECE_ID

const object_mapping: Dictionary = {
	o: null,
	w: null,
	P: preload("res://scenes/pieces/Player.tscn"),
	T: preload("res://scenes/pieces/TimePortal.tscn"),
	B: null,
	H: null,
}

#var map: Array = [
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,P,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,T,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#	[o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o],
#]


var map: Array = [
	[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	[w,P,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,P,P,T,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
]

var bounds: Array = [0, 0]

func _ready():
	Globals.world = self

	bounds = _calculate_world_bounds(map)
	_load_map(map)

func _load_map(_map: Array):
	var x: int = 0
	var y: int = 0
	for row in _map:
		for column in row:
			_instantiate_tile_at(x, y)
			
			var piece_id: int = map[y][x] 
			var resource: Resource = object_mapping.get(piece_id, null)
			if resource:
				_instantiate_obj_at(resource, x, y)
			
			if piece_id == w: 
				# Piece is a wall. Place a wall on the tilemap
				_place_wall_at(x, y)

			x += 1

		y += 1
		x = 0

func _instantiate_obj_at(obj: Resource, x: int, y: int):
	var instance = obj.instance()
	instance.set_piece_pos(x, y, false)
	add_child(instance)

func _instantiate_tile_at(x: int, y: int):
	var instance = preload("res://scenes/pieces/Tile.tscn").instance()
	instance.set_piece_pos(x, y, false)
	add_child(instance)

func _place_wall_at(x: int, y: int):
	$TileMap.set_cell(x, y, 0)
	$TileMap.update_bitmask_area(Vector2(x, y))

func _calculate_world_bounds(_map: Array) -> Array:
	return [len(_map[0]) - 1, len(_map) - 1]

func has_tile_at(x: int, y: int):
	return $TileMap.get_cell(x, y) != TileMap.INVALID_CELL
