extends "res://Object.gd"

func shadow_cast():
	var current_position = $Body.global_position
	# Raycast handling
	var collision_point = $Body/RayCast2D.get_collision_point() 
	$Shadow.global_position = current_position + (collision_point - current_position)*2
	# Deal with fake shadow
	$FakeShadow.global_position.x = $Shadow.global_position.x
	$FakeShadow.global_position.y = $Body.global_position.y
	$CollisionFake_main.global_position = $FakeShadow/CollisionFakeShadow.global_position
	
