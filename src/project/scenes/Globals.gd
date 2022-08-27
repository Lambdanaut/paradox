extends Node

signal time_progressed(new_epoch)
signal time_direction_changed(new_direction)

# DEBUG CONSTANTS
const SHOW_SPLASH_SCREEN_WHEN_IN_DEBUG_MODE := false
const LOAD_GAME_FILE_WHEN_IN_DEBUG_MODE := true

const AUTHOR: String = "Lambdanaut"
const AUTHOR_URL: String = "https://lambdanaut.com"
const NOTES: String = "Starring Charnel Fontaine and Sarah Greene"
const SPECIAL_THANKS: Array = ["Kubbi", "H00DED CR0W"]

const SAVE_FILENAME = "user://savegame.save"

const INITIAL_TIME: int = 9

const MINIMUM_SWIPE_LENGTH: float = 35.0

const TILE_WIDTH: int = 16
const TILE_HEIGHT: int = 16

const COLOR_WHITE = Color("#fff7f7")
const COLOR_BLACK = Color("#000000")
const COLOR_YELLOW = Color("#f8ff00")
const COLOR_PURP = Color("#634065")
const COLOR_BLUE = Color("#89aacb")

const TILE_PIECE_ID: int = 0
const WALL_PIECE_ID: int = 1
const DOOR_PIECE_ID: int = 2
const DOOR_CLOSED_PIECE_ID: int = 3
const PLAYER_PIECE_ID: int = 4
const TIME_PORTAL_PIECE_ID: int = 5
const GATE_RED_PIECE_ID: int = 6
const GATE_GREEN_PIECE_ID: int = 7
const BUTTON_RED_PIECE_ID: int = 8
const BUTTON_GREEN_PIECE_ID: int = 9
const BOX_PIECE_ID: int = 10
const TERMINAL_PIECE_ID: int = 11
const HOURGLASS_PIECE_ID: int = 12

const levels: Array = [
	preload("res://scenes/root_scenes/Level0.tscn"),
	preload("res://scenes/root_scenes/Level1.tscn"),
	preload("res://scenes/root_scenes/Level2.tscn"),
	preload("res://scenes/root_scenes/Level3.tscn"),
	preload("res://scenes/root_scenes/Level4.tscn"),
	preload("res://scenes/root_scenes/Level5.tscn"),
	preload("res://scenes/root_scenes/Level6.tscn"),
	preload("res://scenes/root_scenes/Level7.tscn"),
	preload("res://scenes/root_scenes/Level8.tscn"),
	preload("res://scenes/root_scenes/Level9.tscn"),
]

var level_index: int = 0
var levels_unlocked: int = 1

var world = null
var player = null
var epoch: int = INITIAL_TIME
var time_progression_active := false
var forward_increment_time := false
var engaged_red_button_count: int = 0
var engaged_green_button_count: int = 0
var win_queued := false
var lose_queued := false
var change_level_queued := false
var lost_last_scene := false
var game_just_started := true
var game_loaded := false
var pieces := []

var bgm_enabled := true


func clear_registry():
	world = null
	player = null
	epoch = INITIAL_TIME
	time_progression_active = false
	forward_increment_time = false
	engaged_red_button_count = 0
	engaged_green_button_count = 0
	win_queued = false
	lose_queued = false
	change_level_queued = false
	lost_last_scene = false
	pieces.clear()

func progress_time(x_input: int, y_input: int):
	time_progression_active = true
	
	var player_did_move: bool = player.move(x_input, y_input)

	if player_did_move:
		AudioManager.play("epoch")

		if player.is_currently_animating:
			yield(player, "completed_movement_animation")

		if win_queued:
			return _next_level()

		# Move all pieces
		for piece in pieces:
			if piece != player:
				var lose_was_queued: bool = false
				var piece_did_move: bool = piece.progress_time()

				if lose_queued and not lose_was_queued:
					# Force the piece to animate if it caused a loss.
					if not piece.is_currently_animating:
						piece.move(piece.last_move[0], piece.last_move[1], null, true)
					yield(piece, "completed_movement_animation")

	else:
		AudioManager.play("cant-move")
		yield(get_tree().create_timer(0.5), "timeout")

		if lose_queued:
			# Force the player animation if we're going to die there
			player.move(x_input, y_input, null, true)
			if player.is_currently_animating:
				yield(player, "completed_movement_animation")

	if lose_queued:
		return _lose()

	if player_did_move:
		increment_epoch()

	time_progression_active = false

func increment_epoch():
	var increment: int = 1 if forward_increment_time else -1
	var new_epoch: int = epoch + increment

	if new_epoch == 0 and not forward_increment_time:
		reverse_time_direction()
		
	set_epoch(new_epoch)

func set_epoch(new_epoch: int):
	epoch = new_epoch

	emit_signal("time_progressed", epoch)

func reverse_time_direction():
	forward_increment_time = !forward_increment_time
	
	emit_signal("time_direction_changed", forward_increment_time)

func queue_win():
	win_queued = true

func queue_lose():
	lose_queued = true

func change_level(new_level_i: int):
	if change_level_queued: 
		return

	change_level_queued = true
	for piece in pieces:
		if piece.is_currently_animating:
			yield(piece, "completed_movement_animation")
	
	level_index = new_level_i
	if new_level_i >= levels_unlocked:
		levels_unlocked = new_level_i + 1
	clear_registry()
	get_tree().change_scene_to(levels[level_index])
	_save_game()
	change_level_queued = false

func toggle_bgm_enabled():
	bgm_enabled = !bgm_enabled
	
	if bgm_enabled and world.bgm_enabled:
		play_bgm()
	elif not bgm_enabled:
		AudioManager.stop_bgm()

func play_bgm():
	AudioManager.play_bgm("planet-iii")

func add_piece(piece):
	pieces.append(piece)

func remove_piece(piece):
	pieces.erase(piece)

func get_pieces_at(piece_x: int, piece_y: int, piece_id: int=-1) -> Array:
	var pieces_at: Array = []
	for piece in pieces:
		var type_condition := true if piece_id == -1 or piece.piece_id == piece_id else false
		if type_condition and piece.pos[0] == piece_x and piece.pos[1] == piece_y:
			pieces_at.append(piece)
	return pieces_at

func to_global_pos(val: int) -> float:
	return float(val) * TILE_WIDTH

func _lose():  # Call queue_lose() unless you know what you're doing
	AudioManager.play("lose")
	change_level(level_index)
	lost_last_scene = true

func _next_level():  # Call queue_next_level() unless you know what you're doing
	AudioManager.play("win")
	change_level(level_index + 1)

## Saves the current save state to the save file
func _save_game():
		var save_game = File.new()
		save_game.open(SAVE_FILENAME, File.WRITE)

		var save_state: String = str(levels_unlocked)

		# Store the save dictionary as a new line in the save file.
		save_game.store_string(save_state)

		save_game.close()

## Loads a save from the current game file
## Returns boolean indicating whether load was successful or not
func _load_game() -> bool:
		var save_game = File.new()
		if not save_game.file_exists(SAVE_FILENAME):
				# Error! We don't have a save to load.
				game_loaded = false
				return false

		# Open the save file and load it from JSON
		save_game.open(SAVE_FILENAME, File.READ)
		var loaded_string = save_game.get_as_text()
		levels_unlocked = int(loaded_string)
		
		change_level(levels_unlocked - 1)

		save_game.close()
		
		game_loaded = true

		return true
