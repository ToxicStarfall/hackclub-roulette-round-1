class_name Gate
extends Spawnpoint

@warning_ignore("unused_signal")
signal gate_entered

@export var gate_id: String
@export var linked_level: String

var sublevel = false


func _ready() -> void:
	add_to_group("gates")
	if get_parent() is SubLevel:
		sublevel = true


func _process(_delta: float) -> void:
	if interactable:
		$Label.text = "Leave Area? [E]"
		if Input.is_action_just_pressed("interact"):
			self.interact()
	else:
		$Label.text = ""


func interact():
	print(user, " interacted!")
	#get_parent().exit()
	spawnpoint_used.emit(self)
	get_parent().level_changed.emit(self, linked_level)
