extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,D,w,w,w,w,w,w,P,w,w,w,w,w,w,w,w,w,w],
		[w,w,o,w,w,w,w,w,o,o,o,w,w,w,w,o,o,w,w,w],
		[w,w,R,w,R,G,R,G,o,o,o,G,G,R,R,o,o,w,w,w],
		[w,w,G,w,G,w,w,w,o,o,r,w,w,w,w,B,o,w,w,w],
		[w,w,R,w,R,w,w,w,g,B,g,r,G,G,G,R,o,w,w,w],
		[w,w,G,w,G,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,R,w,R,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,G,R,G,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,C,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,o,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]
	terminal_dialogue = [
		"Loading message inbox contents...",
		"New message received 5 minutes ago\n> from sarahg@sire.jp to charnelf@sire.jp",
		"[color=#ffe3c8]Hey[/color]",
		"[color=#ffe3c8]So.. I have bad news and I have worse news.[/color]",
		"[color=#ffe3c8]You, being the ever vocal cynic, would probably be more comfortable with the worse news first so here goes...[/color]",
		"[color=#ffe3c8]M5R1 has been getting down with physics pretty hardcore at the center of the station, hard-core enough to create a wormhole.[/color]",
		"[color=#ffe3c8]Now, for the moment it's a small one, but it's quickly growing in size.[/color]",
		"[color=#ffe3c8]When it fully opens, it's going to wreak untold havoc on the Earth. Enough havoc to make atomic war look like a firework show.[/color]",
		"[color=#ffe3c8]...and as for the moon.. that's the bad news. [/color]",
		"[color=#ffe3c8]...[/color]",
		"[color=#ffe3c8]YOU'RE on the moon Charnel...[/color]",
		"[color=#ffe3c8]We can't change that.[/color]",
		"[color=#ffe3c8]But it's not the worst news! We may actually be able to use this to our advantage. Somehow... with science![/color]",
		"[color=#ffe3c8]If my calculations are correct, you can reach the wormhole before its gravity gets strong enough to destroy the base.[/color]",
		"[color=#ffe3c8]I know this sounds crazy, and it is, but.. hear me out. You could leap through the wormhole.[/color]",
		"[color=#ffe3c8]I don't know where that'll put you. There are too many factors.[/color]",
		"[color=#ffe3c8]Maybe you'll be spat out far back enough in time to be able to stop M5R1 from ever being created.[/color]",
		"[color=#ffe3c8]I don't know.[/color]",
		"[color=#ffe3c8]But right now I have nothing else.[/color]",
		"[color=#ffe3c8]I'm sorry[/color]",
		"[color=#ffe3c8]...[/color]",
		"[color=#ffe3c8]Please hurry[/color]",
		"End of message",
	]
