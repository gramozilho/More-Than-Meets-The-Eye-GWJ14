extends Area2D


signal lamp_touched


func _on_Lamp_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		emit_signal("lamp_touched", $Position2D.global_position)
