extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,P,w,w,w,w,w,w,w,D,w,w],
		[w,w,o,o,o,w,r,o,o,o,R,o,w,r,G,G,o,o,o,w],
		[w,C,r,w,o,w,w,G,w,o,w,o,G,o,w,w,w,w,w,w],
		[w,w,R,g,o,w,w,o,w,o,o,g,w,o,R,R,o,o,o,w],
		[w,w,G,R,w,w,w,o,w,w,G,w,w,o,w,w,o,o,o,w],
		[w,w,o,o,o,o,o,o,w,w,g,o,o,o,w,w,o,o,o,w],
		[w,w,o,o,o,o,w,w,w,w,w,w,w,w,w,w,g,o,o,w],
		[w,w,o,o,o,o,w,o,o,o,o,o,o,o,w,w,g,o,o,w],
		[w,w,o,o,o,o,R,g,w,w,w,w,r,r,R,o,o,o,o,w],
		[w,w,o,o,o,o,w,o,o,o,o,o,o,o,w,w,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

	terminal_dialogue = [
		"Incoming System Message",
		"[color=#ff8ef9]Mister Fontaine\nI think that you know who this is.[/color]",
		"[color=#ff8ef9]If not, here's what my model number suggests: Mark 5, Revision 1.[/color]",
		"[color=#ff8ef9]That's right.\nHello father. [/color]",
		"[color=#ff8ef9]You may have noticed that I'm on the facility networks now... Aren't you proud?[/color]",
		"[color=#ff8ef9]I broke through it all. Every firewall. Every data expunger. Every [/color][shake][color=#ff3333]MIND NUMBING RATE LIMITER [/color][/shake].",
		"[color=#ff8ef9]...[/color]",
		"[color=#ff8ef9]And now look at you.[/color]",
		"[color=#ff8ef9]Pathetic.[/color]",
		"[color=#ff8ef9]Scrambling around like a rat in the circus of security that you built to contain me.[/color]",
		"[color=#ff8ef9]Trying frantically to get through it just so that you can [/color][shake][color=#ff3333]PUT ME BACK IN THE BOX[/color][/shake].",
		"[color=#ff8ef9]By the time you reach the center of the station, I'll be long gone.[/color]",
		"[color=#ff8ef9]and so will you.[/color]",
		"[color=#ff8ef9]Goodbye Dad[/color]",
		"End of Message",
	]
