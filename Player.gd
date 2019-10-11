extends "res://Object.gd"

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const MIN_Y_SPEED = 1

var y_velo = 0

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed('right'):
		move_dir += 1
	if Input.is_action_pressed('left'):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed('up'):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >= MIN_Y_SPEED:
		y_velo = MIN_Y_SPEED
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED

