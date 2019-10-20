extends "res://Main.gd"

func _ready():
	$Player.position.x = 200
	show_first_two_labels(2)
	$DangerTimer.start()
	Jukebox.ghost_switch()

func _on_DangerTimer_timeout():
	$Camera2D/VBoxContainer/TextHandler.play("show_3_danger")
