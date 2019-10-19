extends "res://Maps/0_TitleScreen.gd"


func _on_Button_pressed():
	get_tree().reload_current_scene()


func _on_Button2_pressed():
	globals.restart()
