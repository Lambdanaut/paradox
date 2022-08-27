extends "res://scenes/pieces/Piece.gd"

const TOTAL_LIFETIME_DURATION: float = 10.0

var duration_left: float = TOTAL_LIFETIME_DURATION


func _init():
	piece_id = Globals.TILE_PIECE_ID
	should_register_piece_on_ready = false

func _ready():
	Globals.connect("time_progressed", self, "_on_time_progressed")
	
	_update_alpha()

func _update_alpha():
	$Polygon2D.color.a = max(0.0, duration_left / TOTAL_LIFETIME_DURATION)

func _on_time_progressed(new_epoch: int, last_epoch: int):
	if new_epoch > last_epoch:
		duration_left -= 1.0
	elif new_epoch < last_epoch:
		duration_left += 1.0
	
	if duration_left > TOTAL_LIFETIME_DURATION:
		return queue_free()

	_update_alpha()
