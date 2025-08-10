class_name Level
extends Node2D


signal level_entered
signal level_exited

@export var parent_level: Level
@export var sublevel = false

@export var Entry: Spawnpoint
@export var Exit: Spawnpoint


func _ready() -> void:
	if !Entry: push_error("This level does not have a Entry point specified.")
	#if !Exit: push_warning("This level does not have a Exit point specified.")


func enter():
	# level initialization stuff
	pass


func exit():
	# do stuff before exiting level
	var player = get_node("Player")
	self.remove_child(player)
	level_exited.emit(player)


func spawn_player(player: Player):
	self.add_child(player)
	Entry.spawn(player)
