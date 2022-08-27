extends Node2D

const Y_OFFSET: float = 2.0  # How many pixels to add to all board pieces

const SPLASH_SCREEN_FADE_DURATION: float = 3.0

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
	_initialize_map(map)
	
	Globals.connect("time_direction_changed", self, "_on_time_direction_changed")

	if bgm_enabled and Globals.bgm_enabled:
		Globals.play_bgm()
	elif AudioManager.music_stream_player.playing:
		AudioManager.stop_bgm()
		
	$TileMap.global_position.y += Y_OFFSET

	if Globals.game_just_started and not Globals.game_loaded and \
			(OS.has_feature("release") or Globals.LOAD_GAME_FILE_WHEN_IN_DEBUG_MODE):
		var load_game_result: bool = Globals._load_game()
		if load_game_result:
			# If we successfully loaded the game, then skip this 
			# initialization because we're about to swap out levels.
			return

	# Run tasks for if the game just started
	if Globals.game_just_started and \
			(OS.has_feature("release") or Globals.SHOW_SPLASH_SCREEN_WHEN_IN_DEBUG_MODE):

		Globals.game_just_started = false
		Controller.is_active = false
		
		$SplashScreen.visible=true
		$UI/PauseMenu.is_toggleable = false
		
		yield(get_tree().create_timer(1.5), "timeout")
		
		$Tween.interpolate_property($SplashScreen, "modulate",
			Color(1, 1, 1, 1), Color(1, 1, 1, 0), SPLASH_SCREEN_FADE_DURATION,
			Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
		$Tween.start()
		
		yield(get_tree().create_timer(SPLASH_SCREEN_FADE_DURATION * 0.5), "timeout")
		
		Controller.is_active = true

		yield($Tween, "tween_completed")

		$SplashScreen.queue_free()
		$UI/PauseMenu.is_toggleable = true
	
	# Update next level text
	if not Globals.lost_last_scene and Globals.level_index > 0:
		$UI/NextLevelText.visible = true
		$UI/NextLevelText.bbcode_text = "LEVEL " + str(Globals.level_index)
		yield(get_tree().create_timer(4.0), "timeout")
		$UI/NextLevelText.visible = false
	else:
		$UI/NextLevelText.visible = false

func _initialize_map(_map: Array):
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
