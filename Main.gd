extends Node2D

func _process(delta):
	if Input.is_action_pressed("click"):
		$Light.global_position = get_global_mouse_position()
	
	# Cast shadows
	#$TestBody.cast_shadows($Light.global_position)
	$Body.on_light_touching($Light.global_position)
