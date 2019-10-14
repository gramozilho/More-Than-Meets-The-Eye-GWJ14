extends KinematicBody2D

var raycast_size = 10000
var viewport_size
var shadow_scale = 1
var sprite_size
var raycast_group
var body_size

func _ready():
	# Get viewport
	viewport_size = get_viewport().size
	
	# Get Body Sprite size
	body_size = $BodySprite.region_rect.end
	
	var shadow_size = $BodySprite.region_rect.end
	$ShadowSprite.scale.x = body_size[0]/shadow_size[0]
	$ShadowSprite.scale.y = body_size[1]/shadow_size[1]*1.2
	
	# Change collision shapes
	for obj in [$BodyCollision, $ShadowCollision]:
		print(obj.scale)
		obj.scale.x = body_size[0]*$BodySprite.scale.x / (obj.shape.extents[0]*2)
		obj.scale.y = body_size[1]*$BodySprite.scale.y / (obj.shape.extents[1]*2)
		print('scale ', obj.scale.x, '  ext ',obj.shape.extents[0], '  body size ', body_size[0])
	
	# Rotate raycast to align with light angle
	$RayCast2D.set_cast_to(Vector2(0, raycast_size))
	
	# add all corner raycasts
	raycast_group = [$Pos_TL/RayCast1, $Pos_TR/RayCast2, $Pos_BL/RayCast3, $Pos_BR/RayCast4]
	#raycast_group = get_tree().get_nodes_in_group("raycast")
	print(raycast_group)

func on_light_touching(coordinates):
	var cast_shadow_vector = $BodyCollision.global_position - coordinates
	$RayCast2D.set_cast_to(cast_shadow_vector.normalized () * raycast_size)
	
	for raycast in raycast_group:
		var cast_vector = raycast.get_parent().global_position - coordinates
		raycast.set_cast_to(cast_vector.normalized () * raycast_size)
	# set shadow scale
	var real_height = abs(coordinates.y - $BodyCollision.global_position.y)
	var shadow_height= abs(coordinates.y - viewport_size.y/2)
	shadow_scale = shadow_height / real_height

func _physics_process(delta):
	shadow_cast()
	mirror()

func shadow_cast():
	var current_position = $BodyCollision.global_position
	# Raycast handling
	var collision_point = $RayCast2D.get_collision_point()
	#$ShadowSprite.global_position = collision_point + \
	#	Vector2(0, viewport_size.y/2 - current_position.y)
	#$ShadowSprite.scale.x = shadow_scale
	
	var stored_collisions = []
	for raycast in raycast_group:
		stored_collisions.append(raycast.get_collision_point()[0])
	
	var col_max = stored_collisions.max()
	var col_min = stored_collisions.min()

	var shadow_center = (col_max + col_min)/2
	shadow_scale = (col_max - col_min) / body_size.x * 2
	
	$ShadowSprite.global_position = Vector2(shadow_center, viewport_size.y - current_position.y)
	$ShadowSprite.scale.x = shadow_scale
	#$ShadowSprite.scale.y = 
	
	$ShadowCollision.scale.x = shadow_scale*1.5

func mirror():
	# Fake collision position update
	$ShadowCollision.global_position.x = $ShadowSprite.global_position.x
