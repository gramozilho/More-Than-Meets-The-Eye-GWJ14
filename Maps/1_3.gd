extends "res://Main.gd"

var do_once_cutscene
var viewport_size

func _ready():
	viewport_size = get_viewport().size
	$Player.state = "game"
	do_once_cutscene = true
	#$Body/ShadowCollision.disabled = true
	#$Player/AnimationPlayer.play("show_1")
	#$ExtraTimer.start()
	#yield($ExtraTimer, "timeout")
	#$Camera2D/VBoxContainer/TextHandler.play("show_3")
	death_position = 2


func _on_TextHandler_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "show_2":
		#$Player.state = "freeze"
		#$CameraTween.interpolate_property($Camera2D, "position", $Camera2D.position, Vector2(viewport_size.x*3/4, viewport_size.y/2), 5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		$CameraTween.interpolate_property($Camera2D, "position", $Camera2D.position, Vector2($Camera2D.position.x, 300), 5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
		$CameraTween.start()
		$SecondMoveTimer.start()
	elif anim_name == "show_3_danger":
		death_position = 3
		$Player.state = "game"


func _on_ExtraTimer_timeout():
	$Player.state = "freeze"


func _on_SecondMoveTimer_timeout():
	#$Camera2D/VBoxContainer/Extra.modulate = Color(1, 0, 0, 0)
	$Camera2D/VBoxContainer/TextHandler.play("show_3_danger")


func _on_TempArea_body_entered(body):
	if do_once_cutscene and body.is_in_group('player'):
		$Player.state = "freeze"
		show_first_two_labels(2)
		do_once_cutscene = false
