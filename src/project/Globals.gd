extends Node

signal time_progressed(new_epoch)
signal time_direction_changed(new_direction)

const AUTHOR: String = "Lambdanaut"
const AUTHOR_URL: String = "https://lambdanaut.com"

const INITIAL_TIME: int = 9

const TILE_WIDTH: int = 16
const TILE_HEIGHT: int = 16

const COLOR_WHITE = Color("#fff7f7")
const COLOR_BLACK = Color("#000000")
const COLOR_YELLOW = Color("#f8ff00")
const COLOR_PURP = Color("#634065")
const COLOR_BLUE = Color("#89aacb")

const TILE_PIECE_ID: int = 0
const WALL_PIECE_ID: int = 1
const DOOR_PIECE_ID: int = 2
const DOOR_CLOSED_PIECE_ID: int = 3
const PLAYER_PIECE_ID: int = 4
const TIME_PORTAL_PIECE_ID: int = 5
const GATE_RED_PIECE_ID: int = 6
const GATE_GREEN_PIECE_ID: int = 7
const BUTTON_RED_PIECE_ID: int = 8
const BUTTON_GREEN_PIECE_ID: int = 9
const HOURGLASS_PIECE_ID: int = 10

var level_index: int = 0
var levels: Array = [
	"res://scenes/root_scenes/Level0.tscn",
	"res://scenes/root_scenes/Level1.tscn",
	"res://scenes/root_scenes/Level2.tscn",
	"res://scenes/root_scenes/Level3.tscn",
	"res://scenes/root_scenes/Level4.tscn",
	"res://scenes/root_scenes/Level5.tscn",
	"res://scenes/root_scenes/Level6.tscn",
	"res://scenes/root_scenes/Level7.tscn",
]

var world = null
var player = null
var epoch: int = INITIAL_TIME
var time_progression_active := false
var forward_increment_time := false
var engaged_red_button_count: int = 0
var engaged_green_button_count: int = 0
var win_queued := false
var lose_queued := false
var lost_last_scene := false
var pieces := []

func clear_registry():
	world = null
	player = null
	epoch = INITIAL_TIME
	time_progression_active = false
	forward_increment_time = false
	engaged_red_button_count = 0
	engaged_green_button_count = 0
	win_queued = false
	lose_queued = false
	lost_last_scene = false
	pieces.clear()

func progress_time(x_input: int, y_input: int):
	time_progression_active = true
	
	var player_did_move: bool = Globals.player.move(x_input, y_input)

	if player_did_move:
		AudioManager.play("epoch")

		if Globals.player and Globals.player.is_currently_animating:
			yield(Globals.player, "completed_movement_animation")
			
		if win_queued:
			return _next_level()
	
		for piece in pieces:
			if piece != player:
				var piece_did_move: bool = piece.progress_time()
				if lose_queued and piece_did_move:
					yield(piece, "completed_movement_animation")
	else:
		AudioManager.play("cant-move")
	
	if lose_queued:
		return _lose()
	
	if player_did_move:
		increment_epoch()

	time_progression_active = false

func increment_epoch():
	var increment: int = 1 if forward_increment_time else -1
	var new_epoch: int = epoch + increment

	if new_epoch == 0 and not forward_increment_time:
		reverse_time_direction()
		
	set_epoch(new_epoch)

func set_epoch(new_epoch: int):
	epoch = new_epoch

	emit_signal("time_progressed", epoch)

func reverse_time_direction():
	forward_increment_time = !forward_increment_time
	
	emit_signal("time_direction_changed", forward_increment_time)

func queue_win():
	win_queued = true

func queue_lose():
	lose_queued = true

func add_piece(piece):
	pieces.append(piece)

func remove_piece(piece):
	pieces.erase(piece)

func get_pieces_at(piece_x: int, piece_y: int, piece_id: int=-1) -> Array:
	var pieces_at: Array = []
	for piece in pieces:
		var type_condition := true if piece_id == -1 or piece.piece_id == piece_id else false
		if type_condition and piece.pos[0] == piece_x and piece.pos[1] == piece_y:
			pieces_at.append(piece)
	return pieces_at

func to_global_pos(val: int) -> float:
	return float(val) * TILE_WIDTH

func _lose():  # Call queue_lose() unless you know what you're doing
	AudioManager.play("lose")
	clear_registry()
	lost_last_scene = true
	get_tree().change_scene(levels[level_index])

func _next_level():  # Call queue_next_level() unless you know what you're doing
	AudioManager.play("win")
	level_index += 1
	clear_registry()
	get_tree().change_scene(levels[level_index])
