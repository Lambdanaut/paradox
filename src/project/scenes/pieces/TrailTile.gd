extends "res://scenes/pieces/Piece.gd"

const TOTAL_LIFETIME_DURATION: float = 10.0

var duration_left: float = TOTAL_LIFETIME_DURATION


func _init():
	piece_id = Globals.TILE_PIECE_ID
	should_register_piece_on_ready = false

func _ready():
	Globals.connect("time_progressed", self, "_on_time_progressed")

func _on_time_progressed(new_epoch: int):
	
	if duration_left < 0:
		queue_free()
	
	$Polygon2D.color.a = duration_left / TOTAL_LIFETIME_DURATION
	
	duration_left -= 1
