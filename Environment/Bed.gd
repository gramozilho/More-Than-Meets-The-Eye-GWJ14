extends Node2D

func _ready():
	var viewport_size = get_viewport().size
	$Shadow.global_position.y = 600 - $Down.global_position.y
