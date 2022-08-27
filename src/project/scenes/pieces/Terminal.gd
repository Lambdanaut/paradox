extends "res://scenes/pieces/Piece.gd"

class_name Terminal

var dialogue_speech := [
	"Terminal logged in as root \n> Accessing local files...",
	"Access Granted",
]

var dialogue_instance: Dialogue
var dialogue_item_instance: Dialogue

onready var dialogue_resource = preload("res://scenes/misc/Dialogue.tscn")


func _init():
	piece_id = Globals.TERMINAL_PIECE_ID
	process_order = -5

func _ready():
	dialogue_speech += Globals.world.terminal_dialogue

func run_dialogue():
	AudioManager.play("terminal")
	Controller.is_active = false
	
	yield(get_tree().create_timer(0.8), "timeout")

	dialogue_instance = dialogue_resource.instance()
	Globals.world.add_child(dialogue_instance)

	dialogue_instance.run_dialogue(dialogue_speech, "terminal-speech")

func on_collided_with(other_piece, move_x: int, move_y: int) -> bool:
	if other_piece == Globals.player:
		run_dialogue()
	
	return true
