extends Node2D

func _ready():
	var viewport_size = get_viewport().size
	$Shadow.global_position.y = viewport_size.y - $Down.global_position.y
