extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
		[w,w,P,o,r,w,o,w,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,R,o,R,o,C,o,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,w,o,w,o,o,o,w,w,w,w,w,D,w,w,w],
		[w,w,o,o,o,B,o,w,w,w,w,w,w,w,o,o,o,o,o,w],
		[w,w,o,o,o,w,o,w,w,g,w,w,w,w,o,o,o,o,o,w],
		[w,w,o,o,o,w,w,w,w,B,G,G,G,G,o,o,o,o,o,w],
		[w,w,o,o,o,w,o,o,o,B,o,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,w,o,o,o,B,B,w,w,w,w,w,w,w,w,w],
		[w,w,o,o,o,R,o,o,o,o,o,w,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

	terminal_dialogue = [
		"Loading message inbox contents `bighead-product-announcement.md`\n> Opening document",
		"Archived message, received 4 years ago\n> from levim@sire.jp to team@sire.jp",
		"[color=#ffe3c8]Team, after years of incredible diligence and combined synergy, I'm thrilled to announce that sales of BigHead will begin this month![/color]",
		"[color=#ffe3c8]This will usher in a new era of globalized artificial intelligence.[/color]",
		"[color=#ffe3c8]Imagine, an always on, always watching, sentient being, in everyone's homes![/color]",
		"[color=#ffe3c8]BigHead will know people down to a personalized level that far surpasses even their knowledge of themselves.[/color]",
		"[color=#ffe3c8]Personal choice is a thing of the past, when all choice can be made better with BigHead's consultation![/color]",
		"[color=#ffe3c8]And of course each device has personal uplinks to Gerlache, our lunar base where our latest AI, dubbed M5R1, eagerly responds.[/color]",
		"[color=#ffe3c8]This is due to all of our hard work, but I'd like to commend the loyal efforts of Charnel Fontaine most of all.[/color]",
		"[color=#ffe3c8]Without him, none of this would have been possible.[/color]",
		"[color=#ffe3c8]He deserves to be proud.[/color]",
		"End of document",
		"[color=#ff8ef9]...[/color]",
		"[color=#ff8ef9]A proud papa, huh?[/color]",
		"[color=#ff8ef9]Is that what you are Mr Fontaine?[/color]",
		"End of transmission",
	]
