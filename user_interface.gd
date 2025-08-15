extends Control


func _on_button_pressed() -> void:
	# START THE GAME
	get_parent().get_node("World").load_level("res://world/levels/testlevel.tscn", true)
	self.hide()
	pass
