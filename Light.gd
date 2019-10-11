extends Node2D

signal light_position

func _process(delta):
	emit_signal("light_position", global_position)
	
	if Input.is_action_just_pressed("ui_right"):
		position.x += 20 
	if Input.is_action_just_pressed("ui_left"):
		position.x -= 20 
