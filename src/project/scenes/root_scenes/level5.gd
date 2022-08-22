extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,D,w,w],
		[w,o,o,w,w,w,w,w,w,o,r,P,w,r,w,o,o,o,C,w],
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
		"Incoming message from Lambdanaut",
		"[color=#ffe3c8]Congrats on making it this far in the #minijam demo of Paradox![/color]",
		"[color=#ffe3c8]I'm honestly super impressed you made it this far. Thank you so much for playing![/color]",
		"[color=#ffe3c8]There are a few more levels, but this is as far as the story with these terminals goes for now.[/color]",
		"[color=#ffe3c8]So much love[/color]\n-Lambda",
	]
