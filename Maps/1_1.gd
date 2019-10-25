extends "res://Main.gd"

var do_once_1_1 = true

func _ready():
	$Player.state = "freeze"
	show_first_two_labels(2)

func _on_Light_light(on):
	if on and do_once_1_1:
		$Player.state = "game"
		hide_all_labels()
		$Camera2D/VBoxContainer/Message.text = "You are no longer too scared to move."
		$Camera2D/VBoxContainer/Instruction.text = "Press keys A and D."
		show_first_two_labels(1)
		do_once_1_1 = false
	#$Camera2D/VBoxContainer/TextHandler.play("show_3")
	
	
