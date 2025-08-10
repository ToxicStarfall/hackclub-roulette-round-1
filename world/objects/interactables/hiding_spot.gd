class_name HidingSpot
extends Interactable


var hiding = false


func _process(delta: float) -> void:
	if interactable:
		if hiding: $Label.text = "Exit cover <key>"
		if !hiding: $Label.text = "Hide <key>"

		#$Label.text = "interactable"
		if Input.is_action_just_pressed("interact"):
			self.interact(user)
	else:
		$Label.text = ""



func interact(user):
	hiding = !hiding
	user.visible = !hiding  # visible when not hiding
	user.can_move = !hiding  # allow moving when not hiding
