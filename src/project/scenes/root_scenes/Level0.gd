extends "res://scenes/root_scenes/WorldTemplate.gd"

const URL := "https://lambdanaut.com"


func _init():
	restart_enabled = false
	bgm_enabled = false
	map = [
		[w,w,w,w,w,w,w,w,w,D,w,w,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,C,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,R,R,R,R,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,r,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,P,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
	]
	terminal_dialogue = [
		"Welcome to the Gerlache primary help system! ",
		"Current status of facility: [color=#ff3333]Terminal[/color]",
		"Temporal anomalies detected in and around site. ",
		"Please alert M5R1 technicians in the event of any anomalies to prevent system outbreak.",
		"Thank you, and have a wonderful day!"
	]

