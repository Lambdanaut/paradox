extends Node

class_name Dialogue

signal dialogue_complete
signal response_given

const DIALOGUE_PROMPT = "> "
const DIALOGUE_CURSOR = " #"

var ongoing_dialogue: GDScriptFunctionState
var next_dialogue_input_received := false
var responses_given := []  # List of all responses given as a list of booleans

onready var text_label: RichTextLabel = $SpeechBackgroundRect/Speech


func _ready():
	$SpeechBackgroundRect.visible = false
 
func _process(delta):
	# Listen for next dialogue input
	if Input.is_action_just_pressed("ui_accept"):
		next_dialogue_input_received = true

func run_dialogue(dialogue: Array, sfx: String="speech1", item_added_texture: Texture=null):
	var current_dialogue_index := 0
	
	$SpeechBackgroundRect.visible = true

	Controller.is_active = false
	Globals.world.get_node("UI").get_node("PauseMenu").is_toggleable = false

	AudioManager.music_stream_player.volume_db = AudioManager.DEFAULT_BGM_VOLUME * 2

	while current_dialogue_index < len(dialogue):
		var current_dialogue = dialogue[current_dialogue_index]
		
		var dialogue_str_i := 0
		var current_dialogue_str = current_dialogue.trim_suffix(" ")
		var in_bbcode_tag := false
		
		text_label.bbcode_text = _decorate_dialogue_string(current_dialogue_str)
		text_label.visible_characters = len(DIALOGUE_PROMPT) - 1
		
		while dialogue_str_i < len(current_dialogue_str):
			next_dialogue_input_received = false

			var next_char: String = current_dialogue_str[dialogue_str_i]

			if next_char == "[":
				in_bbcode_tag = true
			elif next_char == "]":
				in_bbcode_tag = false

			if not in_bbcode_tag:
				# Longer wait times for punctuation 
				var dialogue_timer := 0.02
				if next_char == "." or next_char == "!" or next_char == "?" or next_char == "\n":
					dialogue_timer = 0.2
				elif next_char == ",":
					dialogue_timer = 0.1

				# Update the visible text
				text_label.visible_characters += 1
				
				# Play the sfx if it's set
				if sfx and next_char != " ":
					AudioManager.play(sfx)
				
				# Pause for a few milliseconds before the next character
				yield(get_tree().create_timer(dialogue_timer), "timeout")
				
				if next_dialogue_input_received and dialogue_str_i > 0:
					# Skip dialogue
					dialogue_str_i = len(current_dialogue_str)
					yield(get_tree(), "idle_frame")
					break

			dialogue_str_i += 1

		text_label.visible_characters = -1
		
		next_dialogue_input_received = false
		while not next_dialogue_input_received:
			yield(get_tree(), "idle_frame")
		
		current_dialogue_index += 1

	AudioManager.music_stream_player.volume_db = AudioManager.DEFAULT_BGM_VOLUME

	# Reactivate player to allow movement
	Controller.is_active = true
	Globals.world.get_node("UI").get_node("PauseMenu").is_toggleable = true
	
	# Emit a signal to let the owner know that we're complete
	# Pass along a list of responses given
	emit_signal("dialogue_complete", responses_given)

	# Dialogue finished. Remove it from the scene tree
	queue_free()

func _decorate_dialogue_string(dialogue_string):
	return DIALOGUE_PROMPT + dialogue_string + "[blink]" + DIALOGUE_CURSOR + "[/blink]"

func toggle_dialogue_visible(new_visible: bool):
	$SpeechBackgroundRect.visible = new_visible


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			next_dialogue_input_received = true
		
