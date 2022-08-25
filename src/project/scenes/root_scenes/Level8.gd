extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,P,w,w,w,w,w,w,w,w,w,w,w,w,D,w,w],
		[w,w,o,o,o,o,w,w,w,w,w,w,w,w,w,w,o,o,o,w],
		[w,w,o,o,o,o,w,w,w,w,w,w,w,w,w,w,o,o,o,w],
		[w,w,o,o,r,o,w,w,o,G,G,o,r,w,w,w,o,o,o,w],
		[w,w,o,o,B,o,R,R,o,G,G,o,r,w,w,w,o,o,o,w],
		[w,w,o,o,o,o,w,w,C,w,w,B,w,w,w,w,o,o,o,w],
		[w,r,o,g,o,o,w,w,w,w,w,B,o,o,g,G,o,o,o,w],
		[w,w,w,w,o,w,w,w,w,w,w,B,w,w,w,w,w,w,w,w],
		[w,w,w,w,o,w,w,G,G,G,w,B,w,w,w,w,w,w,w,w],
		[w,w,w,w,o,o,R,R,G,R,R,o,o,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

