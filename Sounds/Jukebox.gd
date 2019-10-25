#extends AudioStreamPlayer2D
extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	background_switch()

func background_switch():
	$BackgroundMusic.play()
	$GhostMusic.stop()

func finish():
	$Alarm.play()

func button_pressed():
	$Button.play()

func ghost_switch():
	$BackgroundMusic.stop()
	$GhostMusic.play()

func door_open():
	$Door.play()

func light_on():
	$LightOn.play()

func light_off():
	$LightOff.play()

func whoosh():
	$Whoosh.play()

func transition():
	$Transition.play()
