extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,D,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,o,o,w,o,o,o,o,o,P,o,o,o,o,o,w,w,o,C,w],
		[w,o,o,w,o,o,o,o,o,o,o,o,o,o,o,w,w,o,o,w],
		[w,o,o,w,G,w,g,w,w,R,w,w,r,w,R,w,w,o,o,w],
		[w,o,o,w,G,w,G,w,o,G,o,w,G,w,R,w,w,o,o,w],
		[w,o,o,o,r,w,R,o,o,g,o,o,o,o,g,r,w,o,o,w],
		[w,o,o,o,o,w,o,o,o,g,o,o,o,o,o,o,w,o,o,w],
		[w,o,o,o,o,w,w,w,w,w,w,w,w,w,w,w,w,o,o,w],
		[w,w,w,o,o,w,g,g,w,o,o,o,o,o,o,o,o,o,o,w],
		[w,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,o,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]


	terminal_dialogue = [
		"Loading message inbox contents...",
		"New message received -10 minutes ago\n> from sarahg@sire.jp to charnelf@sire.jp",
		"[color=#ffe3c8]Charnel! I just received your message in my inbox. Temporal effects seem to be affecting technology as well.[/color]",
		"[color=#ffe3c8]If you've already started going, don't stop. Things aren't any better on Earth right now.[/color]",
		"[color=#ffe3c8]The effects from Gerlache are reaching at least this far...[/color]",
		"[color=#ffe3c8]And... that...[/color]",
		"[color=#ffe3c8]well.. that was one hell of a time to choose to make a confession.[/color]",
		"[color=#ffe3c8]I don't know if we'll see each other again at this point. I can't predict anything about the future right now.[/color]",
		"[color=#ffe3c8]...But I know that...[/color]",
		"[color=#ffe3c8]I love you too.[/color]",
		"[color=#ffe3c8]Good luck.[/color]",
	]
