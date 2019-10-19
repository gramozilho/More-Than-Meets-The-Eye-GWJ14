extends Node2D

onready var death_screen = load("res://DeathScreen.tscn")

var shadow_casting_array
var mouse_state = "game"

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
	# Instance death screen
	var scene_instance = death_screen.instance()
	add_child(scene_instance)
