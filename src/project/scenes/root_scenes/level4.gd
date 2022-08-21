extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,P,w,w,w,w,w,w,w,D,w,w],
		[w,w,o,o,o,w,r,o,o,o,R,o,w,r,G,G,o,o,o,w],
		[w,w,r,w,o,w,w,G,w,o,w,o,G,o,w,w,w,w,w,w],
		[w,w,R,g,o,w,w,o,w,o,o,g,w,o,R,R,o,o,o,w],
		[w,w,G,R,w,w,w,o,w,w,G,w,w,o,w,w,o,o,o,w],
		[w,w,o,o,o,o,o,o,w,w,g,o,o,o,w,w,o,o,o,w],
		[w,w,o,o,o,o,w,w,w,w,w,w,w,w,w,w,g,o,o,w],
		[w,w,o,o,o,o,w,o,o,o,o,o,o,o,w,w,g,o,o,w],
		[w,w,o,o,o,o,R,g,w,w,w,w,r,r,R,o,o,o,o,w],
		[w,w,o,o,o,o,w,o,o,o,o,o,o,o,w,w,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],

	]
