class_name Checkpoint
extends Spawnpoint


func _process(delta: float) -> void:
	if interactable:
		if Input.is_action_just_pressed("interact"):
			#$Label.text = "Saved"
			interact()
		else:
			$Label.text = "Save Checkpoint?"
	else:
		$Label.text = ""


func interact():
	spawnpoint_used.emit(self)
	pass
