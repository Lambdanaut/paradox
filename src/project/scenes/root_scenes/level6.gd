extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,D,w,w,w,w,w,w,w,w,w,w,w,w,P,w,w,w,w],
		[w,o,o,o,o,o,R,G,o,o,o,o,w,o,o,o,o,w,w,w],
		[w,o,o,o,o,o,R,G,o,o,B,o,w,o,o,o,o,w,w,w],
		[w,o,o,o,o,o,R,G,o,o,o,o,w,o,o,o,o,w,w,w],
		[w,R,R,R,R,R,w,w,o,o,o,o,w,o,o,o,o,w,w,w],
		[w,G,G,G,G,G,w,w,o,o,o,o,w,o,o,o,o,w,w,w],
		[w,R,R,R,R,R,w,w,o,o,o,o,w,o,o,o,o,r,g,w],
		[w,G,G,G,G,G,w,w,o,o,o,o,R,o,o,o,o,w,w,w],
		[w,R,R,R,R,R,w,w,o,o,o,o,R,o,B,o,o,w,w,w],
		[w,G,G,G,G,C,w,w,o,o,o,o,R,o,o,o,o,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]
	terminal_dialogue = [
	]
