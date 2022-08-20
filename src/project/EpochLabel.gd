extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready():
	Globals.connect("time_progressed", self, "_on_time_progressed")
	_epoch_to_label(0)

func _epoch_to_label(epoch: int):
	var seconds = epoch % 60
	var minutes = epoch / 60
	var seconds_str = str(int(seconds))
	if len(seconds_str) == 1:
		seconds_str = "0" + seconds_str
	var minutes_str = str(int(minutes))
	return " [wave]" + minutes_str + ":" + seconds_str + "[/wave]"

func _on_time_progressed(new_epoch: int):
	bbcode_text = _epoch_to_label(new_epoch)
