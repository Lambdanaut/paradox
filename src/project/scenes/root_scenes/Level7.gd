extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,D,w,w,w,w,w,w,P,w,w,w,w,w,w,w,w,w,w],
		[w,w,o,w,w,w,w,w,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,w,R,w,R,G,R,G,o,o,o,G,G,R,R,G,G,o,o,w],
		[w,w,G,w,G,w,w,w,o,o,r,w,w,w,o,w,o,B,o,w],
		[w,w,R,w,R,w,w,w,o,B,g,r,w,w,o,w,o,r,o,w],
		[w,w,G,w,G,w,w,w,o,o,o,o,w,w,w,w,o,o,r,w],
		[w,w,R,w,R,w,w,w,w,w,w,w,w,w,o,w,o,o,g,w],
		[w,w,G,R,G,w,w,w,w,w,w,w,w,w,o,w,w,w,w,w],
		[w,w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]
