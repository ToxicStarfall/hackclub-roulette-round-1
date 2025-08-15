class_name Level
extends Node2D

@warning_ignore("unused_signal")
signal level_won
signal level_changed(requester, new_level_id)
signal level_entered
signal level_exited

@export var sublevels: Dictionary[String, PackedScene] = {}
#@export var sublevel = false

@export var Entry: Spawnpoint  # Starting point of level.
@export var Exit: Spawnpoint  # Last eexit to complete the level.

var LastSpawnpoint: Spawnpoint


func _ready() -> void:
	if !Entry: push_error("This level does not have a Entry point specified.")
	#if !Exit: push_warning("This level does not have a Exit point specified.")
	print(get_tree().get_nodes_in_group("gates"))


## Runs level initialization stuff
func enter():
	#if self is SubLevel: sublevel_entered.emit(self)
	#else:
		level_entered.emit(self)


## Do stuff before exiting level
func exit():
	#var player = get_node("Player")
	#self.remove_child(player)

	#if self is SubLevel: sublevel_exited.emit(self)
	#else:
		level_exited.emit(self)


func spawn_player(player: Player, requester = null):
	self.add_child(player)

	if requester:  # Gate objects request level changes
		if requester is Gate:
			for gate in get_tree().get_nodes_in_group("gates"):
				if gate.gate_id == requester.gate_id:
					gate.spawn(player)
					LastSpawnpoint = gate
	else:
		if LastSpawnpoint:
			LastSpawnpoint.spawn(player)
		elif Entry:
			Entry.spawn(player)


func _on_spawnpoint_used(spawnpoint):
	#print(self)
	#print("-", spawnpoint)
	LastSpawnpoint = spawnpoint
	pass
