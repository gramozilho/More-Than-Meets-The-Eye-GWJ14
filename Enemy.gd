extends "res://BadArea.gd"

const MAX_MOVE = 50
const MIN_MOVE = 20
const TIMER_TIME = 20

var there_is_light = false
var initial_player_pos = Vector2()
var facing_right = true


func _process(delta):
	var player_pos = get_tree().get_nodes_in_group("player")[0].global_position
	var error = player_pos - global_position
	var speed = MAX_MOVE * delta 
	
	if not there_is_light:
			position += error.normalized() * speed * 3
	else:
		position += error.normalized() * speed
	
	# Switch eye position
	if facing_right and sign(error.x) == -1: # if moving to the left, swith
		flip()
	if !facing_right and sign(error.x) == 1: # facing left and moving right
		flip()
	shadow_cast()


func is_there_light(on):
	there_is_light = on

func flip():
	facing_right = !facing_right
	for eye in get_tree().get_nodes_in_group("eye_s"):
		eye.position.x *= -1
