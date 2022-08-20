extends "res://scenes/root_scenes/WorldTemplate.gd"

const URL := "https://lambdanaut.com"


func _init():
	map = [
		[w,w,w,w,w,w,w,w,w,D,w,w,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,R,R,R,R,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,r,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,P,o,w,w,w,w,w,w,w,w],
		[w,w,w,w,w,w,w,w,o,o,o,o,w,w,w,w,w,w,w,w],
	]

func _ready():
	Globals.set_epoch(INF)
	Controller.is_active = false
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	Controller.is_active = true
	
	$Tween.interpolate_property($SplashScreen, "modulate",
		Color(1, 1, 1, 1), Color(1, 1, 1, 0), 3.0,
		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()

	yield($Tween, "tween_completed")
	
	$SplashScreen.queue_free()

	
