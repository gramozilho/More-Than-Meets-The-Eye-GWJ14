extends "res://Maps/0_TitleScreen.gd"


func _ready():
	self.rect_size.x = 1020
	self.rect_size.y = 600


func _on_Button_pressed():
	#get_tree().reload_current_scene()
	globals.restart_scene()


func _on_Button2_pressed():
	globals.restart()
