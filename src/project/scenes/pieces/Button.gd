extends "res://scenes/pieces/Piece.gd"

class_name PressButton

enum ButtonType {RED, GREEN}

const COUNTDOWN_DURATION: int = 1

var button_type = ButtonType.RED
var engaged := false
var was_collided_with_this_turn := false


func _init():
	piece_id = Globals.BUTTON_RED_PIECE_ID
	process_order = -5

func progress_time(x_delta=null, y_delta=null) -> bool:
	was_collided_with_this_turn = false
	return .progress_time(x_delta, y_delta)

func regress_time():
	was_collided_with_this_turn = false
	return .regress_time()

func toggle_engaged(new_engaged: bool):
	if new_engaged and not engaged:
		if button_type == ButtonType.RED:
			Globals.engaged_red_button_count += 1
		elif button_type == ButtonType.GREEN:
			Globals.engaged_green_button_count += 1
		AudioManager.play("button-pressed")
	elif not new_engaged and engaged:
		if button_type == ButtonType.RED:
			Globals.engaged_red_button_count -= 1
		elif button_type == ButtonType.GREEN:
			Globals.engaged_green_button_count -= 1

	engaged = new_engaged

	$Sprite.frame = 1 if new_engaged else 0

	for piece in Globals.pieces:
		if piece.is_gate():
			piece.toggle_engaged()

func set_button_type(new_button_type):
	button_type = new_button_type

	if button_type == ButtonType.RED:
		$Sprite.texture = preload("res://data/sprites/pieces/button/button-red.png")
	elif button_type == ButtonType.GREEN:
		$Sprite.texture = preload("res://data/sprites/pieces/button/button-green.png")

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	print("collided", other_piece)
	toggle_engaged(true)
	was_collided_with_this_turn = true
	return true

func on_uncollided_with(other_piece, move_x: int, move_y: int) -> bool:
	print("uncollided", other_piece)
	if not was_collided_with_this_turn:
		toggle_engaged(false)
	return true
