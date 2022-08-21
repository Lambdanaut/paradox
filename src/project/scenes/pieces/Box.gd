extends "res://scenes/pieces/Piece.gd"

const ANIMATION_DURATION: float = 0.35


func _init():
	piece_id = Globals.BOX_PIECE_ID

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	
	# Previously we could be pushed by the player
	if other_piece.piece_id == Globals.PLAYER_PIECE_ID or \
			other_piece.piece_id == Globals.BOX_PIECE_ID:
		var did_move: bool = move(move_x, move_y, other_piece)
		return did_move
	
	return false

func clone(x: int, y: int):
	var instance = .clone(x, y)
	instance.get_node("Sprite").frame = 1

func animate_movement(new_global_x: float, new_global_y: float):
	return bounce_to_position_animation(new_global_x, new_global_y, ANIMATION_DURATION)
