extends Node2D

signal light_position

var old_position


func _ready():
	old_position = global_position


func _process(delta):
	if old_position != global_position:
		emit_signal("light_position", global_position)
		old_position = global_position
	
	if Input.is_action_just_pressed("ui_right"):
		position.x += 20 
	if Input.is_action_just_pressed("ui_left"):
		position.x -= 20 
