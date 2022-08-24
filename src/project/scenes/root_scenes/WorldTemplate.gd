extends Node2D

# Object Ids (for convenience when map-making)
var o: int = Globals.TILE_PIECE_ID
var D: int = Globals.DOOR_PIECE_ID
var w: int = Globals.WALL_PIECE_ID
var P: int = Globals.PLAYER_PIECE_ID
var T: int = Globals.TIME_PORTAL_PIECE_ID
var R: int = Globals.GATE_RED_PIECE_ID
var G: int = Globals.GATE_GREEN_PIECE_ID
var r: int = Globals.BUTTON_RED_PIECE_ID
var g: int = Globals.BUTTON_GREEN_PIECE_ID
var B: int = Globals.BOX_PIECE_ID
var C: int = Globals.TERMINAL_PIECE_ID
var H: int = Globals.HOURGLASS_PIECE_ID

var object_mapping: Dictionary = {
	o: null,
	w: null,
	D: preload("res://scenes/pieces/Door.tscn"),
	P: preload("res://scenes/pieces/Player.tscn"),
	T: preload("res://scenes/pieces/TimePortal.tscn"),
	R: preload("res://scenes/pieces/Gate.tscn"),
	G: preload("res://scenes/pieces/Gate.tscn"),
	r: preload("res://scenes/pieces/Button.tscn"),
	g: preload("res://scenes/pieces/Button.tscn"),
	B: preload("res://scenes/pieces/Box.tscn"),
	C: preload("res://scenes/pieces/Terminal.tscn"),
	H: null,
}

var map: Array = [
	[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
	[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
]
var restart_enabled: bool = true
var bgm_enabled: bool = true
var terminal_dialogue: Array = []

var bounds: Array = [0, 0]


func _init():
	Globals.world = self

func _ready():
	bounds = _calculate_world_bounds(map)
	_load_map(map)
	
	Globals.connect("time_direction_changed", self, "_on_time_direction_changed")

	if bgm_enabled and not AudioManager.music_stream_player.playing:
		AudioManager.play_bgm("planet-iii")

func _load_map(_map: Array):
	var x: int = 0
	var y: int = 0
	for row in _map:
		for column in row:
			_instantiate_tile_at(x, y)
			
			var piece_id: int = map[y][x] 
			var resource: Resource = object_mapping.get(piece_id, null)
			if resource:
				var instance = _instantiate_obj_at(resource, x, y)
				
				if piece_id == Globals.PLAYER_PIECE_ID and \
					map[y-1][x] == Globals.WALL_PIECE_ID and \
					y != 0:
					_instantiate_obj_at(preload("res://scenes/pieces/Door-Closed.tscn"), x, y)

				if piece_id == Globals.GATE_RED_PIECE_ID:
					instance.set_gate_type(Gate.GateType.RED)
				elif piece_id == Globals.GATE_GREEN_PIECE_ID:
					instance.set_gate_type(Gate.GateType.GREEN)

				if piece_id == Globals.BUTTON_RED_PIECE_ID:
					instance.set_button_type(PressButton.ButtonType.RED)
				elif piece_id == Globals.BUTTON_GREEN_PIECE_ID:
					instance.set_button_type(PressButton.ButtonType.GREEN)

				instance.piece_id = piece_id
			
			if piece_id == w: 
				# Piece is a wall. Place a wall on the tilemap
				_place_wall_at(x, y)
				
				# Place walls outside of the visible frame so the tilemap is clean
				if x == 0:
					_place_wall_at(x - 1, y)
				if y == 0:
					_place_wall_at(x, y - 1)
				if x == bounds[0]:
					_place_wall_at(x + 1, y)
				if y == bounds[1]:
					_place_wall_at(x, y + 1)

			x += 1

		y += 1
		x = 0
		
		# Place additional walls right outside of frame in the top bottom left and right so the tilemap is a clean square
		for corner_wall_pos in [ [-1, -1], [bounds[0] + 1, -1], [bounds[0] + 1, bounds[1] + 1], [-1, bounds[1] + 1] ]:
			_place_wall_at(corner_wall_pos[0], corner_wall_pos[1])

func _instantiate_obj_at(obj: Resource, x: int, y: int):
	var instance = obj.instance()
	instance.set_piece_pos(x, y, false)
	add_child(instance)
	
	return instance

func _instantiate_tile_at(x: int, y: int):
	var instance = preload("res://scenes/pieces/Tile.tscn").instance()
	instance.set_piece_pos(x, y, false)
	add_child(instance)

func _place_wall_at(x: int, y: int):
	$TileMap.set_cell(x, y, 0)
	$TileMap.update_bitmask_region(Vector2(x-1, y-1), Vector2(x+1, y+1))

func _calculate_world_bounds(_map: Array) -> Array:
	return [len(_map[0]) - 1, len(_map) - 1]

func _on_time_direction_changed(new_direction: bool):
	if new_direction:
		Globals.player.clone(
			Globals.player.start_pos[0],
			Globals.player.start_pos[1])
		AudioManager.play("clone")

func has_wall_at(x: int, y: int):
	return $TileMap.get_cell(x, y) != TileMap.INVALID_CELL
