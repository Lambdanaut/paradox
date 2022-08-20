extends Node


var is_active := true

func _ready():
	pass

func _physics_process(delta):
	if not is_active:
		return

	if not Globals.player:
		return
		
	if Globals.time_progression_active:
		return

	var select_input: bool = Input.is_action_just_pressed("ui_select")
	if select_input:
		Globals.progress_time(0, 0)
	else:
		var x_input: int = 0
		var y_input: int = 0
		if Input.is_action_just_pressed("ui_right"):
			x_input = 1
		elif Input.is_action_just_pressed("ui_left"):
			x_input = -1
		elif Input.is_action_just_pressed("ui_up"):
			y_input = -1
		elif Input.is_action_just_pressed("ui_down"):
			y_input = 1

		if (x_input or y_input) and not (x_input and y_input):
			Globals.progress_time(x_input, y_input)
