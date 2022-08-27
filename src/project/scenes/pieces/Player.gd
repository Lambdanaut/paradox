extends "res://scenes/pieces/Piece.gd"

const ANIMATION_DURATION: float = 0.35


func _init():
	piece_id = Globals.PLAYER_PIECE_ID
	process_order = 0

func _ready():
	if not Globals.player:
		Globals.player = self
	
	if Globals.player == self:
		Globals.connect("time_progressed", self, "_on_time_progressed")

func regress_time() -> bool:
	var could_move: bool = .regress_time()

	set_flip_h(-last_move[0] > 0)
	
	if Globals.player != self and recorded_movements.empty():
		destroy()
	
	return could_move

func move(x_delta: int, y_delta: int, colliding_piece=null, force: bool=false) -> bool:
	if x_delta:
		set_flip_h(x_delta > 0)
	
	var could_move = .move(x_delta, y_delta, colliding_piece, force)

	if Globals.player == self and could_move:
		var trail_tile_instance = preload(
			"res://scenes/pieces/TrailTile.tscn").instance()
		trail_tile_instance.set_piece_pos(pos[0] - x_delta, pos[1] - y_delta, false)
		Globals.world.add_child(trail_tile_instance)

	if Globals.player != self and not could_move:
		Globals.queue_lose()
	
	return could_move

func set_flip_h(new_flip_h: bool):
	$Sprite.flip_h = new_flip_h

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	if other_piece.piece_id == Globals.PLAYER_PIECE_ID:
		if other_piece != Globals.player:
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

func _on_time_progressed(new_epoch: int, last_epoch: int):
	if new_epoch == 0:
		clone(start_pos[0], start_pos[1])
		AudioManager.play("clone")
