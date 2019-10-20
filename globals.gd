extends Node

var list_of_levels
var current_level
var current_scene = null
var map_fodler_path = "res://Maps/"

onready var background_music = load("res://SOunds/Waltz_To_Death.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	list_of_levels = list_files_in_directory(map_fodler_path)
	restart()
	
	# Add sound player
	#var music_file = "res://SOunds/Waltz_To_Death.wav"
	#var stream = AudioStream.new()
	##var music_player = AudioStreamPlayer.new()
	#if File.new().file_exists(music_file):
	#	var music = load(music_file)
	#	music_player.stream = music
	#	music_player.play()
	##music_player.stream = background_music
	##music_player.play()
		
	#get_tree().get_root().add_child(get_node("res://Jukebox.tscn"))
	#music_player.bus = "master"


func restart():
	current_level = 0
	load_new_level()


func restart_scene():
	load_new_level()


func next_level():
	current_level += 1
	if current_level > len(list_of_levels) - 1:
		current_level = 0
	print(current_level)
	print(len(list_of_levels))
	load_new_level()

func load_new_level():
	goto_scene(list_of_levels[current_level])


func goto_scene(path):
	call_deferred("_deferred_goto_scene", map_fodler_path+path)


func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	if current_scene != null:
		current_scene.free()
	# Load the new scene.
	var s = ResourceLoader.load(path)
	# Instance the new scene.
	current_scene = s.instance()
	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)
	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)


func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif file.ends_with(".tscn"):
			files.append(file)
		
	dir.list_dir_end()
	return files
