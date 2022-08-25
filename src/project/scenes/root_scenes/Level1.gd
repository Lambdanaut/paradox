extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,w,w,D,w,w,w,w,w,w,w,w],
		[w,o,P,o,w,w,w,w,o,o,o,o,o,o,o,w,w,w,w,w],
		[w,o,o,o,w,w,w,w,o,o,o,o,o,o,o,w,w,w,w,w],
		[w,o,o,o,w,w,w,w,o,o,o,o,o,o,o,w,w,w,w,w],
		[w,o,o,o,w,w,w,w,o,o,o,o,o,o,o,w,w,w,w,w],
		[w,o,o,o,w,w,w,w,w,w,w,w,w,w,R,w,w,w,w,w],
		[w,o,o,o,w,w,w,w,w,w,w,w,w,w,R,w,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w,o,o,o,w],
		[w,o,o,o,o,o,r,r,o,o,o,o,o,o,o,o,o,C,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

	terminal_dialogue = [
		"All Gerlache facility employees are expected to make routine trips to the gym and recreational spaces on a daily basis.",
		"Remember, muscular and skeletal atrophy is accelerated while on premise.",
		"Please submit your \"workout\" logs to the helpdesk on a bi-weekly basis.",
		"Thank you for your help in making the Gerlache facility a safe environment for all. \n- The Gerlache People-Ops Team",
	]
