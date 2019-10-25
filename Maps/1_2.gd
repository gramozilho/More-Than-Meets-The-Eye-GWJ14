extends "res://Main.gd"


func _ready():
	show_first_two_labels(1)
	$ExtraTimer.start()
	yield($ExtraTimer, "timeout")
	$Camera2D/VBoxContainer/TextHandler.play("show_3")
