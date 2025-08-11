class_name HidingSpot
extends Interactable


var hiding = false


func _ready() -> void:
	$AttackRange.body_entered.connect( _on_body_entered_attack_range )


func _process(delta: float) -> void:
	if interactable:
		if hiding: $Label.text = "Exit cover <key>"
		if !hiding: $Label.text = "Hide <key>"

		#$Label.text = "interactable"
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
	#user.action = if hiding: return Player.Action.HIDING  #TODO Search for conditional return
	if hiding: user.action = Player.Action.HIDING
	if !hiding: user.action = Player.Action.NONE


func stealth_attack():
	pass

func _on_body_entered_attack_range():
	pass
