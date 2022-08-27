extends "res://scenes/pieces/Piece.gd"

const ANIMATION_DURATION: float = 0.35


func _init():
	piece_id = Globals.BOX_PIECE_ID
	process_order = -3

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	# Don't let us move if we're in a gate
	var red_gates: Array = Globals.get_pieces_at(pos[0], pos[1], Globals.GATE_RED_PIECE_ID)
	var green_gates: Array = Globals.get_pieces_at(pos[0], pos[1], Globals.GATE_GREEN_PIECE_ID)
	var gates: Array = red_gates + green_gates
	if gates and gates.pop_front().engaged:
		return false

	# Let players push us
	if other_piece.piece_id == Globals.PLAYER_PIECE_ID or \
			other_piece.piece_id == Globals.BOX_PIECE_ID:
		var did_move: bool = move(move_x, move_y, other_piece)
		if did_move:
			involuntary_movements_this_epoch.append([move_x, move_y])
		return did_move
	
	return false

func animate_movement(new_global_x: float, new_global_y: float):
	return bounce_to_position_animation(new_global_x, new_global_y, ANIMATION_DURATION)
