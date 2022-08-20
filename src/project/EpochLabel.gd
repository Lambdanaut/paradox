extends RichTextLabel

var prepended_char: String
var current_color: String

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("time_progressed", self, "_on_time_progressed")
	_epoch_to_label(0)

	Globals.connect("time_direction_changed", self, "_on_time_direction_changed")
	
	_on_time_direction_changed(false)

func _epoch_to_label(epoch: int):
	if epoch > 10000 or epoch < 0:
		return ""
	var seconds = epoch % 60
	var minutes = epoch / 60
	var seconds_str = str(int(seconds))
	if len(seconds_str) == 1:
		seconds_str = "0" + seconds_str
	var minutes_str = str(int(minutes))
	return " [wave][color=#" + current_color + "]" + prepended_char + minutes_str + ":" + seconds_str + "[/color][/wave]"

func _on_time_progressed(new_epoch: int):
	bbcode_text = _epoch_to_label(new_epoch)

func _on_time_direction_changed(new_direction: bool):
	if new_direction:
		current_color = Globals.COLOR_WHITE.to_html()
		prepended_char = "T+"
	else:
		current_color = Globals.COLOR_YELLOW.to_html()
		prepended_char = "T-"
		
