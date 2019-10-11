extends Node2D

func _ready():
	var my_group_members = get_tree().get_nodes_in_group("cast_shadow")
	for member in my_group_members:
		$Light.connect("light_position", member, "_on_Light_light_position")
