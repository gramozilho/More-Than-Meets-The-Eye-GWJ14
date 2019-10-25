extends Area2D

signal kill_player

var viewport_size

func _ready():
	viewport_size = get_viewport().size
	shadow_cast()


func _on_BadArea_body_entered(body):
	if body.is_in_group('player'):
		emit_signal("kill_player")


func shadow_cast():
	$Shadow.global_position.y = 600 - $Body.global_position.y
