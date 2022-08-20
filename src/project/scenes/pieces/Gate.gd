extends "res://scenes/pieces/Piece.gd"

class_name Gate

enum GateType {RED, GREEN}

var gate_type = GateType.RED
var engaged := true

func toggle_engaged():
	var button_count: int = 0
	
	if gate_type == GateType.RED:
		button_count = Globals.engaged_red_button_count
	elif gate_type == GateType.GREEN:
		button_count = Globals.engaged_green_button_count
	
	var new_engaged: bool = not bool(button_count)
	engaged = new_engaged
	
	$Sprite.frame = 0 if new_engaged else 1

func set_gate_type(new_gate_type):
	gate_type = new_gate_type

	if gate_type == GateType.RED:
		$Sprite.texture = preload("res://data/sprites/pieces/gate/gate-red.png")
	elif gate_type == GateType.GREEN:
		$Sprite.texture = preload("res://data/sprites/pieces/gate/gate-green.png")

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	return not engaged
