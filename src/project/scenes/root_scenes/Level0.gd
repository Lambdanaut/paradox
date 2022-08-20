extends "res://scenes/root_scenes/WorldTemplate.gd"

const URL := "https://lambdanaut.com"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,P,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

func _ready():
	Globals.set_epoch(INF)
	Controller.is_active = false
