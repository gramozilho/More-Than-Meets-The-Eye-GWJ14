extends ColorRect


signal animation_closed


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "close":
		emit_signal("animation_closed")
