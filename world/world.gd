extends Node2D


var main_level: Level
var current_level: Level


func _ready() -> void:
	load_level("res://world/levels/testlevel.tscn", true)


func load_level(level_scene, first_level = false):
	var player
	if first_level:
		player = preload("res://entities/player/player.tscn").instantiate()
		#player = Player.new()

	var level = load(level_scene).instantiate()
	add_child(level)
	level.enter()
	level.spawn_player(player)


func load_sublevel():
	pass


func _on_level_exited():
	pass


func _on_sublevel_entered():
	pass
