extends "res://Main.gd"

var do_once = true

func _ready():
	#$Player.state = "freeze"
	show_first_two_labels(1)
	#$Body/ShadowCollision.disabled = true
	#$Player/AnimationPlayer.play("show_1")
	$ExtraTimer.start()
	yield($ExtraTimer, "timeout")
	$Camera2D/VBoxContainer/TextHandler.play("show_3")
	

	
