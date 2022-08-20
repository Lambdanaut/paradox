extends "res://scenes/pieces/Piece.gd"

const ANIMATION_DURATION: float = 0.35


func _init():
	piece_id = Globals.PLAYER_PIECE_ID

func _ready():
	if not Globals.player:
		Globals.player = self

func move(x_delta: int, y_delta: int, colliding_piece=null) -> bool:
	if x_delta:
		set_flip_h(x_delta > 0)
	return .move(x_delta, y_delta, colliding_piece)

func set_flip_h(new_flip_h: bool):
	$Sprite.flip_h = new_flip_h

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	if other_piece == Globals.player:
		var did_move: bool = move(move_x, move_y, other_piece)
		return did_move
	
	return false

func clone(x: int, y: int):
	var instance = .clone(x, y)
	instance.get_node("Sprite").frame = 1

func animate_movement(new_global_x: float, new_global_y: float):
	is_currently_animating = true

	$Tween.interpolate_property(self, "global_position",
		global_position, Vector2(new_global_x, new_global_y), ANIMATION_DURATION,
		Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	$Tween.start()

	yield($Tween, "tween_completed")

	is_currently_animating = false

	emit_signal("completed_movement_animation")
