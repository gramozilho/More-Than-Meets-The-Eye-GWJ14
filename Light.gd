extends Node2D

signal light_position

var old_position
var light_energy = 1


func _ready():
	old_position = global_position
	self.energy = light_energy


func _process(delta):
	if old_position != global_position:
		emit_signal("light_position", global_position)
		old_position = global_position
	
	if Input.is_action_just_pressed("ui_right"):
		position.x += 20 
	if Input.is_action_just_pressed("ui_left"):
		position.x -= 20 


func receive_click(destination):
	# If light is off, turn on at location
	if self.energy == 0:
		global_position = destination
		$TweenLight.interpolate_property(self, "energy", 0, light_energy, 0.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	
	# if mouse on same place as light currently, on/off
	elif global_position == destination:
		print()
		$TweenLight.interpolate_property(self, "energy", light_energy, 0, 0.5, Tween.TRANS_EXPO, Tween.EASE_OUT)
	
	# else, tween to location
	else:
		# Check if not travelling
		var travel_duration = 2
		#if $TravelTimer.time_left == 0:
		#	$TweenLight.interpolate_property(self, "position", global_position, destination, travel_duration, Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
		#else:
		$TweenLight.interpolate_property(self, "position", global_position, destination, travel_duration, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	$TweenLight.start()
