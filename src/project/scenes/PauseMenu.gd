extends Node2D

enum MENU_SECTION {LEVEL, BGM}

const SCREEN_TOUCH_TO_PAUSE_DURATION: float = 1.0
const SELECTED_PROMPT: String = "[color=#80ffb3]>[/color]   "
const MENU_SECTION_LENGTH = 2

var _is_active := false
var is_toggleable := true
var _screen_touch_timer: SceneTreeTimer

var _selected_menu_section: int = 0
var _selected_level: int = Globals.level_index

var _swipe_start_pos = null
var _x_swipe_input: int = 0
var _y_swipe_input: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _process(delta):
	if _is_active:
		if _selected_menu_section == MENU_SECTION.LEVEL:
			if Input.is_action_just_pressed("ui_right") or _x_swipe_input > 0:
				AudioManager.play("menu-move")
				_set_selected_level(_selected_level+1)
			elif Input.is_action_just_pressed("ui_left") or _x_swipe_input < 0:
				AudioManager.play("menu-move")
				_set_selected_level(_selected_level-1)
			elif Input.is_action_just_pressed("ui_pause") and \
						_selected_level != Globals.level_index:
				AudioManager.play("level-changed")
				Globals.change_level(_selected_level)
		elif _selected_menu_section == MENU_SECTION.BGM:
			if Input.is_action_just_pressed("ui_right") or \
					Input.is_action_just_pressed("ui_left") or \
					_x_swipe_input:
				AudioManager.play("menu-move")
				_toggle_selected_bgm_enabled()

		if Input.is_action_just_pressed("ui_up") or _y_swipe_input > 0:
			set_selected_menu_section(_selected_menu_section + 1)
			AudioManager.play("menu-move")
		elif Input.is_action_just_pressed("ui_down") or _y_swipe_input < 0:
			set_selected_menu_section(_selected_menu_section - 1)
			AudioManager.play("menu-move")

	if Input.is_action_just_pressed("ui_pause"):
		_toggle_is_active()

func _toggle_is_active():
	if !is_toggleable:
		return
	
	_is_active = !_is_active
	get_tree().paused = _is_active
	visible = _is_active
	_swipe_start_pos = null

	if _is_active:
		AudioManager.play("pause-menu")
		set_selected_menu_section(0)
		_set_selected_level(Globals.level_index)
		_toggle_selected_bgm_enabled(false)
		AudioManager.music_stream_player.volume_db = AudioManager.DEFAULT_BGM_VOLUME * 2
	else:
		AudioManager.music_stream_player.volume_db = AudioManager.DEFAULT_BGM_VOLUME

func set_selected_menu_section(new_selected_menu_section: int):
	_selected_menu_section = abs(new_selected_menu_section % MENU_SECTION_LENGTH) if new_selected_menu_section > -1 else MENU_SECTION_LENGTH - 1
	
	_set_selected_level(_selected_level)
	_toggle_selected_bgm_enabled(false)

func _set_selected_level(new_selected_level: int):
	_x_swipe_input = 0
	_y_swipe_input = 0

	if _selected_menu_section == MENU_SECTION.LEVEL:
		_selected_level = abs(new_selected_level % Globals.levels_unlocked) if new_selected_level > -1 else Globals.levels_unlocked - 1
	else:
		_selected_level = Globals.level_index

	var new_level_string: String = ""
	for level_i in range(len(Globals.levels)):
		var level: String = str(level_i)
		if level_i == _selected_level:
			level = SELECTED_PROMPT + "[color=#80ffb3]" + level + "[/color]"
			if _selected_menu_section == MENU_SECTION.LEVEL:
				level = "[wave amp=30 freq=5]" + level + "[/wave]"
		elif level_i >= Globals.levels_unlocked:
			level = "[color=#000000]" + level + "[/color]"
		new_level_string += level + "   "

	$LevelList.bbcode_text = new_level_string

func _toggle_selected_bgm_enabled(toggle_global:=true):
	_x_swipe_input = 0
	_y_swipe_input = 0

	if toggle_global:
		Globals.toggle_bgm_enabled()
	
	var new_bgm_enabled_string: String
	if Globals.bgm_enabled:
		new_bgm_enabled_string = SELECTED_PROMPT + "[color=#80ffb3]Enabled[/color]"

		if _selected_menu_section == MENU_SECTION.BGM:
			new_bgm_enabled_string = "[wave amp=30 freq=5]" + new_bgm_enabled_string + "[/wave]"

		new_bgm_enabled_string += "   Disabled"
	else:
		new_bgm_enabled_string = SELECTED_PROMPT + "[color=#80ffb3]Disabled[/color]"

		if _selected_menu_section == MENU_SECTION.BGM:
			new_bgm_enabled_string = "[wave amp=30 freq=5]" + new_bgm_enabled_string + "[/wave]"
		
		new_bgm_enabled_string = "Enabled   " + new_bgm_enabled_string
		

	$BgmEnabled.bbcode_text = new_bgm_enabled_string

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			if _is_active:
				_swipe_start_pos = event.position
			else:
				var our_screen_touch_timer = get_tree().create_timer(SCREEN_TOUCH_TO_PAUSE_DURATION)
				_screen_touch_timer = our_screen_touch_timer
				yield(our_screen_touch_timer, "timeout")
				if our_screen_touch_timer == _screen_touch_timer:
					_toggle_is_active()
		else:
			if _is_active:
				_calculate_swipe(event.position)
			_screen_touch_timer = null

func _calculate_swipe(swipe_end):
	if _swipe_start_pos == null: 
		return
	var swipe = swipe_end - _swipe_start_pos
	if abs(swipe.x) > Globals.MINIMUM_SWIPE_LENGTH:
		if swipe.x > 0:
			_x_swipe_input = 1
		else:
			_x_swipe_input = -1
	elif abs(swipe.x) + abs(swipe.y) < Globals.MINIMUM_SWIPE_LENGTH * 0.25:
		# It was a click, not a swipe
		if _selected_level != Globals.level_index:
			AudioManager.play("level-changed")
			yield(get_tree(), "idle_frame")
			Globals.change_level(_selected_level)

		_toggle_is_active()

	if abs(swipe.y) > Globals.MINIMUM_SWIPE_LENGTH:
		if swipe.y > 0:
			_y_swipe_input = 1
		else:
			_y_swipe_input = -1
