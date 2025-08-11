class_name Interactable
extends Area2D


var user: Entity
var interactable: bool = false


func _init() -> void:
	body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )


func _process(delta: float) -> void:
	if interactable:
		$Label.text = "interactable"
		if Input.is_action_just_pressed("interact"):
			self.interact()
	else:
		$Label.text = "not interactable"


func _on_body_entered(body: Node2D) -> void:
	user = body
	if body is Player: interactable = true


func _on_body_exited(body: Node2D) -> void:
	if body is Player: interactable = false


func interact():
	# DO interaction effects
	pass
