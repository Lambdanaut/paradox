extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,D,w,w],
		[w,o,o,w,w,w,w,w,w,o,r,P,o,r,w,o,o,o,C,w],
		[w,o,w,w,g,o,o,w,w,w,R,w,w,w,w,o,o,o,o,w],
		[w,o,r,o,o,w,o,R,R,R,r,w,w,w,w,w,w,R,w,w],
		[w,w,r,w,r,o,o,w,w,w,r,w,w,w,w,w,w,o,w,w],
		[w,w,o,w,w,w,w,w,w,w,R,G,o,o,r,r,o,o,w,w],
		[w,w,o,o,w,w,w,w,w,w,o,w,w,w,w,o,w,w,w,w],
		[w,w,o,o,w,w,w,w,w,w,R,w,w,w,w,o,w,w,w,w],
		[w,w,r,o,R,R,R,R,o,o,o,w,w,w,w,g,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

	terminal_dialogue = [
		"Incoming System Message",
		"[color=#ff8ef9]You found the secret level! Hope you enjoyed!\n-Lambdanaut[/color]",
		"End of Message",
	]
