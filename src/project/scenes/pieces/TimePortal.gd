extends "res://scenes/pieces/Piece.gd"

var consumable := true

func _init():
	piece_id = Globals.TIME_PORTAL_PIECE_ID
	process_order = -2

func _ready():
	pass

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	if other_piece.piece_id == Globals.PLAYER_PIECE_ID:
		other_piece.clone(
			other_piece.start_pos[0],
			other_piece.start_pos[1])
		Globals.set_epoch(0)
		AudioManager.play("clone")
		if consumable:
			destroy()
	return true
