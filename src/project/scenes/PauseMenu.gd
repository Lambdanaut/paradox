extends Node2D

const SELECTED_PROMPT = "[color=#80ffb3]>[/color]   "

var _is_active := false
var is_toggleable := true

var _selected_level: int = Globals.level_index

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

func _process(delta):
	if Input.is_action_just_pressed("ui_pause"):
		_toggle_is_active()
	if _is_active:
		if Input.is_action_just_pressed("ui_right"):
			AudioManager.play("menu-move")
			_set_selected_level(_selected_level+1)
		elif Input.is_action_just_pressed("ui_left"):
			AudioManager.play("menu-move")
			_set_selected_level(_selected_level-1)

func _toggle_is_active():
	if !is_toggleable:
		return
	
	_is_active = !_is_active
	get_tree().paused = _is_active
	visible = _is_active

	if _is_active:
		AudioManager.play("pause-menu")
		_set_selected_level(Globals.level_index)
		AudioManager.music_stream_player.volume_db = AudioManager.DEFAULT_BGM_VOLUME * 2
	else:
		AudioManager.music_stream_player.volume_db = AudioManager.DEFAULT_BGM_VOLUME

func _set_selected_level(new_selected_level: int):
	new_selected_level = abs(new_selected_level % Globals.levels_unlocked) if new_selected_level > -1 else Globals.levels_unlocked - 1
	_selected_level = new_selected_level

	var new_level_string: String = ""
	for level_i in range(len(Globals.levels)):
		var level: String = str(level_i)
		if level_i == _selected_level:
			level = SELECTED_PROMPT + "[wave amp=30 freq=5][color=#80ffb3]" + level + "[/color][/wave]"
		elif level_i >= Globals.levels_unlocked:
			level = "[color=#000000]" + level + "[/color]"
		new_level_string += level + "   "

	$LevelList.bbcode_text = new_level_string
