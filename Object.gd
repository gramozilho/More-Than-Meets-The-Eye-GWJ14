extends KinematicBody2D

var viewport_size
var raycast_size = 1000

func _ready():
	viewport_size = get_viewport().size
	print(viewport_size)
	print('Body ', $Body.global_position.y)
	print('vy: ', viewport_size.y)

func _physics_process(delta):
	shadow_cast()

func shadow_cast():
	pass

func saved_physics_process(delta):
	var current_position = $Body.global_position
	
	#$Shadow.global_position.x = $Body/Sprite.global_position.x
	#$Shadow.global_position.y = viewport_size.y - $Body/Sprite.global_position.y
	
	# Raycast handling
	var collision_point = $Body/RayCast2D.get_collision_point() 
	$Shadow.global_position = current_position + (collision_point - current_position)*2
	#print(collision_point, $Shadow.global_position )


func _on_Light_light_position(coordinates):
	var cast_shadow_vector = global_position - coordinates
	$Body/RayCast2D.set_cast_to(cast_shadow_vector.normalized () * raycast_size)
