extends "res://scenes/root_scenes/WorldTemplate.gd"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,P,w,w,w,w,w,w,w,D,w,w],
		[w,w,o,o,o,w,r,o,o,o,R,o,w,r,G,G,o,o,o,w],
		[w,C,r,w,o,w,w,G,w,o,w,o,G,o,w,w,w,w,w,w],
		[w,w,R,g,o,w,w,o,w,o,o,g,w,o,R,R,o,w,w,w],
		[w,w,G,R,w,w,w,o,w,w,G,w,w,o,w,w,o,w,w,w],
		[w,w,o,o,o,o,o,o,w,w,g,o,o,o,w,w,o,w,w,w],
		[w,w,w,w,w,o,w,w,w,w,w,w,w,w,w,w,g,w,w,w],
		[w,w,w,w,w,o,w,o,o,o,o,o,o,o,w,w,g,w,w,w],
		[w,w,w,w,w,o,R,g,w,w,w,w,r,r,R,o,o,w,w,w],
		[w,w,w,w,w,w,w,o,o,o,o,o,o,o,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w,w],
	]

	terminal_dialogue = [
		"Document revisions found in `M5R1-containment-procedures.md`\n> Opening document",
		"[color=#ffe3c8]CC: engineering_team@sire.jp[/color]",
		"[color=#ffe3c8]As per the requests of the chief information officer, containment procedures are now in effect for M5R1.[/color]",
		"[color=#ffe3c8]Procedures include a several-level multi-floor buffer between the server room housing M5R1 and the rest of the station.[/color]",
		"[color=#ffe3c8]Due to the multi-button patented design, at least two personel are required at all times to traverse the containment zone.[/color]",
		"[color=#ffe3c8]In the case of any attempted breach, contact Charnel (charnelf@sire.jp) immediately.[/color]",
		"[color=#ffe3c8]For all other inquiries into containment procedures or access requests to interact with M5R1, email the CIO. (levim@sire.jp)[/color]",
		"[color=#ffe3c8]All glory be to the CIO.[/color]",
		"End of document"
	]
