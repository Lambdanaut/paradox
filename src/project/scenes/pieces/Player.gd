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
	
	var could_move = .move(x_delta, y_delta, colliding_piece)

	if Globals.player == self:
		var trail_tile_instance = preload(
			"res://scenes/pieces/TrailTile.tscn").instance()
		trail_tile_instance.set_piece_pos(pos[0] - x_delta, pos[1] - y_delta, false)
		Globals.world.add_child(trail_tile_instance)
	elif not could_move:
		Globals.queue_lose()
	
	return could_move

func set_flip_h(new_flip_h: bool):
	$Sprite.flip_h = new_flip_h

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	if other_piece.piece_id == Globals.PLAYER_PIECE_ID:
		Globals.queue_lose()
	
		# Previously we could be pushed by the player
#	if other_piece == Globals.player:
#		var did_move: bool = move(move_x, move_y, other_piece)
#		return did_move
	
	return false

func clone(x: int, y: int):
	var instance = .clone(x, y)
	instance.get_node("Sprite").frame = 1

func animate_movement(new_global_x: float, new_global_y: float):
	return bounce_to_position_animation(new_global_x, new_global_y, ANIMATION_DURATION)
