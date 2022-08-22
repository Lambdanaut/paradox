extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,D,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,w,o,o,o,o,o,w,o,P,o,w,o,o,o,w],
		[w,w,o,o,o,w,o,o,o,o,o,R,o,o,o,R,o,r,o,w],
		[w,w,w,R,w,w,o,r,o,o,o,w,o,o,o,w,o,o,o,w],
		[w,w,o,o,o,w,o,o,o,o,o,w,o,o,o,o,o,o,o,w],
		[w,w,o,o,o,w,o,o,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,w,r,o,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,w,w,R,w,w,o,o,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,o,w,w,o,o,w,w,w,w,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,C,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

	terminal_dialogue = [
		"Loading your sent message outbox contents...",
		"Message sent 1 hour ago \n> from charnelf@sire.jp to sarahg@sire.jp",
		"[color=#ffe3c8]Hello? Sarah, I need a response 10 minutes ago, and with the way things are going I might just got it.[/color]",
		"[color=#ffe3c8]Seriously though, I'm seeing temporal anomalies out the wazoo.[/color]",
		"[color=#ffe3c8]If you don't respond within the hour, I'm going into the containment area.[/color]",
		"[color=#ffe3c8]If it comes to that, and I don't make it back...[/color]",
		"[color=#ffe3c8]I love you.[/color]",
	]
