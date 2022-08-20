extends "res://scenes/pieces/Piece.gd"

func _init():
	piece_id = Globals.DOOR_PIECE_ID

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	if other_piece.piece_id == Globals.PLAYER_PIECE_ID:
		Globals.queue_win()
	return true
