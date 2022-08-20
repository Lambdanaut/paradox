extends Node

signal time_progressed(new_epoch)

const TILE_WIDTH: int = 16
const TILE_HEIGHT: int = 16

const COLOR_PURP = Color("#634065")
const COLOR_BLUE = Color("#89aacb")

const TILE_PIECE_ID: int = 0
const WALL_PIECE_ID: int = 1
const PLAYER_PIECE_ID: int = 2
const TIME_PORTAL_PIECE_ID: int = 3
const BUTTON_PIECE_ID: int = 4
const HOURGLASS_PIECE_ID: int = 5

var levels: Array = []
var level_index: int = 0

var world = null
var player = null
var epoch: int = 0
var time_progression_active := false

var pieces = []

func progress_time(x_input: int, y_input: int):
	time_progression_active = true
	
	var did_move = Globals.player.move(x_input, y_input)
	
	if did_move:
		if Globals.player.is_currently_animating:
			yield(Globals.player, "completed_movement_animation")
		
		for piece in pieces:
			if piece != player:
				piece.progress_time()
		
		epoch += 1
		emit_signal("time_progressed", epoch)

	time_progression_active = false

func add_piece(piece):
	pieces.append(piece)

func get_pieces_at(piece_x: int, piece_y: int) -> Array:
	var pieces_at: Array = []
	for piece in pieces:
		if piece.pos[0] == piece_x and piece.pos[1] == piece_y:
			pieces_at.append(piece)
	return pieces_at

func to_global_pos(val: int) -> float:
	return float(val) * TILE_WIDTH
