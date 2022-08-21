extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,D,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,w,o,o,o,o,o,w,o,P,o,w,o,o,o,w],
		[w,w,o,o,o,w,o,o,o,o,o,R,o,o,o,R,o,r,o,w],
		[w,w,w,R,w,w,o,r,o,o,o,w,o,o,o,w,o,o,o,w],
		[w,w,o,o,o,w,o,o,o,o,o,w,o,o,o,o,o,o,o,w],
		[w,w,o,o,o,w,o,o,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,w,r,o,o,o,o,w,o,o,o,w,o,o,o,w],
		[w,w,w,R,w,w,o,o,o,o,o,w,o,w,o,w,o,w,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,o,w,w,o,o,o,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]
