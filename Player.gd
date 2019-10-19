extends KinematicBody2D

signal next_level
signal dead

const MOVE_SPEED = 400
const JUMP_FORCE = 600
const GRAVITY = 40
const MAX_FALL_SPEED = 800
const MIN_Y_SPEED = 1

var y_velo = 0
var viewport_size
var facing_right = true
var die_once

var state = "game" # can be game, freeze

func _ready():
	viewport_size = get_viewport().size
	state = "game"
	die_once = true

func _physics_process(delta):
	if Input.is_action_pressed("ui_accept"):
		die()
		
	if state == "game":
		var move_dir = 0
		if Input.is_action_pressed('right'):
			move_dir += 1	
		if Input.is_action_pressed('left'):
			move_dir -= 1
		move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
		
		var grounded = is_on_floor()
		var celling = is_on_ceiling()
		y_velo += GRAVITY
		
		# Start grace timer down
		if Input.is_action_just_pressed('up') and $GraceDown.time_left == 0:
			$GraceDown.start()
			
		# Start grace timer up
		if grounded:
			$GraceUp.start()
		#var grounded = $GraceUp.time_left > 0
		
		
		#print('jump', jump, '   grounded', grounded)
		
		#if grounded and Input.is_action_just_pressed('up'):
		if $GraceUp.time_left > 0 and $GraceDown.time_left > 0:
			y_velo = -JUMP_FORCE
			$GraceUp.set_wait_time(0)
			$GraceDown.set_wait_time(0)
		if grounded and y_velo >= MIN_Y_SPEED:
			y_velo = MIN_Y_SPEED
		if celling:
			y_velo = GRAVITY/2
		if y_velo > MAX_FALL_SPEED:
			y_velo = MAX_FALL_SPEED
		
		if facing_right and move_dir < 0:
			flip()
		if !facing_right and move_dir > 0:
			flip()
	elif state == "die":
		move_and_slide(Vector2(0, -GRAVITY/2), Vector2(0, -1))
	else: #frozen
		move_and_slide(Vector2(0, y_velo), Vector2(0, -1))
		y_velo += GRAVITY
	
	shadow_cast()


func shadow_cast():
	#$Shadow.global_position.x = $Body.global_position.x
	$Shadow.global_position.y = viewport_size.y - $Body.global_position.y


func flip():
	facing_right = !facing_right
	for eye in get_tree().get_nodes_in_group("eye"):
		eye.position.x *= -1

func die():
	if die_once:
		$AnimationPlayer.play("die")
		state = "die"
		$CollisionBody.disabled = true
		die_once = false

func enter_door():
	state = "freeze"
	$AnimationPlayer.play('enter_door')


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		emit_signal("dead")
	elif anim_name == "next_level":
		emit_signal('next_level')
