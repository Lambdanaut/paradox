extends Node

var is_active := true

var _swipe_start_pos = null

var _x_swipe_input: int = 0
var _y_swipe_input: int = 0


func _ready():
	pass

func _physics_process(delta):
	if not Globals.player:
		return

	if Globals.time_progression_active:
		return

	if is_active:
		var cancel_input: bool = Input.is_action_just_pressed("ui_cancel")  # For restarting level
		var select_input: bool = Input.is_action_pressed("ui_select")  # For backing up one turn
		if select_input:
			Globals.regress_time()
		elif cancel_input and Globals.world.restart_enabled:
			Globals._lose()
		else:
			var x_input: int = 0 + _x_swipe_input
			var y_input: int = 0 + _y_swipe_input
			if Input.is_action_pressed("ui_right"):
				x_input = 1
			elif Input.is_action_pressed("ui_left"):
				x_input = -1
			elif Input.is_action_pressed("ui_up"):
				y_input = -1
			elif Input.is_action_pressed("ui_down"):
				y_input = 1

			if (x_input or y_input) and not (x_input and y_input):
				Globals.progress_time(x_input, y_input)
	
	_x_swipe_input = 0
	_y_swipe_input = 0

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			_swipe_start_pos = event.position
		else:
			_calculate_swipe(event.position)

func _calculate_swipe(swipe_end):
	if _swipe_start_pos == null: 
		return
	var swipe = swipe_end - _swipe_start_pos
	if abs(swipe.x) > Globals.MINIMUM_SWIPE_LENGTH:
		if swipe.x > 0:
			_x_swipe_input = 1
		else:
			_x_swipe_input = -1
	if abs(swipe.y) > Globals.MINIMUM_SWIPE_LENGTH:
		if swipe.y > 0:
			_y_swipe_input = 1
		else:
			_y_swipe_input = -1
