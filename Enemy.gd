extends "res://BadArea.gd"

const MAX_MOVE = 50
const MIN_MOVE = 20
const TIMER_TIME = 20

var there_is_light = false
var initial_player_pos = Vector2()

#func _ready():
	#initial_player_pos  = get_tree().get_nodes_in_group("player")[0].global_position
	#$DreamSpeed.set_wait_time(TIMER_TIME)

func _process(delta):
	var player_pos = get_tree().get_nodes_in_group("player")[0].global_position
	var error = player_pos - global_position
	#var speed = (TIMER_TIME - $DreamSpeed.time_left)/TIMER_TIME * MAX_MOVE * delta 
	var speed = MAX_MOVE * delta 
	
	if not there_is_light:
			position += error.normalized() * speed * 3
	else:
		position += error.normalized() * speed
	#if false and old_player_pos == player_pos:
	#	position += error.normalized() * MAX_MOVE * .2 * delta
	#elif false and error.length() > MAX_MOVE:
	#	position += error.normalized() * MAX_MOVE * delta
	#elif false and error.length() < MIN_MOVE:
	#	position += error.normalized() * MIN_MOVE * delta
	#else:
	#	print('!')
		#position += error *.8 * delta
	shadow_cast()
	
	if Input.is_action_just_pressed("click"):
		there_is_light = !there_is_light
	
	#old_player_pos = player_pos

func is_there_light(on):
	print('Is there light?', on)
	there_is_light = on
