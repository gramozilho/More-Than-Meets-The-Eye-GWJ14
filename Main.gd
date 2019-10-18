extends Node2D

var shadow_casting_array
var mouse_state = "game"

func _ready():
	shadow_casting_array = get_tree().get_nodes_in_group("cast_shadow")
	for body in shadow_casting_array:
		body.on_light_touching($Light.global_position)
	$Light.global_position.x += 1
	
	for lamp in get_tree().get_nodes_in_group("lamp"):
		lamp.connect('lamp_touched', $Light, 'receive_click')


func _process(delta):
	if Input.is_action_pressed("click") and mouse_state == "free":
		$Light.global_position = get_global_mouse_position()
	
	# Cast shadows
	#$TestBody.cast_shadows($Light.global_position)
	#$Body.on_light_touching($Light.global_position)

func _on_Light_light_position(light_position):
	for body in shadow_casting_array:
		body.on_light_touching(light_position)


func handle_click_on_lamp(lamp_position):
	print(lamp_position)
