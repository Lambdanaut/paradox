extends RichTextLabel

var prepended_char: String
var current_color: String

# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("time_progressed", self, "_on_time_progressed")
	_epoch_to_label(0)

	_on_time_progressed(Globals.epoch, Globals.epoch)

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

func _on_time_progressed(new_epoch: int, last_epoch: int):
	if new_epoch >= 0:
		prepended_char = "T+"
		current_color = Globals.COLOR_WHITE.to_html()
	else:
		prepended_char = "T-"
		current_color = Globals.COLOR_YELLOW.to_html()

	bbcode_text = _epoch_to_label(abs(new_epoch))
	print(new_epoch)
