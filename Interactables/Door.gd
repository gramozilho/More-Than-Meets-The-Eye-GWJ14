extends Area2D

signal go_to_next_level

func _ready():
	var viewport_size = get_viewport().size
	$Shadow.global_position.y = 600 - $DoorFrame.global_position.y


func _on_Door_body_entered(body):
	if body.is_in_group('player'):
		$AnimationPlayer.play("Open")
		body.enter_door()
		Jukebox.door_open()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Open":
		emit_signal('go_to_next_level')
