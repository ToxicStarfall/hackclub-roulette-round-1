class_name TheCheese
extends Interactable


func _ready() -> void:
	get_parent()
	pass


func _process(_delta: float) -> void:
	if interactable:
		$Label.text = "interact [E]"
		if Input.is_action_just_pressed("interact"):
			interact()
	else:
		$Label.text = ""


func interact():
	# GAME WIN
	print("interacted")
	get_parent().level_won.emit(get_parent())
	pass
