extends "res://scenes/pieces/Piece.gd"


func _init():
	piece_id = Globals.TILE_PIECE_ID
	should_register_piece_on_ready = false

func _ready():
	pass

func set_piece_pos(x: int, y: int, animate_piece: bool=false):
	# Color tiles
	if (x+y) % 2:
		$Polygon2D.color = Globals.COLOR_PURP
	else:
		$Polygon2D.color = Globals.COLOR_BLUE

	.set_piece_pos(x, y)
