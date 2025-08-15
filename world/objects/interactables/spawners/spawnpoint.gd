class_name Spawnpoint
extends Interactable


signal spawnpoint_used


func _ready() -> void:
	#add_to_group("spawnpoints")
	spawnpoint_used.connect( get_parent()._on_spawnpoint_used )


func _process(delta: float) -> void:
	pass


func spawn(entity: Entity):
	entity.position = self.position
	spawnpoint_used.emit(self)
