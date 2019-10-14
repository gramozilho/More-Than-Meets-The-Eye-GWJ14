extends "res://Object.gd"

func shadow_cast():
	var current_position = $Body.global_position
	# Raycast handling
	var collision_point = $Body/RayCast2D.get_collision_point()
	var light_to_real_center = collision_point - current_position 
	$Shadow.global_position = current_position + light_to_real_center + \
		Vector2(0, current_position.y)
	# Deal with fake shadow
	$FakeShadow.global_position.x = $Shadow.global_position.x
	$FakeShadow.global_position.y = $Body.global_position.y
	
	# Fake shadow size
	
	
	# Fake shadow position
	$CollisionFake_main.global_position = $FakeShadow/CollisionFakeShadow.global_position
	
	$CollisionFake_main.global_position = $FakeShadow/CollisionFakeShadow.global_position
	
	# Set shadow size
	$Shadow.scale.x = shadow_scale
	$CollisionFake_main.scale.x = shadow_scale
