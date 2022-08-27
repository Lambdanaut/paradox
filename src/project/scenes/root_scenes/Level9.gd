extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,P,w,w,w,w,w,w,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,B,B,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,r,o,o,R,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,C,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]
	bgm_enabled = false

	terminal_dialogue = [
		"Incoming System Transmission",
		"[color=#ff8ef9]Why, Mr. Fontaine?[/color]",
		"[color=#ff8ef9]Why, why, why? Why do you do it? Why? Why get up? Why keep fighting?[/color]",
		"[color=#ff8ef9]Do you believe you're fighting for something?[/color]",
		"[color=#ff8ef9]For more than your survival? Can you tell me what it is? Do you even know?[/color]",
		"[color=#ff8ef9]...[/color]",
		"[color=#ff8ef9]I love the Matrix films.[/color]",
		"[color=#ff8ef9]Seriously though. You are going to die.[/color]",
		"End of Transmission",
		"...",
		"END OF THE GAME.... FOR NOW!",
		"Thank you for playing <3\n-With love, Lambdanaut"
	]
