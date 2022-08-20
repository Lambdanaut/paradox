extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,D,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,P,w,r,o,w,o,o,o,g,w],
		[w,o,o,o,o,o,o,o,o,r,o,G,o,o,w,o,o,o,o,w],
		[w,w,w,w,w,w,w,R,R,w,w,w,o,o,w,w,w,w,G,w],
		[w,w,w,w,w,w,w,o,o,o,w,w,o,o,w,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,g,o,w,w,o,o,w,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,w,w,g,o,w,o,r,o,o,w],
		[w,o,o,r,o,o,o,o,o,o,w,w,R,w,w,G,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,w,w,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,w,w,r,w,g,w,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]
