class_name HidingSpot
extends Interactable


var hiding = false


func _ready() -> void:
	#$AttackRange.body_entered.connect( _on_body_entered_attack_range )
	pass


func _process(_delta: float) -> void:
	if interactable:
		if hiding:
			$Label.text = "Exit cover [E]"
		if !hiding:
			$Label.text = "Hide [E]"

		if Input.is_action_just_pressed("interact"):
			self.interact()
	else:
		$Label.text = ""


func interact():
	hiding = !hiding
	user.visible = !hiding  # visible when not hiding
	user.can_move = !hiding  # allow moving when not hiding
	user.position = self.position
	user.velocity = Vector2.ZERO
	#user.modulate.a = 1 + (-0.25 * int(hiding))
	#self.modulate.a = 1 + (-0.75 * int(hiding))

	if hiding: user.action = Player.Action.HIDING
	if !hiding: user.action = Player.Action.NONE
	$AudioStreamPlayer2D.stream = load("res://audio/086374_shaken-bush-40116.mp3")
	$AudioStreamPlayer2D.playing = true


func stealth_attack():
	pass

func _on_body_entered_attack_range():
	pass
