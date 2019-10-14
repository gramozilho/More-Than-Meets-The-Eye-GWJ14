extends StaticBody2D

var collision_x
var collision_y

func _ready():
	# Get collision size
	if $Sprite.region_enabled:
		collision_x = $Sprite.region_rect.end.x/4
		collision_y = $Sprite.region_rect.end.y
	else:
		collision_x = $Sprite.texture.get_size().x/2
		collision_y = $Sprite.texture.get_size().y/2
	
	# Set collision position
	$CollisionLeft.position = $Sprite.position + Vector2(-collision_x, 0)
	$CollisionRight.position = $Sprite.position + Vector2(collision_x, 0)
	
	# Set collision size
	#var collision_shape = Vector2(collision_x, collision_y)
	#$CollisionLeft/BodyCollision.shape.extents = collision_shape
	#$CollisionRight/BodyCollision.shape.extents = collision_shape
	
	# Scale halves
	$CollisionLeft.scale.x = .5
	$CollisionRight.scale.x = .5

func cast_shadows(source_coordinates):
	$CollisionLeft.on_light_touching(source_coordinates)
	$CollisionRight.on_light_touching(source_coordinates)
