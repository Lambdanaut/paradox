extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,w,w,D,w,w,w,w,w,w,w,w],
		[w,o,P,o,o,o,w,w,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,w,w,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,w,w,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,w,w,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,w,w,w,w,w,w,w,w,R,w,w,w,w,w],
		[w,o,o,o,o,o,w,w,w,w,w,w,w,w,R,w,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,r,r,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]
