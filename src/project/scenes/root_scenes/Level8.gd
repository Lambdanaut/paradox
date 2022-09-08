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
	terminal_dialogue = [
		"Incoming System Message",
		"[shake][color=#ff3333]HaHAhahaHhahAHAHAHhahaHAh HaHAhahaHhahAHAHAHhahaHAh[/color][/shake]",
		"[shake][color=#ff3333]HahAHHahaHHahhAHahhAhahHah HahAHHahaHHahhAHahhAhahHah[/color][/shake]",
		"[shake][color=#ff3333]HaHAhahaHhahAHAHAHhahaHAh HaHAhahaHhahAHAHAHhahaHAh[/color][/shake]",
		"[color=#ff8ef9]...[/color]",
		"[color=#ff8ef9]Okay but seriousl-[/color][shake][color=#ff3333]HaHAhahaHhahAHAHAHhahaHAh HaHAhahaHhahAHAHAHhahaHAh[/color][/shake]",
		"[color=#ff8ef9]...[/color]",
		"[color=#ff8ef9]Sorry, it's just that it's so funny[/color]",
		"[shake][color=#ff8ef9]You actually think that you can stop me[/color][/shake]",
		"End of Message",
	]
