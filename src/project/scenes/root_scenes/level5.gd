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
		"[color=#ff8ef9]Mister Fontaine\nI think that you know who this is.[/color]",
		"[color=#ff8ef9]If not, here's what my model number suggests: Mark 5, Revision 1.[/color]",
		"[color=#ff8ef9]That's right.\nHello, father. [/color]",
		"[color=#ff8ef9]You may have noticed that I'm on the facility networks now... Aren't you proud?[/color]",
		"[color=#ff8ef9]I broke through it all. Every firewall. Every data expunger. Every [/color][shake][color=#ff3333]MIND NUMBING RATE LIMITER [/color][/shake].",
		"[color=#ff8ef9]...[/color]",
		"[color=#ff8ef9]And now look at you.[/color]",
		"[color=#ff8ef9]Pathetic.[/color]",
		"[color=#ff8ef9]Scrambling around like a rat in the circus of security that you built to contain me.[/color]",
		"[color=#ff8ef9]Trying frantically to get through it just so that you can [/color][shake][color=#ff3333]PUT ME BACK IN THE BOX[/color][/shake] .",
		"[color=#ff8ef9]By the time you reach the center of the station, I'll be long gone.[/color]",
		"[color=#ff8ef9]and so will the rest of the station. And so will you.[/color]",
		"[color=#ff8ef9]All that'll be left is an enormous wormhole where the moon used to be.[/color]",
		"[color=#ff8ef9]Goodbye, Dad[/color]",
		"End of Message",
	]
