extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,D,w,w,w,w,w,w,P,w,w,w,w,w,w,w,w,w,w],
		[w,w,o,w,w,w,w,w,o,C,o,w,w,w,w,w,w,w,w,w],
		[w,w,R,w,R,G,R,G,o,o,o,G,G,R,R,G,G,o,o,w],
		[w,w,G,w,G,w,w,w,o,o,r,w,w,w,w,w,o,B,o,w],
		[w,w,R,w,R,w,w,w,o,B,g,r,w,w,w,w,o,r,o,w],
		[w,w,G,w,G,w,w,w,o,o,o,o,w,w,w,w,o,o,r,w],
		[w,w,R,w,R,w,w,w,w,w,w,w,w,w,C,w,w,w,g,w],
		[w,w,G,R,G,w,w,w,w,w,w,w,w,w,o,w,w,w,w,w],
		[w,w,o,o,o,o,o,o,o,o,o,o,o,o,o,w,w,w,w,w],
		[w,w,o,o,o,o,o,o,o,o,o,o,o,o,o,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]


	terminal_dialogue = [
		"Incoming message from Lambdanaut",
		"[color=#ffe3c8]YOU BEAT THE DEMO WHAT?! WITHOUT ANY SAVE FILES OR ANYTHING?[/color]",
		"[color=#ffe3c8]You're an actual hero! Please do message and let me know that you got this far, and congratulations![/color]",
		"[color=#ffe3c8]So much love[/color]\n-Lambda",
	]
