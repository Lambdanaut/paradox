extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,D,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,o,o,w,o,o,o,o,o,P,o,o,o,o,o,w,w,o,o,w],
		[w,o,o,w,o,o,o,o,o,o,o,o,o,o,o,w,w,o,o,w],
		[w,o,o,w,G,w,g,w,w,R,w,w,r,w,R,w,w,o,o,w],
		[w,o,o,w,G,w,G,w,o,G,o,w,G,w,R,w,w,o,o,w],
		[w,o,o,o,r,w,R,o,o,g,o,o,o,o,g,r,w,o,o,w],
		[w,o,o,o,o,w,o,o,o,g,o,o,o,o,o,o,w,o,o,w],
		[w,o,o,o,o,w,w,w,w,w,w,w,w,w,w,w,w,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],

	]
