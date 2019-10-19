extends Node2D

onready var death_screen = load("res://DeathScreen.tscn")

var shadow_casting_array
var mouse_state = "game"
var do_once = true
var death_position = 1

func _ready():
	shadow_casting_array = get_tree().get_nodes_in_group("cast_shadow")
	for body in shadow_casting_array:
		body.on_light_touching($Light.global_position)
	
	for lamp in get_tree().get_nodes_in_group("lamp"):
		lamp.connect('lamp_touched', $Light, 'receive_click')
	
	for bad_area in get_tree().get_nodes_in_group("bad_area"):
		bad_area.connect("kill_player", self, "kill_player")
		if bad_area.is_in_group("enemy"):
			bad_area.connect("light", bad_area, "is_there_light")
	
	#Spawn player on same margin from camera
	var margin_from_camera = $Camera2D.global_position - Vector2(440*$Camera2D.zoom.x, 0)
	$Player.global_position = Vector2(margin_from_camera.x, 279) #Vector2(margin_from_camera, 279)
	
	# Set light to no energy
	$Light.energy = 0
	
	# Hide text
	$Camera2D/VBoxContainer/Message.modulate = Color(1, 1, 1, 0)
	$Camera2D/VBoxContainer/Instruction.modulate = Color(1, 1, 1, 0)
	$Camera2D/VBoxContainer/Extra.modulate = Color(1, 1, 1, 0)
	
	death_position = 1


func _process(delta):
	if Input.is_action_pressed("click") and mouse_state == "free":
		$Light.global_position = get_global_mouse_position()
	
	# Cast shadows
	#$TestBody.cast_shadows($Light.global_position)
	#$Body.on_light_touching($Light.global_position)

func _on_Light_light_position(light_position):
	for body in shadow_casting_array:
		body.on_light_touching(light_position)


func _on_Door_go_to_next_level():
	globals.next_level()


func kill_player():
	$Player.die()


func _on_Light_light(on):
	#print('light on from main ', on)
	if shadow_casting_array != null:
		# Disable all body shadow collisions
		for body in shadow_casting_array:
			body.if_light_on_enable_shadow(on)
	#pass # Replace with function body.


func _on_TextHandler_animation_finished(anim_name):
	pass #$Camera2D/VBoxContainer/TextHandler.play("show_2")

func show_first_two_labels(time_delay):
	$MessageTimer.wait_time = .5
	$MessageTimer.start()
	yield($MessageTimer, "timeout")
	$Camera2D/VBoxContainer/TextHandler.play("show_1")
	$MessageTimer.wait_time = time_delay
	$MessageTimer.start()
	yield($MessageTimer, "timeout")
	$Camera2D/VBoxContainer/TextHandler.play("show_2")
	
func hide_all_labels():
	$Camera2D/VBoxContainer/Message.modulate = Color(1, 1, 1, 0)
	$Camera2D/VBoxContainer/Instruction.modulate = Color(1, 1, 1, 0)
	$Camera2D/VBoxContainer/Extra.modulate = Color(1, 1, 1, 0)


func _on_Player_dead():
	# Instance death screen
	var scene_instance = death_screen.instance()
	if death_position == 2:
		scene_instance.rect_position = Vector2(512, 0)
		scene_instance.rect_scale = Vector2(0.5, 0.5)
	elif death_position == 3:
		scene_instance.rect_position = Vector2(512, 150)
		scene_instance.rect_scale = Vector2(0.5, 0.5)
	add_child(scene_instance)
