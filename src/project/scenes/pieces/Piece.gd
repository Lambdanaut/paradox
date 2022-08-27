extends Node2D

signal completed_movement_animation

class_name Piece

var should_register_piece_on_ready: bool = true

var pos: Array = [0, 0]
var start_pos = null  # Array of [0, 0]
var piece_id: int = -1

var is_currently_animating: bool = false

var last_move: Array = [0, 0]
var recorded_movements: Array = []  # An array of [[ [0, 1], [-1,0] ], [[0, 1], [-1,0] ], ] because a piece can move more than once a turn(like a box)
var playback_movements: Array = []
var playback_movements_popped: Array = []
var involuntary_movements_this_epoch: Array = []  # An array of [[ [0, 1], [-1,0] ], [[0, 1], [-1,0] ], ] of moves that have made without our volition this turn(like being pushed as a box)
var child_clones: Array = []
var clone_parent = null

var _z_index_cached: int = z_index


func _ready():	
	if should_register_piece_on_ready:
		Globals.add_piece(self)

func progress_time(x_delta=null, y_delta=null) -> bool:
	var could_move: bool = false
	var next_moves: Array = [[0,0]]
	if playback_movements:
		next_moves = playback_movements[0]
		could_move = true
		for move in next_moves:
			could_move = could_move and move(move[0], move[1])
		if could_move:
			playback_movements.pop_front()
			playback_movements_popped.append(next_moves)
	elif x_delta != null or y_delta != null:
		next_moves = [[x_delta, y_delta]]
		could_move = move(x_delta, y_delta)

	recorded_movements.append(next_moves)
	for child in child_clones:
		child.playback_movements.append(next_moves)

	return could_move

func regress_time() -> bool:
	var could_move: bool = false
	if playback_movements_popped:
		playback_movements.insert(0, playback_movements_popped.pop_back())
		playback_movements.remove(abs(Globals.INITIAL_EPOCH))
	if recorded_movements:
		# Loop through all the recorded movements made in the last turn(*usually* just a single movement per turn)
		for recorded_move in recorded_movements.pop_back():
			could_move = move(recorded_move[0] * -1, recorded_move[1] * -1, null, true) and could_move
		
	return could_move

# function to be called when the turn ends after all pieces have moved.
func end_epoch():
	if recorded_movements:
		for movement in involuntary_movements_this_epoch:
			recorded_movements[-1].append(movement)
	involuntary_movements_this_epoch = []

func move(x_delta: int, y_delta: int, colliding_piece=null, force: bool=false) -> bool:
	last_move = [x_delta, y_delta]
	
	var new_x: int = pos[0] + x_delta
	var new_y: int = pos[1] + y_delta

	var could_move: bool = move_to(new_x, new_y, colliding_piece, force)
	
	return could_move

func move_to(new_x: int, new_y: int, _colliding_piece=null, force: bool=false) -> bool:
	if new_x < 0 or new_x > Globals.world.bounds[0] or new_y < 0 or new_y > Globals.world.bounds[1]:
		return false

	var pieces_at_new_pos: Array = Globals.get_pieces_at(new_x, new_y)

	# Call on_collided_with() for every piece we'll be colliding with
	var can_move_piece: bool = true
	if not self in pieces_at_new_pos:
		for piece_at_pos in pieces_at_new_pos:
			var colliding_piece = _colliding_piece if _colliding_piece else self
			can_move_piece = can_move_piece and piece_at_pos.on_collided_with(
				colliding_piece, 
				last_move[0],
				last_move[1])

	# Can't move through walls
	if Globals.world.has_wall_at(new_x, new_y):
		can_move_piece = false

	if can_move_piece or force:
		var pieces_at_old_pos = Globals.get_pieces_at(pos[0], pos[1])
		for piece_at_pos in pieces_at_old_pos:
			if piece_at_pos != self:
				piece_at_pos.on_uncollided_with(
					self,
					last_move[0], 
					last_move[1])

		set_piece_pos(new_x, new_y)
	
	return can_move_piece

func set_piece_pos(new_x: int, new_y: int, animate_piece: bool=true):
	pos = [new_x, new_y]

	if start_pos == null:
		start_pos = pos

	z_index = _z_index_cached + new_y  # So we draw lower pieces on top of higher pieces

	var new_global_x: float = Globals.to_global_pos(new_x)
	var new_global_y: float = Globals.to_global_pos(new_y) + Globals.world.Y_OFFSET

	var does_animate = animate_movement(new_global_x, new_global_y) if animate_piece else false

	if not animate_piece or not does_animate:
		global_position = Vector2(
			new_global_x,
			new_global_y)

func is_button() -> bool:
	return piece_id in [
		Globals.BUTTON_GREEN_PIECE_ID,
		Globals.BUTTON_RED_PIECE_ID,
	]

func is_gate() -> bool:
	return piece_id in [
		Globals.GATE_GREEN_PIECE_ID,
		Globals.GATE_RED_PIECE_ID,
	]

func bounce_to_position_animation(new_global_x: float, new_global_y: float, duration: float):
	# Animates bouncing to a global position
	# Requires a child tween node named "Tween" to function
	
#	if not Globals.player:
#		return

	is_currently_animating = true
	
	var tween: Tween = Tween.new()
	Globals.world.add_child(tween)

	tween.interpolate_property(self, "global_position",
		global_position, Vector2(new_global_x, new_global_y), duration,
		Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	tween.start()

	yield(tween, "tween_completed")

	is_currently_animating = false
	
	tween.queue_free()

	emit_signal("completed_movement_animation")

### Abstract function to be called when we clone this piece
func clone(x: int, y: int):
	var instance = self.duplicate()
	Globals.world.add_child(instance)
	instance.set_piece_pos(x, y)

	instance.playback_movements = recorded_movements.duplicate()
	
	instance.clone_parent = self
	child_clones.append(instance)
	
	return instance

### Abstract function to be called when we collide with another piece
func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	return true

### Abstract function to be called when another piece moves off of us
func on_uncollided_with(other_piece, move_x: int, move_y: int) -> bool:
	return true

## Abstract function to be called when we animate a movement progression
func animate_movement(new_global_x: float, new_global_y: float):
	emit_signal("completed_movement_animation")

func destroy():
	Globals.remove_piece(self)
	if clone_parent != null:
		clone_parent.child_clones.erase(self)
	queue_free()
