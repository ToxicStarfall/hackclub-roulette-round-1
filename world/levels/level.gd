class_name Level
extends Node2D


signal level_entered
signal level_exited
signal sublevel_entered
signal sublevel_exited

@export var sublevels: Dictionary[String, PackedScene] = {}
#@export var sublevels: Dictionary = {}
#@export var sublevel = false
#@export var parent_level: Level

@export var Entry: Spawnpoint  # Starting point of level.
@export var Exit: Spawnpoint  # Last eexit to complete the level.


func _ready() -> void:
	if !Entry: push_error("This level does not have a Entry point specified.")
	#if !Exit: push_warning("This level does not have a Exit point specified.")


func enter():
	# level initialization stuff
	if self is SubLevel: sublevel_entered.emit()
	else: level_entered.emit()


func exit():
	# do stuff before exiting level
	var player = get_node("Player")
	self.remove_child(player)

	if self is SubLevel: sublevel_exited.emit()
	else: level_entered.emit(player)


func spawn_player(player: Player):
	self.add_child(player)
	Entry.spawn(player)
