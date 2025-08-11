extends Node2D


var main_level: Level
var current_level: Level
var sublevels = []


func _ready() -> void:
	load_level("res://world/levels/testlevel.tscn", true)


func load_level(level_scene, first_level = false):
	var player
	if first_level:
		player = preload("res://entities/player/player.tscn").instantiate()
		#player = Player.new()

	var level = load(level_scene).instantiate()
	#level.load_sublevels()
	add_child(level)

	if level is SubLevel:
		level.sublevel_entered.connect( _on_sublevel_entered )
		level.sublevel_exited.connect( _on_sublevel_exited )
	else:
		level.level_entered.connect( _on_level_entered )
		level.level_exited.connect( _on_level_exited )
	level.enter()
	level.spawn_player(player)
	main_level = level
	current_level = level


func load_sublevel():
	pass


func _on_level_entered():
	# Notify level start
	pass

func _on_level_exited():
	# Notify level success
	pass


func _on_sublevel_entered():
	pass

func _on_sublevel_exited():
	pass
