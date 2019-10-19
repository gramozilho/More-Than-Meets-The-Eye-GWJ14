extends Control


func _on_Button_pressed():
	globals.next_level()


func _on_Button2_pressed():
	get_tree().quit()
