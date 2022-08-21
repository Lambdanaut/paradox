extends "res://scenes/pieces/Piece.gd"

class_name Terminal

func _init():
	piece_id = Globals.TERMINAL_PIECE_ID

func run_dialogue():
	AudioManager.play("terminal")

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	if other_piece == Globals.player:
		run_dialogue()
	
	return true
