class_name Gate
extends Interactable


signal gate_entered

@export var gate_id: String
@export var linked_level: String

var sublevel = false


func _ready() -> void:
	if get_parent() is SubLevel:
		sublevel = true


func interact():
	print(user, " interacted!")
	gate_entered.emit(self)


func spawn(entity: Entity):
	entity.position = self.position
